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
#let solution = note.with(
    variant: "Megoldás", 
    color: green,
)

#align(center)[
  #text(blue, size: 25pt)[*Második házifeladat*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Adott egy $"poly"(n)$ méretű négyzetrács, amin Alíznak és Bobnak van egy-egy
  konvex $n$-szöge, koordináta listában megadva. Mutassuk meg, hogy $O(log ^2
  n)$ bit kommunikálásával el tudják dönteni, hogy üres-e a két sokszög
  metszete.
]

#solution[
  A protokoll a következő. Alíz megkérdezi Bob-tól hogy egy számtól jobbra vagy
  balra van az ő alakzata. Erre Bob megválasolja 1 bitben, hogy igen vagy nem.
  Alíz mindig olyan síkféltekre kérdez rá amiben az ő sokszöge is benne van.

  Ha a maradandó síkrész már kisebb mint egy négyzet és még mindig Bob-nak és
  Alíznak is ebben a részben benne van a sokszöge, akkor tudjuk hogy a metszet
  nem üres.

  Mivel a protokoll mindig felezi a maradó rácspontok számát, ezért $log
  ("poly"(n) dot "poly"(n))$ kérdés szükséges Alíz részéről. Nyilván $O("poly"(n)
  dot "poly"(n)) = O("poly"(n))$, továbbá $O(log "poly"(n)) = O(log n)$.

  Mivel $O(log n)$ kérdése volt Alíznak és minden kérdésben egy számot
  kérdezett, plusz egy bittel megmondta, hogy most vízszintesen vagy
  függőlegesen oszt ketté, ezért egy összesen $O(log ^2 n)$ a kommunikáció
  költsége.

  Az alábbi ábra illusztálja az állást az a két kérdés után, hogy
  + $y=0$-tól jobbra lévő félsíkban benne van-e a te sokszöged, Bob?
  + $x=0$-tól lefe lévő félsíkban benne van-e a te sokszöged, Bob?

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      line((3, -3), (0, -3), (0, 3), (3, 3), stroke: 0pt,
        fill: color.mix((red, 20%), white))
      line((-3, -3), (-3, 0), (3, 0), (3, -3), stroke: 0pt,
        fill: color.mix((red, 20%), white))
      line((0, -3), (0, 0), (3, 0), (3, -3), stroke: 0pt,
        fill: color.mix((red, 40%), white))
      line((-3, 0), (3, 0), stroke: red)
      line((0, -3), (0, 3), stroke: red)
      line((-2, 0), (-1.5, -1), (0, -1.5), (1, 1.5), stroke: blue, close: true)
      line((1, -2), (2, 0), (1, 2.5), (-2, 1.5), stroke: green, close: true)
      grid((-3, -3), (3, 3), step: 0.5, stroke: gray + 0.2pt)
    })
  ]

]

