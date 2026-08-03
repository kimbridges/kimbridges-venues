# DIEREN.S00 decode — internal cross-consistency verification.
# Each species record carries a role code (c3). Independently, a separate
# region of the file lists the four group memberships bracketed by -(group id).
# These two regions must agree. Footnote count (Dieren_table) must equal the
# count of low-constancy (-3) species. All checks pass (run 2026-06-11).

# (id, name, constancy c1, c2, role c3) transcribed from the S00 species block
sp = [
(1,"CARELYNG",9,12,2),(2,"ELEOPALU",4,7,4),(3,"JUNCARCT",9,5,2),(4,"SCIRACUT",4,14,4),
(5,"LILAOCCI",10,1,2),(6,"CENTMINI",5,3,1),(7,"TRIGMARI",10,29,2),(8,"TILLAQUA",5,32,1),
(9,"ISOEMARI",3,34,4),(10,"ELATTRIA",3,17,4),(11,"ASTESUBS",4,44,1),(12,"POTEPACI",13,43,-2),
(13,"TYPHLATI",1,45,-3),(14,"DESCCESP",10,54,2),(15,"HYPORADI",5,33,1),(16,"TRIFWORM",5,48,1),
(17,"SONCARVE",7,55,3),(18,"SCIRAMER",5,52,1),(19,"ELEOROST",5,27,1),(20,"SCIRCER?",1,39,-3),
(21,"ERIGPHIL",2,16,-3),(22,"PLANMACR",5,59,1),(23,"ORTHCAST",2,6,-3),(24,"PLANMARI",1,19,-3),
(25,"SISYANGU",3,18,1),(26,"SAGICRAS",2,15,-3),(27,"EQUIARVE",5,22,1),(28,"GRININTE",1,8,-3),
(29,"PLANLANC",9,64,-1),(30,"DODEPAUC",4,79,1),(31,"RUMECRIS",3,53,1),(32,"HYPEFORM",7,11,1),
(33,"GLAUMARI",6,2,1),(34,"CIRSARVE",7,69,3),(35,"FESTRUBR",1,81,-3),(36,"LYTHSALI",1,4,-3),
(37,"MELIALBA",1,74,-3),(38,"JUNCBUFF",2,30,-3),(39,"BRODHYAC",5,71,1),(40,"MAIADILA",2,70,-3),
(41,"MONTFONT",1,9,-3),(42,"BIDEAMPL",2,66,-3),(43,"CASTUNAL",7,65,1),(44,"FRITCAMS",7,76,1),
(45,"CAMAQUAM",6,83,1),(46,"RANUORTH",2,10,-3),(47,"HABEDILA",2,75,-3),(48,"MYRIGALE",6,80,1),
(49,"LEONNUDI",2,67,-3),(50,"AGROREPE",1,31,-3),(51,"ELEOPARV",2,25,-3),(52,"MENTARVE",5,68,1),
(53,"LATHPALU",4,42,1),(54,"HOLCLANA",6,56,3),(55,"ACHIMILL",6,49,3),(56,"PRUNVULG",2,21,-3),
(57,"CICUDOUG",1,85,-3),(58,"LILASCIL",1,87,-3),(59,"PLANMAJO",5,62,1),(60,"SAGIPROC",1,82,-3),
(61,"GALIBORE",2,38,-3),(62,"EPILWATS",2,94,-3),(63,"SALIHOOK",1,95,-3),(64,"ROSANUTK",4,73,3),
(65,"RUBUSPEC",3,61,3),(66,"VICISATI",3,26,3),(67,"LONIINVO",3,47,3),(68,"HERALANA",3,23,3),
(69,"SIDAHEND",4,72,3),(70,"PHALARUN",3,51,3),(71,"CIRSVULG",3,46,3),(72,"SANGOFFI",2,40,-3),
(73,"ANGEGENU",2,20,-3),(74,"ASTEEATO",4,35,3),(75,"SIUMSUAV",3,63,-1),(76,"ANGELUCI",3,41,3),
(77,"SISYCALI",1,28,-3),(78,"PRUNEMAR",1,78,-3),(79,"ELYMMOLL",4,50,3),(80,"PYRUFUSC",3,57,3),
(81,"SOLICANA",4,60,3),(82,"GALIAPAR",2,24,-3),(83,"AGROSTOL",3,77,3),(84,"ALLIGEYE",1,84,-3),
(85,"RUMEACET",2,13,-3),(86,"AQUIFORM",1,86,-3),(87,"ANAPMARG",2,58,-3),(88,"TRIFPRAT",1,88,-3),
(89,"ZIGAVENE",1,89,-3),(90,"TRIFREPE",1,90,-3),(91,"POAxPRAT",1,91,-3),(92,"CONIPACI",1,92,-3),
(93,"LATHNEVA",1,93,-3),(94,"SYMPALBU",2,36,-3),(95,"CAREOBNU",2,37,-3),(96,"BROMSITC",1,96,-3),
(97,"PICESITC",1,97,-3),(98,"RHAMPURS",1,98,-3),(99,"POLYMUNI",1,99,-3),(100,"RIBEDIVA",1,100,-3),
(101,"POLYGLYC",1,101,-3),(102,"ATHYFILI",1,102,-3),(103,"MELISUBU",1,103,-3),(104,"GAULSHAL",1,104,-3),
(105,"VACCPARV",1,105,-3),(106,"RUBUURSI",1,106,-3),(107,"LACTMURA",1,107,-3),(108,"VICITETR",1,108,-3),
(109,"CYTISCOP",1,109,-3),(110,"AIRACARY",1,110,-3),(111,"SPEC380",1,111,-3),(112,"LEPICAMP",1,112,-3),
(113,"LOTUDENT",1,113,-3),(114,"AGROSCAB",1,114,-3),(115,"AIRAPRAE",1,115,-3),(116,"CORNNUTT",1,116,-3),
]

# Group membership lists from the MIDDLE section, bracketed by -(group id).
mid = {
 3:[34,17,54,55,64,79,69,81,74,71,70,66,65,76,83,80,67,68],            # 40/10
 1:[32,44,43,45,33,48,52,27,39,16,59,6,19,18,15,22,8,53,11,30,31,25],  # 50/20
 2:[7,5,14,1,3],                                                       # 66/33
 4:[2,4,9,10],                                                         # 66/33 (b)
}

byid = {s[0]:s for s in sp}
print("species records:", len(sp), "(expect 116)")

# Check 1: role-code group sets == middle-section membership sets
for g in (1,2,3,4):
    from_roles = sorted(s[0] for s in sp if s[4]==g)
    from_mid   = sorted(mid[g])
    ok = from_roles==from_mid
    print(f"group {g}: role-set size {len(from_roles)}  mid-set size {len(from_mid)}  MATCH={ok}")
    if not ok:
        print("   role:",from_roles); print("   mid :",from_mid)

# Check 2: partition counts
from collections import Counter
c=Counter(s[4] for s in sp)
print("role-code counts:", dict(sorted(c.items())))
print("  groups total:", c[1]+c[2]+c[3]+c[4], "(expect 49)")
print("  footnote (-3):", c[-3], "(expect 64 = Dieren_table footnote count)")
print("  body companions (-1):", c[-1], "  super-companion (-2):", c[-2])

# Check 3: role vs constancy consistency
print("low-constancy(-3) with constancy>=3 (expect none):",
      [s[1] for s in sp if s[4]==-3 and s[2]>=3])
print("super-companion(-2) with constancy<=12 i.e. <=66% (expect none):",
      [s[1] for s in sp if s[4]==-2 and s[2]<=12])
print("body companion(-1) with constancy<3 (expect none):",
      [s[1] for s in sp if s[4]==-1 and s[2]<3])

# Emit CSV fixture
import csv
role_label={-3:"footnote(<3 rel)",-2:"super-companion(>66%)",-1:"companion",
            1:"group_50/20",2:"group_66/33a",3:"group_40/10",4:"group_66/33b"}
with open("dieren_s00_species.csv","w",newline="") as f:
    w=csv.writer(f); w.writerow(["id","species","constancy","c2_index","role_code","role"])
    for s in sp: w.writerow([s[0],s[1],s[2],s[3],s[4],role_label[s[4]]])
print("wrote dieren_s00_species.csv")
