#import "@preview/thmbox:0.3.0": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/cetz:0.4.2"
#show: thmbox-init()

#set text(size: 11pt, font: "Times New Roman")
#set page(numbering: "1")
#set heading(numbering: none)

#show math.equation.where(block: false): box

#let exercise-counter = counter("exercise")
#show: sectioned-counter(exercise-counter, level: 1)
#let exercise = exercise.with(counter: exercise-counter)

#let solution = proof.with(
    title: "Solution", 
)

#align(center)[
  #text(blue, size: 25pt)[= Analysis test] \
]


#exercise[
  Determine the logical relation between these two statements:
  1. *P:* The function $f$ is strictly monotonically increasing.
  2. *Q:* The function $f$ converges to infinity.
]

#solution[
  $P ==> Q$ but not the other way around. 

  If a function $f$ is strictly monotonically increasing it means that for all
  $x > y$ we have $f(x) > f(y)$. Notice the strict inequality! This implies
  that if we take greater and greater values $x in RR$ we get greater and
  greater values $f(x)$, thus the function converges to infinity.

  The other way around is not necessarily true, take for example $f(x) = x +
  sin (x)$, which tends to infinity but is not monotonically increasing.

  #align(center)[
    #let x = lq.linspace(0, 50)
    #lq.diagram(
      lq.plot(x, x => x + calc.sin(x))
    )
  ]
]

#exercise[
  a) Determine the limit of the following
  $
    lim_(n -> infinity) (1 + n/n^2)^(2 n)
  $

  b) Determine the limit of the following
  $
    lim_(x -> infinity) (4x^2 + 9x - 3)/(5x^2 + 4x - 13)
  $
]

#solution[ \
  a)
  $
    lim_(n -> infinity) (1 + n/n^2)^(2n) =  lim_(n -> infinity) ((1 + 1/n)^n)^2 =  e^2
  $

  b)
  $
    lim_(x -> infinity) (4x^2 + 9x - 3)/(5x^2 + 4x - 13) = lim_(x -> infinity)
  (4 x^2/x^2 + 9 x/x^2 - 3/x^2)/(5 x^2/x^2 + 4 x/x^2 - 13/x^2) = lim_(x ->
  infinity) (4 + 9/x - 3/x^2)/(5 + 4/x - 13/x^2) = 4/5
  $
]

#exercise[
  a) Determine the limit of the following
  $
    lim_(n -> infinity) (4^n + 2)/(6^n)
  $

  b) Determine if the following limit is convergent
  $
    lim_(n -> infinity) (n^2 + 3^n)/n!
  $
]

#solution[\
  a)
  $
    lim_(n -> infinity) (4^n + 2)/(6^n) = lim_(n -> infinity) 4^n/6^n + 2/6^n = lim_(n -> infinity) (4/6)^n + 2/6^n = 0
  $

  b)
  $
    lim_(n -> infinity) (n^2 + 3^n)/n! = lim_(n -> infinity) n^2/n! + 3^n/n! = lim_(n -> infinity) 3^n/n! = lim_(n -> infinity) (overbrace(3 dot 3 dot 3 dot dots dot 3, n))/(1 dot 2 dot 3 dot dots dot n) = 0
  $
]

#exercise[
  a) Determine the following limit
  $
    lim_(x -> 0^+) (x^(-3) + 5x^(-2))/(2x^(-2) + x^(-1))
  $

  b) Determine the following limit
  $
    lim_(h -> 0) ((x + h)^3 - x^3)/h
  $
]

#solution[\
  a)
  $
    lim_(x -> 0^+) (x^(-3) + 5x^(-2))/(2x^(-2) + x^(-1))
    = lim_(x -> 0^+) (x^(-3)/x^(-3) + 5 x^(-2)/x^(-3))/(2x^(-2)/x^(-3) + x^(-1)/x^(-3))
    = lim_(x -> 0^+) (1 + 5x)/(2 x + x^2) = +infinity
  $
  Because it is always positive, and as $x->0^+$ the denominator tends to $0$,
  thus the ratio tends to $+infinity$.

  b) Notice that the problem is asking for $f'(x)$, where $f(x) = x^3$, so the
  answer should be $3 x^2$.

  Since $(a + b)^3 = a^3 + 3a b^2 + 3 a^2 b + b^3$ we have the following
  $
    lim_(h -> 0) ((x + h)^3 - x^3)/h = lim_(h -> 0) (x^3 + 3x h^2 + 3x^2 h + h^3 - x^3)/h \ = lim_(h -> 0) = (3 x h^2 + 3 x^2 h + h^3)/h = lim_(h -> 0) (3 x h + 3 x^2 + h^2 ) = 0 + 3x^2 + 0 = 3 x^2.
  $

]

#exercise[
  Determine at which point is the tangent of the following function horizontal
  $
    f(x) = 3x^3 - 2x^2 + 5
  $
]

#solution[
  The tangent line being horizontal means that $f'(x) = 0$, because the derivative of $f$ means the steepness of the tangent line, so if the tangent is horizontal it means that is has $0$ steepness.

  So we need to find an $x$ at which $f'(x) = 0$.
  $
    0 = f'(x) = 3 dot 3 x^2 - 2 dot 2 x = 9 x^2 - 4 x \
    0 = 9 x^2 - 4 x = x dot (9 x - 4)
  $

  From this, we get that $f'(x) = 0$ at $x=0$ and $x = 4\/9$.
]
