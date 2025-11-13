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

#let P = $bold("P")$
#let NP = $bold("NP")$
#let coNP = $bold("coNP")$
#let NPC = $bold("NPC")$
#let BPP = $bold("BPP")$
#let ZPP = $bold("ZPP")$
#let RP = $bold("RP")$
#let coRP = $bold("coRP")$

#align(center)[
  #text(blue, size: 25pt)[*Ötödik házifeladat*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  $
    #NP^(#NP inter #coNP) = #NP
  $
]

#solution[

  *1.* $#NP^(#NP inter #coNP) subset.eq #NP$ \
  Ez az irány triviális, mert csak nem használjuk az orákulumot.

  *2.* $#NP^(#NP inter #coNP) supset.eq #NP$ \
  Ez az irány már érdekes.

  Legyen $A in #NP inter #coNP$ tetszőleges és $L in #NP^A$. Ez azt jelenti,
  hogy létezik egy $#NP$ orákulum gép $T^A$, ami legfeljebb polinom sok
  orákulum kérdéssel nemdeterminisztikusan felismeri $L$-et.

  Ekkor tetszőleges $x in Sigma_0^k$ inputra, a $K$ NDTG nemdeterminisztikusan
  tippeljen meg egy helyes lefutását $T^A$-nak az $x$ inputon. Tehát megtippel
  egy polinom hosszú $z$ szót, ami tartalmazza a $T^A$ által tett
  nemdeterminisztikus lépéseket sorrendben és az orákulum kérdéseket $q_i in
  Sigma_0^k$ és azokra kapott válaszokat $a_i in {0, 1}$. Ez lefutás felirat
  nyilván polinom hosszú lesz.

  Annyival bővítsük ki a $z$ futás feliratot, hogy minden orákulum kérdésnél,
  ahol $q_i in A$-ra a válasz igen volt, ott megtippelünk
  (nemdeterminisztikusan) egy polinomiális bizonyítékot $q_i in A$-ra.
  Különben, ahol $q_i in A$-ra a válasz nem volt, ott $q_i in overline(A)$-ra
  tippelünk egy bizonyítékot.

  Egy polinomiális futásidejű TG ezt a feliratot tudja ellenőrizni, hogy
  valóban egy helyes lefutása $T$-nek a megadott orákulum válaszok mellett,
  továbbá, minden tanu helyes a fel tett kérdés tartalmazásra, avagy nem
  tartalmazásra. 

  Ezzel beláttuk, hogy tetszőleges $A in #NP inter #coNP$-re $#NP^A supset.eq #NP$.

]

