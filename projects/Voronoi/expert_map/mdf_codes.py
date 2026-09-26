import numpy as np, json, csv
g=np.load("regions_grid.npy").copy(); G=json.load(open("grid.json"))
# split Kipuka Ki polygon (open outline merged into scM(ns) region 3)
rr,cc=np.indices(g.shape); g[(g==3)&(rr>=375)&(cc<=245)]=900003
code={2:"AcM(od-C)",3:"scM(ns)",80:"MAc(od-C)",182:"x-scM(G)",201:"oM(mx)",234:"mx(MAc)",239:"cM(C)",245:"mx-AcM",
271:"AcM(od-C)",280:"AcM",283:"mx(MAc)",310:"mx-MAc",330:"MAc(ns)",336:"MAc(ns)",339:"mx(scM)",343:"AcM(od)",344:"mx(AcSoM)",
350:"mx(MAc)",352:"x",361:"MAc(ns)",364:"AcM(od)",371:"MAc(ns)",373:"mx-AcM",375:"MAc(ns)",376:"x",382:"mx-AcSoM",401:"mx-AcM",
403:"AcSoM(od)",410:"mx-AcSoM",413:"AcSoM(od)",436:"AcSoM(od)",440:"mx-AcSoM",447:"mx(scM)?",452:"MAc(ns)",455:"mx(AcSoM)",
460:"oM(ns-L)/scM(ns-L)",464:"mx(scM)?",480:"mx",492:"mx-AcSoM",496:"AcSoM(od)",499:"mx-AcSoM",503:"mx-AcSoM",505:"mx-AcSoM",
509:"MAc(ns)?",515:"mx-AcM",517:"oM(G-C)",544:"scM(An-G)",568:"mx-ns",570:"scM(ns-L)",
100003:"mx(AcSaSoM)+ns(i)",100004:"mx-AcSoM",100006:"mx-AcM",100008:"mx-ns?",100009:"scM(ns)/scM(ns-L)",100010:"scM(ns-L)",
100011:"MAc(ns)",100012:"oM(ns-L)",100013:"x",100014:"scM(An-G)",100017:"fu",100022:"mx-ns",100045:"r-scM(ns)",100055:"x",
100058:"scM(ns-r)",100060:"scM(ns-L)",100069:"r-ash(ns)",100070:"x",100074:"ash?",100075:"x",900003:"AcSoM(od)"}
def cls(s):
    s=s.rstrip("?")
    if s.startswith("AcSoM") or s.startswith("AcSaM"): return 1,"Kipuka forest (koa-manele-ohia)"
    if s.startswith(("AcM","MAc")): return 2,"Koa-ohia forest"
    if s.startswith(("cM","oM(mx)","oM(G")): return 3,"Ohia forest"
    if s.startswith(("scM","oM(ns-L","x-scM")): return 4,"Ohia scrub / low forest"
    if s.startswith("mx"): return 5,"Grass mix / savanna"
    if s.startswith(("r","ash")): return 6,"Open lava / ash"
    if s.startswith(("x","fu")): return 7,"Modified / other"
    raise ValueError(s)
u=np.unique(g); missing=[int(r) for r in u if int(r) not in code]; print("missing",missing)
lut={int(r):cls(code[int(r)])[0] for r in u}
C=np.vectorize(lut.get)(g).astype(np.int16)
# ESRI ascii grid in OHD lon/lat
with open("mdf1974_classes_ohd.asc","w") as f:
    f.write(f"ncols {g.shape[1]}\nnrows {g.shape[0]}\nxllcorner {G['lon0']}\nyllcorner {G['lat0']-g.shape[0]*G['res']}\ncellsize {G['res']}\nNODATA_value -9999\n")
    np.savetxt(f,C,fmt="%d")
with open("mdf1974_regions_ohd.asc","w") as f:
    f.write(f"ncols {g.shape[1]}\nnrows {g.shape[0]}\nxllcorner {G['lon0']}\nyllcorner {G['lat0']-g.shape[0]*G['res']}\ncellsize {G['res']}\nNODATA_value -9999\n")
    np.savetxt(f,g,fmt="%d")
with open("mdf1974_region_codes.csv","w",newline="") as f:
    w=csv.writer(f); w.writerow(["region","symbol","class_id","class","uncertain"])
    for r in u: s=code[int(r)]; ci,cn=cls(s); w.writerow([int(r),s.rstrip("?"),ci,cn,s.endswith("?")])
vals,cnt=np.unique(C,return_counts=True); print(dict(zip(vals.tolist(),cnt.tolist())))
