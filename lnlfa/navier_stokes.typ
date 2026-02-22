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

#theorem[
  Let $Omega subset.eq RR^3$ be a bounded domain, and let a constant $mu > 0$
  and an element $f in H^*$ be given. Then $exists (u, p) in H^1_0 (Omega)
  times L^2_0 (Omega)$ such that
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
    mu integral_Omega (- Delta u ) dot v &= mu integral_Omega nabla u dot nabla v - integral_(partial Omega) (partial_nu u) v \
    &= mu integral_Omega nabla u dot nabla v
  $
  because $v in H^1_0(Omega) => v|_(partial Omega) = 0$.

  With these reformulations we can write the weak solution of the original problem as
  #numbered_eq($
    a(u, v) + b(u, u, v) + integral_Omega (nabla p)v &= l v \
    nabla dot u &= 0,
  $)
  where
  #numbered_eq($
    a(u, v) &= mu integral_Omega nabla u dot nabla v \
    b(w, u, v) &= integral_Omega ((w dot nabla) u ) v  \
    l v &= integral_Omega f v.
  $)

  Since
  $
    nabla dot (p v) = (nabla p) dot v + p (nabla dot v),
  $
  we can apply the Gauss--Ostrogradsky theorem to $(p v)$
  $
    integral_Omega nabla dot (p v) &= integral_(partial Omega) (p v) dot nu \
    integral_Omega (nabla p) dot v + integral_Omega p (nabla dot v) &= integral_(partial Omega) (p v) dot nu \
    integral_Omega (nabla p) v &= - integral_Omega p (nabla dot v) + integral_(partial Omega) (p v) dot nu \
    &= - integral_Omega p (nabla dot v) flushr((v|_(partial Omega) = 0)).
  $

  With this the weak solution becomes
  #numbered_eq($
    a(u, v) + b(u, u, v) - integral_Omega p (nabla dot v) &= l v \
    nabla dot u &= 0.
  $)

  It is clear to see that the bilinear form $a : H^1_0 (Omega) times H^1_0
  (Omega) -> RR$ is continuous. Likewise the linear functional $l : H^1_0 ->
  RR$ is continuous. Now we will conclude that $b : H^1_0 (Omega) times
  H^1_0(Omega) times H^1_0 (Omega) -> RR$ is continuous too.

  // By definition
  // $
  //   b(w, u, v) = integral_Omega ((w dot nabla) u ) dot v,
  // $
  //
  // $
  //   w dot nabla &= sum_(i = 1)^n w_i partial_i \
  //   (w dot nabla)u &= sum_(i = 1)^n w_i (partial_i u) \
  //   ((w dot nabla)u) dot v &= sum_(j = 1)^n sum_(i = 1)^n w_i (partial_i u_j) v_j \
  //   integral_Omega ((w dot nabla)u) dot v &= sum_(j = 1)^n sum_(i = 1)^n integral_Omega w_i (partial_i u_j) v_j \
  // $

  Try to prove that $b$ is bounded, then it is continuous since it is a
  trilinear functional.
  // $
  //   abs(b(w, u, v)) &= abs(sum_(j = 1)^n sum_(i = 1)^n integral_Omega w_i (partial_i u_j) v_j) \
  //   &<= sum_(j = 1)^n sum_(i = 1)^n abs(integral_Omega w_i (partial_i u_j) v_j).
  // $
  //
  // By Hölder's inequality with $1/4 + 1/2 + 1/4 = 1$ we have
  // $
  //   abs(integral_Omega w_i (partial_i u_j) v_j) <= norm(w_i)_(L^4) dot norm(partial_i u_j)_(L^2) dot norm(v_j)_(L^4).
  // $
  //
  // Thus we have
  // $
  //   abs(b(w, u, v)) &<= sum_(j = 1)^n sum_(i = 1)^n norm(w_i)_(L^4) dot norm(partial_i u_j)_(L^2) dot norm(v_j)_(L^4) \
  //   &<=^"C.S.B" (sum_(j=1)^n sum_(i=1)^n norm(partial_i u_j)_(L^2)^2)^(1/2) (sum_(j=1)^n sum_(i=1)^n norm(w_i)_(L^4)^2 norm(v_j)_(L^4)^2)^(1/2) \
  //   &= norm(nabla u)_(L^2) (sum_(i=1)^n norm(w_i)_(L^4)^2)^(1/2) (sum_(j=1)^n norm(v_j)_(L^4)^2)^(1/2) \
  //   &<= c norm(u)_(H^1_0) norm(w)_(L^4) norm(v)_(L^4).
  // $
  //
  // *Alternate version of continuity proof of $b$*

  $
    abs((w dot nabla u) dot v) <=^"C.S." abs(w dot nabla u) abs(v) <=^"C.S." abs(w) abs(nabla u) abs(v)
  $

  $
    abs(b(w, u, v)) = abs(integral_Omega (w dot nabla u) dot v) <=
  integral_Omega abs((w dot nabla u ) dot v) <= integral_Omega abs(w) abs(nabla
    u) abs(v)
  $

  Apply Hölder's inequality with $4, 2, 4$
  $
    integral_Omega abs(w) abs(nabla u) abs(v) <= norm(w)_(L^4) norm(nabla
    u)_(L^2) norm(v)_(L^4) <=^"P.F." c norm(w)_(L^4) norm(u)_(H^1_0)
  norm(v)_(L^4) 
  $


  #theorem(title: "Sobolev embedding")[
    $W^(m, p) (Omega) arrow.hook L^(p^*) (Omega)$ where $1/p^* = 1/p - m/N$ if $m
    < N/p$ and $Omega subset.eq RR^N$.
  ]

  #corollary[
    $H^1 (Omega) = W^(1, 2) (Omega) quad m = 1, quad p = 2, quad N = 3$. We have $1 <^checkmark 3/2$, thus

    $
      1/p^* = 1/2 - 1/3 ==> p^* = 6 ==> H^1 (Omega) arrow.hook L^6 (Omega) arrow.hook L^4 (Omega)
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

  a)

  We have
  $
    b(w, v, v) &= integral_Omega w_j (partial_j v_i) v_i = 1/2 integral_Omega w_j partial_j (v_i^2)
  $
  or more concisely
  $
    b(w, v, v) = integral_Omega (w dot nabla v) dot v = 1/2 integral_Omega w dot nabla (v dot v)
  $
  By the Gauss--Ostrogradsky theorem we have
  $
    integral_Omega w dot nabla phi.alt &= -integral_Omega (nabla dot w) phi.alt + integral_(partial Omega) phi.alt (w dot nu) flushr((phi.alt = v dot v = abs(v)^2)) \
    integral_Omega w dot nabla abs(v)^2 &= -integral_Omega (nabla dot w) abs(v)^2 + integral_(partial Omega) abs(v)^2 (w dot nu)
  $
  since $nabla dot w = 0$ and $v|_(partial Omega) = 0$ bot terms vanish, thus concluding that
  $
    b(w, v, v) = integral_Omega (w dot nabla v) dot v = 0.
  $

  // Let $phi.alt = v_i^2$
  // $
  //   integral_Omega w_j partial_j phi.alt &= -integral_Omega (partial_j w_j) phi.alt + integral_(partial Omega) phi.alt w_j nu_j \
  //   integral_Omega w_j partial_j (v_i^2) &= -integral_Omega (partial_j w_j) v_i^2 + integral_(partial_Omega) v_i^2 w_j nu_j \
  //   &= -integral_Omega (partial_j w_j) v_i^2 + integral_(partial Omega) v_i^2 (w dot nu) \
  // $
  //
  // If $nabla dot w = 0$ and $v in H^1_0 (Omega)$ then $b(w, v, v) = 0$ since
  // $
  //   b(w, v, v) = overbrace(-integral_Omega (partial_j w_j) v_i^2, 0) + overbrace(integral_(partial Omega) v_i^2 (w dot nu), 0) = 0.
  // $

  b) $b : (H^1_0(Omega))^3 -> RR$ is antisymmetric in its second and third arguments.
  $
    0 &= b(w, u+v, u+v) = overbrace(b(w, u, u), 0) + b(w, u, v) + b(w, v, u) + overbrace(b(w, v, v), 0) \
    &= b(w, u, v) + b(w, v, u) \
    ==> b(w, u, v) &= - b(w, v, u)
  $


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
    bracket(F^n (w), v) &= a(w, v) + b(w, w, v) - integral_Omega p overbrace(nabla dot v, 0) - l v flushr((forall v in V^n)) \
    bracket(F^n (w), v) &= underbrace(a(w, v) + b(w, w, v) - l v, l_w v) flushr((forall v in V^n))
  $

  This is a classic operator equation where the lhs is a bounded and coercive
  bilinear form and the rhs is a linear functional. The Lax--Milgram lemma thus
  says that a solution $F^n (w) in V^n$ uniquely exists. Or I guess you could
  say that $F^n (w)$ is the Riesz representation of the linear functional $l_w$.

  Since $w |-> l_w$ is continuous, thus $w |-> F^n (w)$ is continuous too.

  If $v = w$ the previous operator equation looks as follows
  $
    bracket(F^n (w), w) &= a(w, w) + overbrace(b(w, w, w), 0) - l w \
    &= a(w, w) - l w.
  $

  $
    a(w, w) := mu integral_Omega abs(nabla w)^2 = mu norm(w)_(H^1_0)^2
  $

  $
    l w := bracket(f, w)_(L^2) <=^"C.S.B." norm(f)_((H^1)^*) dot norm(w)_(H^1)
  $

  $
    ==> - l w >= - norm(f)_((H^1)^*) dot norm(w)_(H^1).
  $

  By the above arguments we have
  $
    bracket(F^n (w), w) >= mu norm(w)_(H^1)^2 - norm(f)_((H^1)^*) norm(w)_(H^1).
  $

  If $norm(w)_(H^1_0) = 1/mu norm(f)_((H^1)^*)$ then $mu norm(w)_(H^1)^2 -
  norm(f)_((H^1)^*) norm(w)_(H^1) = 0$. Thus $bracket(F^n(w), w) >= 0$ in this
  case.

  #theorem(title: "Acute angle lemma")[
    If $exists r > 0$ such that $bracket(f(v), v) >= 0 quad forall v in V$
    where $norm(v) = r$. Then $exists v_0 in V$ such that $norm(v_0) = r$ and
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
    a(u^n, v) + b(u^n, u^n, v) = l v flushr((forall v in V^n)).
  $

  That is, that $u^n$ is a solution to the original equation in the finite
  subspace $V^n$.

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

  Since $H^1 (Omega) subset.double L^4 (Omega)$ we have $u^n -> u$ in $L^4
  (Omega)$.


  For a given $v in V(Omega)$ let $v^n in V^n$ be such that
  $
    lim_(n -> oo) norm(v^n - v)_(H^1) = 0.
  $
  That is, the sequence $(v^n)$ approximates $v$ in finite dimensions.

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
