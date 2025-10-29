#import "@preview/thmbox:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#show: thmbox-init()

= NP-n túl
== Polinomialis hierarchia

#definition[Polinomiális reláció][
  Azt mondjuk, hogy $P(x, y_1, y_2, dots, y_l)$ egy polinomiális reláció, ha
  $exists i$ úgy, hogy $forall i: |y_i| <= |x|^c$ es $P(x, y_1, dots, y_i)$
  kiszámolható $|x|$-ben polinomimális időben.
]

#definition[$Sigma_i$][
  Tetszőleges $L$ nyelvre $L in Sigma_i <=> exists P(x, y_1, dots, y_i)$
  polinomiális reláció úgy, hogy $x in L <=> exists y_1 forall y_2 exists y_3
  dots Q y_i$ úgy, hogy $P(x, y_1, y_2, dots, y_i)$ teljesül. Ahol $Q$ a
  következőképpen van definiálva:
    $
      Q = cases(
        forall & "ha" i "paros" \
        exists & "ha" i "paratlan"
      )
    $
]

#definition[$Pi_i$][
  Tetszoleges $L$ nyelvre $L in \Pi_i <=> exists P(x, y_1, dots, y_i)$
  polinomialis relacio ugy, hogy $x in L <=> forall y_1 exists y_2 forall
  y_3 dots tilde(Q) y_i$ ugy, hogy $P(x, y_1, y_2, dots, y_i)$ teljesul.
  Ahol $tilde(Q)$ a kovetkezokeppen van definialva:
  $
    tilde(Q) = cases(
      forall & "ha" i "paratlan" \
      exists & "ha" i "paros"
    )
  $
]

#example[
  Pár nevezetes bonyolultsági osztály amit már ismerünk:
  + $"NP" = Sigma_1$
  + $"co-NP" = Pi_1$
  + $"P" = Sigma_0 = Pi_0$
]

#remark[
  + Minden $i$-re $Sigma_i subset.eq Sigma_(i + 1)$. Valasszuk ugy a polinomimalis relaciot hogy az utolso valtozotol ne fuggjon.
  + Minden $i$-re $Pi_i subset.eq Pi_(i + 1)$. Valasszuk ugy a polinomimalis relaciot hogy az elso valtozotol ne fuggjon.
  + Minden $i$-re $Pi_i subset.eq Sigma_(i + 1)$.
  + Minden $i$-re $Sigma_i subset.eq Pi_(i + 1)$.
]

Ezen osztalyokat a kovetkezo hierarchiaval tudjuk vizualisan jellemezni.

#import "@preview/cetz:0.3.0": canvas, draw

#figure(
  canvas({
    import draw: *
    
    // Define the nodes with their positions
    let node-style = (stroke: black, fill: none, padding: 0.2)
    
    // Bottom level
    content((0, 0), [$Sigma_0 = "P" = Pi_0$], name: "P", ..node-style)
    
    // Second level
    content((-2, 1.5), [NP $= Sigma_1$], name: "Sigma1", ..node-style)
    content((2, 1.5), [$Pi_1$ = co-NP], name: "Pi1", ..node-style)
    
    // Third level
    content((-2, 3), [$Sigma_2$], name: "Sigma2", ..node-style)
    content((2, 3), [$Pi_2$], name: "Pi2", ..node-style)
    
    // Fourth level
    content((-2, 4.5), [$Sigma_3$], name: "Sigma3", ..node-style)
    content((2, 4.5), [$Pi_3$], name: "Pi3", ..node-style)
    
    // Dots
    content((-2, 5.5), [$dots.v$], name: "dots1")
    content((2, 5.5), [$dots.v$], name: "dots2")
    
    // Draw arrows
    line((-0.2, 0.2), (-1.8, 1.3), mark: (end: ">"))
    line((0.2, 0.2), (1.8, 1.3), mark: (end: ">"))
    line((-2, 1.7), (-2, 2.8), mark: (end: ">"))
    line((-1.3, 1.7), (1.7, 3), mark: (end: ">"))
    line((2, 1.7), (2, 2.8), mark: (end: ">"))
    line((1, 1.7), (-1.7, 3), mark: (end: ">"))
    line((-2, 3.3), (-2, 4.3), mark: (end: ">"))
    line((-1.8, 3.2), (1.7, 4.3), mark: (end: ">"))
    line((2, 3.3), (2, 4.3), mark: (end: ">"))
    line((1.7, 3.2), (-1.7, 4.3), mark: (end: ">"))
  }),
  caption: [Polinomiális hierarchia vizualizáció]
) <fig:poli-hier>


#definition[Polinomialis Hierarchia][
  $
    "PH" = union.big_{i=1}^infinity Sigma_i = union.big{i=1}^infinity Pi_i
  $
]

#definition[
  $
    "INDEPENDENT" := { (G, m) : alpha(G) >= m }
  $
  azaz, azon $G$ grafok es $m$ szamok parosai, melyekre $G$ fuggetlensegi
  szama nagyobb mint $m$.
]

#definition[
  $
    "EXACT_INDEPENDENT" := { (G, m) : alpha(G) = m }
  $
  azaz, azon $G$ grafok es $m$ szamok parosai, melyekre $G$ fuggetlensegi szama
  nagyobb pont $m$.
]

#proposition[
  $
    "EXACT_INDEPENDENT" in Sigma_2
  $
]

#proof[
  $exists H subset.eq V(G)$ fuggetlen csucshalmmaz es $|H| = m$ \
  $forall H' subset.eq V(G)$ csucshalmazra, ahol $|H| = m + 1$ mar $H'$ osszefuggo.
]

#remark[
  A letezest ($exists$) es a mindent ($forall$) nem kell polinomialis idoben
  szamolni, csak a $H$-t es $H'$-t kell polinomialis idoben ellenorizni.
]

#theorem[
  Ha $exists i >= 1$ amire $Sigma_i = Pi_i$, akkor $Sigma_{i+1} =
  Pi_(i+1)$, amibol tovabb kovetkezik, hogy $"PH" = Sigma_i = Pi_i$. Azt
  mondjuk, hogy a polinommialis hierarchia #emph[osszeomlik] az $i$-edik
  szintre.
]

#proof[
  Mivel tudjuk, hogy $Sigma_i subset.eq Sigma_(i+1)$, ezert eleg azt
  belatnunk, hogy $Sigma_(i+1) subset.eq Sigma_i$ es ezzel belatjuk, hogy
  $Sigma_i = Sigma_(i+1)$. Hasonlo modon be tudjuk latni hogy $Pi_i =
  \i_(i+1)$.

  Legyen $L in Sigma_(i+1)$ tetszoleges nyelv, bizonyitsuk be hogy $L in
  Sigma_i$. Mivel $L in Sigma_(i+1)$, ezert letezik egy $P$ polinomialis
  relacio, melyre
  $
    x in L <=> exists y_1 forall y_2 exists dots Q y_(i+1) P(x, y_1, dots, y_i).
  $
  Tovabba, letezik egy $L' in Pi_i$ nyelv, melyre
  $
    x in L <=> exists y_1 : (x, y_1) in L'.
  $
  Figyelem, itt csak annyi tortent hogy beillesztettuk egy extra $y_1$ valtozot
  a letezes ($exists$) kvantorral a $\Pi_i$ definicio ele, igy kaptunk egy
  definiciot $Sigma_(i+1)$-re.

  Mivel $Sigma_i = Pi_i$, ezert $L' in Sigma_i$, tehat letezik egy
  polinomialis relacio $S$ ugy, hogy
  $
    x in L <=> exists y_1 exists y_2 forall dots Q y_(i+1) S(x, y_1, dots, y_i).
  $
  Csoportosithatjuk $y_1$-et es $y_2$-t.
  $
    x in L <=> exists (y_1, y_2) forall dots Q y_(i+1) S(x, (y_1, y_2), dots, y_i).
  $
  A jobboldalon $i$ darab kvantor van es pont abban a sorrendben mint ahogy
  kell lenniuk $Sigma_i$ definiciojahoz. Tehat belattuk, hogy ha $L \in
  Sigma_(i+1)$ akkor $L in Sigma_i$.
]

#theorem[Savitch][
  Ha $forall n f(n) >= n$, akkor
  $
    "NSPACE"(f(n)) subset.eq "DSPACE"(f^2 (n))
  $
]

#proof[
  Legyen $L in "NSPACE"(f(n))$ egy tetszőlegese nyelv, a célunk megmutatni,
  hogy $L$ felismerhető egy determinisztikus Turing-géppel $f^2(n)$ tárban.

  Figyeljük meg, hogy aha egy Turing-gép $t$ tárat használ futása alatt, akkor
  legfeljebb $O(2^(c dot t))$ különböző konfigurációba kerülhet.

  Tudjuk, hogy van egy nemdeterminisztikus Turing-gép mely felismeri az $L$
  nyelvet, tehát a konfigurációs gráfban van út a kezdőállapotból a
  reprezentáns elfogadó állapotok csúcsába. Mivel legfeljebb $2^(c dot f(n))$
  konfiguráció van, ezért egy elfogadó út hossza legfeljebb $2^(c dot f(n))$.

  Ha tudunk mutatni egy determinisztikus Turing-gépet ami el tudja dönteni egy
  gárfban, hogy adott $s$ és $t$ csúcsok között van-e út $O(log^2 n)$ tárban,
  akkor a konfigurációs gráfra alkalmazva $O(f^2(n))$ méretű tárat használó
  eljárást adnánk $L$ felismerésére.

  Megmutatjuk, hogy $O(log^2 n)$ tárban el tudjuk dönteni, hogy $s$ és $t$
  között megy-e út egy adott $G$ gráfban. Legyen $"st-conn"(k, s, t)$ az
  algoritmus ami eldönti, hogy legfeljebb $k$ hosszú út van-e $s$ és $t$
  között. Nyilvan ha van olyan $u in V(G)$ csúcs mely $s$-ből elérhető
  legfeljebb $k \/ 2$ hosszú úton és $u$-ból $t$ elérhető legfeljebb $k \/ 2$
  hosszú úton, akkor $s$-ből $t$ is elérhető legfeljebb $k$ hosszó úton.

  Tehát a következőképpen néz ki a rekurziónk:
  $
    cases(
      "st-conn"(0, s, t) = (s =^? t),
      "st-conn"(1, s, t) = (s t) in^? E(G),
      "st-conn"(k, s, t) = exists ? u in V(G): "st-conn"(k \/ 2, s, u) and "st-conn"(k \/ 2, u, t).
    )
  $

  Látszik, hogy a rekurzió mélysége $O(log n)$ és mindegyik rekurzív hívásban
  csak a függvény argumentumait kell tárolnunk amiket bitekben $O(log n)$
  tárban meg tudjuk oldani. Tehát az $"st-conn"$ algoritmus $O(log^2 n)$ tárban működik, és ezzel készen is vagyunk, mivel
  $
    (log (2^(c dot f(n))))^2 = (c dot f(n) dot log 2 )^2 = c^2 dot f^2(n) = O(f^2 (n)).
  $
]

#corollary[
  $
    "NPSPACE" = "PSPACE"
  $
]

#proof[Polinom négyzete polinom.]

== PSPACE teljesség
#definition[PSPACE teljesség][
  Azt mondjuk, hogy $L$ PSPACE teljes, ha $L in "PSPACE"$ és $forall L' in
  "PSPACE"$ nyelvre $L' prop L$. Tehát $L'$ visszavezethető $L$-re polinomiális
  #emph[időben].
]

#definition[tqbf -- Totally Quantified Boolean Formula][
  Azt mondju, hogy $phi$ egy teljesen kvantifikált Boole-formula, ha olyan
  alaba írható, hogy 
  $
    phi = Q_1 x_1 Q_2 x_2 dots Q_l x_l f(x_1, x_2, dots, x_l),
  $
  ahol $Q_i in {forall, exists}$ és $x_i$ Boole változók és $f(x_1, dots, x_l)$
  egy konjunktív normál formula (CNF).
]

#example[
  $
    phi = forall x exists y exists z ((x or z) and y)
  $

  Ez a formula igaz.
]

#remark[
  Egy tqbf vagy igaz vagy hamis. Nem olyan mint egy CNF ahol az a kérdés hogy van-e helyes behelyettesítése, hanem magát a kvantálás megválaszolja, hogy a formula igaz vagy hamis.
]

#definition[TQBF -- True Quantified Boolean Formula][
  $
    "TQBF" := {phi, " ahol" phi "egy tqbf és" phi = "true"}.
  $
  Azaz TQBF az igaz teljesen kvantifikált Boole formulák nyelve.
]

#theorem[
  A $"TQBF"$ nyelv $"PSPACE"$ teljes.
]

#proof[

  *1. $"TQBF" in "PSPACE"$*

  Végezzünk teljes indukciót a kvantorok számára. Ha $(n - 1)$ kvantoros tqbf
  ellenörzését el tudjuk végezni $"poly"(n)$ tárban, akkor $n$ kvantoros tqbf
  ellenörzésénél csak $1$-el több bitet kell tárolnom a kvantor típsára és meg
  $x_n$ értékét.

  *2. $forall L in "PSPACE": L prop "TQBF"$*

  Röviden megemlítjük, hogy ebben az esetben nem tudjuk azt a trükköt
  eljátszani amivel bizonyítottuk, hogy $"SAT" in "NPC"$, mert a Turing-gép
  összes szabályos lépését leíró formula hossza már bőven nem polinomiális
  lesz. Ez a trükk azért működött a SAT feladatnál, mert ott polinomiális
  időben kellett ellenőriznünk, itt viszont a tárnak kell polinomiálisnak
  lennie.

  Az ötlet, hogy újra felhasználjuk az $"st-conn"$ feladatot. Ha fel tudjuk
  írni az $"st-conn"$ feladatot mint egy polinomiálisan méretű tqbf a kezdő
  csúcsra és az elfogadó csúcsok reprezentására a konfiguráció gráfra, akkor
  készen lennénk. Mivel bármilyen polinoiális tárban felismerhető nyelvet át tudunk
  írni polinomiális időben egy polinomiálisan hosszú tqnf-re.

  Nézzük mit ad a köztes csúcs trükk amit már használtunk a Savitch tétel
  bizonyításában:
  $
    "st-conn"(k, s, t) <=> exists u in V: "st-conn"(k \/ 2, s, u) and
  "st-conn"(k \/ 2, u, t).
  $

  A probléma ezzel a felírással, hogy bár feleztük a $k$ paramétert, de a
  formula hossza nőt, tehát összességében nem értünk el érdembeli javulást.

  A trükk az, hogy kihasználjuk az univerzális kvantort ($forall$), hogy ne
  kelljen dupláznunk a formula méretét:
  $
    "st-conn"(k, s, t) <=> exists u in V forall (x, y) in {(s, u), (u, t)}: "st-conn"(k \/ 2, x, y).
  $

  Ha az $L$ nyelvet $t$ tárban felismerte egy Turing-gép, akkor legfeljebb
  $2^(c dot t)$ konfigurációja van. Tehát a konfigurációs gráfnak legfeljebb
  $2^(c dot t)$ csúcsa van. Mivel a jobboldali formula mérete polinomiális és $k$ értékét mindig felezzük, ezért a végső formula mérete polinomiális lesz.

]

#definition[Generalized Geography játék][
  Legyen $(G, u)$ egy rendezett pár, ahol $G$ egy irányított gráf és $u in
  V(G)$ a gráf egy adott csúcsa. A játékot Alíz és Bob játsza a következő
  szabályok alapján:
  - Alíz kezd az $u$ csúcsból.
  - Alíz és Bob felváltva lépnek.
  - A jelenlegi csúcsból csak belőle kifele menő élel keresztül szabad lépni a
    következő csúcsba.
  - Már látogatott csúcsba tilos lépni.
  - Ha a soron következő játékosnak már nincs szabályos lépése, akkor az
    ellenfél nyer.
]

#remark[
  Ez a játék az általánosítása az ország-város játéknak, ahol felváltva
  sorolunk városokat azzal a megkötéssel, hogy a következő város azzal a
  betűvel kezdőthet amivel az előző végződött és az veszít aki már nem tud
  várost mondani.
]

#definition[Generalized Geography osztály][
  $
    "GG" = {(G, u): "Alíznak van nyerő stratégiája" u"-ból indulva"}.
  $
]

#theorem[
  A $"GG"$ nyelv $"PSPACE"$ teljes.
]

#proof[

  *1. $"GG" in "PSPACE"$*

  Végezzünk teljes indukciót a leghosszabb út hosszára. Ha polinomiális tárban
  el tudjuk dönteni, hogy Bob-nak nincsen stratégiája legfeljebb $(n-1)$ hosszú
  útra, akkor tudjuk, hogy Alíznak van nyerő stratégiája.

#align(center)[
  #let nodes = ($u$, $v_1$, $v_2$, $v_3$, $v_4$, $dots$, $v_i$)
  #let edges = (
    (0, 1),
    (0, 2),
    (0, 3),
    (0, 4),
    (0, 5),
    (0, 6),
    (0, 5),
  )

  #diagram({
    for (i, n) in nodes.enumerate() {
      let θ = 180deg - i*360deg/nodes.len()
      node((θ, 18mm), n, stroke: 0.5pt, name: str(i))
    }
    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }
  })
  ]

  Nézzük meg $u$-nak az összes ki-szomszédkára, hogy Bob-nak nincs nyerő
  stratégiája. Mivel minden szomszédra polinomiális tárban eldönthetjük, és a
  tárat újra tudjuk használni, ezért az egész feladatot el tudjuk dönteni
  polinomiális tárban.


  *2. $"TQBF" prop "GG"$*

#align(center)[
  #let nodes = (
    (0, 0),
    (-1, 0.5),
    (1, 0.5),
    (0, 1),
    (0, 1.7),
    (-1, 2.2),
    (1, 2.2),
    (0, 2.7),
    (0, 4.4),
    (-1, 4.9),
    (1, 4.9),
    (0, 5.4),

    (7, 3),

    (5, 1),
    (3, 0.5),
    (3, 1),
    (3, 1.5),

    (5, 3),
    (3, 2.5),
    (3, 3),
    (3, 3.6),
  )
  #let edges = (
    (0, 1),
    (0, 2),
    (1, 3),
    (2, 3),
    (3, 4),
    (4, 5),
    (4, 6),
    (5, 7),
    (6, 7),
    (8, 9),
    (8, 10),
    (9, 11),
    (10, 11),

    (12, 13),
    (12, 17),

    (13, 14),
    (13, 15),
    (13, 16),

    (17, 18),
    (17, 19),
    (17, 20),
  )

  #diagram({
    for (i, n) in nodes.enumerate() {
      node(n, "", stroke: 0.5pt, name: str(i))
    }

    node((rel: (-0.5, -0.2), to: <0>), "true")
    node((rel: (0.5, -0.2), to: <0>), "false")
    node((0, 0.0), $u$)
    node((3.02, 0.5), $x_1$)
    node((3.02, 1.0), $x_2$)
    node((3.02, 1.5), $x_3$)
    node((rel: (-0.5, 0), to: <1>), $x_1$)
    node((rel: (-0.5, 0), to: <5>), $x_2$)
    node((rel: (-0.5, 0), to: <9>), $x_k$)

    node((3, 4.1), $dots.v$, stroke: 0.0pt)
    node((5, 3.5), $dots.v$, stroke: 0.0pt)
    node((5, 5), "", stroke: 0.1pt, name: str(99))
    node((1.8, 2.3), "", stroke: 0.0pt, name: str(98))
    edge(label(str(12)), label(str(99)), "..>")

    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }


    edge(label(str(11)), label(str(12)), "-|>", bend: -65deg)

    edge(label(str(7)), label(str(8)), "--|>")
    edge(label(str(14)), label(str(2)), "-|>", bend: -10deg)
    edge(label(str(15)), label(str(5)), "-|>", bend: 12deg)
    edge(label(str(16)), label(str(98)), "..>", bend: 8deg)

  })
  ]

]

