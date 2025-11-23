#import "@preview/thmbox:0.3.0": *
#import "@preview/cetz:0.4.2"
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
  #text(blue, size: 25pt)[*Hetedik házifeladat*] \

  #text(size: 14pt)[Algoritmuselmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Mutasd meg, hogy nem feltétlen teljes páros gráfban minden stabil
  párosításban ugyanazoknak a csúcsoknak van párja.
]

#solution[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 120%, y: 120%)

      let girl_nodes = ((-2, 0), (-1, 0), (0, 0),    (1, 0), (2, 0))
      let girl_labels = ($l_1$,       $$,     $$, $l_(k-1)$,  $l_k$)

      let boy_nodes = ((-2, -2), (-1, -2), (0, -2), (1, -2), (2, -2), (3, -2))
      let boy_labels = ($f_1$,      $f_2$,      $$,      $$,  $f_k$, $f_(k+1)$)

      for (node, label) in girl_nodes.zip(girl_labels) {
        circle(node, radius: 5pt)
        content(node, label, anchor: "south", padding: 10pt)
      }

      for (node, label) in boy_nodes.zip(boy_labels) {
        circle(node, radius: 5pt)
        content(node, label, anchor: "north", padding: 10pt)
      }

      for (boy, girl) in boy_nodes.zip(girl_nodes) {
        line(boy, girl, stroke: 1.5pt + blue.lighten(20%))
      }

      for (girl, boy) in girl_nodes.zip(boy_nodes.slice(1)) {
        line(boy, girl, stroke: 1.5pt + red.lighten(20%))
      }

      content((-2.5, -1), text(blue.lighten(20%))[$M_1$])
      content(( 3.0, -1), text( red.lighten(20%))[$M_2$])
    })
  ]

  Tegyük fel, hogy az eredeti #text(blue.lighten(20%))[$M_1$] párosítás stabil,
  továbbá, az #text(red.lighten(20%))[$M_2$] párosítás is stabil.

  Mivel $M_1$ stabil volt, ezért $(f_(k+1), l_k)$ él nem blokkoló, tehát $l_k$
  jobban szereti $M_1$-beli párját, $f_k$-t, mint $f_(k+1)$-et, mert ugye
  $f_(k+1)$-nek nem volt párja $M_1$-ben, aminél bárkit jobban szeret aki a
  listáján van.

  Mivel $M_2$ is stabil, ezért $(f_k, l_k)$ él nem blokkoló, tehát $f_k$ jobban
  szereti $l_(k-1)$-et, mint $l_k$-t, mert $l_k$-ról már tudjuk, hogy $f_k$-t
  szereti jobban a két opció közül.

  Ezt az érvelést folytathatjuk, ameddig vissza nem probagáltuk a preferencia
  sorrendet $f_1$-hez, ahol azt kapjuk, hogy $l_1$ jobban szereti $f_1$-et,
  mint $f_2$-t, mert $(f_2, l_1)$ nem blokkolja $M_1$-et. Viszont $f_1$ jobban
  szeretne $l_1$-el lenni mint senkivel, ezért $(f_1, l_1)$ blokkoló él
  $M_2$-ben.

  Tehát azt kaptuk, hogy nem lehet két párosítás is stabil, ha a két
  párosításban nem pont ugyanazok a csúcsok vannak párosítva.
]

