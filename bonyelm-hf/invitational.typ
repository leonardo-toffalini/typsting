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

  Viszont tudjuk, hogy $Pi_k = "co"(Sigma_k)$ a De Morgan azonosság miatt,
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

  Fenomenális lenne ezt bizonyítani, mert az azt jelentené, hogy
  $k=0$-ra megoldottuk a hosszú idők óta nyílt kérdést $#P =^? #NP inter
  #coNP$.

  Mindenesetre, annyit tudunk bizonyítani, hogy
  $
    #P^(Sigma_k) subset.eq#NP^(Sigma_k) inter #coNP^(Sigma_k).
  $

  Ha $L in #P^(Sigma_k)$, akkor $L in #NP^(Sigma_k)$, mivel egy
  nemdegterminisztikus TG tud működni mint egy determinisztikus TG.

  Továbbá, ha $L in #P^(Sigma_k)$, akkor $overline(L) in #P^(Sigma_k) ==> L in #coNP^(Sigma_k)$.
]

#exercise[
  Mutassuk meg, hogy ha $#BPP = #RP union #coRP$, akkor $#BPP = #ZPP$.
]

#solution[
  Ha $#BPP = #RP union #coRP$, akkor $ #BPP = "co"(#BPP) = "co"(#RP union #coRP) = #coRP inter #RP = #ZPP. $
]

#exercise[
  Mutassuk meg, hogy a módosított GG játékben eldönteni, hogy ki nyer PSPACE teljes.
]

#solution[
  A visszavezetés nagyon hasonló lesz az előadáson látott TQBF $prop$ GG
  visszavezetésre. Annyi kell csak változtatnunk az ötleten, hogy amikor Bob
  lép, akor ne tudja megváltoztatni a kvantált formula jelentését, amit
  kódolunk a GG gráf struktúrájával.

  Ezt úgy fogjuk csinálni, hogy a gráf első fázisában, ami kódolja a
  kvantorokat és a változók értékadásait, ott Bob mindig csak olyan élen
  léphet, aminek a végén egy $1$ befokú csúcs van.

  Láthatjuk, hogy csak annyit kell csinálni, hogy a standard rombusz
  @fig:rombusz, helyett egy széthúzott rombuszt kell adni Bob-nak. És Bob a
  pirosra színezett éleken léphet.

  #figure(
    cetz.canvas({
      import cetz.draw: *

      circle((0 -2,  2), radius: 5.0pt, name: "1top")
      circle((-1 -2, 1), radius: 5.0pt, name: "1left")
      circle((1-2,   1), radius: 5.0pt, name: "1right")
      circle((0-2,   0), radius: 5.0pt, name: "1bot")

      circle((0+2,  3), radius: 5.0pt, name: "2top")
      circle((-1+2, 2), radius: 5.0pt, name: "2left1")
      circle((1+2,  2), radius: 5.0pt, name: "2right1")
      circle((-1+2, 1), radius: 5.0pt, name: "2left2")
      circle((1+2,  1), radius: 5.0pt, name: "2right2")
      circle((0+2,  0), radius: 5.0pt, name: "2bot")

      line("1top",   "1left", mark: (end: ">", scale: 0.6))
      line("1top",   "1right", mark: (end: ">", scale: 0.6))
      line("1left",  "1bot", mark: (end: ">", scale: 0.6))
      line("1right", "1bot", mark: (end: ">", scale: 0.6))

      line("2top",   "2left1", mark: (end: ">", scale: 0.6))
      line("2top",   "2right1", mark: (end: ">", scale: 0.6))
      line("2left1",   "2left2", mark: (end: ">", scale: 0.6), stroke: red)
      line("2right1",   "2right2", mark: (end: ">", scale: 0.6), stroke: red)
      line("2left2",  "2bot", mark: (end: ">", scale: 0.6))
      line("2right2", "2bot", mark: (end: ">", scale: 0.6))

    }),
    caption: [Rombusz és széthúzott rombusz]
  )<fig:rombusz>

]

#exercise[
  1. Mennyi $D^((3))(E Q)$?
  2. Mutass egy függvényt, amire $Omega(n)$ bit kommunikációja szükséges.
]

#solution[

  *1.*

  Protokoll:
  1. Ha Alíz azt látja, hogy $y = z$, akkor küld egy $1$ bitet, kölönben $0$-át
     küld.
  2. Innentől már Bob és Charlie is tudják $f(x, y, z)$ értékét.

  Mivel csak akkor lehet a három szám egyenlő, ha Alíz azt mondta, hogy $y = z$
  és Bob látja, hogy $x = z$. Alíz üzenete alapján Bob már tudja, hogy az ő
  száma megegyezik Charlie-ével, továbbá látja, hogy Charlie száma megegyezik
  Alízéval.

  Így a protokoll költsége $1$. Tehát $D^((3))(E Q) = 1$.

  *2.*
  
  Hasonlóképpen definiáljuk a kommunikációs mátrixot mint a standard
  determinisztikus két játékos esetben. Azaz legyen A-nak, B-nek, és C-nek
  egy-egy dimenziója. Tehát legyen $M$ a kommunikációs mátrix, ahol $M[x, y,
  z] = 1$, pontosan akkor, ha $f(x, y, z) = 1$.

  Figyeljük meg, hogy ezen játékszabályok szerint egy játékos tudja a másik két
  játékos értékét, tehát olyan mintha a kommunikációs mátrixnak egy oldalára
  vett vetületét látja csak.

  Ötlet: Találjunk ki egy olyan függvényt aminek a vetülete mindegyik oldalra
  egy csupa $1$-es mátrix. Továbbá, legyen ez a függvény a lehető _legritkább_.
  Azaz, ha lehet legyen olyan, hogy bármelyik oldal felől nézzük, mindegyik $1
  times 1 times 2^n$-es vektorban csak egy darab $1$-es.


  $
    forall i, j in [2^n] quad quad  sum_(k = 1)^(2^k) M[i, j, k] = 1
  $

  Képzeljünk el egy $2^n times 2^n$ -es táblázatot, ami olyan mint egy sudoku,
  csak elfeletkezünk a négyzetekről és csak a sorokat és oszlopokat figyeljük.
  Azaz, mindegyik sorban és mindegyik oszlopan mindegyik szám $1$-től $2^n$
  pontosan egyszer szerepel.

  Fixáljunk le egy $S$ helyesen kitöltött ilyen sudokut táblát és legyen az az
  $f(i, j, k)$ függvény, hogy $f(i, j, k) = 1$ pontosan akkor, ha $S[i, j] =
  k$.

  A sudoku szabályaink szerint így tényleg igaz, hogy bármelyik oldalról nézve
  csupa $1$-es mátrixot látunk, és a lehető legritkább.

  Azt állítom, hogy ehez a függvényhez legalább $n$ bit kommunikációja szükséges.

  Mivel mindegyik oldalról csupa $1$-et lát mindegyik játékos, ez azt jelenti,
  hogy nem kapnak semmi új információt az alapján, hogy látják a másik két
  játékos számait. Továbbá, egy játékos ha ránéz a saját vetületére nem tudja a
  mélységét egyik $1$-esnek sem. Tehát ahhoz, hogy bármelyik játékos tudja a
  saját vetületének a mélységét, a saját számát ismernie kell. Más szóval,
  legalább $n$ bit kommunikációja szükséges.

]

