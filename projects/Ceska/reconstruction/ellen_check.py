# ELLEN.S00 cross-check. Species role codes (c3) vs independent group lists.
# All assertions pass (run 2026-06-11).
sp = [
(1,"ARRHELAT",25,1,-2),(2,"DACTGLOM",25,2,-2),(3,"HELIPUBE",16,19,-2),(4,"BROMEREC",7,6,2),
(5,"FESTOVIN",4,17,5),(6,"POA PRAT",25,32,-2),(7,"BRIZMEDI",5,20,5),(8,"KOELPYRA",4,24,5),
(9,"FESTRUBR",15,30,2),(10,"CAREFLAC",6,14,-1),(11,"TRIFPRAT",18,15,-2),(12,"TRIFREPE",14,28,-1),
(13,"MEDILUPU",17,23,-2),(14,"ACHIMILL",21,11,-2),(15,"DAUCCARO",20,13,-2),(16,"CAMPROTU",13,38,2),
(17,"PLANLANC",25,3,-2),(18,"HERASPON",14,36,-1),(19,"GALIMOLU",25,33,-2),(20,"CHRYLEUC",23,9,-2),
(21,"SCABCOLU",5,18,3),(22,"LINUCATH",5,27,5),(23,"RUMEACET",19,12,-2),(24,"RANUACER",23,31,-2),
(25,"THYMSERP",5,50,3),(26,"CERACAES",13,26,2),(27,"CENTJACE",14,56,-1),(28,"TARAOFFI",19,16,-2),
(29,"CAMPGLOM",7,63,2),(30,"VEROCHAM",22,49,-2),(31,"PLANMEDI",14,57,-1),(32,"FESTPRAT",23,44,-2),
(33,"TRISFLAV",15,54,-1),(34,"SILEINFL",3,48,-1),(35,"LEONHISP",4,59,5),(36,"CREPBIEN",15,29,-1),
(37,"MYOSARVE",2,51,-3),(38,"AJUGREPT",16,66,-2),(39,"VICISEPI",7,4,3),(40,"LOTUCORN",4,39,-1),
(41,"SALVPRAT",5,60,3),(42,"KNAUARVE",3,52,3),(43,"VIOLHIRT",6,58,3),(44,"BELLPERE",11,67,2),
(45,"DIANSUPE",4,43,5),(46,"PIMPSAXI",2,10,-3),(47,"GALIBORE",4,7,-1),(48,"ALOPPRAT",9,53,1),
(49,"HOLCLANA",12,41,1),(50,"CIRSOLER",14,62,1),(51,"TRAGPRAT",7,68,-1),(52,"GLECHEDE",6,21,1),
(53,"ANTHSILV",5,22,-1),(54,"LATHPRAT",10,25,1),(55,"FILIULMA",4,65,4),(56,"GEUMRIVA",13,45,1),
(57,"MELADIUR",11,47,1),(58,"ANGESILV",6,35,4),(59,"LYSINUMU",8,8,1),(60,"DESCCESP",7,5,1),
(61,"POA TRIV",1,55,-3),(62,"CAREACUT",5,64,-1),(63,"PRUNVULG",12,40,-1),(64,"PIMPMAGN",4,42,4),
(65,"POLYBIST",4,75,4),(66,"LYCHFLOS",7,34,1),(67,"SENEJACO",6,69,3),(68,"VICICRAC",5,80,3),
(69,"POTEREPT",3,83,-1),(70,"CAREHIRT",1,37,-3),(71,"CARDPRAT",2,71,-3),(72,"PHLEPRAT",1,88,-3),
(73,"MYOSPALU",2,73,-3),(74,"GERAPRAT",1,79,-3),(75,"PASTSATI",3,46,4),(76,"FESTARUN",1,76,-3),
(77,"GALIULIG",1,61,-3),(78,"SANGOFFI",1,78,-3),(79,"GALIVERU",2,74,-3),(80,"SILAPRAT",3,70,-1),
(81,"RANUREPE",1,81,-3),(82,"LOLIPERE",1,82,-3),(83,"EUPHODON",2,72,-3),(84,"GLYCFLUI",1,84,-3),
(85,"PHALARUN",1,85,-3),(86,"CAREGRAC",1,86,-3),(87,"LAMIALBU",1,87,-3),(88,"RUMECRIS",2,77,-3),
(89,"POLYCONV",1,89,-3),(90,"CHENALBU",1,90,-3),(91,"PHRACOMM",1,91,-3),(92,"BRACPINN",1,92,-3),
(93,"ALCHVULG",1,93,-3),
]
mid = {4:[58,65,55,64,75], 1:[50,56,49,57,54,48,59,66,60,52], 2:[9,26,16,44,29,4],
       3:[39,67,43,41,68,21,25,42], 5:[7,22,45,35,8,5]}
print("species:",len(sp),"(expect 93)")
for g in sorted(mid):
    a=sorted(s[0] for s in sp if s[4]==g); b=sorted(mid[g])
    print(f"group {g}: roleset {len(a)} midset {len(b)} MATCH={a==b}")
from collections import Counter
c=Counter(s[4] for s in sp)
print("role counts:",dict(sorted(c.items())))
print("grouped:",sum(c[g] for g in (1,2,3,4,5)),"(expect 35)")
print("footnote(-3):",c[-3],"(expect 25)")
print("-3 with constancy>=3 (expect none):",[s[1] for s in sp if s[4]==-3 and s[2]>=3])
n=25; thr=(2*n)//3
print(f"floor(2n/3)={thr}  -2 min={min(s[2] for s in sp if s[4]==-2)}  -1 max={max(s[2] for s in sp if s[4]==-1)}")
