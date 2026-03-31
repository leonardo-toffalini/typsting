#import "@preview/intextual:0.1.0": flushr, intertext-rule
#import "@preview/theorion:0.4.1": *
#import cosmos.default: *
#show: show-theorion
#show: intertext-rule

#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")
// #set math.equation(numbering: "(1)")

#let uu = $bold(u)$
#let ff = $bold(f)$
#let vv = $bold(v)$
#let ww = $bold(w)$
#let FF = $bold(F)$

#let numbered_eq(content) = math.equation(
    block: true,
    numbering: "(1)",
    content,
)

#let bracket(a, b) = $angle.l #a, #b angle.r$

// Title
#align(center)[
  #text(size: 1.2em)[= Existence theorem for the stationary \ Navier--Stokes problem]

  #v(0.5em)
  #text(size: 1.25em)[Leonardo Toffalini]
]
#v(2em)

#set heading(numbering: "1.1")

= Introduction
The Navier--Stokes equations model the stationary flow of an incompressible
viscous fluid filling up a domain $Omega subset RR^3$, they take the vector form
$
  -mu Delta uu + (uu dot nabla) uu + nabla p &= ff \
  nabla dot uu &= 0 \
  uu|_(partial Omega) &= 0,
$
where $uu = (u_1, u_2, u_3)$. Alternatively, componentwise for $i = 1, ..., 3$
$
  -mu Delta u_i + sum_(j=1)^3 u_j partial_j u_i + partial_i p &= f_i \
  sum_(j=1)^3 partial_j u_j &= 0\
  u_i|_(partial Omega) &= 0.
$

In these equations the unknowns are $uu: Omega -> RR^3$ the velocity vector
field, and $p : Omega -> RR$ the scalar pressure field (determined up to a
constant factor). The definining data are $mu > 0$ the kinematic viscosity of
the fluid, and $ff : Omega -> RR^3$ the density of the applied external forces.

The boundary conditions represent the velocity vanishing on the boundary
($uu|_(partial Omega) = 0$) and the fluid being incompressible ($nabla dot u =
0$), since by the Gauss--Ostrogradsky theorem we have
$
  0 = integral_Omega nabla dot uu = integral_(partial Omega) uu dot nu
$
meaning that the entering flow is equal to the outgoing flow, and thus now new
flow is created inside the domain.

= Main result

#theorem[
  Let $Omega$ be a bounded domain in $RR^3$, and let a constant $mu > 0$ and a
  vector field $ff : H^1_0(Omega) -> RR^3$ be given. Then $exists (uu, p) in
  H^1_0 (Omega) times L^2_0 (Omega)$ such that
  $
    - mu Delta uu + (uu dot nabla)uu + nabla p &= ff flushr("in "(H_0^1(Omega))^*)\
    nabla dot uu &= 0 \
    uu|_(partial Omega) &= 0.
  $
]

#proof[
  If $ff equiv 0$, then $(uu, p) = (0, 0)$ is a trivial solution, thus we assume
  $ff equiv.not 0$.

  *1. Finding a weak solution.*

  Let us define the Frobenius product between two matrices as follows
  $
      A : B := sum_(i, j) A_(i j) B_(i j).
  $
  With this we can proceed to find the week form of the original equation

  #numbered_eq($
    - mu Delta uu + (uu dot nabla) uu + nabla p &= ff flushr((\/ dot vv in H^1_0 (Omega))) \
    (- mu Delta uu + (uu dot nabla) uu + nabla p ) dot vv &= ff dot vv flushr((\/ integral_Omega)) \
    integral_Omega (- mu Delta uu + (uu dot nabla) uu + nabla p ) dot vv &= integral_Omega ff dot vv \
    mu integral_Omega (- Delta uu) : vv + integral_Omega (uu dot nabla) uu dot vv + integral_Omega nabla p dot v &= integral_Omega ff dot vv
  $)

  By Green's formula we have
  $
    mu integral_Omega (- Delta uu ) dot vv &= mu integral_Omega nabla uu : nabla vv - mu integral_(partial Omega) (partial_nu uu) vv \
    &= mu integral_Omega nabla uu : nabla vv
  $
  since $vv in H^1_0(Omega) ==> vv|_(partial Omega) = 0$.

  With these reformulations we can say that a weak solution to the original
  problem amounts to finding $uu in H^1_0(Omega)$ and $p in L^2(Omega)$ such
  that
  #numbered_eq($
    a(uu, vv) + b(uu, uu, vv) + integral_Omega (nabla p) dot vv &= l(vv) \
    nabla dot uu &= 0,
  $)
  where
  #numbered_eq($
    a(uu, vv) &= mu integral_Omega nabla uu : nabla vv \
    b(ww, uu, vv) &= integral_Omega ((ww dot nabla) uu ) dot vv  \
    l(vv) &= integral_Omega ff dot vv.
  $)

  We can change the pressure part by noticing that
  $
    nabla dot (p vv) = (nabla p) dot vv + p (nabla dot vv),
  $
  and with this we can apply the Gauss--Ostrogradsky theorem to $(p vv)$ as
  follows
  $
    integral_Omega nabla dot (p vv) &= integral_(partial Omega) (p vv) dot nu \
    integral_Omega (nabla p) dot vv + integral_Omega p (nabla dot vv) &= integral_(partial Omega) (p vv) dot nu \
    integral_Omega (nabla p) dot vv &= - integral_Omega p (nabla dot vv) + integral_(partial Omega) (p vv) dot nu \
    &= - integral_Omega p (nabla dot vv) flushr((vv|_(partial Omega) = 0)).
  $

  With this the weak form becomes
  #numbered_eq($
    a(uu, vv) + b(uu, uu, vv) - integral_Omega p (nabla dot vv) &= l(vv) \
    nabla dot uu &= 0.
  $)

  It is clear to see that the bilinear form $a : H^1_0 (Omega) times H^1_0
  (Omega) -> RR$ is continuous. Likewise, the linear functional $l :
  H^1_0(Omega) -> RR$ is continuous too. Now we will conclude that $b : H^1_0
  (Omega) times H^1_0(Omega) times H^1_0 (Omega) -> RR$ is continuous too.

  Try to prove that $b$ is bounded, then it is continuous since it is a
  trilinear functional.
  //
  // $
  //   abs((w dot nabla u) dot v) <=^"C.S." abs(w dot nabla u) abs(v) <=^"C.S." abs(w) abs(nabla u) abs(v)
  // $

  $
    abs(b(ww, uu, vv)) = abs(integral_Omega (ww dot nabla uu) vv) <=
  integral_Omega abs((ww dot nabla uu) vv) = norm((ww dot nabla uu) vv)_1
  $

  Applying Hölder's inequality with $4, 2, 4$ we get
  $
    abs(b(ww, uu, vv)) <= norm((ww dot nabla uu) vv)_1 <= norm(ww)_4 norm(nabla
    uu)_2 norm(vv)_4 = norm(ww)_4 norm(uu)_(H^1_0) norm(vv)_4.
  $

  #definition[
    Let $X$ and $Y$ be two normed spaces with norms $norm(dot)_X$ and
    $norm(dot)_Y$ such that $X subset.eq Y$. If the identity function $i : X ->
    Y$ is continuous, i.e. $exists c > 0: norm(x)_Y <= c norm(x)_X quad forall
    x in X$, then we say that $X$ is continuously embeddable in $Y$, $X arrow.hook Y$ in notation.
  ]

  #definition[
    Let $X$ and $Y$ be two normed spaces. We say that a linear operator $T: X
    -> Y$ is compact if for any sequence $(x_n)_(n=1)^oo subset X$ its image
    $(T x_n)_(n=1)^oo subset Y$ contains a converging subsequence.
  ]

  #definition[
    Let $X$ and $Y$ be two normed spaces. We say that $X$ is compactly
    embeddable in $Y$ if it is continuously embeddable and the identity
    function is a compact operator. Notation: $X subset.double Y$.
  ]

  #theorem(title: "Rellich–Kondrachov")[
    Let $Omega subset.eq RR^n$ be an open bounded Lipschitz domain, and let $1 <= p <n$. Let
    $
      p^* := (n p)/(n - p).
    $
    Then $W^(1, p)(Omega) arrow.hook L^(p^*)(Omega)$ and $W^(1, p)(Omega)
    subset.double L^q (Omega)$ for $1 <= q < p^*$.
  ]

  #corollary[
    Since $H^1 (Omega) = W^(1, 2) (Omega)$ and $Omega subset.eq RR^3$ we have
    $p^* = 6$, thus by the previous theorem we get $W^(1, 2)(Omega)
    subset.double L^4(Omega)$.

    That is $exists c : norm(u)_(L^4) <= c norm(u)_(H^1)$ for all $u in L^4 (Omega)$.
  ]

  Since before we have shown $abs(b(ww, uu, vv)) <= norm(ww)_4 norm(uu)_(H^1_0)
  norm(vv)_4$, by the previous theorem and corollary we have
  $
    abs(b(ww, uu, vv)) <= c norm(uu)_(H^1_0) norm(ww)_(H^1_0) norm(vv)_(H^1_0),
  $
  so $b$ is a bounded trilinear form over $(H^1_0 (Omega))^3$, which also
  means that it is continuous.


  *2. Technical preliminary*

  #proposition[
    $
      b(ww, vv, vv) = 0
    $
  ]
  #proof[
    We have
    $
      b(ww, vv, vv) &= integral_Omega w_j (partial_j v_i) v_i = 1/2 integral_Omega w_j partial_j (v_i^2)
    $
    or more concisely
    $
      b(ww, vv, vv) = integral_Omega ((ww dot nabla) vv) dot vv = 1/2 integral_Omega ww
    dot nabla (vv dot vv) = 1/2 integral_Omega ww dot nabla abs(vv)^2.
    $

    We know that $nabla dot (phi.alt ww) = ww dot nabla phi.alt + (nabla dot
    ww) phi.alt$, when $phi.alt$ is a scalar field and $ww$ is a vector field.
    By the Gauss--Ostrogradsky theorem we have
    $
      integral_Omega nabla dot (phi.alt ww) &= integral_(partial Omega) (phi.alt ww) dot nu \
      integral_Omega ww dot nabla phi.alt &= -integral_Omega (nabla dot ww) phi.alt + integral_(partial Omega) (phi.alt ww) dot nu flushr((phi.alt = v dot v = abs(v)^2)) \
      integral_Omega ww dot nabla abs(vv)^2 &= -integral_Omega (nabla dot ww) abs(vv)^2 + integral_(partial Omega) abs(vv)^2 (ww dot nu)
    $
    since $nabla dot ww = 0$ and $vv|_(partial Omega) = 0$ both terms vanish, thus concluding that
    $
      b(ww, vv, vv) = integral_Omega ((ww dot nabla) vv) dot vv = 0.
    $
  ]


  #proposition[
    $
      b(ww, uu, vv) = -b(ww, vv, uu)
    $
  ]

  #proof[
    $
      0 &= b(ww, uu + vv, uu + vv) = overbrace(b(ww, uu, uu), 0) + b(ww, uu, vv) + b(ww, vv, uu) + overbrace(b(ww, vv, vv), 0) \
      &= b(ww, uu, vv) + b(ww, vv, uu)
    $
    $
      ==> b(ww, uu, vv) &= -b(ww, vv, uu)
    $
  ]


  *3. Proving the existence of a solution*

  Let $V := {vv in H^1_0 (Omega): nabla dot vv|_Omega = 0}$. Since $V$ is a
  closed subspace of $H^1_0(Omega)$ it is separable too, that is $exists
  (ww_j)_(j=1)^oo$ Hilbert-basis in $V$.

  For each $n >= 1$ we can define the finite dimensional space
  $
    V^n := "span"(ww_j)_(j=1)^n.
  $

  For a fixed $ww in V^n$ let $FF^n (ww) in V^n$ be defined as the solution of the
  following equation
  $
    bracket(FF^n (ww), vv) &= a(ww, vv) + b(ww, ww, vv) - integral_Omega p overbrace(nabla dot vv, 0) - l(vv) flushr((forall vv in V^n)) \
    bracket(FF^n (ww), vv) &= underbrace(a(ww, vv) + b(ww, ww, vv) - l(vv), l_(ww) (vv)) flushr((forall vv in V^n))
  $

  Note, that $FF^n (ww)$ does exist (uniquely) for any $ww in V^n$, since the lhs
  is just an inner product in $H^1_0 (Omega)$ this means that $FF^n (ww)$ is the
  Riesz representative of the bounded linear functional $l_ww$.

  Furthermore, since $ww |-> l_ww$ is continuous, thus $ww |-> FF^n (ww)$ is
  continuous too.

  If we set $vv = ww$, then the previous operator equation looks as follows
  $
    bracket(FF^n (ww), ww) &= a(ww, ww) + overbrace(b(ww, ww, ww), 0) - l(ww) \
    &= a(ww, ww) - l(ww).
  $

  Now we want to find a lower bound for $bracket(FF^n (ww), ww)$. We can easily
  notice that $a(ww, ww)$ is just a weighted norm in $H^1_0(Omega)$ since

  $
    a(ww, ww) := mu integral_Omega abs(nabla ww)^2 = mu norm(ww)_(H^1_0)^2.
  $

  Moreover, by the definition of the dual norm
  $
    norm(ff)_* := sup_(ww != 0) abs(bracket(ff, ww))/norm(ww) ==> norm(ff)_* >=
  abs(bracket(ff, ww))/norm(ww) ==> norm(ff)_* norm(ww) >= abs(bracket(ff, ww))
  $

  $
    l(ww) := bracket(ff, ww) <= norm(ff)_* norm(ww)_(H^1)
  $

  $
    ==> -l(ww) >= -norm(ff)_* norm(ww)_(H^1).
  $

  By the above arguments we have
  $
    bracket(FF^n (ww), ww) >= mu norm(ww)_(H^1_0)^2 - norm(ff)_* norm(ww)_(H^1).
  $

  If $norm(ww)_(H^1_0) = 1/mu norm(ff)_*$ then $mu norm(ww)_(H^1)^2 -
  norm(ff)_* norm(ww)_(H^1) = 0$. Thus $bracket(FF^n (ww), ww) >= 0$ in this
  case.

  #theorem(title: "Acute angle lemma")[
    If $exists r > 0$ such that $bracket(f(vv), vv) >= 0 quad forall vv in V$
    where $norm(vv) = r$. Then $exists vv_0 in V$ such that $norm(vv_0) <= r$ and
    $f(vv_0) = 0$.
  ]<thm:acute_angle>

  In our case we have $bracket(FF^n (ww), ww) >= 0$ if $norm(ww)_(H^1) = 1/mu
  norm(ff)_*$. Applying @thm:acute_angle to our case we get that $exists
  uu^n in V^n$ such that 
  $
    norm(uu^n)_(H^1) <= 1/mu norm(ff)_* quad "and" quad FF^n (uu^n) = 0.
  $

  The latter means exactly that
  $
    a(uu^n, vv) + b(uu^n, uu^n, vv) = l(vv) flushr((forall vv in V^n)).
  $

  That is, that $uu^n$ is a weak solution in the finite subspace $V^n$.

  #theorem(title: [Banach--Eberlein--Smulian])[
    In a Hilbert space every bounded sequence contains a weakly convergent
    subsequence.
  ]<thm:BES>

  #theorem[
    In a normed space, if $x_n harpoon_(n -> oo) x$ then $norm(x) <= liminf_(n
    -> oo) norm(x_n)$.
  ]<thm:liminf_upper_bnd>

  By @thm:BES we know that $uu^n harpoon_(n -> oo) uu$ in $V(Omega)$ for some $uu$, since $uu^n$ is bounded by $1/mu norm(f)_*$.

  \/\/ (idk why this next statement is needed) \
  By @thm:liminf_upper_bnd we know that
  $
    norm(uu)_(H^1) <= liminf_(n -> oo) norm(uu^n)_(H^1) <= 1/mu norm(ff)_((H^1)^*).
  $

  #theorem[
    Let $X$ and $Y$ be normed spaces over $KK$. Let $A in B(X, Y)$ be a compact
    bounded linear operator. Then $x_n harpoon_(n -> oo) x$ in $X$ implies $A
    x_n ->_(n -> oo) A x$ in $Y$.
  ]

  Since $H^1 (Omega) subset.double L^4 (Omega)$ that means that the inclusion
  operator is compact, and the image of $u$ is of course $u$, so we have $u^n
  -> u$ in $L^4 (Omega)$.


  For a given $vv in V(Omega)$ let $vv^n in V^n$ be such that
  $
    lim_(n -> oo) norm(vv^n - vv)_(H^1) = 0.
  $
  That is, the sequence $(vv^n)$ approximates $vv$ in finite dimensions.

  Since $b: L^4 (Omega) times H^1 (Omega) times L^4 (Omega) -> RR$ is bounded
  (thus continuous), we have
  $
    lim_(n -> oo) b(overbrace(uu^n, in L^4), overbrace(uu^n, in H^1), overbrace(vv^n, in L^4)) &= lim_(n -> oo) - b(uu^n, vv^n, uu^n) \
    &= -b(uu, vv, uu) \
    &= b(uu, uu, vv).
  $

  This works because the first and last arguments converge strongly in $L^4$,
  while the middle argument converges only weakly in $H^1$.

  Furthermore, it is easy to see that $lim_(n -> oo) a(uu^n, vv^n) - l(vv^n) = a(uu, vv) - l(vv)$.

  Putting the two together we have
  $
    lim_(n -> oo) (overbrace(a(uu^n, vv^n) + b(uu^n, uu^n, vv^n) - l(vv^n), = 0 quad forall vv^n in V^n)) = a(uu, vv) + b(uu, uu, vv) - l(vv)
  $

  Thus
  $
    a(uu, vv) + b(uu, uu, vv) = l(vv) flushr((forall vv in V(Omega))),
  $
  which is just as we were hoping to prove.
]
