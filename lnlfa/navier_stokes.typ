#import "@preview/intextual:0.1.0": flushr, intertext-rule
#import "@preview/theorion:0.4.1": *
#import cosmos.default: *
#show: show-theorion
#show: intertext-rule

#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")
// #set math.equation(numbering: "(1)")

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
  -mu Delta u + (u dot nabla) u + nabla p &= f \
  nabla dot u &= 0 \
  u|_(partial Omega) &= 0,
$
or componentwise for $i = 1, ..., 3$
$
  -mu Delta u_i + sum_(j=1)^3 u_j partial_j u_i + partial_i p &= f_i \
  sum_(j=1)^3 partial_j u_j &= 0\
  u_i|_(partial Omega) &= 0.
$

In these equations the unknowns are $u: Omega -> RR^3$ the velocity vector
field, and $p : Omega -> RR$ the scalar pressure field (determined up to a
constant factor). The definining data are $mu > 0$ the kinematic viscosity of
the fluid, and $f : Omega -> RR^3$ the density of the applied external forces.

The boundary conditions represent the velocity vanishing on the boundary
($u|_(partial Omega) = 0$) and the fluid being incompressible ($nabla dot u =
0$), since by the Gauss--Ostrogradsky theorem we have
$
  0 = integral_Omega nabla dot u = integral_(partial Omega) u dot nu
$
meaning that the entering flow is equal to the outgoing flow, and thus now new
flow is created inside the domain.

= Main result

#theorem[
  Let $Omega$ be a bounded domain in $RR^3$, and let a constant $mu > 0$
  and a function $f : H^1_0(Omega) -> RR^3$ be given. Then $exists (u, p) in
  H^1_0 (Omega) times L^2_0 (Omega)$ such that
  $
    - mu Delta u + (u dot nabla)u + nabla p &= f \
    nabla dot u &= 0 \
    u|_(partial Omega) &= 0.
  $
]

#proof[
  If $f equiv 0$, then $(u, p) = (0, 0)$ is a trivial solution, thus we assume
  $f equiv.not 0$.

  *1. Finding a weak solution.*

  #numbered_eq($
    - mu Delta u + (u dot nabla) u + nabla p &= f flushr((\/ dot v in H^1_0 (Omega))) \
    (- mu Delta u + (u dot nabla)u + nabla p ) v &= f v flushr((\/ integral_Omega)) \
    integral_Omega (- mu Delta u + (u dot nabla)u + nabla p ) v &= integral_Omega f v \
    mu integral_Omega (- Delta u) dot v + integral_Omega (u dot nabla) u dot v + integral_Omega nabla p dot v &= integral_Omega f v
  $)

  By Green's formula we have
  $
    mu integral_Omega (- Delta u ) dot v &= mu integral_Omega nabla u dot nabla v - mu integral_(partial Omega) (partial_nu u) v \
    &= mu integral_Omega nabla u dot nabla v
  $
  since $v in H^1_0(Omega) ==> v|_(partial Omega) = 0$.

  With these reformulations we can say that a weak solution to the original
  problem amounts to finding $u in H^1_0(Omega)$ and $p in L^2(Omega)$ such
  that
  #numbered_eq($
    a(u, v) + b(u, u, v) + integral_Omega (nabla p)v &= l(v) \
    nabla dot u &= 0,
  $)
  where
  #numbered_eq($
    a(u, v) &= mu integral_Omega nabla u dot nabla v \
    b(w, u, v) &= integral_Omega ((w dot nabla) u ) v  \
    l(v) &= integral_Omega f v.
  $)

  We can change the pressure part by noticing that
  $
    nabla dot (p v) = (nabla p) dot v + p (nabla dot v),
  $
  and with this we can apply the Gauss--Ostrogradsky theorem to $(p v)$ as
  follows
  $
    integral_Omega nabla dot (p v) &= integral_(partial Omega) (p v) dot nu \
    integral_Omega (nabla p) dot v + integral_Omega p (nabla dot v) &= integral_(partial Omega) (p v) dot nu \
    integral_Omega (nabla p) v &= - integral_Omega p (nabla dot v) + integral_(partial Omega) (p v) dot nu \
    &= - integral_Omega p (nabla dot v) flushr((v|_(partial Omega) = 0)).
  $

  With this the weak form becomes
  #numbered_eq($
    a(u, v) + b(u, u, v) - integral_Omega p (nabla dot v) &= l(v) \
    nabla dot u &= 0.
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
    abs(b(w, u, v)) = abs(integral_Omega (w dot nabla u) v) <=
  integral_Omega abs((w dot nabla u ) v) = norm((w dot nabla u) v)_1
  $

  Apply Hölder's inequality with $4, 2, 4$ we get
  $
    abs(b(w, u, v)) <= norm((w dot nabla u)v)_1 <= norm(w)_4 norm(nabla
    u)_2 norm(v)_4 = norm(w)_4 norm(u)_(H^1_0) norm(v)_4.
  $


  #theorem(title: "Sobolev embedding")[
    Given a domain $Omega$ in $R^N$, if $m < N/p$ then with $p^*$ as the solution to
    $1/p^* = 1/p - m/N$ we have $W^(m, p)(Omega) arrow.hook L^(p^*)(Omega)$.
  ]

  #corollary[
    Since $H^1 (Omega) = W^(1, 2) (Omega)$ we have the veriables $m = 1, quad p = 2, quad N = 3$. We have $1 <^checkmark 3/2$, thus

    $
      1/p^* = 1/2 - 1/3 ==> p^* = 6 ==> H^1 (Omega) arrow.hook L^6 (Omega) arrow.hook L^4 (Omega).
    $

    That is $exists c : norm(u)_(L^4) <= c norm(u)_(H^1)$ for all $u in L^4 (Omega)$.
  ]

  By the previous theorem and corollary we have
  $
    abs(b(w, u, v)) <= c norm(u)_(H^1_0) norm(w)_(H^1_0) norm(v)_(H^1_0),
  $
  so $b$ is a bounded trilinear form over $(H^1_0 (Omega))^3$, which also
  means that it is continuous.


  *2. Technical preliminary*

  #proposition[
    $
      b(w, v, v) = 0
    $
  ]
  #proof[
    We have
    $
      b(w, v, v) &= integral_Omega w_j (partial_j v_i) v_i = 1/2 integral_Omega w_j partial_j (v_i^2)
    $
    or more concisely
    $
      b(w, v, v) = integral_Omega (w dot nabla v) dot v = 1/2 integral_Omega w
    dot nabla (v dot v) = 1/2 integral_Omega w dot nabla abs(v)^2.
    $

    We know that $nabla dot (phi.alt w) = w dot nabla phi.alt + (nabla dot w)
    phi.alt$. By the Gauss--Ostrogradsky theorem we have
    $
      integral_Omega nabla dot (phi.alt w) &= integral_(partial Omega) phi.alt w dot nu
    $

    $
      integral_Omega w dot nabla phi.alt &= -integral_Omega (nabla dot w) phi.alt + integral_(partial Omega) phi.alt (w dot nu) flushr((phi.alt = v dot v = abs(v)^2)) \
      integral_Omega w dot nabla abs(v)^2 &= -integral_Omega (nabla dot w) abs(v)^2 + integral_(partial Omega) abs(v)^2 (w dot nu)
    $
    since $nabla dot w = 0$ and $v|_(partial Omega) = 0$ bot terms vanish, thus concluding that
    $
      b(w, v, v) = integral_Omega (w dot nabla v) dot v = 0.
    $
  ]


  #proposition[
    $
      b(w, u, v) = -b(w, v, u)
    $
  ]

  #proof[
    $
      0 &= b(w, u+v, u+v) = overbrace(b(w, u, u), 0) + b(w, u, v) + b(w, v, u) + overbrace(b(w, v, v), 0) \
      &= b(w, u, v) + b(w, v, u)
    $
    $
      ==> b(w, u, v) &= - b(w, v, u)
    $
  ]


  *3. Proving the existence of a solution*

  Let $V := {v in H^1_0 (Omega): nabla dot v |_Omega = 0}$. Since $V$ is a
  closed subspace of $H^1_0(Omega)$ it is separable too, that is $exists
  (w_i)_(i=1)^oo$ Hilbert-basis in $V$.

  For each $n >= 1$ we can define the finite dimensional space
  $
    V^n := "span" (w_i)_(i=1)^n.
  $

  For a fixed $w in V^n$ let $F^n (w) in V^n$ be defined as the solution of the
  following equation
  $
    bracket(F^n (w), v) &= a(w, v) + b(w, w, v) - integral_Omega p overbrace(nabla dot v, 0) - l(v) flushr((forall v in V^n)) \
    bracket(F^n (w), v) &= underbrace(a(w, v) + b(w, w, v) - l(v), l_w (v)) flushr((forall v in V^n))
  $

  Note, that $F^n (w)$ does exist (uniquely) for any $w in V^n$, since the lhs
  is just an inner product in $H^1_0 (Omega)$ this means that $F^n (w)$ is the
  Riesz representative of the bounded linear functional $l_w$.

  Furthermore, since $w |-> l_w$ is continuous, thus $w |-> F^n (w)$ is
  continuous too.

  If $v = w$ the previous operator equation looks as follows
  $
    bracket(F^n (w), w) &= a(w, w) + overbrace(b(w, w, w), 0) - l(w) \
    &= a(w, w) - l(w).
  $

  Now we want to find a lower bound for $bracket(F^n (w), w)$. We can easily
  notice that $a(w, w)$ is just a weighted norm in $H^1_0(Omega)$ since

  $
    a(w, w) := mu integral_Omega abs(nabla w)^2 = mu norm(w)_(H^1_0)^2.
  $

  Moreover, by the definition of the dual norm
  $
    norm(f)_* := sup_(w != 0) abs(bracket(f,w))/norm(w) ==> norm(f)_* >=
  abs(bracket(f,w))/norm(w) ==> norm(f)_* norm(w) >= abs(bracket(f,w))
  $

  $
    l(w) := bracket(f, w) <= norm(f)_* norm(w)_(H^1)
  $

  $
    ==> - l(w) >= - norm(f)_* norm(w)_(H^1).
  $

  By the above arguments we have
  $
    bracket(F^n (w), w) >= mu norm(w)_(H^1_0)^2 - norm(f)_* norm(w)_(H^1).
  $

  If $norm(w)_(H^1_0) = 1/mu norm(f)_((H^1)^*)$ then $mu norm(w)_(H^1)^2 -
  norm(f)_((H^1)^*) norm(w)_(H^1) = 0$. Thus $bracket(F^n (w), w) >= 0$ in this
  case.

  #theorem(title: "Acute angle lemma")[
    If $exists r > 0$ such that $bracket(f(v), v) >= 0 quad forall v in V$
    where $norm(v) = r$. Then $exists v_0 in V$ such that $norm(v_0) <= r$ and
    $f(v_0) = 0$.
  ]<thm:acute_angle>

  In our case we have $bracket(F^n (w), w) >= 0$ if $norm(w)_(H^1) = 1/mu
  norm(f)_((H^1)^*)$. Applying @thm:acute_angle to our case we get that $exists
  u^n in V^n$ such that 
  $
    norm(u^n)_(H^1) <= 1/mu norm(f)_((H^1)^*)
  $
  and
  $
    F^n (u^n) = 0.
  $

  The latter means exactly that
  $
    a(u^n, v) + b(u^n, u^n, v) = l(v) flushr((forall v in V^n)).
  $

  That is, that $u^n$ is a weak solution in the finite subspace $V^n$.

  #theorem(title: [Banach--Eberlein--Smulian])[
    In a Hilbert space every bounded sequence contains a weakly convergent
    subsequence.
  ]<thm:BES>

  #theorem[
    In a normed space, if $x_n harpoon_(n -> oo) x$ then $norm(x) <= liminf_(n
    -> oo) norm(x_n)$.
  ]<thm:liminf_upper_bnd>

  By @thm:BES we know that $u^n harpoon_(n -> oo) u$ in $V(Omega)$.

  By @thm:liminf_upper_bnd we know that
  $
    norm(u)_(H^1) <= liminf_(n -> oo) norm(u^n)_(H^1) <= 1/mu norm(f)_((H^1)^*).
  $

  #theorem[
    Let $X$ and $Y$ be normed spaces over $KK$. Let $A in B(X, Y)$ be a compact
    bounded linear operator. Then $x_n harpoon_(n -> oo) x$ in $X$ implies $A
    x_n ->_(n -> oo) A x$ in $Y$.
  ]

  Since $H^1 (Omega) subset.double L^4 (Omega)$ that means that the inclusion
  operator is compact, and the image of $u$ is of course $u$, so we have $u^n
  -> u$ in $L^4 (Omega)$.


  For a given $v in V(Omega)$ let us take a $v^n in V^n (Omega)$ from each
  finite dimensional subspace such that
  $
    lim_(n -> oo) norm(v^n - v)_(H^1) = 0.
  $
  That is, the sequence $(v^n)_(n=1)^oo$ approximates $v$ in finite dimensions.

  Since $b: L^4 (Omega) times H^1 (Omega) times L^4 (Omega) -> RR$ is bounded
  (thus continuous), we have
  $
    lim_(n -> oo) b(overbrace(u^n, in L^4), overbrace(u^n, in H^1), overbrace(v^n, in L^4)) &= lim_(n -> oo) - b(u^n, v^n, u^n) \
    &= - b(u, v, u) \
    &= b(u, u, v).
  $

  This works because the first and last arguments converge strongly in $L^4$,
  while the middle argument converges only weakly in $H^1$.

  Furthermore, it is easy to see that $lim_(n -> oo) a(u^n, v^n) - l(v^n) = a(u, v) - l (v)$.

  Putting the two together we have
  $
    lim_(n -> oo) (overbrace(a(u^n, v^n) + b(u^n, u^n, v^n) - l(v^n), =0 quad forall v^n in V^n)) = a(u, v) + b(u, u, v) - l(v)
  $

  Thus
  $
    a(u, v) + b(u, u, v) = l(v) flushr((forall v in V(Omega))),
  $
  which is just as we were hoping to prove.
]
