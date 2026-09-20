#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/cetz:0.4.2"
#import "@preview/intextual:0.1.0": flushr, intertext-rule
#show: thmbox-init()

#set text(font: "Times New Roman")
#set page(numbering: "1")

#show math.equation.where(block: false): box

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

#let solution = proof.with(
    title: "Solution", 
)

#align(center)[
  #text(blue, size: 25pt)[*Homework 2*] \

  Toffalini Leonardo
]

#exercise[
  Milyen értelemben ekvivalensek az $dot(x) = 2 x$ és az $dot(y) = y + 2$
  egyenletek? Adjuk meg a megfelelő $h$ és $a$ függvényeket.
]

#solution[
  Először írjuk fel a két egyenlet megoldását dinamikai rendszerekként:
  $
    x(t) &= phi(t, p) = e^(2 t)p \
    y(t) &= psi(t, p) = e^t (p + 2) - 2,
  $
  ahol a $psi$-ben a zárójelen belül hozzá kell adnunk egy extra $+2$-t hogy
  teljesüljön a dinamikai rendszer definiciójában szerepló $psi(0, p) = p$.

  Keressük megfelelő $h$ és $a$ függvényeket, hogy teljesüljön az alábbi
  $
    h(phi(t, p)) &= psi(a(t, p), h(p)) \
    h(e^(2 t) p) &= e^(a(t, p)) (h(p) + 2) - 2.
  $

  Első próbálkozásra nézzük meg $h(p) = sqrt(p)$ függvényt $a(t, p) = t$-vel
  $
    e^t sqrt(p) =^? e^t (sqrt(p) + 2) -2.
  $

  Ez alapján módosítjuk $h$-t a következőre $h(p) = sqrt(p) - 2$ hogy a
  zárójelen belül kioltsuk a $+2$-t. Ezzel
  $
    e^t sqrt(p) - 2 =^? e^t (sqrt(p) - 2 + 2) -2 = e^t sqrt(p) - 2.
  $
  már teljesül.

  Egyetlen szépség hibát kell még megoldanunk, hogy a jelen $h$ függvény nem
  homeomorfizmus, ezt könnyen orvosolhatjuk ha kiterjesztjük értelmesen $h$-t a
  negatív számokra is a következő definícióval0
  $
    h(p) = cases(
      sqrt(p) - 2 & " ha " p >= 0,
      - sqrt(-p) - 2 & " ha " p < 0
    )
  $

  Ellenőrízhető, hogy ezzel a $h$-val is teljesül az egyenlet és ez a $h$ már
  homeomorfizmus.

  Már csak annyit kell belátnunk, hogy minden $k >= 1$-re nem létezhet $h$ ami
  $C^k$-diffeomorfizmus.

  Tegyük fel, hogy mégis létezik ilyen $h$, ekkor írjuk fel a definiciót,
  deriváljunk $p$ szerint és helyettesítsünk $p=0$-t
  $
    h(phi(t, p)) &= psi(t, h(p)) \
    h(e^(2 t) p) &= e^t (h(p) + 2) - 2 \
    h'(e^(2 t) p) e^(2 t) &= e^t h'(p) \
    h'(0) e^(2 t) &= e^t h'(0).
  $
  Mivel $h$ diffeomorfizmus ezért létezik inverze, tehát azt kapjuk hogy $e^(2
  t) = e^t$ ami ellentmondás, tehát nem létezhet $h$ diffeomorfizmus.

]

#pagebreak()

#exercise[
  Milyen értelemeben ekvivalensek az alábbi rendszerek?
  $
    cases(
      dot(x_1) = x_2,
      dot(x_2) = -x_1
    )
  $
  és az
  $
    cases(
      dot(y_1) = 2 y_2,
      dot(y_2) = -2 y_1
    )
  $
  Adjuk meg a megfelelő $h$ és $a$ függvényeket.
]

#solution[
  A két rendszert fel lehet írni mátrixos alakba $dot(x) = A x$ és $dot(y) = B y$, ahol
  $
    A = mat(0, 1; -1, 0) quad " és " quad B = mat(0, 2; -2, 0).
  $

  Az órán belátott állítás alapján a két rendszer pontosan akkor
  $C^k$-ekvivalens ($k>=1$), ha $A$ és $B$ lineárisan ekvivalensek, azaz
  létezik olyan $alpha > 0$ és $P$ invertálható mátrix, mellyel $A = alpha P B
  P^(-1)$.

  Továbbá, az állítás bizonyításából megkapjuk azt is hogy $h(p) = P p$ és
  $a(t, p) = alpha t$ függvényekkel teljesül a $C^k$-ekvivalencia a két rendszer
  között.

  Könnyen belátható hogy $P = I$ és $alpha = 2$ értékadással a két mátrix
  lineárisan ekvivalens, tehát $C^k$-ekvivalensek $h(p) = p$ és $a(t, p) = 2 t$
  függvényekkel.
]

