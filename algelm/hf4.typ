#import "@preview/sleek-university-assignment:0.1.0": assignment

#show: assignment.with(
  title: "Negyedik házifeladat",
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
Hogyan keressünk hatékonyan egy csúcssúlyozott fában (negatívok is lehetnek a
súlyok) maximális összsúlyúfüggetlen csúcshalmazt.

= Megoldás
Jelöljünk ki egy tetszőleges $r$ csúcsot mint gyökeret. \
Jelölje $A[v]$ a maximális súlyú független csúcshalmaz súlyát azon részfában,
mely $v$ alatt van és $v$ _benne van_ van a csúcshalmazban. \
Hasonlóképpen, jelölje $B[v]$ a maximális független csúcshalmaz súlyát azon
részfában, mely $v$ alattt van és $v$ _nincs benne_ a csúcshalmazban.

Ekkor mindegyik $v$ csúcsra, ha $v$ benne benne van a csúcshalmazban, akkor
egyik gyereke se lehet benne, ezért
$
  A[v] = w(v) + sum_(u) B[u],
$
ahol $u$ gyereke $v$-nek az $r$ gyökerű fában.

Ha viszont $v$ nincs benne a csúcshalmazban, akkor bármelyik gyereke benne
lehet vagy nem, ezért
$
  B[v] = sum_u max { A[u], B[u] },
$
ahol $u$ gyereke $v$-nek.

Ezeket az alfeladatokat megoldjuk DFS sorrendben, és a végső válaszunk a következő:
$
  max { A[r], B[r] }.
$

A futásidő linearás a csúcsok számában $n$, mivel mindkét dinamikus
programozási tömb $n$ méretű és ezért $2 n$ részfeladatot kell megoldanunk.

Egy kicsit kell figyelnünk arra, hogy mennyi idő egy következő részfeladatot
megkapni. Ha naivan azt mondjuk, hogy legfeljebb $n$ elem maximumát kell
megtalálni, akkor $O(n^2)$-es algoritmust kapnánk. Viszont megfigyelhetjük,
hogy egy maximumnál $d(v) - 1$ elem közül kell megtalálnunk a maximumot, és ha
ezeket összeadjuk akkor $O(m)$-et kapunk, ami egy fában $O(n)$.
