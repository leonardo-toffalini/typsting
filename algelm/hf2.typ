#import "@preview/sleek-university-assignment:0.1.0": assignment

#show: assignment.with(
  title: "Második házifeladat",
  course: "Algoritmuselmélet",
  authors: (
    (
      name: "Toffalini Leonardo",
      email: "leonardotoffalini@gmail.com",
      student-no: "JPWNJX",
    ),
  ),
)

= Question
Adott egy dobozban $n$ különböző méretű csavar, egy másik dobozban pedig a
hozzájuk illő anyák. Sajnos sem a csavarokat nem tudjuk egymással
összehasonlítani, sem az anyákat. Azt tudjuk csak kipróbálni, hogy egy csavar
külső átmérője kisebb, nagyobb vagy egyenlő egy anya belső átmérőjénél
(megpróbáljuk az anyát rácsavarni a csavarra). Adjunk az algoritmus
összehasonlításokban mért költségének várható értékben minél hatákonyabb
algoritmust.

= Solution
Figyeljük meg, hogy a Quicksort algoritmusban a Partition lépést tudjuk
módosítani azzal, hogy nem egy véletlenül választott csavarral hasonlítjuk
össze a többi csavart a résztömbben, hanem egy véletlenül választott anyával.

Tehát mindengyik partition lépésben kiválasztunk egy véletlenszerű anyát és az
összes csavart a résztömbben megpróbáljuk ezzel az anyával. Ha túl kicsi, akkor
balra rakjuk, ha túl nagy akkor jobbra rakjuk.

A lépésszám elemzését nem részletezzük, mert ugyanaz mint a quicksort
algoritmusé, mivel csak annyi változott hogy nem egy véletlenül választott
elemmel hasonlítjuk össze az összes másik elemet a résztömbben, hanem egy külső
elemet választunk. Egyedül azt kell tárgyalni hogy mi van akkor amikor olyan
anyát választunk aminek az a csavarja nincsen a résztömbben. Ebben az esetben
sem változik a szubrutin, mivel olyan mintha titokban becsempésszük ezt az
elemet a résztömbbe, összehasonlítjuk ezzel a többit, majd kicsempésszük a
résztömbből.

Feltéve, hogy a kérdés az hogy nagyságrendileg hány összehasonlításban
tudjuk rendezni a csavarokat, akkor a válaszunk a quicksort várható futásideje,
azaz $O(n log n)$.

