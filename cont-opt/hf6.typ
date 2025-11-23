#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/cetz:0.4.2"
#show: thmbox-init()

#set text(font: "Times New Roman")
#set page(numbering: "1")

#show math.equation.where(block: false): box

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

#let solution = proof.with(
    title: "Solution", 
)

#align(center)[
  #text(blue, size: 25pt)[*Homework 6*] \

  Toffalini Leonardo
]


#exercise[
  Let $f: RR^n -> RR$ be a function and define $tilde(f) : RR^n -> RR$ a
  $tilde(f)(x) = f(A x + b)$ where $A in RR^(n times n)$ is an invertible
  matrix and $b in RR^n$. Prove that if $x_0$ moves to $x_1$ by applying one
  step of Newton's method with respect to $tilde(f)$, then $y_0 = A x_0 + b$
  moves to $y_1 = A x_1 + b$ by applying one step of Newton's method with
  respect to $f$.
]

#solution[
  Given $x_1 = x_0 - H^(-1)_tilde(f) (x_0) dot nabla tilde(f)(x_0)$, we need to
  show that
  $
    A x_1 + b = A x_0 + b - H^(-1)_f (A x_0 + b) dot nabla f(A x_0 + b).
  $

  We know that
  $
    nabla tilde(f)(x_0) = A^T nabla f(A x_0 + b)
  $
  by the chain rule, and likewise
  $
    H_(tilde(f))(x_0) = A^T H_f (A x_0 + b) A.
  $

  From this we have
  $
    x_1 &= x_0 - H^(-1)_(tilde(f))(x_0) dot nabla tilde(f)(x_0) \
    x_1 &= x_0 - (A^T H_f (A x_0 + b) A)^(-1) dot A^T nabla f(A x_0 + b) \
    x_1 &= x_0 - A^(-1) H_f^(-1) A^(-T) dot A^T nabla f(A x_0 + b) \
    x_1 &= x_0 - A^(-1) H^(-1)_f dot nabla f(A x_0 + b) \
    A x_1 &= A x_0 - H^(-1)_f dot nabla f(A x_0 + b) \
    A x_1 + b &= A x_0 + b - H^(-1)_f dot nabla f(A x_0 + b) \
    y_1 &= y_0 - H^(-1)_f dot nabla f(y_0) \
  $
]

#pagebreak()

#exercise[
  Consider the following functions $f: K -> RR$. Check if they satisfy the *NL*
  condition for some constant $0 < delta_1 < 1$.

  1. $f(x) = -log cos (x)$ on $K = (-pi \/ 2, pi \/ 2)$.
  2. $f(x) = x log (x) + (1 - x) log (1 - x)$ on $K = (0, 1)$.
  3. $f(x) = -sum_(i=1)^n log (x_i)$ on $K = RR^n_(>0)$.
]

#solution[ \
  *1.* \
  $
    H(x) = f''(x) = (1/cos x sin x)' = tg' x = 1/(cos^2 x).
  $

  $
    (1 - 3 delta) H(x) = (1 - 3 delta) 1/(cos^2 x) <=^? 1/(cos^2 y)
  $

  $
    (1 - 3 delta) 1/(cos^2 x) <= 1 < 1/(cos^2 y)
  $

  $
    1 - 3 delta <= cos^2 x
  $

  Let $delta = 2\/3$, then
  $
    1 - 3 delta = -1 <= cos^2 x quad forall x.
  $

  We did not even have to use the fact that $norm(y - x)_x <= delta$.

  The same reasoning works for the opposite direction aswell.

  *2.* \ 
  $
    H(x) = f''(x) = (1 + log x -log (1 - x) - 1)' = (log x - log (1 - x))' = 1/x + 1/(1 - x).
  $

  $
    (y - x)^2/x + (y - x)^2/(1 - x) <= delta
  $

  $
    (1 - 3 delta) (1/x + 1/(1 - x)) <=^? 1/y + 1/(1 - y)
  $

  $
    1/1 + 1/(1 - 0) = 2 < 1/y + 1/(1 - y)
  $

  It is enough to show
  $
    (1 - 3 delta)(1/x + 1/(1 - x)) = (1 - 3 delta) 1/(x (1 - x)) <= 2
  $
  $
    1 - 3 delta <= 2 x (1 - x)
  $
  Since $0 <= 2 x (1 - x)$ when $x in (0, 1)$, we can choose $delta = 2\/3$, thus
  $
    1 - 3 delta = -1 <= 2 x ( 1- x) quad forall x in (0, 1).
  $

  A similar argument can be applied for the opposite direction.

  *3.* \
  $
    H(x) = nabla (nabla -sum_(i=1)^n log x_i) = nabla (-1/x_1, dots, -1/x_n) =
    mat(
      1/x_1^2, 0, 0, dots, 0;
      0, 1/x_2^2, 0, dots, 0;
      0, 0, 1/x_3^2, dots, 0;
      dots.v, dots.v, dots.v, dots.down, dots.v;
      0, 0, 0, dots, 1/x_n^2;
      delim: "["
    )
  $

  $
    norm(y - x)_x = (y - x)^T H(x) (y - x) <= delta
 $
]

#pagebreak()

#exercise[
  Let $P = {x in RR^2 : abs(x_1) <= 1, quad abs(x_2) <= 1}$ and $c = (1, 1) in
  RR^2$. Determine the points of the central path $Gamma_c$.
]

#solution[
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 100%, y: 100%)

      line((-3, 0), (3, 0), mark: (end: ">"))
      line((0, -3), (0, 3), mark: (end: ">"))

      rect((-1, -1), (1, 1), stroke: 2pt + blue, fill: blue.transparentize(80%))
      line((-0.5, 2.5), (2.5, -0.5), stroke: 2pt + red)
      line((-0.1, 2 + 0.1), (-0.5 - 0.1, 1.5 + 0.1), stroke: 1pt + red, mark: (end: ">"))
      line((0,0), (1,1), stroke: 1pt + green)

      // content((0,0), text(size: 18pt)[$P$])
      // content((2.2, -0.6), text(size: 14pt)[$c$])

    })
  ]

  The polytope can be given with the following conditions:
  $
    x_1 &<= 1; quad
    -x_1 &<= 1; quad
    x_2 &<= 1; quad
    -x_2 &<= 1.
  $

  From this we have the logarithmic barrier function and it's gradient as follows
  $
    F(x) = - log(1 - x_1) - log (1 + x_1) - log(1-x_2) - log(1 + x_2)
  $
  $
    nabla F(x) = mat(
      1/(1 - x_1) - 1/(1 + x_1);
      1/(1 - x_2) - 1/(1 + x_2);
      delim: "[",
    ).
  $

  Let $f_t (x) = t (c dot x) + F(x)$, with this we have
  $
    nabla f_t (x) = mat(
      t + 1/(1 - x_1) - 1/(1 + x_1);
      t + 1/(1 - x_2) - 1/(1 + x_2);
      delim: "[",
    ),
  $
  and we need this to be the $(0, 0)$ vector for all $t > 0$. Since the two
  equations are the same we only focus on one of them.
  $
    t + 1/(1 - x_1) - 1/(1 + x_1) &= 0 \
    (1 - x_1^2) t + 1 + x_1 - 1 + x_1 &= 0 \
    t x_1^2 - 2 x_1 - t &= 0 \
    x_1 &= (2 plus.minus sqrt(4 - 4 t^2))/(2 t) = (1 plus.minus sqrt(1 - t^2))/t.
  $

  From these two solutions only the the one with the minus will be inside the
  polytope. Thus we have
  $
    Gamma_c = {(gamma(t), gamma(t)) : t >= 0}, quad " where " quad gamma(t) = (1 - sqrt(1 - t^2))/t.
  $

]

#pagebreak()

#exercise[
  Consider a bounded polyhedron $P = {x in RR^n : a_i dot x <= b_i quad "for" i
  = 1, dots, m}$ and let $F(x)$ be the logarithmic barrier function on the
  interior of $P$, that is $F(x) = -sum_(i=1)^m log(b_i - a_i dot x)$. Write up
  the gradient and the Hessian of $F$ and prove that $F$ is strictly convex.
]

#solution[
  $
    nabla F(x) = - sum_(i=1)^m 1/(b_i - a_i dot x) dot (-a_i) = sum_(i=1)^m a_i/(b_i - a_i dot x)
  $

  $
    H(x) = nabla^2 F(x) = nabla (sum_(i=1)^m a_i/(b_i - a_i dot x)) =
  sum_(i=1)^m a_i/(b_i - a_i dot x) dot a_i^T = sum_(i=1)^m (a_i dot a_i^T)/(b_i
  - a_i dot x).
  $

  To show that $F$ is strictly convex on the interior of $P$ we need to show that $H(x)$ is positive definite.
  In other words, that $forall z in RR^n$ we have $z^T H(x) z > 0$.
  $
    z^T H(x) z &= z^T = z^T (sum_(i=1)^m (a_i dot a_i^T)/(b_i - a_i dot x)) z = sum_(i=1)^m (z^T a_i dot a_i^T z)/(b_i - a_i dot x) \
    &= sum_(i=1)^m ((a_i^T z)^T (a_i^T z)) / (b_i - a_i dot x) = sum_(i=1)^m (norm(a_i^T z)^2)/(b_i - a_i dot x) >= 0.
  $

  Since $x in "int"P$, we have $b_i - a_i dot x >= 0$ for any $i = 1, dots, m$,
  and the norm of any vector is nonnegative.

  Now we just need to show that for any $z != 0$ we have $z^T H(x) z != 0$.
  This could only happen if $a_i dot z = 0$ for all $i = 1, dots, m$. However,
  since the problem specified that $P$ is bounded, this implies that there are at
  least $n$ linearly independent constraint vectors $a_i$, thus such a $z$ cannot exist.
]

#pagebreak()

#exercise[
  Let $P = {x in RR^n : a_i dot x <= b_i quad "for" i = 1, dots, m}$ and $x in
  "int"(P)$. For a vector $c in RR^n$, let $c_x = H^(-1)(x) c$, where $H(x)$ is
  the Hessian of the logarithmic barrier function. Verify that hte point $x -
  c_x \/ norm(c_x)_x$ is in $P$.
]

#solution[
]

#pagebreak()

#exercise[
  Let $A in RR^(m times n)$, and let $P = {x in RR^n: A x <= b}$ be a polytope with nonempty interior. Suppose that $x_0 in P$ satisfies $b_i - a_i dot x_0 >= delta$  for all $i = 1, dots, m$ and some $delta > 0$. Define the logarithmic barrier function $F(x) = -sum_(i=1)^m log (b_i - a_i dot x)$ and let $g(x) = nabla F(x)$ denote it's gradient. If $D$ is the Euclidian diameter of $P$, show that for every $x in P$ and every $i = 1, dots, m$ we have
  $
    b_i - a_i dot x >= (delta)/(m + norm(g(x)) D).
  $
]

#solution[
]

#pagebreak()

#exercise[
  Let $f : RR^n -> RR$ and suppose that there sxists cosntants $0 < m <= L$
  such that for all $z in RR^n$ the Hessian satisfies $m I prec.eq nabla^2 f(z)
  prec.eq L I$. Let $x in RR^n$ and let $n(x) = -H^(-1)(x) g(x)$ be the Newton
  step with $g(x) = nabla f(x)$ and $H(x) = nabla^2 f(x)$ Show that
  $
    f(x + n(x)) - f(x) <= - 1/(2 L) norm(g(x))^2
  $
  and
  $
    f(x + n(x)) - f(x) >= - 1/(2 m) norm(g(x))^2.
  $

  (Hint: use the second-order Taylor expansion with the mean-value form of the
  remainder and the bounds on $nabla^2 f$.)
]

#solution[
  
]
