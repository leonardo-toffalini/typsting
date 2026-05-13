#import "@preview/intextual:0.1.1": flushr, intertext-rule
#import "@preview/theorion:0.4.1": *
#show: intertext-rule
#show: show-theorion

#let bracket(a, b) = $angle.l #a, #b angle.r$
#let div(a) = $"div"(#a)$

#set page(
  paper: "a4",
  margin: (
    x: 2.2cm,
    y: 2.4cm,
  ),
  numbering: "1"
)

#set text(
  font: "Libertinus Serif",
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.65em,
)

#set heading(numbering: "1.")

#set enum(
  indent: 1.2em,
  body-indent: 0.5em,
)


// ---------- Sheet wrapper ----------

#let sheet(
  title,
  semester: none,
  author: none,
  body,
) = {

  align(center)[
    #text(15pt, weight: "bold")[#title]
    #v(-1em)

    #if author != none {
      linebreak()
      [#author]
    }

    #datetime.today().display()

  ]

  v(1.8em)

  body
}


// ---------- Problem counter ----------

#let problem-counter = counter("problem")
#problem-counter.update(1)


// ---------- Problem ----------

#let problem(
  points: none,
  body,
) = context {

  problem-counter.step()

  let n = problem-counter.get().first()

  v(1.2em)

  line(length: 100%)
  grid(
    columns: (1fr, auto),
    gutter: 1em,

    [
      *Problem #n*

    ],

    [
      #if points != none {
        [(#points pts)]
      }
    ],
  )

  v(0.4em)

  body
}

// ---------- Solution ----------

#let solution(body) = {
  v(0.6em)

  line(length: 100%)
  [
    *Solution.*

    #v(0.3em)

    #body
  ]
}


// ---------- Example ----------

#show: doc => sheet(
  "Beadando",
  semester: "asd",
  author: "Toffalini Leonardo",
  doc,
)

#problem(points: 1)[
  Let $k in NN^+$ be fixed and $I = [a, b]$ be a given interval. Prove that the
  following operator $L$ is symmetric and strictly positive in the space $H :=
  L^2 (I)$. What is the energy space $H_L$?
  $
    L u := (-1)^k u^((2k)) quad "(the" 2k"-th derivative)" quad "on the following domain:" \
    D(L) := {u in C^(2 k) (I) : quad u^((i))(a) = u^((i)) (b) = 0 quad forall i = 0, ..., k-1}
  $
]

#solution[
  We need to show that $bracket(L u, v) = bracket(u, L v) quad forall u, v in D(L)$, where $bracket(dot, dot) = bracket(dot, dot)_(L^2[a, b])$.

  Integrating by parts one time gives us the following:
  $
    bracket(L u, v) &:= integral_a^b (-1)^k u^((2k))(x) v(x) dif x \
    &= (-1)^k ([u^((2k - 1))(x) v(x)]_a^b - integral_a^b u^((2k - 1))(x) v^((1))(x)  dif x) \
    &= (-1)^k  (0 - integral_a^b u^((2k - 1))(x) v^((1))(x) dif x) \
    &= (-1)^(k+1) integral_a^b u^((2k - 1))(x) v^((1))(x) dif x.
  $

  We can see that after integrating by parts $k$ times we get 
  $
    bracket(L u, v) = (-1)^(2k) integral_a^b u^((k))(x) v^((k))(x) dif x.
  $

  Applying $k$ integrations by parts from the other way around we get the same
  $
    bracket(u, L v) = (-1)^(2k) integral_a^b u^((k))(x) v^((k))(x) dif x.
  $

  Thus we conclude that $bracket(L u, v) = bracket(u, L v)$.

  To show that $L$ is strictly positive we need to show that $bracket(L u, u) > 0 quad forall u in D(L)$, where $u != 0$.

  Indeed, we can see
  $
    bracket(L u, u) = (-1)^(2k) integral_a^b u^((k))(x) u^((k))(x) dif x = integral_a^b abs(u^((k))(x))^2 dif x >= 0.
  $

  Furthermore, this expression can only be $0$ if $u^((k)) equiv 0$, and that
  means that $u(x)$ is a polynomial of order at most $k-1$, but then by the
  boundary conditions we get that $u equiv 0$.

  For finding the energy space we need to show what the energy scalar product is:
  $
    bracket(u, v)_L := bracket(L u, v) = integral_a^b u^((k))(x) v^((k))(x) dif x =: bracket(u, v)_(H^k_0 [a, b]).
  $

  Thus we conclude that the energy space $H_L$ is in fact $H^k_0 (I)$, since
  that is the natural completion of $D(L)$ with the above scalar product.
]

#problem-counter.update(4)

#problem(points: 2)[
  Let $L$ be an $S$-bounded and $S$-coercive operator, and consider the weak
  solution of the equation $L u = g$ (in the sense discussed in the seminar).
  Construct the Galerkin method for this equation, then prove Céa's lemma and
  (by giving a suitable condition for the subspaces) the convergence of the
  Galerkin method. (The analogous study in the lecture for nonlinear equations
  can be adapted.)
]

#solution[
  Let $u^* in H$ be the solution of the variational equation, that is 
  $
    bracket(L u^*, v) = bracket(g, v) flushr((forall v in H)).
  $

  Let $H_n subset H$ be arbitrary, then let $u_n$ be the solution in this
  finite subspace, that is
  $
    bracket(L u_n, v) = bracket(g, v) flushr((forall v in H_n)).
  $

  We can easily show Galerkin orthogonality by subtracting the finite
  dimensional variational equation from the full dimensional one to get
  $
    bracket(L(u_n - u^*), v) = 0 flushr((forall v in H_n)).
  $

  #lemma(title: "Céa's lemma")[
    Let $L$ be an $S$-coercive and $S$-bounded linear operator and let $u_n$
    and $u^*$ be defined as above. Then
    $
      norm(u_n - u^*)_S <= M/m min_(v in H_n) norm(u^* - v)_S,
    $
    where $M >= m > 0$ are the constants from the boundedness and coercivity of
    $L$.
  ]
  #proof[
    For any fixed $v in H_n$
    $
      m norm(u_n - u^*)_S^2 &<= bracket(L (u_n - u^*), u_n - u^*) \ 
      &= bracket(L (u_n - u^*), v - u^*) + underbrace(bracket(L (u_n - u^*), overbrace(u_n - v, in H_n)), 0) \ 
      &= bracket(L (u_n - u^*), v - u^*) \
      &<= M norm(u_n - u^*)_S norm(v - u^*)_S.
    $

    In the end we get $norm(u_n - u^*)_S <= M/m norm(v - u^*)_S$, this
    specially holds for the minimal such $v in H_n$ concluding the proof.
  ]

  With this version of Céa's lemma we can provide a new condition for the
  convegence of the Galerkin method.

  #theorem[
    Suppose that $(H_n) subset H$ is a good approximating series of subspaces,
    in the sense that $forall u in H: "dist"_S (u, H_n) -> 0$ when $n -> oo$.
    Then $ norm(u_n - u^*)_S -> 0. $
  ]

  #proof[
    By Céa's lemma
    $
      norm(u_n - u^*)_S &<= M/m min_(v in H_n) norm(u^* - v)_S = M/m "dist"_S (u^*, H_n) \
      lim_(n->oo) norm(u_n - u^*)_S &<= lim_(n->oo) M/m "dist"_S (u^*, H_n) = 0 \
      ==> lim_(n->oo) norm(u_n - u^*)_S &= 0.
      
    $
  ]
]

#problem-counter.update(6)

#problem(points: 2)[
  Consider the following 2D boundary value problem:
  $
    cases(
      -div(abs(nabla u)^(-2\/3) nabla u) = alpha\,,
      u = 0 "on" Gamma_D\, quad partial_nu u = 0 "on" Gamma_N.
    )
  $

  Here $Omega subset RR^2$ is the planar profile of a glacier in a shallow ice
  model and $alpha > 0$ is a physical constant, further, the boundary $partial
  Omega$ is decomposed to disjoint subparts $Gamma_D$ and $Gamma_N$ of positive
  measure. Define the notion of weak solution in a proper Sobolev space, and
  prove that the problem has a unique weak solution.
]

#solution[
  Recall the $p$-Laplace problem from the lecture
  $
    cases(
      -div(abs(nabla u)^(p-2) nabla u) = g\,,
      u|_(partial Omega) = 0.
    )
  $

  This looks too similar to our problem, indeed with $p = 4\/3$ we get back our
  problem.

  The first thing one must do to find a weak form is to multiply by $v in H$
  for some $H$, and integrate over $Omega$
  $
    -div(abs(nabla u)^(-2\/3) nabla u) &= alpha \
    -div(abs(nabla u)^(-2\/3) nabla u) dot v &= alpha dot v \
    integral_Omega -div(abs(nabla u)^(-2\/3) nabla u) dot v &= integral_Omega alpha dot v
  $

  Let us prove a helper proposition
  $
    div(v F) &= nabla v dot F + v div(F) \
    integral_Omega div(v F) &= integral_(partial Omega) v F dot nu \
    integral_Omega nabla v dot F + integral_Omega v div(F) &= integral_(partial Omega) v F dot nu \
    integral_Omega div(F) dot v &= -integral_(Omega) F dot nabla v + integral_(partial Omega) v F dot nu.
  $

  Applying the above proposition with $F = abs(nabla u)^(-2\/3) nabla u$ we get for the weak form
  $
    integral_Omega abs(nabla u)^(-2\/3) nabla u dot nabla v - integral_(partial Omega) v abs(nabla u)^(-2\/3) nabla u dot nu = integral_Omega alpha dot v.
  $

  Let us just focus on the integral over $partial Omega$
  $
    integral_(partial Omega) v abs(nabla u)^(-2\/3) nabla u dot nu  = integral_(Gamma_D) v abs(nabla u)^(-2\/3) nabla u dot nu + integral_(Gamma_N) v abs(nabla u)^(-2\/3) nabla u dot nu.
  $

  Let $v|_(Gamma_D) = 0$ and since $(partial_nu u)|_(Gamma_N) = 0$, both of the
  above integral over $Gamma_D$ and $Gamma_N$ vanish.

  With this we can say that solving the weak form of the problem amounts to
  finding a $u in W^(1, 4\/3)_(Gamma_D) (Omega)$ such that
  $
    integral_Omega abs(nabla u)^(-2\/3) nabla u dot nabla v = integral_Omega alpha dot v flushr((forall v in W^(1, 4\/3)_(Gamma_D) (Omega))),
  $
  where $W^(1, 4\/3)_(Gamma_D)(Omega) = {v in W^(1, 4\/3)(Omega): v|_(Gamma_D) = 0}$.

  Now having established the weak form and the proper Sobolev space in which
  the solution ought to be found, we can turn to proving that such a solution
  exists uniquely.


  #theorem[
    For any given $g in L^q (Omega)$ $exists ! u in W^(1, p)_0 (Omega)$ weak
    solution of the $p$-Laplace equation.
  ]

  The above theorem was shown to be true during the lecture.

  This theorem can be directly applied for the glacier problem with $p = 4\/3$,
  $g = alpha$, and with the modification that we only restrict $u$ to vanish on
  $Gamma_D$.

]
