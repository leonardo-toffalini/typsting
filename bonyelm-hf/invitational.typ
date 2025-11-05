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

#let proof = proof.with(
    title: "Biz", 
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
  #text(blue, size: 25pt)[*Bonyelm invitational*] \

  #text(size: 14pt)[Bonyolultság elmélet gyakorlat] \

  Toffalini Leonardo 
]

#exercise[
  Mutast meg, hogy ha a $#P$ és az $#NP$ osztályok nincsenek _összetapadva_
  (azaz nem egyenlőek), akkor létezik olyan $L in #NP \\ #P$ nyelv, ami nem
  $#NP$-teljes!
]

#solution[
  Legyen $A$ tetszőleges $#NP$-teljes nyelv, például $A = "SAT"$. Ekkor legyen
  $L = { x 0^(f(abs(x))) : x in A }$, ahol $f(n) = n^(log n)$.

  Azt állítom, hogy $L in #NP$ és $L in.not #P$ és $L in.not #NPC$.

  Érthetően $L in #NP$, mivel egy NDTG könnyen felismeri egy inputról, hogy
  $x^(f(abs(x)))$ alakú és kinyeri $x$-et az inputból. Mivel $x in A$ és $A in
  #NP$, ezért van olyan NDTG ami felismeri $A$-t, hát akkor a mi NDTG-énk is
  tudja szimulálni ezt polinomiális időben mind.

  $L in.not #P$, mivel ha $#P$-ben lenne, akkor az eredeti $A$ nyelvet is fel
  tudnánk ismerni $#P$-ben, viszont feltettük, hogy $#P != #NP$ és $A in #NPC$,
  ezért ez ellentmondás.

  $L in.not #NPC$, mivel ha $#NP$-teljes volna, akkor létezne polinomiális
  visszavezetés $A$-ról, mivel $A in #NPC$. Az $R : A -> L$ visszavezetés egy
  $w in A$ szót átalakít egy $y in L$ szóra polinomiális időben. Viszont $y = x
  0^(f(abs(x)))$, ahol $x in A$, így $abs(y) = abs(x) + f(abs(x))$, ami nem
  polinomiális $abs(x)$-ben. Így nem létezhet polinomiális visszavezetés
  $A$-ról $L$-re, és így $L in.not #NPC$.
]

#exercise[
  Mutasd meg, hogy $#P^(Sigma_k) = Sigma_(k+1) inter Pi_(k+1)$
]

#lemma[
  $ Sigma_(k+1) = #NP^(Sigma_k) $
  $ Pi_(k+1) = #coNP^(Sigma_k) $
]

#proof[

  $Sigma_(k+1) subset.eq #NP^(Sigma_k)$

  Definició szerint: $L in Sigma_(k+1) <==> exists P$ polinomiális reláció,
  hogy $exists y_1 forall y_2 dots Q y_(k+1) P(x, y_1, dots, y_(k+1))$.

  Egy NDTG nem determinisztikusan meg tudja tippelni $y_1$-et, így annyi marad,
  hogy $forall y_2 dots Q y_(k+1) P(x, y_1, dots, y_(k+1))$, ami pont $Pi_k$
  alakú, tehát $Sigma_(k+1) subset.eq #NP^(Pi_k)$.

  Viszont tudjuk, hogy $Pi_k = "co"(Sigma_k)$ De Morgan azonosság miatt,
  viszont egy NDTG-nek nem változtat, hogy egy $"co"(A)$ vagy $A$ orákuluma
  van. Így $Sigma_(k+1) subset.eq #NP^(Sigma_k)$, ahogyan kívántuk.

  $#NP^(Sigma_k) subset.eq Sigma_(k+1)$

  Egy NDTG egy $Sigma_k$ orákulumal nem determinisztikusan meg tud tippelni egy
  polinomiális tanut $z$, hogy $exists y_1 forall y_2 dots Q y_k P(x, z, y_1,
  dots y_k)$. Ez a nem determinisztikus tippelés ekvilalens a következő
  formuláva $exists z exists y_1 forall y_2 exists y_3 dots Q y_k P(x, z, y_1,
  y_2, dots y_k)$. Itt az első kettő egzisztenciális kvantort össze tudjuk
  olvasztani, és így az kapjuk, hogy $exists (z, y_1) forall y_2 exists y_3 Q
  y_k P(x, z, y_1, y_2, dots y_k)$, ami pont egy $Sigma_k$ formula, és mivel
  $Sigma_k subset.eq Sigma_(k+1)$ így készen vagyunk.

  A második állítást a lemmában hasonló módon lehet bizonyítani.
]


#solution[
  Az előző két lemma segítségével már csak azt kell bizonyítani, hogy 
  $
    #P^(Sigma_k) = #NP^(Sigma_k) inter #coNP^(Sigma_k).
  $

  Nagyon jó lenne, ha tudnánk ezt bizonyítani, mert az azt jelentené, hogy
  $k=0$-ra megoldottuk a hosszú idők óta nyílt kérdést $#P =^? #NP inter
  #coNP$.

  Mindenesetre, annyit tudunk bizonyítani, hogy
  $
    #P^(Sigma_k) subset.eq#NP^(Sigma_k) inter #coNP^(Sigma_k).
  $
]

#exercise[
  Mutassuk meg, hogy ha $#BPP = #RP union #coRP$, akkor $#BPP = #ZPP$.
]

#solution[
  Ha $#BPP = #RP union #coRP$, akkor $ #BPP = "co"(#BPP) = "co"(#RP union #coRP) = #coRP inter #RP = #ZPP. $
]

