# ==============================================================================
# review_report.R -- PubMaps step 4: REVIEW
# One HTML page per manuscript for the editor: an interactive map of every place
# coloured by where its position came from, the planned map frame, a preview of the
# rendered map, the full place table with evidence, and author-query text ready
# to paste. Self-contained except for the Leaflet library and the map tiles (Esri;
# OSM's own tile servers refuse pages opened from disk).
# ==============================================================================

QUERY_ROLES <- c("study_site", "sampling_point", "reference_town", "natural_feature",
                 "relative_location")

MATCH_STYLE <- data.frame(
  match = c("stated", "editor", "exact", "partial", "suggestion", "none"),
  colour = c("#1b7837", "#7b3294", "#2166ac", "#e08214", "#b2182b", "#777777"),
  text = c("stated in the manuscript", "set by the editor", "gazetteer, exact match",
           "gazetteer, partial match - confirm", "suggestion only - not placed",
           "not located"),
  stringsAsFactors = FALSE)

esc <- function(x) {
  x <- ifelse(is.na(x), "", as.character(x))
  x <- gsub("&", "&amp;", x, fixed = TRUE); x <- gsub("<", "&lt;", x, fixed = TRUE)
  x <- gsub(">", "&gt;", x, fixed = TRUE); gsub("\"", "&quot;", x, fixed = TRUE)
}

fmt_ll <- function(lat, lon) sprintf("%.4f\u00b0 %s, %.4f\u00b0 %s",
  abs(lat), ifelse(lat < 0, "S", "N"), abs(lon), ifelse(lon < 0, "W", "E"))

author_queries <- function(p, manuscript) {
  named <- c("study_site", "sampling_point", "reference_town")
  need <- p[p$role %in% named & (p$match %in% "none" | p$flag %in% "generic"), ]
  rel  <- p[p$role %in% "relative_location", ]
  conf <- p[p$role %in% named & p$match %in% c("partial", "suggestion") &
            !p$flag %in% "generic", ]
  line <- function(r) sprintf("  - %s%s", r$name,
    ifelse(is.na(r$page), "", sprintf(" (p. %s: \"%s\")", r$page, r$evidence)))
  lines <- function(d) vapply(split(d, seq_len(nrow(d))), line, "")
  out <- c(sprintf("Manuscript: %s", manuscript), "")
  if (nrow(need)) out <- c(out,
    "To place your study sites accurately on the location map, please supply",
    "coordinates (decimal degrees, WGS84) for these localities:", "", lines(need), "")
  if (nrow(conf)) {
    out <- c(out, "Please confirm, or correct, these positions taken from a gazetteer:", "")
    for (k in seq_len(nrow(conf))) {
      r <- conf[k, ]; ll <- if (!is.na(r$lat)) c(r$lat, r$lon) else c(r$gaz_lat, r$gaz_lon)
      out <- c(out, sprintf("  - %s: %s (gazetteer entry \"%s\", %s)%s",
        r$name, if (!is.na(ll[1])) fmt_ll(ll[1], ll[2]) else "?", r$gaz_name, r$gaz_type,
        if (r$match == "suggestion") " -- not yet on the map" else
        if (isTRUE(r$flag == "spelling")) " -- spelled differently in the gazetteer" else ""))
    }
    out <- c(out, "")
  }
  if (nrow(rel)) out <- c(out,
    sprintf("The manuscript locates %d sampling site%s only relative to named places", nrow(rel),
            if (nrow(rel) > 1) "s" else ""),
    sprintf("(for example: %s).", rel$name[1]),
    "If you recorded GPS positions for your plots, please send them; otherwise the",
    "map will show the named places only.", "")
  if (!nrow(need) && !nrow(conf) && !nrow(rel)) out <- c(out, "No queries: every study site is located.")
  list(text = paste(out, collapse = "\n"), n_need = nrow(need) + nrow(rel) * 0 + (nrow(rel) > 0),
       n_confirm = nrow(conf))
}

review_report <- function(plan, dir, manuscript, png = NULL, provider = "", key = "", legend = TRUE) {
  has_strip <- isTRUE(legend)   # 'legend' is reused below for the check-map colour key
  p <- plan$points
  p$status <- ifelse(p$drawn, "on map", p$reason)
  p$show_lon <- ifelse(is.na(p$lon), p$gaz_lon, p$lon)
  p$show_lat <- ifelse(is.na(p$lat), p$gaz_lat, p$lat)
  p$colour <- MATCH_STYLE$colour[match(p$match, MATCH_STYLE$match)]
  p$colour[is.na(p$colour)] <- "#777777"
  aq <- author_queries(p, manuscript)
  st <- plan$study
  pts <- p[!is.na(p$show_lon), c("name", "role", "match", "status", "show_lon", "show_lat",
                                  "gaz_name", "gaz_type", "page", "evidence", "colour", "drawn")]
  js <- jsonlite::toJSON(pts, na = "null", dataframe = "rows", auto_unbox = TRUE)
  ajs <- "null"
  if (!is.null(plan$areas_ll) && nrow(plan$areas_ll)) {
    tf <- tempfile(fileext = ".geojson")
    st_write(st_transform(plan$areas_ll, 4326), tf, quiet = TRUE, delete_dsn = TRUE)
    ajs <- paste(readLines(tf, warn = FALSE), collapse = ""); unlink(tf)
  }
  ext <- plan$extent_lonlat
  img <- if (!is.null(png) && file.exists(png))
    sprintf('<img src="data:image/png;base64,%s" alt="Planned map">', base64enc::base64encode(png)) else ""
  legend <- paste(sprintf('<span class="key"><i style="background:%s%s"></i>%s</span>',
    MATCH_STYLE$colour, ifelse(MATCH_STYLE$match == "suggestion", ";opacity:.35", ""),
    MATCH_STYLE$text), collapse = "")
  rows <- paste(sprintf(
    '<tr class="%s"><td>%d</td><td><b>%s</b></td><td>%s</td><td><span class="dot" style="background:%s"></span>%s</td><td>%s</td><td>%s</td><td>%s</td><td class="ev">%s</td></tr>',
    ifelse(p$drawn, "on", "off"), seq_len(nrow(p)), esc(p$name), esc(gsub("_", " ", p$role)),
    p$colour, esc(p$match), esc(p$status),
    ifelse(is.na(p$lat), "", esc(fmt_ll(p$lat, p$lon))), esc(p$page), esc(p$evidence)),
    collapse = "\n")
  n_on <- sum(p$drawn)
  html <- paste0('<!doctype html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PubMaps review</title>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<style>
:root{--ink:#1f2328;--muted:#5b6470;--line:#d8dde3;--bg:#fbfbf9;--card:#fff}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);
font:15px/1.5 system-ui,-apple-system,"Segoe UI",sans-serif}
main{max-width:1180px;margin:0 auto;padding:24px 16px 48px}
h1{font-size:22px;margin:0 0 4px}h2{font-size:16px;margin:28px 0 8px}
.sub{color:var(--muted);margin:0 0 16px}
.stats{display:flex;gap:12px;flex-wrap:wrap;margin:12px 0 20px}
.stat{background:var(--card);border:1px solid var(--line);border-radius:8px;padding:8px 14px}
.stat b{font-size:20px;display:block}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
@media(max-width:860px){.grid{grid-template-columns:1fr}}
#map{height:460px;border:1px solid var(--line);border-radius:8px}
.preview img{width:100%;border:1px solid var(--line);border-radius:8px;background:#fff}
.legend{display:flex;flex-wrap:wrap;gap:6px 16px;font-size:13px;color:var(--muted);margin:8px 0}
.key i{display:inline-block;width:11px;height:11px;border-radius:50%;margin-right:6px;vertical-align:-1px}
textarea{width:100%;height:260px;font:13px/1.45 ui-monospace,Consolas,monospace;
border:1px solid var(--line);border-radius:8px;padding:10px;background:var(--card)}
button{font:inherit;padding:6px 14px;border:1px solid var(--line);border-radius:6px;background:var(--card);cursor:pointer}
.tablewrap{overflow-x:auto}
table{border-collapse:collapse;width:100%;font-size:13px;background:var(--card)}
th,td{border-bottom:1px solid var(--line);padding:6px 8px;text-align:left;vertical-align:top}
th{background:#f1f3f5;position:sticky;top:0}tr.off{color:var(--muted)}
td.ev{max-width:360px;font-style:italic}
.dot{display:inline-block;width:9px;height:9px;border-radius:50%;margin-right:6px}
.howto{background:var(--card);border:1px solid var(--line);border-radius:8px;padding:12px 16px}
code{background:#f1f3f5;padding:1px 5px;border-radius:4px}
</style></head><body><main>
<h1>Study-site map review</h1>
<p class="sub">', esc(manuscript), ' &middot; ', esc(st$study_area_summary), '<br>Read by ',
  esc(provider), ' &middot; ', format(Sys.Date()), '</p>
<div class="stats">
<div class="stat"><b>', nrow(p), '</b>places in the manuscript</div>
<div class="stat"><b>', n_on, '</b>on the map</div>
<div class="stat"><b>', aq$n_need, '</b>need coordinates</div>
<div class="stat"><b>', aq$n_confirm, '</b>to confirm</div></div>
<div class="grid"><div><div id="map"></div><div class="legend">', legend,
'<span class="key"><i style="border:2px dashed #333;background:none;border-radius:2px"></i>planned map frame</span></div></div>
<div class="preview">', img, '</div></div>
<h2>Author query</h2>
<textarea id="aq">', esc(aq$text), '</textarea>
<p><button onclick="navigator.clipboard.writeText(document.getElementById(\'aq\').value);this.textContent=\'Copied\'">Copy text</button></p>
<h2>Symbol key for the figure caption</h2>
<p class="sub">What each symbol on this map means, in words, for the caption. ', if (has_strip)
  'The map also carries a legend strip; for a journal that explains symbols in the caption, redraw with <code>legend = FALSE</code>.' else
  'The map is drawn without a legend strip, so this key belongs in the caption.', '</p>
<textarea id="key" style="height:110px">', esc(key), '</textarea>
<p><button onclick="navigator.clipboard.writeText(document.getElementById(\'key\').value);this.textContent=\'Copied\'">Copy key</button></p>
<h2>Every place</h2><div class="tablewrap"><table><thead><tr><th>#</th><th>Name</th><th>Role</th>
<th>Position from</th><th>Status</th><th>Coordinates</th><th>Page</th><th>Evidence</th></tr></thead><tbody>
', rows, '</tbody></table></div>
<h2>Making corrections</h2><div class="howto">Edit <code>points.csv</code> in this folder:
<code>include</code> = yes / no to force a place on or off the map (<code>name</code> = print the name only, without a symbol, e.g. a state), <code>label</code> to change
the printed name, <code>lon</code> / <code>lat</code> to set a position (decimal degrees).
<br><b>To move a name without moving the place:</b> <code>label_pos</code> = N, NE, E, SE, S, SW, W or NW
puts the name on that side of the symbol (<code>none</code> hides it); or give <code>label_lon</code> /
<code>label_lat</code> to put the name exactly there. Changing <code>lon</code>/<code>lat</code> moves the
place itself, and the map frame is re-planned around it. Add a row
with a blank <code>id</code> for a place the manuscript lacks. Then run
<code>pubmap_rerender("', esc(normalizePath(dir, winslash = "/", mustWork = FALSE)), '")</code>
(or just <code>pubmap_rerender("', esc(basename(dir)), '")</code>).
Rivers named in the manuscript are drawn as blue lines; <code>include</code> = no hides one.</div>
</main><script>
const pts=', js, ';
const map=L.map("map");
// tile servers that accept pages opened from disk (the OpenStreetMap servers return 403 to file:// pages)
const esri="https://server.arcgisonline.com/ArcGIS/rest/services/";
const streets=L.tileLayer(esri+"World_Street_Map/MapServer/tile/{z}/{y}/{x}",{maxZoom:19,attribution:"Tiles &copy; Esri"}).addTo(map);
const topo=L.tileLayer(esri+"World_Topo_Map/MapServer/tile/{z}/{y}/{x}",{maxZoom:19,attribution:"Tiles &copy; Esri"});
const sat=L.layerGroup([L.tileLayer(esri+"World_Imagery/MapServer/tile/{z}/{y}/{x}",{maxZoom:19,attribution:"Imagery &copy; Esri, Maxar, Earthstar Geographics"}),
 L.tileLayer(esri+"Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}",{maxZoom:19})]);
L.control.layers({"Streets (Esri)":streets,"Topographic (Esri)":topo,"Satellite + labels (Esri)":sat},null,{collapsed:false}).addTo(map);
L.control.scale({imperial:false}).addTo(map);
const frame=L.rectangle([[', ext[2], ',', ext[1], '],[', ext[4], ',', ext[3], ']],{color:"#333",weight:1.5,dashArray:"6 4",fill:false}).addTo(map);
const b=L.latLngBounds(frame.getBounds());
const e=s=>String(s??"").replace(/[&<>"]/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;","\\"":"&quot;"}[c]));
pts.forEach(p=>{const sug=p.match==="suggestion";
 const m=L.circleMarker([p.show_lat,p.show_lon],{radius:p.drawn?8:6,color:p.colour,
  weight:sug?2:1.5,dashArray:sug?"3 3":null,fillColor:p.colour,fillOpacity:sug?0.1:(p.drawn?0.85:0.45)}).addTo(map);
 m.bindTooltip(e(p.name));
 m.bindPopup("<b>"+e(p.name)+"</b><br>"+e(p.role.replace(/_/g," "))+" &middot; "+e(p.match)+
  "<br>"+e(p.status)+(p.gaz_name?"<br>gazetteer: "+e(p.gaz_name)+" ("+e(p.gaz_type)+")":"")+
  (p.page?"<br>p. "+e(p.page)+": <i>"+e(p.evidence)+"</i>":""));
 if(p.drawn) b.extend([p.show_lat,p.show_lon]);});
const areas=', ajs, ';
if(areas) L.geoJSON(areas,{style:f=>f.properties.role==="protected_area"?
 {color:"#3d6b30",weight:1.5,fillColor:"#7fbf5f",fillOpacity:0.18}:
 f.properties.role==="river"?{color:"#2f7fc1",weight:3,opacity:0.8}:
 {color:"#555",weight:1.5,dashArray:"6 4",fill:false},
 onEachFeature:(f,l)=>l.bindTooltip(e(f.properties.name)+(f.properties.role==="river"?" (river)":" (area)"))}).addTo(map);
map.fitBounds(b.pad(0.08));
</script></body></html>')
  f <- file.path(dir, "review.html")
  writeBin(charToRaw(enc2utf8(html)), f)
  invisible(f)
}
