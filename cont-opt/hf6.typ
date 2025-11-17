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
  #text(blue, size: 25pt)[*Homework 5*] \

  Toffalini Leonardo
]


#exercise[
  Let $f: RR^n -> RR$ be a function and define $tilde(f) : RR^n -> RR$ as
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

#solution[
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

      rect((-1, -1), (1, 1), stroke: 2pt + blue, fill: blue.transparentize(70%))
      line((-0.5, 2.5), (2.5, -0.5), stroke: 2pt + red)
      line((-0.1, 2 + 0.1), (-0.5 - 0.1, 1.5 + 0.1), stroke: 1pt + red, mark: (end: ">"))

      content((0,0), text(size: 18pt)[$P$])
      content((2.2, -0.6), text(size: 14pt)[$c$])

    })
  ]
]

#pagebreak()

#exercise[
  Consider a bounded polyhedron $P = {x in RR^n : a_i dot x <= b_i quad "for" i
  = 1, dots, m}$ and let $F(x)$ be the logarithmic barrier function on the
  interior of $P$, that is $F(x) = -sum_(i=1)^m log(b_i - a_i dot x)$. Write up
  the gradient and the Hessian of $F$ and prove that $F$ is strictly convex.
]

#solution[
]

#pagebreak()

#exercise[
  Let $P = {x in RR^n : a_i dot x <= b_i quad "for" i = 1, dots, m}$ and $x in
  "int"(P)$. For a vector $c in RR^n$, let $c_x = H^(-1)(x) c$, where $H(x)$ is
  the Hessian of the logarithmic barrier function. Verify that hte points $x -
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
