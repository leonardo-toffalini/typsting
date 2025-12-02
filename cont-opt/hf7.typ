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
  #text(blue, size: 25pt)[*Homework 7*] \

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
  Let $E(x_0, M) subset.eq RR^2$ be an ellipsoid where
  $
    x_0 = (1, 2) "and" M = mat(9, 0; 0, 4).
  $

  Let $phi(x) = mat(2, 1; 1, 2) x + (3, 5)$. Show that $M$ is positive
  definite. Write up the ellipsoid $phi(E(x_0, M))$.
]

#solution[
  Clearly $M$ is positive definite, as its two leading minors are $9$ and $36$,
  both of which are positive, thus by Sylvester's theorem $M$ is positive
  definite.

  By the previous exercise, $phi(E(x_0, M)) = E(A x_0 + b, A M A^T)$ with $A =
  mat(2, 1; 1, 2)$ and $b = (3, 5)$ if $A$ is inverteble, which indeed it is.
  Giving us the following
  $
    phi(E(x_0, M)) &= E(A x_0 + b, A M A^T) \
    &= E(mat(2, 1; 1, 2) dot mat(1; 2) + mat(3; 5), A M A^T) \
    &= E( mat(2 dot 1 + 1 dot 2 + 3; 1 dot 1 + 2 dot 2 + 2), A M A^T) \
    &= E( mat(7; 7), A M A^T) \
    &= E( mat(7;7), mat(40, 26; 26, 25)).
  $
]

#pagebreak()

#exercise[
  Let both $B_1$ be the unit ball with the origin as a center and $B_2$ be the
  unit ball with the point $(1,0)$ as a center in $RR^2$. Let
  $
    x_1 = (1, 1), quad x_2 = (2, 2), quad M_1 = mat(2, 0; 0, 1), quad "and" quad M_2 = mat(2, 1; 1, 2).
  $

  Prove that there exists no affine mapping $phi$ such that $phi(B_1) = E(x_1,
  M_1)$ and $phi(B_2) = E(x_2, M_2)$.
]

#solution[
  Notice that a ball can be defined as an ellipse as follows:
  $
    B_1 &= E((0,0), mat(1,0;0,1)) \
    B_2 &= E((1,0), mat(1,0;0,1)) \
  $

  Let $phi(x) = A x + b$, where $A in RR^(2 times 2)$ and $b in RR^2$.

  From Exercise 2 we know that
  $
    phi(B_1) = phi(E(mat(0;0), mat(1, 0; 0, 1))) = E(A mat(0;0) + b, A mat(1, 0; 0, 1) A^T) = E(b, A A^T),
  $
  and likewise
  $
    phi(B_2) = E(A mat(1; 0) + b, A A^T).
  $

  Since the problem asks for $phi(B_1) = E_1$ it means that $A A^T = mat(2, 0;
    0, 1)$ and because $phi(B_2) = E_2$ it means that $A A^T = mat(2, 1; 1,
    2)$.

  This is a contradiction as $A$ is some fixed matrix, thus $A A^T$ cannot take two different values.
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
  square, thus it separates their convex hull.

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
