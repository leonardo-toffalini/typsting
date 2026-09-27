#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/cetz:0.4.2"
#import "@preview/intextual:0.1.0": flushr, intertext-rule
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
  #text(blue, size: 25pt)[*Homework 3*] \

  Toffalini Leonardo
]

#exercise[
  Determine the homeomorphism h showing that the following systems are topologically conjugate.
  $
    cases(
      dot(x)_1 &= -x_1,
      dot(x)_2 &= x_2
    )
    quad 
    cases(
      dot(y)_1 &= -y_1 + y_2,
      dot(y)_2 &= 2y_2
    )
  $
]

#solution[
  As hinted we will first provide a homeomorphism $g$ that will take the first system to the system
  $
    cases(
      dot(z)_1 &= -z_1,
      dot(z)_2 &= 2z_2
    ).
  $

  We have seen this case before, so without going into too much detail, it can
  be verified that $g(p) = (g_1(p), g_2(p))$ defined as $g_1(p_1, p_2) = p_1,
  quad g_2 (p_1, p_2) = p^3/abs(p) = p dot abs(p) = p^2 "sgn"(p)$ is a
  homeomorphism that maps the $x$-system into the $z$-system.

  Now we just need to provide a homeomorphism that maps the $z$-system into the
  $y$-system. First, notice that both these systems are linear with the
  matrices $D = mat(-1, 0; 0, 2)$ and $B = mat(-1, 1; 0, 2)$, and $dot(z) = D
  z$, $dot(y) = B y$.

  As continuous linear dynamical systems, we know that they are $C^k$-conjugate
  ($k >= 1$) if and only if their defining matrices are similar.

  After some calculations, we can find that the matrix $A = mat(1, 1/3; 0, 1)$
  is such that $B A = A D$, that is, $B$ and $D$ are similar.

  Since the $z$-system and the $y$-system are $C^k$-conjugate, they are also
  $C^0$-conjugate, thus $h(p) = A(g(p))$ is a homeomorphism between the
  original two systems.
]

#pagebreak()

#exercise[
  Show that $C^0$-equivalence divides the set $L(RR^4)$ into infinitely many
  classes.
]

#solution[
  TODO
]

#pagebreak()

#exercise[
  In which classes (according to $C^0$-equivalence) is the following system as $lambda$ runs in $RR$?
  $
    cases(
      dot(x_1) &= x_1 + lambda x_2,
      dot(x)_2 &= lambda x_1 + lambda x_2
    )
  $
]

#solution[
  It is clear to see that we can write this system as $dot(x) = A x$ where $A =
  mat(1, lambda; lambda, lambda)$. Using Kuiper's theorem we just need to
  analyze the eigenvalue structure of this simple matrix to get a complete view
  of the $C^0$-equivalence classes.

  To calculate the eigenvalues we need to find the roots of the matrix's
  characteristic polynomial:
  $
    P_A (x) = (x - 1) (x - lambda) - lambda^2 = x^2 -(1 + lambda) x + lambda - lambda^2 = 0
  $

  $
    x_(1, 2) = (1 + lambda plus.minus sqrt((1 + lambda)^2 - 4 lambda + 4 lambda^2))/2 = (1 + lambda plus.minus sqrt(5 lambda^2 - 2 lambda + 1))/2
  $

  We can clearly see that when $lambda in RR$ the determinant of the above
  expression is always positive, so we do not have to worry about complex
  eigenvalues, meaning that $"Re"(x) = x$.

  According to Kuiper's theorem we need only know the sign of the eigenvalues
  to characterize the $C^0$-equivalnce. To find the sign we can solve the
  equation $x_(1, 2) (lambda) = 0$.

  After some calculations we can come to the conclusion that the original
  system has a zero eigenvalue only in the cases where $lambda = 0$ or $lambda
  = 1$. This splits the real line into $5$ components that need to be treated:
  $lambda < 0, quad lambda = 0, quad lambda in (0, 1), quad lambda = 1, quad lambda > 1$.

  (From now we will use the convention that $x_1$ is the root of a quadratic
  which we get by using the plus in the $plus.minus$ of the formula.)

  1. $lambda < 0$: $x_1 < 0$, $x_2 > 0$.
  2. $lambda > 1$: $x_1 > 0$, $x_2 < 0$.
  3. $lambda = 0$: $x_1 = 0$, $x_2 = 1$.
  4. $lambda = 1$: $x_1 = 0$, $x_2 = 2$.
  5. $lambda in (0, 1)$: $x_1 > 0$, $x_2 > 0$.

  From this we can conclude that cases 1. and 2. are equivalent, and cases 3.
  and 4. are also equivalent. Thus we get three classes:
  1. $lambda in (-oo, 0) union (1, +oo)$: $A ~ mat(1, 0; 0, -1)$ (saddle)
  2. $lambda in {0, 1}$: $A ~ mat(1, 0; 0, 0)$ (infinitely many equilibrium points)
  3. $lambda in (0, 1)$: $A ~ mat(1, 0; 0, 1)$ (source)
]

