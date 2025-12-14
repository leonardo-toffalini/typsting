#import "@preview/thmbox:0.3.0": *
#show: thmbox-init()

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)
#set text(font: "Times New Roman")
#set page(numbering: "1")

// derive from some predefined function

#let exercise = exercise.with(
    variant: "Feladat", 
    color: blue,
)
#let solution = proof.with(
    title: "Megoldás", 
    color: green,
)

#let P = $bold("P")$
#let NP = $bold("NP")$
#let coNP = $bold("coNP")$
#let NPC = $bold("NPC")$
#let BPP = $bold("BPP")$
#let ZPP = $bold("ZPP")$
#let RP = $bold("RP")$
#let coRP = $bold("coRP")$
#let AC1 = $bold("AC"^1)$
#let NC1 = $bold("NC"^1)$

#align(center)[
  #text(blue, size: 25pt)[*Hatodik házifeladat*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  $
    "MAJORITY" in #AC1
  $
]

#solution[
  A *3.* feladat szerint összeadni két $n$ bites számot meg tudunk csinálni
  $O(1)$ mélységben. Akkor számoljuk ki, hogy hány darab $1$-es van az inputban úgy
  hogy megnézem, hogy hány $1$-es van a bal felében az inputnak és hány $1$-es
  van a jobb felében az inputnak, majd ezt a kettőt összeadom $O(1)$ mélységbe.

  Így egy rekurzív hálót kapok, aminek a mélységére igaz, hogy $T(n) = T(n\/2)
  + O(1)$, mert a két fél összeszámolását tudom egyszerre csinálni. Ez a
  reláció azt eredményezi, hogy $T(n) = O(log n)$.

  Most, hogy már tudom, hogy hány $1$-es van az inputban, a *2.* feladat
  szerint szintén $O(1)$ mélységben össze tudom ezt hasonlítani az $n\/2$-vel.

  Tehát végül azt kapom, hogy $O(log n)$ mélységben megszámolom az $1$-eseket
  és utána $O(1)$ mélységben összehasonlítom ezt a számot $n \/ 2$-vel.
]

#exercise[
  $
    "MAJORITY" in #NC1
  $
]

#solution[
  Az Ajtai, Komlós, Szemerédi rendező hálózattal rendezzük az $n$ bites inputot
  $O(log n)$ mélységű polinom méretű hálóval, amiben minden kapunak a  bemenete
  legfeljebb $2$. Miután rendeztük az input bitjeit, már elég csak megmondani,
  hogy milyen bit van az $n\/2$ helyen.

  (Előadáson említve volt, persze nem bizonyítva, az AKS rendező háló létezése
  és komplexitása.)
]

