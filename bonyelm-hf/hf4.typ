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
  #text(blue, size: 25pt)[*Negyedik házifeladat*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Adj egy $tilde(O)(n^2)$ idejű randomziált algoritmust, ami edlönti az $A, B,
  C$ $n times n$-es egész mátrixokról, hogy $A dot B = C$ igaz-e. Melyik osztályba van ez az algoritmus *RP*, *co-RP*, és *BPP* közül?
]

#lemma[Schwartz--Zippel][
  Legyen $P in ZZ[x_1, dots, x_n]$ egy nem azonosan nulla polinom, aminek a foka
  legalább $d >= 0$. Legyen $S$ egy véges halmaz és $r_1, dots, r_n in S$
  véletlen elemek. Ekkor 
  $
    PP(P(r_1, dots, r_n) = 0) <= d/abs(S).
  $
]

#solution[
  $
    A dot B = C <==> A B - C = 0
  $

  Ha $A B - C = 0$, akkor $(A B - C) x = 0$ minden $x in RR^n$-re. Nyilván $A B
  - C$ is egy $n times n$-es egész mátrix.

  Figyeljük meg, hogy egy $c dot x$ skaláris szorzat érthető úgy mint egy $c$
  együthatókkal rendelkező $n$ változós elsőrendű polinomba behelyettesítés:
  $
    x_1 c_1 + x_2 c_2 + dots + x_3 c_n.
  $

  Ha $A B - C$ sorait a $c_i$ vektorok jelölik, akkor $(A B - C)x = 0$
  ekvivalens azzal, hogy $x$ gyöke a $c_i$ együtthatús elsőfokú $n$ változós
  polinomoknak.

  Tehát az algoritmus csak annyit fog csinálni, hogy kiválaszt véletlenül egy
  $n$ hosszú $x$ vektort egy kellően nagy halmazból és leteszteli, hogy $(A B -
  C)x =^? 0$.

  Ha van olyan koordináta ami nem $0$, akkor fixen $A B != C$, ha viszont a
  csupa nulla vektort kapjuk eredményül, akkor csak kis eséllyel tévedünk.

  Amikor a nem választ mindig eltaláljuk és az igenlő válasznál mindig
  legfeljebb $1/2$ eséllyel tévedünk az a *co-RP* definíciója. Tehát ez a
  feladat *co-RP*-ben van. Mivel *co-RP* $subset.eq$ *BPP*, ezért *BPP*-ben is
  benne van ez a feladat.

  Ennek az algortimusnak a futásideje valóban négyzetes (logaritmusoktól
  eltekintve), mivel sosem szoroztunk össze mátrixokat, csak mátrix-vektor
  szorzatot számoltunk, ami négyzetes időben könnyen kiszámolható.
  Újra zárójelezve látjuk, hogy
  $
    (A B - C)x = A (B x) - C x,
  $
  ahonnan valóban csak három mátrix-vektor szorzatot és egy vektor-vektor
  kivonást kell elvégeznünk RAM-gépen, amit meg tudunk csinálni $tilde(O)(n^2)$
  időben.
]

