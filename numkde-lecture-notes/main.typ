#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/commute:0.3.0": node, arr, commutative-diagram
#show: thmbox-init()

= KDE numerikus módszerei
== Alapfogalmak

#definition[kezdeti-érték-feladat][
  Legyen $G subset RR^(d + 1)$ egy tartomány, $t_0, u_0 in G$ egy
  adott pont ($t_0 in RR, u_0 in RR^d$), $f: G -> RR^d$ egy folytonos
  leképezes. Az
  $
    cases(
      u'(t) &= f(t, u(t)),
      u(t_0) &= u_0
    )
  $
  feladatot kezdeti-érték-feladatnak, más szóval Cauchy-feladatnak nevezzük.
]

#definition[kezdeti-érték-feladat megoldása][
  Az olyan $u : U -> RR^d$ ($I$ egy nyílt intervallum) folytonosan
  differenciálható függvényt, melyre

  + ${ (t, u(t)) : t in I } subset G$
  + $u'(t) = f(t, u(t)) quad forall t in I$
  + $t_0 in I$ és $u(t_0) = u_0$
  a kezdeti-érték-feladat megoldásának nevezzük
]

#definition[][
  Legyen $G subset RR times RR^d$ tartomány. Az $f: G -> RR^d$ függvényt a
  második változójában Lipschitz-tulajdonságúnak nevezzük, ha $exists L >= 0 :
  forall (t, p_1), (t, p_2) in G$ esetén
  $
        \|f(t, p_1) - f(t, p_2)\| <= L #sym.dot \|p_1 - p_2\|.
$
]

#theorem[Picard--Lindelöf][
  Legyen $f: G -> RR^d$ folytonos függvény, ahol 
  $
    G := {  (t, n) in RR times RR^d : \||t - t_0\|| <= a "és" \||u - u_0\|| <=
  b }
  $ henger, $t_0, u_0 in RR times RR^d$ és $0 < a < infinity, 0 < b <
  infinity$. Legyen $m = max_{(t, u) in G} \||f(t, u)\||$, továbbá tegyük
  fel, hogy az $f$ függvény második változójában Lipschitz-tulajdonságú. Ekkor
  a Cauchy-feladatnak egyértelműen létezik megoldása $[t_0 - delta, t_0 +
  delta]$ intervallumon, ahol $delta = min {a, b/m}$.
]

A numerikus módszerek alapfogalmai megértéséhez vizsgáljuk a következő skaláris Cauchy-feladatot:
$
  cases(
    u'(t) = f(t, u(t))\, quad t in [0, T],
    u(0) = u_0
  )
$

== Általános egylépéses numerikus módszerek
Definiáljunk egy egyenlő lépésközű
$
  omega_h := { t_n = n h, quad n = 0, dots, N, quad h = I / N }
$
úgynevezett ekvidisztáns rácshálót.

Jelölje $y_h$ az $omega_h$-n értelmezett rácsfüggvényt. Célunk egy $y_h(t_n$ rácsfüggvény megválasztása, hogy a pontos megoldás ezen a rácspontjaikhoz közel legyen, azaz
$
  y_h(t_n) approx u(t_n) quad forall t_n in omega_h.
$

#align(center)[
#let x = lq.linspace(3, 9, num: 10)

#lq.diagram(
  width: 8cm,
  height: 5cm,
  lq.plot(
      x, x.map(x => calc.sin(x)),
    ),

    lq.plot(
      x, x.map(x => calc.sin(x) + 0.1),
      stroke: none,
    )
)
]

#remark[
  A továbbiakban már az $y_n$ rövidítést használjuk.
]

A legegyszerűbb numerikus módszereket az $u'(t)$ közelítésére tanult véges differenciaeljárásokkal származtatjuk.

*Explicit Euler (EE)*
$
  u'(t_n) approx (y_(n + 1) - y_n)/h
$

$
  f(t_n, u(t_n)) approx f(t_n, y_n)
$

Az előző kettő egyenletből következik az Explicit Euler általános lépése:
$
  y_(n+1) = y_n + h f(t_n, y_n),
$
ahol $y_0$ adott kezdőpont.


Hasonlóképpen néz ki az Implicit Euler (IE) módszer lépése, viszont itt az előre differencia helyett a hátra differenciát használjuk a derivált közelítésére.

*Implicit Euler (IE)*
$
  u'(t_n) approx (y_n - y_(n-1))/h
$

$
  y_(n+1) = y_n + h f(t_(n+1), y_(n+1)),
$
ahol szintén adott $y_0$ kezdőpont.

Ezeknek az egylépéses módszereknek tekintsük az alábbi általános egylépéses alakját
$
  y_(n+1) = y_n + h Phi(h, t_n, y_n, y_(n+1))
$
ahol $Phi$ a numerikus módszert meghatározó adott függvény.

#remark[
  + Ha $Phi equiv Phi(h, t_n, y_n)$, akkor explicit a módszer.
  + Ha $Phi equiv Phi(h, t_n, y_n, y_(n+1))$, akkor implicit a módszer.
  + Ha $Phi equiv f(t_n, y_n)$, akkor visszakapjuk az Explicit Euler módszert.
  + Ha $Phi equiv f(t_(n+1), y_(n+1))$, akkor visszakapjuk az Implicit Euler módszert.

]


#definition[Globális diszkretizációs hibafüggvény][
  Az $e_h (t^*) = y_n - u(t^*)$ függvényt a $Phi$ numerikus módszer $t^*$
  pontbeli globális diszkretizációs hibafüggvényének nevezzük, ahol $n h = t^*$
  rögzített pont.
]

#definition[Konvergencia][
  Azt mondjuk, hogy a $Phi$ numerikus módszer konvergens a $t^*$ pontban, ha
  $
      lim_( h -> 0 ) e_h (t^*) = 0
  $
]

#remark[
  Ha a $Phi$ numerikus módszer konvergens a $[0, T]$ intervallum minden
  pontjában, akkor egyszerűen konvergensnek nevezzük. A
  \eqref{eq:num_mod_conv_lim} konvergenciájának a rendjét a $Phi$ módszer
  konvergencia rendjének nevezzük.
]


A $Phi$ módszer viselkedését jól jellemzi az a közelítés, amelyet a megoldásból
indulva egy lépés elvégzése után nyerünk:

$
  hat(y)_(n+1) = u(t_n) + h Phi (h, t_n, u(t_n), hat(y)_(n+1)).
$

#definition[Lokális diszkretizációs hibafüggvényének][
  Az $l_h (t_n) = hat(y)_n - u(t_n)$ függvényt a $Phi$ numerikus módszer $t_n$
  pontbeli lokális diszkretizációs hibafüggvényének nevezzük.
]


#definition[Konzisztencia rend][
  Azt mondjuk, hogy a $Phi$ numerikus módszer $p$-ed rendben konzisztens, ha
  $g_h(t_n) = O(h^(p+1))$ valamely $p > 0$ állandóval $forall t_n in omega_h$
  rácsponton.
]

#definition[Lokális approximációs hibafüggvényének][
  A következő $g_h (t_n)$ függvényt a $Phi$ numerikus módszer $t_n in omega_h$
  pontbeli lokális approximációs hibafüggvényének nevezzük:
  $
    g_h (t_n) = -u(t_(n+1)) + u(t_n) + h Phi(h, t_n, u(t_n), u(t_(n+1))).
  $
] 

#definition[][
  A következő $g_h (t_n)$ függvényt a $Phi$ numerikus módszer $t_n in omega_h$
  pontbeli lokális approximációs hibafüggvényének nevezzük:
  $
    g_h (t_n) = -u(t_(n+1)) + u(t_n) + h Phi(h, t_n, u(t_n), u(t_(n+1))).
  $
]


== Általános egylépéses módszerek konvergenciája

A továbbiakban tegyük fel, hogy $Phi$ függvény a harmadik és negyedik
változójában egyaránt Lipschitz tulajdonságú, azaz $exists L_3 >= 0$ és $L_4 >=
0$ állandók, hogy $forall s_1, s_2, p_1, p_2 in RR$ mellett
$
  \|Phi(h, t_n, s_1, p_1) - Phi(h, t_n, s_2, p_2)\| <= L_3 \| s_1 - s_2\| + L_4 \|p_1-p_2\| 
$

tetszőleges $t_n in omega_h$ és $h > 0$ esetén.

#remark[
  Ha $Phi$ nem függ $y_n$-től, akkor $L_3 = 0$, ha viszont $y_(n+1)$-től sem függ akkor $L_4 = 0$.
]

Vezessük be a következő jelöléseket:
$
  e_h (t_n) = e_n, quad g_h (t_n) = g_n, quad l_h (t_n) = l_n.
$

Ekkor $e_(n+1) = y_(n+1) - u(t_(n+1)) = y_(n+1) - hat(y)_(n+1) + hat(y)_(n+1) -
u(t_(n+1)) = y_(n+1) - hat(y)_(n+1) + l_(n+1)$. Azaz $\|e_(n+1)\| <= \|y_(n+1)
- hat(y)_(n+1)\| + \| l_(n+1)\|$.

Célunk a $<=$ jobb oldalán lévő két tagra becslést adni. Kezdjük a lokális
diszkretizációs hibafüggvénnyel.

$
    l_(n+1) &= hat(y)_(n+1) - u(t_(n+1)) = u(t_n) + h Phi(h, t_n, u(t_n), hat(y)_(n+1)) - u(t_(n+1)) \
    &= -u(t_(n+1)) + u(t_n) + h Phi(h, t_n, u(t_n), u(t_(n+1))) + \
    &+ h(Phi(h, t_n, u(t_n), hat(y)_(n+1)) - Phi(h, t_n, u(t_n), u(t_(n+1))) \
    &= g_n + h(Phi(h, t_n, u(t_n), hat(y)_(n+1)) - Phi(h, t_n, u(t_n), u(t_(n+1))))
$


Felhasználva a Lipschitz tulajdonságot, adódik, hogy
$
  |l_(n+1)| <= |g_n| + h L_4 |hat(y)_(n+1) - u(t_(n+1))| = |g_n| + h L_4 |l_(n+1)| 
$
azaz
$
  |l_(n+1)| <= 1/(1 - h L_4) |g_n|.
$

#remark[
  A fenti $<=$ azt is mutatja, hogy a lokális diszkretizációs hiba rendje nem
  lehet kisebb, mint a módszer konzisztencia rendje. Tehát egy $p$-ed rendben
  konzisztens módszer esetén a lokális diszkretizációs hiba is legalább $p$-ed
  rendben tart $0$-hoz.
]


Folytassuk a hibabecslés jobb oldalának első tagjával a vizsgálatot:
$
  e_(n+1) <= |y_(n+1) - hat(y)_(n+1)| + |l_(n+1)| 
$
ahol $|l_(n+1)|$-re már adtunk becslést, ezért
$
	|y_{n+1} - hat(y)_(n+1)|  &= |y_n + h Phi(h, t_n, y_n, y_(n+1)) - (u(t_n) + h Phi(h, t_n, u(t_n), hat(y)_(n+1)))| \
	& <= |e_n| + h |Phi (h, t_{n}, y_{n}, y_{n+1}) - Phi(h, t_{n}, u(t_{n}), hat(y)_{n+1})|  \
	& <= |e_{n}| + h L_{3} |y_{n} - u(t_{n})| + h L_4 |y_(n+1) - hat(y)_(n+1)| \
	& = (1 + h L_{3}) |e_n| + h L_{4} |y_(n+1) - hat(y)_(n+1)| 
$

Azaz
$
  |y_(n+1) - hat(y)_(n+1)| <= (1 + h L_3)/(1 - h L_4) |e_{n}|.
$

Így a két becslésből adódik, hogy 
$
    |e_{n+1}| <= |y_{n+1} - hat(y)_(n+1)| + |l_(n+1)| <= (1 + h L_3)/(1 - h L_4) |e_n| + 1/(1 - h L_4) |g_{n}|.
$

Vezessük be a 
$
  mu = mu(h) = (1 + h L_3)/(1 - h L_4)
$
és
$
  eta = eta(h) = 1/(1 - h L_4)
$
jelöléseket.

Ekkor
$
  mu = (1 + h L_3 + h L_4 - h L_4)/(1 - h L_4) = 1 + h (L_3 + L_4)/(1 - h L_4)
$
és így $mu = 1 + O(h)$. Ezért választhatók olyan $h_0, mu_0,$ és $eta_0$ állandók, hogy $mu = mu(h) <= 1 + mu_0h$ és $eta = eta(h) <= eta_0$ $forall h in (0, h_0)$.

Ezzel pedik adódik, hogy
$
    | e_{n+1} | <= (1 + h L_3)/(1 - h L_4) |e_n| + 1/(1 - h L_4) |g_n| <= mu |e_n| + eta |g_n|.
$

Továbbá
$
    |e_(n+1)| <= mu |e_n| + eta |g_n| 
$
avagy
$
    |e_n| &<= mu |e_(n-1)| + eta |g_(n-1)| <= mu(mu |e_(n-2) + eta |g_(n-2)|  | ) + eta |g_(n-1)| = \
    &= mu^2 |e_(n-2)| + eta(mu |g_(n-2)| + |g_(n-1)|) <= dots \
    &<= mu^n |e_0| + eta sum_(i=0)^(n-1) mu^i |g_(n-1-i)| <= mu^n (|e_0| + eta sum_(i=0)^(n-1) |g_(n-1-i)|).
$

Mivel $forall h in (0, h_0)$ esetén $eta <= eta_0$ és $mu^n <= (1 + mu_0 h)^n <= e^{mu_0 h n} = e^{mu_0 dot t^*}$, ahol $n h = t_n = t^*$ rögzített pont. Így
$
    |e_n| <= e^{mu_0 dot t^*} (|e_0| + eta_0 sum_(i=0)^(n-1) |g_(n-1-i)|).
$

Mivel feltettük, hogy a $Phi$ numerikus módszer $p$-ed rendben konzisztens, így
elegendően kis $h$ esetén valamely $c_0 >= 0$ állandóval fennáll a $|g_j| <=
c_0 h^(p+1)$ egyenlőtlenség.

Ezért kis $h$ esetén
$
  sum_(i=0)^(n-1) |g_(n-1-i)| <= n dot c_0 dot h^(p+1) = n dot h dot c_0 h^p = t^* c_0 h^p.
$

Azaz mindent figyelembe véve adódik, hogy $|e_n| <= e^(\mu_0 t^*) (|e_0 + c_1 h^p|)$, ahol $c_1 = eta_0 dot c_0 dot t^*$ állandó. Mivel $|e_0| = 0$ (hiszen $y_0 = u_0$), így $|e_n| <= c_2 dot h^p$, ahol $c_2 = e^(\mu_0 dot t^*) c_1$. Ezzel az alábbi tételt bizonyítottuk.

#theorem[
  Tegyük fel, hogy a $Phi$ numerikus módszer $p$-ed rendben konzisztens, a
  módszert definiáló $Phi$ függvény folytonos és ervényes rá a
  \eqref{eq:lips-vars-3-4} Lipschitz-feltétel. Ekkor a $Phi$ numerikus módszer
  $p$-ed rendben konvergens a $[0, T]$ intervallumon.
]

#emph(text(red)[*There are some parts missing between here.*])

#align(center)[#commutative-diagram(
  node((0, 0), $C^1[0, T]$),
  node((0, 1), $C[0, T]$),
  node((1, 0), $FF(omega_h)$),
  node((1, 1), $FF(omega_h^0)$),
  arr((0, 0), (0, 1), $N$),
  arr((0, 0), (1, 0), $P_h$),
  arr((1, 0), (1, 1), $N_h$),
  arr((0, 1), (1, 1), $R_h$),
)]


