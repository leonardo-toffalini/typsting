#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.5.0" as lq
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
  Suppose that we want to find the root to $x^3 - 7x^2 + 8x - 3 = 0$. Is it
  possible to use $x_1 = 4$ as the initial point? What can you conclude about
  using Newton's method to approximate roots from this example?
]

#solution[
  Let's calculate the derivative of $f$:
  $
    f'(x) = 3 x^2 - 14 x + 8.
  $
  Substituting $x = 4$, we get that
  $
    f'(4) = 3 dot 4^2 - 14 dot 4 + 8 =  48 - 56 + 8 = 0.
  $
  So the derivative of $f$ at $4$ is zero, so we cannot get the next point in
  the Newton iteration.

  This can be see easily from the below diagram, where we see $x_1 = 4$ as an
  orange dot and the derivative of $f$ at $4$ as an orange line, while the two
  roots highlighted with a red dot. Notice, that the tangent line is parallel
  to the x axis, so it will never intersect it, giving us no next point in the
  iteration.

  Any other starting point $x_1 > 4$ would do just fine for finding the root of
  the function.

  #align(center)[
    #let x = lq.linspace(-1, 7)
    #let scatter_x = (4, 5.6858)
    #let scatter_y = (4*4*4 - 7*4*4 + 8*4 - 3, 0)
    #let colors = (orange, red)

    #lq.diagram(
      width: 8cm,
      height: 5cm,
      lq.plot(x, x => x*x*x - 7*x*x + 8*x - 3, mark: none, stroke: 2pt),
      lq.plot(x, x => -19, mark: none, stroke: 1pt),
      lq.scatter(scatter_x, scatter_y, stroke: 4pt, color: colors),

    )
  ]
]

#pagebreak()

#exercise[
  1. Let $f(x_1, x_2) = x_1^2 + K x_2^2$ be a quadratic function where $K > 0$.
     Define $ norm((u_1, u_2))_circle := sqrt(u_1^2 + K u_2^2). $ Determine the
     optimum point of $max_(norm(u)_circle = 1) - nabla f(x) dot u$.

  2. Let $f(x) = x^T A x + b^T x$ (where $A$ is positive definite). Define
     $norm(u)_A := sqrt(u^T A u)$. Determine the optimum point of
     $max_(norm(u)_A = 1) - nabla f(x) dot u$.
]

#solution[
  *1.*\
  Istead of solving the constrained problem
  $
    max_(norm(u)_circle = 1) -nabla f(x) dot u,
  $
  we will move the constraint into the objective with a Lagrange multiplier:
  $
    max_u -nabla f(x) dot u + mu (norm(u)_circle^2 - 1).
  $
  Here we also replaced $norm(u)_circle = 1$ with $norm(u)_circle^2 = 1$, as
  they are equivalent.

  Writing out the objective function, we get
  $
    g(u) &= - nabla (x_1^2 + K x_2^2) dot (u_1, u_2) + mu (u_1^2 + K u_2^2 - 1) \
    &= - (2 x_1, 2 K x_2) dot (u_1, u_2) + mu (u_1^2 + K u_2^2 - 1) \
    &= - (2 x_1 u_1 +  2 K x_2 u_2) + mu (u_1^2 + K u_2^2 - 1).
  $

  This is a nice quadratic function in $u$, so we can just find a root to the
  gradient to optimize the objective.

  Thus, we just need to solve the following:
  $
    nabla g(u) = mat(
      -2x_1 + 2 mu u_1;
      -2 K x_2 + 2 mu K u_2;
      delim: "[",
    ) = mat(0; 0; delim: "[").
  $

  This givs us the solutions:
  $
    u_1 &= x_1 / mu \
    u_2 &= x_2 / mu,
  $
  More concisely, $u = x\/mu$. However, we still need to account for
  $norm(u)_circle^2 = 1$, so $mu = norm(x)_circle$, giving us the final
  solution:
  $
    u = x/norm(x)_circle.
  $
]

#solution[
  *2.*\
  Once again, we will move the constraint into the objective with a
  Lagrange-multiplier.

  Instead of
  $
    max_(norm(u)_A = 1) - nabla f(x) dot u,
  $
  we write
  $
    max_(u) -nabla f(x) dot u + mu (norm(u)_A^2 - 1) = max_u g(u).
  $

  Since $A$ is positive definite, the above objective is convex, thus we need
  only find the root of the gradient to find the minimizer:

  $
    g(u) &= - nabla f(x) dot u + mu (u^T A u - 1) \
    nabla g(u) &= - nabla f(x) + mu A u = 0 \
    nabla f(x) &= mu A u \
    u &= (A^(-1) nabla f(x))/mu.
  $

  Since we need $norm(u)_A^2 = 1$, we have
  $
    mu = norm(A^(-1) nabla f(x))_A \
    u = (A^(-1) nabla f(x)) / norm(A^(-1) nabla f(x))_A.
  $

  We can write out explicity the gradient of $f$ as 
  $
    nabla f(x) = A x + b,
  $
  and with this the explicit form of $u$ is the following:
  $
    u &= (A^(-1) (A x + b)) / norm(A^(-1) (A x + b))_A \
    u &= (x + A^(-1)b) / norm(x + A^(-1) b)_A.
  $
]

#pagebreak()

#exercise[
  Determine the square root of $2$, accurate to four decimal places. using
  Newton's method.
]

#solution[
  We want to find a root to $f(x) = x^2 - 2$, which will give us the value of
  $sqrt(2)$. To solve this we will, of course, use Newton's method:

  $
    x_(t+1) &= x_t - f(x_t)/(f'(x_t)) \
    x_(t+1) &= x_t - (x_t^2 - 2)/(2 x_t).
  $
  Let us call $r$ the root of $f$, that is, $r^2 - 2 = 0 ==> r = sqrt(2)$.

  We can verify, that
  #set math.equation(numbering: "(1)")
  $
    0 = r^2 - 2 &= x_0^2 - 2 + 2(r - x_0) x_0 + (r - x_0)^2 \
    &= x_0^2 - 2 + 2x_0 r - 2 x_0^2 + r^2 - 2 x_0 r + x_0^2 \.
  $<eq:1>
  #set math.equation(numbering: none)

  From the update step, we have
  $
    x_1 = x_0 - (x_0^2 - 2)/(2 x_0) ==> x_0^2 - 2 = 2x_0 (x_0 - x_1)
  $

  Substituing the previously derived equation for $x_1$ into @eq:1 we have
  $
    0 &= 2 x_0 (x_0 - x_1) + 2 (r - x_0) x_0 + (r - x_0)^2 \
    0 &= 2x_0 (x_0 - x_1 + r - x_0) + (r - x_0)^2 \
    0 &= 2 x_0 (r - x_1) + (r - x_0)^2 \
    x_1 - r &= ((r - x_0)^2)/(2 x_0) \
    e_1 &= e_0^2/(2x_0)
  $

  Which implies that the error term converges quadratically. If we choose $x_0
  = 1.5$, we know that $e_0 <= 0.5$, since $sqrt(2) in (1, 1.5)$, because
  $1^2 = 1 < 2 < 2.25 = 1.5^2$. Furthermore, the approximate solution will
  always be greater than $r$ during the iteration with this starting point.

  If we take $k$ steps with Newton's method, the error will be
  $
    e_k <= e_0^(2^k) = 0.5^(2^k).
  $

  We want that $e_k <= 10^(-4)$ so we need to solve $0.5^(2^k) <= 10^(-4)$.

  With some elementary calculations we should get the following result:
  $
    k >= log log 10^(-4).
  $
]

#pagebreak()

#exercise[
  Let $f : RR^n -> RR$ be a strictly convex function. Verify that
  $norm(dot)_(H(x)^(-1))$ is dual to the norm $norm(dot)_x$, where $H$ denotes
  the Hessian of $f$.
]

#solution[
  Assuming, that $norm(y)_x := x^T H(x) x$, where $H(x)$ is the Hessian of $f$
  at $x$. Then, what we want to solve is the following:
  #set math.equation(numbering: "(1)")
  $
    norm(z)_(A^(-1)) = sup_(norm(y)_A <= 1) z dot y.
  $<eq:2>
  #set math.equation(numbering: none)
  Where $A = H(x)$ for some fixed $x$. We will prove a more general
  proposition, that for any $A$ symmetric positive definite matrix the norm
  $norm(dot)_(A^(-1))$ is dual to the norm $norm(dot)_A$. Since, for a convex
  twice differentiable function, it's Hessian is symmetric positive definite,
  this will in turn solve the proposed problem.

  Substituting for the definitions, we have
  $
    sqrt(z^T A^(-1) z) =^? sup_(y^T A y <= 1) z dot y.
  $

  We can move the constraint into the objective function by introducing a
  Lagrange multiplier to represent $y^T A y - 1 <= 0$ and instead of finding
  the supremum, we will find the infimum of the negated objective to align with
  the lecture notes:

  $
    L(y, lambda) &= - z dot y + lambda (y^T A y - 1) quad (lambda >= 0) \
    nabla L(y, lambda) &= -z + 2 lambda A y = 0 \
    ==> y &= 1/(2 lambda) A^(-1) z
  $
  
  And we want to set $lambda$ such that $y^T A y = 1$, so after some derivation
  we solve for $lambda$:
  $
    (1/(2 lambda) A^(-1) z)^T A (1/(2 lambda) A^(-1) z) &<= 1 \
    1/(2 lambda) z^T A^(-1) A (1/(2 lambda) A^(-1)z) &<= 1 \
    1/(2 lambda) z^T (1/(2 lambda) A^(-1) z) &<= 1 \
    z^T A^(-1) z &<= 4 lambda^2 \
    1/2 norm(z)_(A^(-1)) &<= lambda .
  $

  Substituting the derived formula for $lambda$ into the formula for $y$ we get
  $
    y &<= (A^(-1)z)/(norm(z)_(A^(-1))) \
    z dot y &<= (z^T A^(-1)z)/(norm(z)_(A^(-1))) =
  (norm(z)_(A^(-1))^2)/(norm(z)_(A^(-1))) = norm(z)_(A^(-1)),
  $
  which means that the right-hand side of @eq:2 is bounded by above.
  Furthermore, the bound is achievable, which proves the original claim.
]

#pagebreak()

#exercise[
  Let $A in RR^(m times n)$, $b in RR^m$ and $P = { x in RR^n : A x <= b}$ be a
  polytope. For $x in P$, let $H(x)$ denote the Hessian of the logarithmic
  barrier function $F(x) = - sum_(i = 1)^m log (b_i - a_i dot x)$ defined on
  the interior of $P$, denoted by $"int"(P)$. The analytic center of $P$ is
  the unique minimizer of $F(x)$, and is denoted by $x_0^*$. We define the
  Dinkin ellipsoid at a point $x in P$ as 
  $
    E_x = {y in RR^n : (y - x)^T H(x) (y- x) <= 1 }.
  $

  1. Prove thet for all $x in "int"(P)$, $E_x subset.eq P$.

  2. Assume without loss of generality (by shifting the polytope) that $x_0^* =
     0$.\ Prove that $P subset.eq m E_(x_0^*)$.

  3. Prove that if the set of constraints is symmetric, i.e., for every
     constraint of the form $a' dot x <= b'$ there is a corresponding
     constraint $a' dot x >= - b'$, then $x_0^* = 0$ and $P subset.eq sqrt(m)
     E_(x_0^*)$.
]

#solution[
  Solution
]

