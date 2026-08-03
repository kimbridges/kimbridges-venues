# SET1.S00 cross-check + super-companion threshold (-2 iff constancy >= floor(2n/3)).
# All assertions pass (run 2026-06-11).
sp = [
(1,"CANTODOR",24,7,-1),(2,"CHRIDENT",33,6,-1),(3,"COPRFOLI",33,12,-1),(4,"CORDFRUI",15,15,-1),
(5,"LANTCAMA",17,11,-1),(6,"MICRSTRI",59,13,-2),(7,"OPLEHIRT",61,3,-2),(8,"PASPCONJ",27,10,-1),
(9,"PISOSPCS",13,2,-1),(10,"PSIDCATT",33,8,-1),(11,"PSIDGUAJ",35,1,-1),(12,"RUBUROSI",49,20,-2),
(13,"SCHITERR",34,17,-1),(14,"ALEUMOLU",20,14,-1),(15,"NEPHEXAL",38,16,-1),(16,"PISOBRUN",20,5,-1),
(17,"CHRIPARA",22,4,-1),(18,"GREVROBU",5,9,2),(19,"NESTSAND",10,28,-1),(20,"OXALSPCS",22,19,-1),
(21,"PLEOTHUN",3,25,2),(22,"BLECOCCI",7,22,-1),(23,"COCUTRIL",1,39,-3),(24,"DIOSHILL",1,30,-3),
(25,"POUTSAND",7,18,1),(26,"SIDARHOM",4,26,1),(27,"KALAPINN",1,34,-3),(28,"ANTISPCS",11,21,-1),
(29,"FRAXUHDE",1,32,-3),(30,"HEDITERM",6,33,1),(31,"PISOUMBE",3,31,1),(32,"YOUNJAPO",3,37,2),
(33,"AGERSPCS",3,35,2),(34,"PIPTALBI",4,40,-1),(35,"BUDLASIA",2,23,-3),(36,"SYZYCUMI",1,24,-3),
(37,"PHLEAURE",2,27,-3),(38,"CLIDHIRT",1,36,-3),(39,"DIPLSAND",6,29,-1),(40,"ALYXOLIV",2,38,-3),
(41,"ASPLKOLF",1,41,-3),(42,"CERTCARY",1,42,-3),(43,"SIDAFALA",1,43,-3),
]
mid = {1:[25,30,26,31], 2:[18,21,32,33]}
print("species:",len(sp),"(expect 43)")
for g in sorted(mid):
    a=sorted(s[0] for s in sp if s[4]==g); b=sorted(mid[g])
    print(f"group {g}: roleset {len(a)} midset {len(b)} MATCH={a==b}")
from collections import Counter
c=Counter(s[4] for s in sp)
print("role counts:",dict(sorted(c.items())))
print("grouped:",c[1]+c[2],"(expect 8)")
print("footnote(-3):",c[-3],"(expect 12)")
print("-3 with constancy>=3 (expect none):",[s[1] for s in sp if s[4]==-3 and s[2]>=3])
n=63; thr=(2*n)//3
sc=[s[2] for s in sp if s[4]==-2]; cp=[s[2] for s in sp if s[4]==-1]
print(f"floor(2n/3)={thr}  -2min={min(sc)} -1max={max(cp)}  rule(-2 iff const>=thr)={all(x>=thr for x in sc) and all(x<thr for x in cp)}")
