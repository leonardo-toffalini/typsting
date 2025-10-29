#import "@preview/sleek-university-assignment:0.1.0": assignment

#show: assignment.with(
  title: "Ötödik házifeladat",
  course: "Algoritmuselmélet",
  authors: (
    (
      name: "Toffalini Leonardo",
      email: "leonardotoffalini@gmail.com",
      student-no: "JPWNJX",
    ),
  ),
)

= Feladat
Szerepeljen a $G$ összefüggő írányítatlan multigráfban minden él páros sokszor.
Bizonyítsuk be, hogy $O(m)$ időben megadható egy Euler-körséta, ahol $m$ az
élek száma!

= Megoldás
Mivel minden él páros sokszor szerepel és összefüggő a gráf ezért tudjuk, hogy
létezik Euler-körséta, mert minden csúcs foka páros.

Az algoritmus kiindul egy tetszőleges $s$ csúcsból és bármilyen bejárási
módszerrel végig halad az összes csúcson addig ameddig nem ér vissza $s$-be.
Így találunk egy körsétát, viszont nem biztos hogy minden élen átment. Ha van
olyan $u$ csúcs amiből még mennek ki élek amiket nem használtunk fel, akkor
most $u$-ból is keressünk egy körsétát. Az $u$-ból talált körsétával kibővítjuk
az eredeti $s$-ből induló körsétát úgy, hogy ahol $u$-t érintettük ott
megtoldjuk még az új körsétával ami visszatér $u$-ba.

A leírt algoritmus megtalálja az Euler-körsétát, mivel minden bővítésnél
körsétát kapunk és az algoritmus végére bejárunk minden élt.

Az algoritmus $O(m)$ időben fut, mivel minden élet pontosan egyszer processzálunk.
A körséta bővítések megoldhatóak $O(1)$ időben, ha oda-vissza láncolt listát
használunk a válasz megadására, mert ekkor ebbe a listába bárhova be tudunk
illeszteni egy másik listát. Azt, hogy van-e még olyan csúcs aminek van
járatlan éle, azt szintén el tudjuk dönteni $O(1)$ időben, ha a még
használatlan éleket egy sorban tartjuk.

