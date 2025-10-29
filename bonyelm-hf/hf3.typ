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
#let solution = note.with(
    variant: "Megoldás", 
    color: green,
)

#align(center)[
  #text(blue, size: 25pt)[*Harmadik házifeladat*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Mutasd meg, hogy a Generalized Geography játéknak az a verziója is *PSPACE*-teljes, hogy az egyik játékos kettőt lép, a másik meg csak egyet.
]

#solution[
  Visszavezetjük a *TQBF* nyelvet erre a módosított GG nyelvre. Emlékezzünk
  vissza, hogy a *TQBF* $prop$ *GG* visszavezetésben, ha a változók
  kvantálásában nem pont felválta jöttek az univerzális és az egzisztenciális
  kvantorok, akkor beillesztettünk Alíznak avagy Bobnak egy egyértelmű lépést,
  hogy a sor visszakerüljön a másik játékosra.

  Hasonló trükköt tudunk elvégezni ezen módosított GG nyelvre visszavezetésben
  is. Tegyük fel, hogy Alíznak van mindig kettő lépése, míg Bobnak csak egy.
  Ebben az esetben, a visszavezetésben, amikor a gráfon Alízon lenne a sor
  beillesztünk még egy triviális lépést ahol éppen Alízon lenne. Így valójában
  lépett egyet Alíz ahol volt döntése és utána döntés nélkül tovább lép, így
  két lépés után Bobon a sor.

  Ezzel a trükkel visszavezettük a *TQBF* nyelvet ezen módosított *GG* nyelvre,
  tehát beláttuk, hogy ez a nyelv is *PSPACE* teljes.
]

