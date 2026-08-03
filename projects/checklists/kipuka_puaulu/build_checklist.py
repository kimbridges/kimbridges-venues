#!/usr/bin/env python3
"""
Build a vascular-plant checklist for the Kipuka Puaulu region, Hawaii Volcanoes NP,
from GBIF preserved-specimen (herbarium) records.

Source query (GBIF occurrence API, accessed 2026-07-05):
  geoDistance = 19.437, -155.296, 2km
  taxonKey    = 6 (Plantae)
  basisOfRecord = PRESERVED_SPECIMEN
  total records = 385 ; unique accepted species (GBIF) = 159

Method: the GBIF interpreted-scientificName facet (verbatim name + specimen count)
was normalized by hand to accepted species. Synonyms and infraspecific taxa were
collapsed to the accepted binomial and their specimen counts summed. Hawaiian
biogeographic status follows Wagner, Herbst & Sohmer (Manual of the Flowering
Plants of Hawai'i) and Palmer (Hawai'i's Ferns and Fern Allies) conventions.

Status codes:
  E    = Endemic (Hawaii only)
  I    = Indigenous (native, occurs naturally elsewhere too)
  Pol  = Polynesian introduction
  Nat  = Naturalized (alien, reproducing in the wild)
  Cult = Cultivated / planted (forestry or horticultural trial; not naturalized)
  ?    = Status uncertain / name of doubtful application at this site
"""
import csv

# Each taxon: accepted_name, family, common_name, status, rank, notes, [(verbatim, count), ...]
T = [
 # ---------------- NATIVE SEED PLANTS ----------------
 ("Acacia koa","Fabaceae","koa","E","species","", [("Racosperma koa (A.Gray) Pedley",4)]),
 ("Alphitonia ponderosa","Rhamnaceae","kauila","E","species","", [("Alphitonia ponderosa Hillebr.",2)]),
 ("Alyxia stellata","Apocynaceae","maile","I","species","formerly A. oliviformis", [("Alyxia stellata (J.R.Forst. & G.Forst.) Roem. & Schult.",5)]),
 ("Charpentiera obovata","Amaranthaceae","papala","E","species","incl. genus-only record", [("Charpentiera obovata Gaudich.",1),("Charpentiera Gaudich.",1)]),
 ("Cheirodendron trigynum","Araliaceae","olapa","E","species","", [("Cheirodendron trigynum (Gaudich.) A.Heller",1)]),
 ("Clermontia hawaiiensis","Campanulaceae","oha wai","E","species","", [("Clermontia hawaiiensis (Hillebr.) Rock",1),("Clermontia hawaiiensis var. hawaiiensis",1)]),
 ("Clermontia parviflora","Campanulaceae","oha wai","E","species","", [("Clermontia parviflora Gaudich. ex A.Gray",2)]),
 ("Coprosma ernodeoides","Rubiaceae","kukaenene","E","species","", [("Coprosma ernodeoides A.Gray",1)]),
 ("Coprosma menziesii","Rubiaceae","pilo","E","species","", [("Coprosma menziesii A.Gray",1)]),
 ("Coprosma ochracea","Rubiaceae","pilo","E","species","", [("Coprosma ochracea W.R.B.Oliv.",1)]),
 ("Coprosma rhynchocarpa","Rubiaceae","pilo","E","species","", [("Coprosma rhynchocarpa A.Gray",4)]),
 ("Coprosma sp.","Rubiaceae","pilo","E","genus","genus-level record", [("Coprosma J.R.Forst. & G.Forst.",1)]),
 ("Cyanea floribunda","Campanulaceae","haha","E","species","", [("Cyanea floribunda E.Wimm.",2)]),
 ("Cyperus hillebrandii","Cyperaceae","","E","species","", [("Cyperus hillebrandii Boeckeler",1)]),
 ("Cyrtandra platyphylla","Gesneriaceae","haiwale","E","species","", [("Cyrtandra platyphylla A.Gray",4)]),
 ("Dianella sandwicensis","Asphodelaceae","ukiuki","I","species","incl. D. lavarum (syn.)", [("Dianella sandwicensis Hook. & Arn.",3),("Dianella lavarum O.Deg.",1)]),
 ("Dodonaea viscosa","Sapindaceae","aalii","I","species","", [("Dodonaea viscosa (L.) Jacq.",5)]),
 ("Dubautia ciliolata","Asteraceae","naenae","E","species","", [("Dubautia ciliolata (DC.) D.D.Keck",1)]),
 ("Freycinetia arborea","Pandanaceae","ieie","I","species","", [("Freycinetia arborea Gaudich.",6)]),
 ("Hibiscadelphus giffardianus","Malvaceae","hau kuahiwi","E","species","extinct in wild; type locality Kipuka Puaulu", [("Hibiscadelphus giffardianus Rock",5)]),
 ("Hibiscadelphus hualalaiensis","Malvaceae","hau kuahiwi","E","species","extinct in wild; Hualalai sp., likely outplanted/cultivated here", [("Hibiscadelphus hualalaiensis Rock",3)]),
 ("Ilex anomala","Aquifoliaceae","kawau / aiea","I","species","", [("Ilex anomala Hook. & Arn.",4)]),
 ("Ipomoea indica","Convolvulaceae","koali awa","I","species","", [("Ipomoea indica (Burm.) Merr.",1)]),
 ("Kadua centranthoides","Rubiaceae","manono","E","species","formerly Hedyotis", [("Kadua centranthoides Hook. & Arn.",2)]),
 ("Melicope cinerea","Rutaceae","alani","E","species","", [("Melicope cinerea A.Gray",1)]),
 ("Melicope pseudoanisata","Rutaceae","alani","E","species","", [("Melicope pseudoanisata (Rock) T.G.Hartley & B.C.Stone",12)]),
 ("Metrosideros polymorpha","Myrtaceae","ohia lehua","E","species","incl. 4 varieties + M. collina (syn.)", [("Metrosideros polymorpha Gaudich.",6),("Metrosideros polymorpha var. incana (H.Lev.) Skottsb.",3),("Metrosideros collina (Forst.) A.Gray",1),("Metrosideros polymorpha var. glabrifolia (A.Heller) H.St.John",1),("Metrosideros polymorpha var. polymorpha",1),("Metrosideros polymorpha var. pumila (A.Heller) Skottsb.",1)]),
 ("Myoporum sandwicense","Scrophulariaceae","naio","I","species","incl. genus-only record", [("Myoporum sandwicense (A.DC.) A.Gray",2),("Myoporum Banks & Sol. ex G.Forst.",1)]),
 ("Myrsine lessertiana","Primulaceae","kolea lau nui","E","species","", [("Myrsine lessertiana A.DC.",3)]),
 ("Nestegis sandwicensis","Oleaceae","olopua","E","species","", [("Nestegis sandwicensis (A.Gray) O.Deg., I.Deg. & L.A.S.Johnson",3)]),
 ("Nephroia orbiculata","Menispermaceae","huehue","I","species","= Cocculus orbiculatus", [("Cocculus orbiculatus (L.) DC.",2),("Nephroia orbiculata (L.) L.Lian & Wei Wang",2)]),
 ("Peperomia cookiana","Piperaceae","alaala wai nui","E","species","", [("Peperomia cookiana C.DC.",6)]),
 ("Peperomia blanda","Piperaceae","alaala wai nui","I","species","var. floribunda", [("Peperomia blanda var. floribunda (Miq.) H.Huber",2)]),
 ("Peperomia tetraphylla","Piperaceae","alaala wai nui","I","species","var. parvifolia", [("Peperomia tetraphylla var. parvifolia (C.DC.) O.Deg. & I.Deg.",1)]),
 ("Perrottetia sandwicensis","Dipentodontaceae","olomea","E","species","", [("Perrottetia sandwicensis A.Gray",1)]),
 ("Pipturus albidus","Urticaceae","mamaki","E","species","incl. P. hawaiiensis (syn.)", [("Pipturus albidus (Hook. & Arn.) A.Gray",3),("Pipturus albidus (Hook. & Arn.) A.Gray ex H.Mann",3),("Pipturus hawaiiensis H.Lev.",1)]),
 ("Pisonia brunoniana","Nyctaginaceae","papala kepau","I","species","", [("Pisonia brunoniana Endl.",1)]),
 ("Pisonia sandwicensis","Nyctaginaceae","papala kepau / aulu","E","species","", [("Pisonia sandwicensis Hillebr.",1)]),
 ("Pisonia umbellifera","Nyctaginaceae","papala kepau","I","species","", [("Pisonia umbellifera (J.Forst. & G.Forst.) Seem.",1)]),
 ("Pittosporum hosmeri","Pittosporaceae","hoawa","E","species","incl. genus-only record", [("Pittosporum hosmeri Rock",2),("Pittosporum Gaertn.",1)]),
 ("Psychotria hawaiiensis","Rubiaceae","kopiko","E","species","incl. Straussia hillebrandii (syn.)", [("Psychotria hawaiiensis (A.Gray) Fosberg",1),("Straussia hillebrandii Rock",2)]),
 ("Sapindus oahuensis","Sapindaceae","aulu / lonomea","E","species","", [("Sapindus oahuensis Hillebr. ex Radlk.",1)]),
 ("Sapindus saponaria","Sapindaceae","manele / a'e","I","species","status sometimes questioned", [("Sapindus saponaria L.",2),("Sapindus saponaria var. saponaria",2)]),
 ("Scaevola chamissoniana","Goodeniaceae","naupaka kuahiwi","E","species","incl. var. bracteosa", [("Scaevola chamissoniana Gaudich.",1),("Scaevola chamissoniana var. bracteosa Hillebr.",1)]),
 ("Sophora chrysophylla","Fabaceae","mamane","E","species","", [("Sophora chrysophylla (Salisb.) Seem.",3)]),
 ("Stenogyne calaminthoides","Lamiaceae","","E","species","", [("Stenogyne calaminthoides A.Gray",2)]),
 ("Stenogyne rotundifolia","Lamiaceae","","E","species","", [("Stenogyne rotundifolia A.Gray",1)]),
 ("Stenogyne rugosa","Lamiaceae","maohiohi","E","species","", [("Stenogyne rugosa Benth.",2)]),
 ("Stenogyne scrophularioides","Lamiaceae","","E","species","", [("Stenogyne scrophularioides Benth.",2)]),
 ("Stenogyne sp.","Lamiaceae","","E","genus","genus-level record", [("Stenogyne Benth.",1)]),
 ("Styphelia tameiameiae","Ericaceae","pukiawe","I","species","", [("Styphelia tameiameiae (Cham.) F.Muell.",1)]),
 ("Vaccinium reticulatum","Ericaceae","ohelo","E","species","", [("Vaccinium reticulatum Sm.",1)]),
 ("Wikstroemia sandwicensis","Thymelaeaceae","akia","E","species","", [("Wikstroemia sandwicensis Meisn.",5)]),
 ("Zanthoxylum dipetalum","Rutaceae","kawau / a'e","E","species","", [("Zanthoxylum dipetalum H.Mann",1)]),

 # ---------------- NATIVE FERNS & FERN ALLIES ----------------
 ("Asplenium adiantum-nigrum","Aspleniaceae","iwaiwa","I","species","", [("Asplenium adiantum-nigrum L.",4)]),
 ("Asplenium contiguum","Aspleniaceae","","I","species","", [("Asplenium contiguum Kaulf.",1)]),
 ("Asplenium macraei","Aspleniaceae","","E","species","", [("Asplenium macraei Hook. & Grev.",1)]),
 ("Asplenium furcatum","Aspleniaceae","","?","species","native; name of doubtful application", [("Asplenium furcatum Hillebr., 1888",1)]),
 ("Asplenium sp.","Aspleniaceae","","I","genus","genus-level records", [("Asplenium L.",3)]),
 ("Cibotium glaucum","Cibotiaceae","hapuu pulu","E","species","", [("Cibotium glaucum (Sm.) Hook. & Arn.",1)]),
 ("Ctenopteris sp.","Polypodiaceae","","I","genus","native grammitid fern; genus-level", [("Ctenopteris Blume ex Kunze",1)]),
 ("Cyrtomium caryotideum","Dryopteridaceae","","I","species","", [("Cyrtomium caryotideum (Wall. ex Hook. & Grev.) C.Presl",3)]),
 ("Dicranopteris linearis","Gleicheniaceae","uluhe","I","species","recorded as D. pectinata (misapplied)", [("Dicranopteris pectinata (Willd.) Underw.",1)]),
 ("Diplazium sandwichianum","Athyriaceae","hoio","E","species","", [("Diplazium sandwichianum (C.Presl) Diels",2)]),
 ("Dryopteris fuscoatra","Dryopteridaceae","iiii","E","species","", [("Dryopteris fuscoatra (Hillebr.) W.J.Rob.",1)]),
 ("Dryopteris glabra","Dryopteridaceae","kilau","E","species","", [("Dryopteris glabra (Brack.) Kuntze",1)]),
 ("Dryopteris hawaiiensis","Dryopteridaceae","","E","species","", [("Dryopteris hawaiiensis (Hillebr.) W.J.Rob.",1)]),
 ("Dryopteris wallichiana","Dryopteridaceae","laukahi","I","species","incl. D. paleacea (syn.)", [("Dryopteris wallichiana (Spreng.) Hyl.",2),("Dryopteris paleacea (Lag. ex Sw.) C.Chr.",1)]),
 ("Elaphoglossum crassifolium","Dryopteridaceae","ekaha","E","species","", [("Elaphoglossum crassifolium (Gaudich.) W.R.Anderson & Crosby",1)]),
 ("Elaphoglossum hirtum","Dryopteridaceae","ekaha","I","species","var. micans", [("Elaphoglossum hirtum var. micans (Mett.) C.Chr.",4)]),
 ("Elaphoglossum paleaceum","Dryopteridaceae","ekaha","I","species","", [("Elaphoglossum paleaceum (Hook. & Grev.) Sledge",1)]),
 ("Elaphoglossum wawrae","Dryopteridaceae","ekaha","E","species","", [("Elaphoglossum wawrae (Luerss.) C.Chr.",1)]),
 ("Lepisorus thunbergianus","Polypodiaceae","pakahakaha","I","species","incl. Pleopeltis thunbergiana (syn.)", [("Lepisorus thunbergianus (Kaulf.) Ching",1),("Pleopeltis thunbergiana Kaulf.",1)]),
 ("Microlepia speluncae","Dennstaedtiaceae","","I","species","", [("Microlepia speluncae (L.) T.Moore",2)]),
 ("Microlepia strigosa","Dennstaedtiaceae","palapalai","I","species","incl. var. hirta", [("Microlepia strigosa (Thunb.) C.Presl",4),("Microlepia strigosa var. hirta (Kaulf.) Hillebr.",1)]),
 ("Nephrolepis biserrata","Nephrolepidaceae","okupukupu","I","species","", [("Nephrolepis biserrata (Sw.) Schott",1)]),
 ("Nephrolepis cordifolia","Nephrolepidaceae","kupukupu","I","species","", [("Nephrolepis cordifolia (L.) C.Presl",1)]),
 ("Nephrolepis exaltata","Nephrolepidaceae","kupukupu","I","species","native subsp. hawaiiensis", [("Nephrolepis exaltata (L.) Schott",2)]),
 ("Nephrolepis sp.","Nephrolepidaceae","","?","genus","genus-level; incl. name of doubtful application", [("Nephrolepis Schott",1),("Nephrolepis saligna Carruth.",1)]),
 ("Pellaea ternifolia","Pteridaceae","kalamoho","I","species","", [("Pellaea ternifolia (Cav.) Fee",1)]),
 ("Pteridium aquilinum","Dennstaedtiaceae","kilau (bracken)","I","species","var./subsp. decompositum", [("Pteridium aquilinum var. decompositum (Gaudich.) R.M.Tryon",4),("Pteridium aquilinum subsp. decompositum (Gaudich.) Lamoureux ex J.A.Thomson",1)]),
 ("Pteris cretica","Pteridaceae","owali","I","species","", [("Pteris cretica L.",1)]),
 ("Sadleria rigida","Blechnaceae","amau","E","species","", [("Sadleria rigida Copel.",1)]),
 ("Sphenomeris chinensis","Lindsaeaceae","palaa","I","species","= Odontosoria chinensis", [("Sphenomeris chinensis (L.) Maxon",2)]),
 ("Morelotia affinis","Cyperaceae","","I","species","native sedge", [("Morelotia affinis (Brongn.) S.T.Blake",1)]),

 # ---------------- INDIGENOUS / uncertain herbs ----------------
 ("Persicaria punctata","Polygonaceae","kamole","I","species","= Polygonum punctatum", [("Persicaria punctata (Elliott) Small",2)]),
 ("Solanum americanum","Solanaceae","popolo","I","species","", [("Solanum americanum Mill.",1)]),
 ("Hedyotis biflora","Rubiaceae","","?","species","weedy; identity/status doubtful at this elevation", [("Hedyotis biflora (L.) Lam.",1)]),

 # ---------------- NATURALIZED ALIENS ----------------
 ("Achillea millefolium","Asteraceae","yarrow","Nat","species","", [("Achillea millefolium L.",1)]),
 ("Ageratina riparia","Asteraceae","Hamakua pamakani","Nat","species","", [("Ageratina riparia (Regel) R.M.King & H.Rob.",4)]),
 ("Agrostis stolonifera","Poaceae","creeping bentgrass","Nat","species","", [("Agrostis stolonifera L.",2)]),
 ("Aira caryophyllea","Poaceae","silver hairgrass","Nat","species","var. capillaris", [("Aira caryophyllea var. capillaris (Host) Mutel",1)]),
 ("Andropogon virginicus","Poaceae","broomsedge","Nat","species","", [("Andropogon virginicus L.",1),("Andropogon virginicus var. virginicus",1)]),
 ("Anemone hupehensis","Ranunculaceae","Japanese anemone","Nat","species","garden escape", [("Anemone hupehensis (E.Lemoine) E.Lemoine",1),("Anemone hupehensis var. japonica (Thunb.) Bowles & Stearn",1)]),
 ("Anthoxanthum odoratum","Poaceae","sweet vernalgrass","Nat","species","", [("Anthoxanthum odoratum L.",1)]),
 ("Axonopus fissifolius","Poaceae","carpetgrass","Nat","species","", [("Axonopus fissifolius (Raddi) Kuhlm.",2)]),
 ("Brassica sp.","Brassicaceae","mustard","Nat","genus","genus-level record", [("Brassica L.",1)]),
 ("Briza minor","Poaceae","little quakinggrass","Nat","species","", [("Briza minor L.",2)]),
 ("Buddleja asiatica","Scrophulariaceae","dogtail","Nat","species","", [("Buddleja asiatica Lour.",4)]),
 ("Bulbostylis capillaris","Cyperaceae","","Nat","species","", [("Bulbostylis capillaris (L.) Kunth ex C.B.Clarke",1)]),
 ("Cardamine flexuosa","Brassicaceae","bittercress","Nat","species","incl. C. occulta", [("Cardamine flexuosa With.",1),("Cardamine occulta Hornem.",1)]),
 ("Centaurium erythraea","Gentianaceae","common centaury","Nat","species","", [("Centaurium erythraea subsp. erythraea",1),("Centaurium erythraea var. erythraea",1)]),
 ("Cerastium fontanum","Caryophyllaceae","mouse-ear chickweed","Nat","species","", [("Cerastium fontanum subsp. triviale (E.H.L.Krause) Jalas",1),("Cerastium fontanum subsp. vulgare (Hartm.) Greuter & Burdet",1)]),
 ("Cuphea carthagenensis","Lythraceae","tarweed cuphea","Nat","species","", [("Cuphea carthagenensis (Jacq.) J.F.Macbr.",2)]),
 ("Cynoglossum amabile","Boraginaceae","Chinese forget-me-not","Nat","species","", [("Cynoglossum amabile Stapf & J.R.Drumm.",6)]),
 ("Cyperus brevifolius","Cyperaceae","green kyllinga","Nat","species","= Kyllinga brevifolia", [("Cyperus brevifolius (Rottb.) Hassk.",1),("Kyllinga brevifolia Rottb.",1)]),
 ("Dactylis glomerata","Poaceae","orchardgrass","Nat","species","", [("Dactylis glomerata L.",2)]),
 ("Digitaria eriantha","Poaceae","pangola grass","Nat","species","", [("Digitaria eriantha Steud.",2)]),
 ("Digitaria violascens","Poaceae","","Nat","species","", [("Digitaria violascens Link",1)]),
 ("Fragaria vesca","Rosaceae","wild strawberry","Nat","species","", [("Fragaria vesca L.",4)]),
 ("Geranium carolinianum","Geraniaceae","Carolina cranesbill","Nat","species","", [("Geranium carolinianum L.",1)]),
 ("Hypochaeris radicata","Asteraceae","hairy catsear / gosmore","Nat","species","", [("Hypochaeris radicata L.",2),("Hypochoeris radicata L.",1)]),
 ("Lachnagrostis filiformis","Poaceae","","Nat","species","= Agrostis avenacea", [("Lachnagrostis filiformis (G.Forst.) Trin.",2),("Agrostis avenacea J.F.Gmel.",1)]),
 ("Leucanthemum vulgare","Asteraceae","oxeye daisy","Nat","species","", [("Leucanthemum vulgare Lam.",2)]),
 ("Lolium multiflorum","Poaceae","Italian ryegrass","Nat","species","", [("Lolium multiflorum Lam.",2)]),
 ("Ludwigia palustris","Onagraceae","marsh seedbox","Nat","species","", [("Ludwigia palustris (L.) Elliott",1)]),
 ("Medicago lupulina","Fabaceae","black medick","Nat","species","", [("Medicago lupulina L.",2)]),
 ("Melinis minutiflora","Poaceae","molasses grass","Nat","species","", [("Melinis minutiflora P.Beauv.",6)]),
 ("Melinis repens","Poaceae","Natal redtop","Nat","species","", [("Melinis repens (Willd.) Zizka",1)]),
 ("Microlaena stipoides","Poaceae","meadow ricegrass","Nat","species","", [("Microlaena stipoides (Labill.) R.Br.",2)]),
 ("Mimosa pudica","Fabaceae","sensitive plant","Nat","species","var. unijuga", [("Mimosa pudica var. unijuga (Duchass. & Walp.) Griseb.",4)]),
 ("Modiola caroliniana","Malvaceae","Carolina bristlemallow","Nat","species","", [("Modiola caroliniana (L.) G.Don",4)]),
 ("Morella faya","Myricaceae","firetree / faya","Nat","species","= Myrica faya; highly invasive", [("Myrica faya (Dryand.) Aiton",1)]),
 ("Nephrolepis multiflora","Nephrolepidaceae","Asian swordfern","Nat","species","invasive", [("Nephrolepis multiflora (Roxb. ex Griff.) F.M.Jarrett ex C.V.Morton",1)]),
 ("Nuttallanthus canadensis","Plantaginaceae","blue toadflax","Nat","species","incl. Linaria texana", [("Nuttallanthus canadensis (L.) D.A.Sutton",1),("Linaria texana Scheele",2)]),
 ("Physalis peruviana","Solanaceae","poha / cape gooseberry","Nat","species","", [("Physalis peruviana L.",4)]),
 ("Pityrogramma calomelanos","Pteridaceae","silverback fern","Nat","species","", [("Pityrogramma calomelanos (L.) Link",1)]),
 ("Pluchea carolinensis","Asteraceae","sourbush","Nat","species","", [("Pluchea carolinensis (Jacq.) G.Don",2)]),
 ("Psidium cattleyanum","Myrtaceae","strawberry guava / waiawi","Nat","species","", [("Psidium cattleianum var. cattleianum",2)]),
 ("Psidium guajava","Myrtaceae","common guava / kuawa","Nat","species","", [("Psidium guajava L.",4)]),
 ("Pyracantha angustifolia","Rosaceae","narrowleaf firethorn","Nat","species","", [("Pyracantha angustifolia (Franch.) C.K.Schneid.",1)]),
 ("Pyracantha koidzumii","Rosaceae","firethorn","Nat","species","", [("Pyracantha koidzumii (Hayata) Rehder",3)]),
 ("Rubus ellipticus","Rosaceae","yellow Himalayan raspberry","Nat","species","var. obcordatus; highly invasive", [("Rubus ellipticus var. obcordatus (Franch.) Focke",2)]),
 ("Rumex acetosella","Polygonaceae","sheep sorrel","Nat","species","", [("Rumex acetosella L.",4)]),
 ("Schizachyrium condensatum","Poaceae","bush beardgrass","Nat","species","invasive", [("Schizachyrium condensatum (Kunth) Nees",1)]),
 ("Schizachyrium microstachyum","Poaceae","","Nat","species","", [("Schizachyrium microstachyum (Desv.) Roseng., B.R.Arrill. & Izag.",1)]),
 ("Setaria parviflora","Poaceae","yellow foxtail / mau'u","Nat","species","", [("Setaria parviflora (Poir.) Kerguelen",4)]),
 ("Solanum pseudocapsicum","Solanaceae","Jerusalem cherry","Nat","species","", [("Solanum pseudocapsicum L.",1)]),
 ("Sporobolus indicus","Poaceae","smutgrass","Nat","species","", [("Sporobolus indicus (L.) R.Br.",1)]),
 ("Stachytarpheta australis","Verbenaceae","","Nat","species","", [("Stachytarpheta australis Moldenke",6)]),
 ("Stenotaphrum secundatum","Poaceae","St. Augustine grass","Nat","species","", [("Stenotaphrum secundatum (Walter) Kuntze",2)]),
 ("Trifolium repens","Fabaceae","white clover","Nat","species","", [("Trifolium repens subsp. repens",1),("Trifolium repens var. repens",1)]),
 ("Verbena litoralis","Verbenaceae","owi","Nat","species","", [("Verbena litoralis Kunth",2)]),
 ("Vulpia bromoides","Poaceae","brome fescue","Nat","species","= Festuca bromoides", [("Festuca bromoides L.",2),("Vulpia bromoides (L.) Gray",2)]),
 ("Youngia japonica","Asteraceae","oriental hawksbeard","Nat","species","", [("Youngia japonica (L.) DC.",4)]),

 # ---------------- PLANTED / CULTIVATED (forestry & horticultural trials) ----------------
 ("Araucaria sp.","Araucariaceae","araucaria","Cult","genus","planted; genus-level record", [("Araucaria Juss.",2)]),
 ("Carya illinoinensis","Juglandaceae","pecan","Cult","species","planted trial", [("Carya illinoensis (Wangenh.) K.Koch",1),("Carya illinoinensis (Wangenh.) K.Koch",1)]),
 ("Castanea dentata","Fagaceae","American chestnut","Cult","species","planted trial or mislabeled specimen - verify", [("Castanea dentata (Marshall) Borkh.",6)]),
 ("Corylus americana","Betulaceae","American hazelnut","Cult","species","planted trial", [("Corylus americana Walter",1)]),
 ("Corylus cornuta","Betulaceae","beaked hazelnut","Cult","species","planted trial", [("Corylus cornuta Marshall",1)]),
 ("Cunninghamia lanceolata","Cupressaceae","China-fir","Cult","species","planted trial", [("Cunninghamia lanceolata (Lamb.) Hook.",2)]),
 ("Cupressus arizonica","Cupressaceae","Arizona cypress","Cult","species","planted trial", [("Cupressus arizonica Greene",2)]),
 ("Cupressus sempervirens","Cupressaceae","Italian cypress","Cult","species","planted trial", [("Cupressus sempervirens L.",2)]),
 ("Juglans regia","Juglandaceae","English walnut","Cult","species","planted trial", [("Juglans regia L.",4)]),
 ("Pinus halepensis","Pinaceae","Aleppo pine","Cult","species","planted trial", [("Pinus halepensis Mill.",2)]),
 ("Pinus patula","Pinaceae","patula pine","Cult","species","planted trial", [("Pinus patula Schiede ex Schltdl. & Cham.",2)]),
 ("Sequoia sempervirens","Cupressaceae","coast redwood","Cult","species","planted trial", [("Sequoia sempervirens (D.Don) Endl.",2)]),
]

# Bryophytes (GBIF kingdom Plantae includes mosses) - reported separately
BRYO = [
 ("Barbellopsis trichophora","Meteoriaceae","moss","?","species","bryophyte", [("Barbellopsis trichophora (Mont.) W.R.Buck",1)]),
 ("Ectropothecium zollingeri","Hypnaceae","moss","?","species","bryophyte", [("Ectropothecium zollingeri (Muell.Hal.) A.Jaeger",1)]),
 ("Floribundaria floribunda","Meteoriaceae","moss","?","species","bryophyte", [("Floribundaria floribunda (Dozy & Molk.) M.Fleisch.",1)]),
 ("Pseudoscleropodium purum","Brachytheciaceae","moss","Nat","species","bryophyte", [("Pseudoscleropodium purum (Hedw.) M.Fleisch.",3)]),
]

def rows(data):
    out=[]
    for rec in data:
        if rec is None: continue
        acc,fam,com,stat,rank,notes,verb = rec
        n=sum(c for _,c in verb)
        vjoin="; ".join(f"{v} [{c}]" for v,c in verb)
        out.append(dict(accepted_name=acc,family=fam,common_name=com or "",
                        status=stat,rank=rank,n_records=n,
                        verbatim_names=vjoin,notes=notes or ""))
    return out

vasc=rows([r for r in T if r])
bryo=rows(BRYO)

# write vascular checklist
cols=["accepted_name","family","common_name","status","rank","n_records","notes","verbatim_names"]
with open("kipuka_puaulu_checklist.csv","w",newline="",encoding="utf-8") as f:
    w=csv.DictWriter(f,fieldnames=cols); w.writeheader()
    for r in sorted(vasc,key=lambda x:(x["status"],x["family"],x["accepted_name"])): w.writerow(r)
with open("kipuka_puaulu_bryophytes.csv","w",newline="",encoding="utf-8") as f:
    w=csv.DictWriter(f,fieldnames=cols); w.writeheader()
    for r in bryo: w.writerow(r)

# summary
from collections import Counter
sp=[r for r in vasc if r["rank"]=="species"]
cnt=Counter(r["status"] for r in vasc)
tot_records=sum(r["n_records"] for r in vasc)+sum(r["n_records"] for r in bryo)
print("VASCULAR taxa rows:",len(vasc)," (species-rank:",len(sp),", genus-level:",len(vasc)-len(sp),")")
print("Bryophyte rows:",len(bryo))
print("Status breakdown (vascular):")
labels={"E":"Endemic","I":"Indigenous","Nat":"Naturalized","Cult":"Cultivated/planted","?":"Uncertain","Pol":"Polynesian"}
for k in ["E","I","Pol","Nat","Cult","?"]:
    if cnt.get(k): print(f"  {labels[k]:20s}: {cnt[k]}")
native=cnt.get("E",0)+cnt.get("I",0)
print("Native (E+I) taxa:",native)
print("Total specimen records represented:",tot_records)
