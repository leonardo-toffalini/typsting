#import "@preview/thmbox:0.3.0": *
#show: thmbox-init()

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

// derive from some predefined function

#let exercise = exercise.with(
    variant: "Feladat", 
    color: blue,
)
#let solution = proof.with(
    title: "Megoldás", 
    color: green,
)

#align(center)[
  #text(blue, size: 25pt)[*Hatodik házifeladat*] \

  #text(size: 14pt)[Algoritmuselmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Egy hálózatban a kapacitások egész számok, továbbá adva van egy egészértékű
  maximális folyam. Az egyik él kapacitását eggyel lecsökkentjük. Határozzuk meg
  $O(n + m)$ időben a módosított hálózatban a maximális folyamértékét!
]

#solution[
  Ha a módosított él az eredeti maximális folyamban nem volt telített, akkor
  nem kell semmit csinálnunk és készen vagyunk.

  Ha az eredeti maximális folyamban a módosított él telített volt, akkor
  mostmár ez a folyam sértő, és ki kell javítanunk.

  Legyen a módosított él $e in E$. Keressünk a reziduális gráfban egy $P$ utat
  $t$-ből $s$-be, ami tartalmazza $e$-t. Ezen az úton visszafele tudunk tolni
  egy $1$ értékű folyamot, amivel kijavítjuk a sértő élt. \
  Mostmár csak annyit kell meggondolnunk, hogy ez maximális folyam lesz-e.

  A módosított folyam pontosan $1$-el kisebb mint az eredeti, így elég csak még
  egy Ford--Fulkerson fázist elvégezni. Tudjuk, hogy több mint $1$-et nem kell,
  mert akkor már több lenne a módosított folyam értéke mint az eredeti
  maximálisé, ami ellentmondás. Egy ilyen fázis ideje $O(n + m)$, azaz egy BFS
  vagy DFS ideje.

  Egy $P$ utat hasonlóan tudunk találni BFS/DFS-el, például úgy, hogy $e = (u
  v)$ élnek $u$ csúcsából visszafele keresünk $s$-be utat, és $t$-ből a $v$
  csúcsába. Így kapunk egy $t -> v -> u -> s$ utat.

  Összesen két BFS/DFS-t kellett elvégeznünk, így valóban $O(n + m)$ időben
  bonyolítottuk le a javítást.
]

