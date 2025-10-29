#import "@preview/thmbox:0.3.0": *
#show: thmbox-init()

#set text(font: "Times New Roman")
#set page(numbering: "1")

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

#let solution = proof.with(
    title: "Solution", 
)

#align(center)[
  #text(blue, size: 25pt)[*Homework 4*] \

  Toffalini Leonardo
]


#exercise[
  Prove that for all $p in Delta_n, D_"KL" (p, p^1) <= log n$. Here $p^1$ is
  the uniform probability distribution with $p^1_i = 1/n$ for $i = 1, dots, n$.
]

#solution[
  Let $p = (p_1, dots, p_n)$.

  $
    D_"KL" (p, p^1) &= sum_(i = 1)^n p_i log p_i/(1 \/ n) = sum_(i=1)^n p_i log
  (p_i n) = sum_(i=1)^n p_i (log p_i + log n) = sum_(i=1)^n p_i log p_i +
  sum_(i=1)^n p_i log n \
    &= sum_(i=1)^n p_i log p_i + log n sum_(i=1)^n p_i = sum_(i=1)^n p_i log
  p_i + log n.
  $

  Since $p_i <= 1$ for all $i = 1, dots n$, we have $log p_i <= 0$ for all $i =
  1, dots n$. Thus, we get the final result:
  $
    D_"KL" (p, p^1) <= log n.
  $
]

#pagebreak()

#exercise[
  Verify that in the exponential gradient descent algorithm, $p^(t+1)$ is the
  projection of $w^(t+1)$ onto $Delta_n$ with respect to $D_H$ (i.e. show
  that $p^(t+1) = "argmin" { D_H (x, w^(t + 1)) : x in Delta_n }$).
]

#solution[Let's recall the definitions:
  $
    Delta_n := {p in [0, 1]^n : sum_(i=1)^n p_i = 1}
  $

  $
    p^(t+1) := "argmin"_(p in Delta_n) { D_"KL" (p, p^t) + alpha nabla f(p^t)
  dot p }
  $

  $
    w^(t+1)_i := p^t_i e^(-alpha nabla f(p^t)_i)
  $

  $
    p_i^(t+1) := w_i^(t+1)/(sum_(j=1)^n w_j^(t+1))
  $

  Let $z = w^(t+1)$ ,thus $p^(t+1) = z \/ norm(z)_1$. First we derive $D_H (z
  \/ norm(z)_1), z)$, then show that this is a lower bound for any other point
  on $Delta_n$.

  $
    D_H (z/norm(z)_1, z) &= - sum z_i/norm(z)_1 log z_i / (z_i / norm(z)_1) +
  sum (z_i - z_i / norm(z)_1) \
    &= - (log norm(z)_1)/norm(z)_1 sum z_i + sum z_i - 1/norm(z)_1 sum z_i \
    &= - log norm(z)_1 + norm(z)_1 - 1.
  $

  $
    D_H (x, z) &= - sum x_i log z_i/x_i + sum z_i - sum x_i \
    &= - sum x_i log z_i/x_i + norm(z)_1 - 1.
  $

  Thus, we need only prove that
  $
    sum x_i log z_i/x_i <= log norm(z)_1.
  $

  We know that $x log 1/x$ is concave, thus we need only minimize $- sum x_i
  log z_i/x_i$. However, we need to keep in mind that $x in Delta_n$, which is
  an additional constraint. Hence, the following convex problem needs to be solved:
  $
    min_(x in Delta_n) quad -sum x_i log z_i/x_i.
  $

  With a Lagrange multiplier the above is equivalent to the following:
  $
    min_x quad -sum x_i log z_i/x_i + mu (sum x_i - 1).
  $

  Taking the gradient of the objective function we get that
  $
    log x_i - log z_i - 1 + mu = 0.
  $

  Solving this we get that
  $
    x_i = z_i dot e^(1 - mu).
  $

  To accomodate for the constraint $x in Delta_1 <==> norm(x)_1 = 1$, we have
  $
    1 = norm(x)_1 = sum x_i = sum z_i dot e^(1 - mu) = e^(1 - mu) norm(z)_1.
  $

  Thus $e^(1 - mu) = 1/norm(z)_1$.

  With $x^* = z / norm(z)_1$ we have
  $
    sum x_i^* log z_i / x_i^* = log norm(z)_1.
  $
  Circling back to what we were hoping to show, we have
  $
    sum x_i log z_i/x_i <= log norm(z)_1.
  $

  Furthermore, the maximum is attained at $x = z / norm(z)_1$, which is exactly
  what we were hoping to show.


]

#pagebreak()

#exercise[
  Given a sequence of conex and differentiable function $f^1, f^2, dots : K ->
  RR$ and a sequence of points $x^1, x^2, dots in K$, define the *regret* up to
  time $T$ to be
  $
    "Regret"_T := sum_(t=1)^T f^t (x^t) - min_(x in K) sum_(t=1)^T f^t (x).
  $

  Consider the following strategy:
  $
    x^(t+1) := "argmin"_(x in K) sum_(i=1)^t f^i (x) + R(x)
  $
  for a convex regularizer $R : K -> RR$ and $x^1 := "argmin"_(x in K) R(x)$.
  Assume that the gradient of each $f_i$ is bounded everywhere by $G$ and that
  the diameter of $K$ is bounded by $D$. Prove the following:

  1. $"Regret"_T <= sum_(t=1)^T (f^t (x^t) - f^t (x^(t+1))) - R(x^1) + R(x^*)$
     for every $T = 1, dots$, where
     $
       x^* := "argmin"_(x in K) sum_(t=1)^T f^t (x)
     $.

  2. Given $epsilon > 0$, use this method for $R(x) := 1/eta norm(x)_2^2$ for
     an appropriate choice of $eta$ and $T$ to get $1/T "Regret"_T <= epsilon$.

]

#solution[
  Solution
]

#pagebreak()

#exercise[
  Let $G = (V, E)$ be an undirected graph with $n$ vertices and $m$ edges, and
  let $s, t in V$ distinct vertices. Let $B in RR^(n times m)$ denote the
  vertex-edge incidence matrix of the graph, that is we pick an arbitrary
  orientation of the graph and set the column corresponding to each arc $u v$
  as $e_v - e_u$. Consider the $s$--$t$ maximum flow problem:
  $
    max_(x in RR^m, F >= 0) & quad F \
    "s.t." quad & quad B x = F b, \
           & quad norm(x)_infinity <= 1,
  $
  where $b = e_s - e_t$.

  1. Prove that the dual of this formulation is equvalent to the following:
  $
    min_(y in RR^n) & quad sum_(u v in E) abs(y_u - y_v) \
    "s.t." & quad y_s - y_t = 1.
  $

  2. Prove that the optimal value of the above problem is equal to
     $"MinCut"_(s,t)(G)$, the minimum number of edges one needs to remove from
  $G$ to disconnect $s$ from $t$. This latter problem is known as the $s$--$t$
  minimum cut problem.

  3. Reformulate the dual as follows:
  $
    min_(x in RR^m) & quad norm(x)_1 \
    "s.t." & quad x in "Im"(B^T) \
           & quad x dot z = 1
  $
  for some $z in RR^m$ that depends on $G$ and $s,t$. Write an explicit formula
  for $z$.
]

#solution[ \
  *1.* Notice that this problem is just an LP, so we can use the simple LP dual.

  #figure(
    image("general_lp_dual.png", width: 50%),
    caption: [
      General form of LP duality theorem.
    ],
  )

  
  Using the general LP form, we can write our problem as 
  $
    x_0 = x, quad x_1 = F in RR \
    P = B, quad A = -b \
    Q = mat(I_m; -I_m; delim: "[") \
    b_0 = underline(0)_n, quad b_1 = underline(1)_(2m) \
    c_0 = underline(0)_m, quad c_1 = 1.
  $
  With this notation, our primal problem becomes
  $
    max x_0 c_1 + x_1 c_1 \
    B x -F b = P x_0 + A x_1 = b_0 \
    norm(x)_1 <= 1 <==> mat(I_m; -I_m; delim: "[") x_0 <= 1 <==> Q x_0 <= 1 \
    F >= 0 <==> x_1 >= 0.
  $

  The dual of this general LP is the following:
  $
    y_0 B = 0 ==> y^0_u - y^0_v = 0 quad forall (u v) in E \
    ==> y^0_u = y^0_v quad forall (u v) in E \
    -y_0 b >= 1 <==> y_0 b <= -1  <==> y^0_s - y^0_t <= 1 \
  $
  These were the parts that come from $P, A$ and $c_0, c_1$. Now the part that
  comes from $Q$ and $c_0$. Let $y^1_e$ denote the coordinate of $y_1$
  corresponding to edge $e in E$, and $(y^1_e)'$ the other coordinate
  corresponding to edge $e$, since $y_1 in RR^(2m)$.
  $
    mat(I_m; -I_m; delim: "[") y_1 = 0 <==> 
    y^1_e - (y^1_e)' = 0 quad forall e in E \
    <==> y^1_e = (y^1_e)' quad forall e in E
  $

  The dual objective function then becomes:
  $
    y_0 b_0 + y_1 b_1 <==> y_1 dot underline(1)_(2m) = sum_(i = 1)^(2m) y^1_i =
  sum_(e in E) 2 y_e.
  $

  *2.*
  Let $S$ and $T$ denote the following set of vertices:
  $
    S = { u : y_u = 1 } \
    T = { v : y_v = 0 }.
  $

  From this we can see that from the constraint $y_s - y_t = 1$ it follows that
  $s in S$ and $t in T$. Moreover, we can see that $abs(y_u - y_v) = 0$ if $u,
  v in S$ or $u, v in T$. Thus, the only set of edges that remain in the sum
  are the ones that run between $S$ and $T$. This is precisely the number of
  edges that when removed disconnect $S$ from $T$. Hence, this dual is
  equivalent to $"MinCut"_(s,t)(G)$.

  *3.*
  Since $x in "Im"(B^T)$, this means that there exists a $y in RR^n$ such that
  $y B = x$. Notice that this $y$ can be precisely what we defined in the
  second section of this problem, meaning that $x_e = x_(u v) = y_u - y_v$.

  With this the objective functions match, we only need to show that there exists a $z in RR^m$ such that $ x dot z = y_s - y_t. $

  We can see that $x dot z = y_s - y_t$ means that we need to find a $z_e$ for
  all edges such that
  $
    sum_(e in "in"(u)) x_e z_e = sum_(e in "out"(u)) x_e z_e
  $
  for all $u in V minus {s, s, t}$.

  Meaning, that the weighted sum of the in-edges to a vertex $u$ must equal the
  weighted sum of the out-edges from a vertex for all inner vertices (so
  exluding the source and the sink).

  The extra constraint is that the weighted sum of the out-edges from $s$ must
  equal $1$. Likewise that weighted sum of the in-edges to $t$ must equal $1$.

  This is basically a linear system of equations that is easily solvable.

]


