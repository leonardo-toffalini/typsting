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
  The perfect mathing polytope of a graph $G$ is given by
  $
    P_(P M) = {x in RR_+^E | x(delta(v)) = 1 "for " v in V, quad x(delta(U)) >=
  1 "for " U subset.eq V, quad abs(U) "odd"}.
  $
  Separating over $P_(P M) (G)$ means that for a vector $x in RR^E$, we want to
  devide if $x in P_(P M) (G)$ or not.

  1. Prove that separating over $P_(P M)(G)$ reduces to the following *odd minimum cut problem:* give $x in QQ^E$, find
  $
    min_(S subset.eq V, abs(S) "odd") sum_(u in S, v in.not S, u v in E) x_(u v).
  $

  2. Prove that the odd minimum cut problem is polynomially solvable.
]

#solution[
  *TODO*
]

#pagebreak()

#exercise[
  Consider an affine map $phi(x) = A x + b$, where $A in RR^(n times n)$ is an
  invertible matrix. Show that $phi(E(x_0, M)) = E(A x_0 + b, A M A^T)$.
]

#solution[
  We need to show that $x in phi (E(x_0, M)) <==> x in E(A x_0 + b, A M A^T)$.

  $
    x &in phi (E(x_0, M)) <==> phi^(-1)(x) in E(x_0, M) \
    &<==>^"def" (phi^(-1)(x) - x_0)^T M^(-1) (phi^(-1)(x) - x_0) <= 1 \
    &<==> (A^(-1)(x - b) - x_0)^T M^(-1) (A^(-1)(x - b) - x_0) <= 1 \
    &<==> (A^(-1)(x - b - A x_0))^T M^(-1) (A^(-1) (x - b - A x_0)) <=1 \
    &<==> (x - b - A x_0)^T A^(-T) M^(-1) A^(-1) (x - b - A x_0) <= 1 \
    &<==> (x - (A x_0 + b)) (A M A^T)^(-1) (x - (A x_0 + b)) <= 1 \
    &<==>^"def" x in E(A x_0 + b , A M A^T).
  $
]

#pagebreak()

#exercise[
  Let $C = [0, 1] times [0, 1] subset.eq RR^2$ and let $a = (3, 3)$. Find all
  hyperplanes that separates $C$ and $a$.
]

#solution[
  A hyperplane $P$ is defined as $x dot v = c$ where $v in RR^n$ is the normal
  of the plane. A plane separates two points $a, b in RR^n$ if $a dot v <= c$
  and $b dot v >= c$.

  It is enough to show that a plane $P$ separates the four corners of the
  square, thus it separates any convex conbination of the corners.

  So we need to find $v in RR^2$ and $c in RR$ such that
  $
    (0, 0) dot (v_1, v_2) <= c \
    (0, 1) dot (v_1, v_2) <= c \
    (1, 0) dot (v_1, v_2) <= c \
    (1, 1) dot (v_1, v_2) <= c \
  $

  and $(3,3) dot (v_1, v_2) >= c$.

  This results in the following five simple inequalities
  $
    0 <= c, quad v_1 <= c, quad v_2 <= c, \
    v_1 + v_2 <= c, quad v_1 + v_2 >= c/3.
  $

  Any plane $x dot v = c$ that satisfies the above five condition separates $C$
  and $a$.

  Example: $v = (1, 1)$ and $c = 3$.

]
