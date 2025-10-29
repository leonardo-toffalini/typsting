#import "@preview/thmbox:0.3.0": *
#show: thmbox-init()

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

// derive from some predefined function
#let solution = note.with(
    variant: "Solution", 
    color: green,
)

#align(center)[
  #text(blue, size: 25pt)[*Homework 2*] \

  Toffalini Leonardo
]

#exercise[
  Show that $f: RR^n -> RR$ is convex if and only if $g(t) := f(t y + (1  - t)x)$ is convex for any $x, y in "dom"(f)$.
]

#solution[
  By definition $f$ is convex if and only if $f(t y + (1 - t)x) <= t f(y) +
  (1 - t) f(x)$ for any $t in [0, 1]$. We need to prove that the previous is
  equivalent
  to the following:
  $
    g(lambda t_1 + (1 - lambda)t_2) <= lambda g(t_1) + (1 - lambda) g(t_2).
  $
  Expanding the above equation by substituting for the definition of $g$ we get
  the following:
  $
    g(lambda t_1 + (1 - lambda)t_2) &= f((lambda t_1 + (1 - lambda) t_2) y + (1
  - (lambda t_1 + (1 - lambda)t_2)) x) \
    &= f(lambda t_1 y + (1 - lambda t_1) x + (1 - lambda)t_2 y + (1 - (1 -
  lambda)t_2) x) \
    &= f ( lambda (t_1 y + (1 - t_1)x) + (1 - lambda) (t_2 y + (1 - t_2)x)) \
    &<= lambda f(t_1 y + (1 - t_1)x) + (1 - lambda) f(t_2 y + (1 - t_2)x) \
    &= lambda g(t_1) + (1 - lambda) g(t_2)
  $
]

#exercise[
  Prove that
  + $e^(a x)$ is convex on $RR$ for any $a in RR$,
  + $x^a$ is convex on $R_(> 0)$ when $a >= 1$ or $a <= 0$, and is concave when
    $0 < a < 1$,
  + $log(x)$ is concave on $RR_(> 0)$,
  + $x log(x)$ is convex on $RR_(> 0)$.
]

#solution[
  *1. $e^(a x)$ is convex for any $a in RR$*

  Since $e^(a x) in C^infinity(RR)$ for any $a in RR$, we can just show that
  it's second derivative is positive. The following is the second derivative:
  $
    (e^(a x))'' = a^2 e^(a x).
  $

  We can clearly see that it is nonnegative, since $a^2 >= 0, forall a in RR$,
  and $e^c >0, forall c in RR$.

]
#solution[
  *2. $x^a$ is convex on $R_(> 0)$ when $a >= 1$ or $a <= 0$, and is concave
  when $0 < a < 1$*

  Since $x^a in C^2$ for any value $a in RR$, we just need to verify that in
  the given intervals it is convex and concave, respectively. The following is
  the second derivative:
  $
    (x^a)'' = (a x^(a - 1))' = a (a - 1) x^(a - 2).
  $

  Since $x^c >= 0$ holds for all $x > 0$, we just need to check for which
  values of $a$ is $a (a - 1)$ negative or positive. With some elementary
  arithmetic we can verify that $a (a - 1)$ is negative if and only if $a in
  (0, 1)$. Thus, the function is concave on said interval, and is convex
  elsewhere.

  To tidy up some negligence from the previous argument, we still need to take
  care of the cases where $a = 1$ and $a = 0$, since in these cases the power
  rule does not hold for $(x^0)'$. Luckily it is trivial to check that the
  linear function $x$ and the constant function $x^0 = 1$ are both convex.
]

#solution[
  *3. $log(x)$ is concave on $RR_(> 0)$*

  Once again, because $log x in C^2 RR$ we just need to check the sign of $(log
  x)''$.
  $
    (log x)'' = (1/x)' = - 1/x^2 < 0 quad forall x in RR_(>0)
  $
]

#solution[
  *4. $x log(x)$ is convex on $RR_(> 0)$*

  $
    (x log x)'' = (log x + x 1/x)' = 1 / x > 0 quad forall x in RR_(>0)
  $

]

#exercise[
  Show the following.
  + (Nonnegative weighted sum) If $w_i >= 0$ and $f_i$ is convex for every $i$,
    then $f = sum_i w_i f_i$ is convex.
  + (Affine mapping) If $f$ is convex, then $g(x) = f(A x + b)$ is convex.
  + (Pointwise maximum) If $f_i$ is convex for every $i$, then $f(x) = max_i
    {f_i (x)}$ is convex.
  + (Composition) If $g$ is convex and $h$ is convex and non-decreasing, then
    $f(x) = h(g(x))$ is convex.
]

#solution[
  *Nonnegative weighted sum*

  $
    f(t x + (1 - t)y) = sum w_i f_i (t x + (1 - t)y) <= sum w_i (t f_i (x) + (1
  - t) f_i (y)) \
    = t sum w_i f_i (x) + (1 - t) sum w_i f_i (y) = t f(x) + (1 - t) f(y).
  $
]

#solution[
  *Affine mapping*

  $
    g(t x + (1 - t)y) = f(A (t x + (1 - t)y) + b) = f(t A x + (1 - t) A y + b) <= \
    <= t f(A x + b) + (1 - t) f(A y + b) = t g(x) + (1 - t) g(y).
  $
]

#solution[
  *Pointwise maximum*

  $
    f(t x + (1 - t)y) = (max_i f_i)(t x + (1 - t)y)
  $

  Let $f_k$ be the convex function at which the maximum is obtained.

  $
    (max_i f_i)(t x + (1 - t)y) = f_k (t x + (1 - t) y) <= t f_k (x) + (1 - t)
  f_k (y) <= \
    <= t (max_i f_i)(x) + (1 - t) (max_i f_i) (y) = t f (x) + (1 - t) f (y).
  $
]

#solution[
  *Composition*

  $
    f(t x + (1 - t)y) = h(g(t x + (1 - t)y))
  $
  Since $g$ is convex the inner sum can be broken into something bigger, and
  since $h$ is non-decreasing, if we put something larger inside the body the
  value will not get smaller.
  $
    <= h(t g(x) + (1 - t) g(y)) <= t h(g(y)) + (1 - t) h(g(y)) = t f(x) + (1 -
  t) f(y).
  $
]

#exercise[
  Prove that for an arbitrary set $S subset.eq RR^n$, the polar set
  $
    S^* = {y in RR^n | y^T x <= 1 quad forall x in S}
  $
  is convex.
]

#solution[
  By the definition of a convex set, we have to prove the following:
  $
    forall x, y in S^*, t in [0, 1]: quad t x + (1 - t) y in S^*.
  $
  Since $x, y in S^*$ we have $x dot z <= 1$ and $y dot z <= 1$ for all $z in S$.
  $
    (t x + (1 - t)y) dot z = t x dot z + (1 - t) y dot z <= t + (1 - t) = 1.
  $
]

#exercise[
  Let us consider the following functions:
  $
    f_1(x, y) &= 1/2 x^2 + 7/2 y^2 \
    f_2(x, y) &= 100(y - x^2)^2 + (1 - x)^2 quad quad "(Rosenbrock's function)" \
    f_3(x, y) &= 1/2 x^2 + x cos y.
  $

  + Calculate the gradient of the funcions.
  + Determine the global minimum of the functions.
  + Are these function convex?
]

// #align(center)[
// #lq.diagram(
//   width: 12cm, height: 6cm,
//   lq.contour(
//     lq.linspace(-6, 6, num: 100),
//     lq.linspace(-3, 3, num: 100),
//     (x, y) => 1/2 * x * x + 7/2 * y * y,
//     fill: true,
//     map: color.map.viridis,
//     levels: 20,
//   )
// )]

// #align(center)[
// #lq.diagram(
//   width: 8cm, height: 8cm,
//   lq.contour(
//     lq.linspace(-1.8, 1.8, num: 100),
//     lq.linspace(-1, 3, num: 100),
//     (x, y) => 100 * calc.pow(y - calc.pow(x, 2), 2) + calc.pow(1 - x, 2),
//     fill: true,
//     map: color.map.viridis,
//     levels: 20,
//   )
// )]

#solution[
  *1.* \
  1.1
  $
    nabla f_1(x, y) = mat(partial_x f_1(x, y); partial_y f_1(x, y); delim: "[")
  = mat(x; 7 y; delim: "[")
  $
  2.1 The global minimum value of $f_1$ is $0$, which is attained at the point
    $(0, 0)$. \
  3.1 The function is in fact convex, because it's Hessian is $mat(1, 0; 0, 7;
    delim: "[")$, which is positive definite.
]

#solution[
  *2.* \
  2.1
  $
    nabla f_2(x, y) = mat(
      200(y - x^2) dot (-2 x) + 2(1 - x^2) dot (- 1);
      200(y - x^2);
    delim: "[") = \
    = mat(
    -400x(y- x^2) - 2 (1 - x^2);
    200(y - x^2);
    delim: "["
  ) = \
  = mat(
    400x^3 - 400 x y + 2 x - 2;
    200(y - x^2);
    delim: "["
  )
  $
  2.2 The global minimum value is $0$, which is attained at the point $(1, 1)$. \
  2.3 The hessian of the Rosenbrock function is the following:
  $
    H = mat(
    1200x^2 - 400y + 2, -400x;
    -400x, 200;
    delim: "["
  ).
  $
  The hessian at point $(x, y) = (1, 1.5)$ is the following:
  $
    H = mat(
    602, -400;
    -400, 200;
    delim: "["
  ).
  $
  At this point the full determinant is $602 dot 200 - 400 dot 400 = -39600 <
  0$. Thus, the hessian is not PSD making it non convex.
]

#solution[
  *3.* \
  3.1
  $
    nabla f_3(x, y) = mat(
      x + cos y;
      -x sin y;
      delim: "["
    )
  $
  3.2 The minimum value of $-1$ is attained at the point $(x, y) = (-1, 0)$. \
  3.3 The hessian of the function is the following:
  $
    H = mat(
    1, -sin y;
    - sin y, -x cos y;
    delim: "["
  )
  $
  The full determinant of the matrix is $-x cos y - sin^2 y$, which at the
  point $(1, 0)$ is $-1$, making the hessian not PSD, thus the function is not
  convex.
  
]

#exercise[
  Prove that for an arbitrary function $f: RR^n -> RR$, the conjugate function
  $
    f^*(y) = sup {y^T x - f(x) | x in "dom"(f)}
  $
  is convex.
]

#solution[
  $
    f^*(t y + (1 - t)z) &= sup_(x in "dom"(f)) { (t y + (1 - t)z) dot x - f(x) } \
    &= sup_(x in "dom"(f)) { t (y dot x) + (1 - t)(z dot x) - f(x) } \
    &= sup_(x in "dom"(f)) { t (y dot x) + (1 - t)(z dot x) - (t f(x) + (1 - t)
  f(x))} \
    &= sup_(x in "dom"(f)) {t (y dot x - f(x)) + (1 - t) (z dot x - f(x))} \
    &<= sup_(x in "dom"(f)) {t (y dot x - f(x))} + sup_(x in "dom"(f)) {(1 -
  t)(z dot x - f(x))} \
    &= t sup_(x in "dom"(f)) { y dot x - f(x) } + (1 - t) sup_(x in "dom"(f)) {
  z dot x - f(x) } \
    &= t f^* (y) + (1 - t) f^* (z)
  $
]

#exercise[
  Consider the optimization problem
  $
    min_(x in RR) quad& x^2 + 2x + 4 \
    "s.t." quad& x^2 - 4x <= -3
  $
  + Solve this problem, i.e., find the optimal solution.
  + Derive the Lagrangian dual problem.
  + Prove, that weak duality holds by computing the maximum of the dual
    problem. Is Slater's condition satisfied? Does strong duality hold?
]

#solution[
  1. Since the objective function is a convex quadratic function, the optimum
    will be attained at either the point where the first derivative vanishes,
    or on the boundary.

    The objective function's derivative is $2x + 2$, which has a root at $-1$.
    However, we still need to check if the defining condition is met for $x =
    -1$.
    $
      (-1)^2 - 4(-1) = 1 + 4 = 5 lt.eq.not -3.
    $
    So $x = -1$ is not the solution. Thus, we need to investigate the boundary
    of the condition.

    We need to check for what $x$ does the following hold:
    $
      x^2 - 4x + 3 <= 0.
    $
    This inequality holds for $x in [1, 3]$. From this it is easily verifiable,
    that the solution is found at $x = 1$ with the value of $7$.
]

#solution[
  2. The Lagrangian dual function is the following:
    $
      g(lambda, mu) &= inf_x L(x, lambda, mu) \
      &= inf_x (f_0 (x) + sum_(i=1)^m lambda_i f_i (x) + sum_(i=1)^p mu_i h_i (x))
    $

    In our case $f_0 = x^2 + 2x + 4$, and $f_1 = x^2 - 4x + 3$, and there are not
    other $f_i$ or $h_i$.
    $
      g(lambda, mu) &= inf_x (x^2 + 2x + 4 + lambda (x^2 - 4x + 3)) \
      &= inf_x ((1 + lambda) x^2 + (2 - 4 lambda)x + 4 + 3 lambda)
    $
    Thus the Lagrangian dual problem is the following:
    $
      "maximize" quad & inf_x ((1 + lambda) x^2 + (2 - 4 lambda)x + 4 + 3 lambda) \
      "subject to" quad & lambda >= 0
    $
]

#solution[
  3. Let's solve the dual problem. Since the dual function is always concave,
     independent of the convexity of the primal function, we just need to check
     where the first derivative vanishes.
    $
      0 &= ((1 + lambda)x^2 + (2 - 4 lambda)x + 4 + 3 lambda)' = 2 ( 1 + lambda) +
        2 - 4 lambda \
      0 &= 4 - 2 lambda ==> lambda = 2.
    $

    At $lambda = 2$ the maximal value of the dual function is
    $
      g(2) = inf_x (3 x^2 - 6 x + 10) = 7.
    $
    From this we see that not only weak duality, but strong duality holds, as
    $d^* = p^* = 7$. \
    We can also see that Slater's conditions are met, since $f_1$ is convex and
    there exists a point $x in (1, 3)$, which strictly satisfies the condition
    $f_1 (x) < 0$.
]

#exercise[
  Given a convex, differentiable function $F: K -> RR$ over a convex subset $K$
  of $RR^n$, the #emph[Bregman divergence] of $x, y in K$ is defined as
  $D_F (x, y) = F(y) - F(x) - angle.l nabla F(x), y- x angle.r$. Prove that
  $D_F (x, y) >= 0$. Define a function $F$ for which $D_F (x, y) = norm(x-
    y)_2^2$.
]

#solution[
  Since $F$ is convex and differentiable, the first order characterization holds:
  $
   F(y) >= F(x) + angle.l nabla F(x), y - x angle.r.
  $
  Rearranging the inequality we get the following:
  $
    F(y) - F(x) - angle.l nabla F(x), y -  x angle.r >= 0.
  $
  The left hand side of the inequality is precisely the definition of $D_F (x,
  y)$, thus it is nonnegative.

  In the following we show that for $F(x) = norm(x)^2$, we get $D_F (x, y) =
  norm(x - y)^2$:
  $
    F(x) &= norm(x)^2 ==> nabla F(x) = nabla (x^T I x) = 2x \
    D_F (x, y) &= norm(y)^2 - norm(x)^2 - angle.l 2 x, y-x angle.r \
    &= norm(y)^2 - norm(x)^2 - angle.l 2x, y angle.r + angle.l 2x, x angle.r \
    &= norm(y)^2 - norm(x)^2 - 2 angle.l x, y angle.r + 2 norm(x)^2 \
    &= norm(x)^2 - 2 angle.l x, y angle.r + norm(y)^2 \
    &= angle.l x - y, x - y angle.r = norm(x - y)^2
  $
]
