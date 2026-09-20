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
  #text(blue, size: 25pt)[*Homework 1*] \

  Toffalini Leonardo
]

#exercise[
  Let $S$ be a finite set of positive integers. In the $S$-nim game, we have a pile
  of $n$ chips, and two players take turns removing chips from the pile. The
  number of chips that a player removes in a turn must be in the set $S$. The
  player who cannot move loses. Determine the pile sizes for which the starting
  player has a winning strategy in ${2,4,7}$-nim.
]

#solution[
  The positions starting from $0$ have the following $N$ and $P$ assignments:
  $
    P, P, N, N, N, N, P, N, N, P, P, N, N, P, P, N, N, P, ...
  $

  We can see a pattern here:
  $
    P, P, N, N, N, N, | (P, N, N), (P, N, N), (P, N, N), (P, N, N), ...
  $

  From this we can determine the rule for which positions are $N$ or $P$:
  $
    x in P <==> cases(
      x < 6 "and" x in {0, 1},
      x >= 6 "and" (x - 6) equiv 0 " " mod 3
    )
  $

  For cases $x < 6$ we can check by hand, for cases $x >= 6$ we can see that if
  we are in a position $(x - 6) equiv.not 0 mod 3$ then we can always jump to a
  position that is in $P$. \
  Likewise if we are in a position which is $(x-6) equiv 0 mod 3$ then there is
  not jump we can make that will take us back to a position in $P$.
]

#pagebreak()

#exercise[
  Consider the following two-palyer game. There are two piles of chips, of size $n$
  and $m$ respectively. The two players take turns. In each turn, the player
  discards one of the piles, and divides the remaining pile arbitrarily into
  two non-empty piles. The player who cannot move loses (this happens when both
  piles contain a single chip). Determine the $(n,m)$ values for which the first
  player has a winning strategy.
]

#solution[
  For figuring out the solution it is helpful to write out the talbe for the
  first $7 times 7$ positions:
  $
    mat(
      , 1, 2, 3, 4, 5, 6, 7;
      1, P, N, P, N, P, N, P;
      2,  , N, N, N, N, N, N;
      3,  ,  , P, N, P, N, P;
      4,  ,  ,  , N, N, N, N;
      5,  ,  ,  ,  , P, N, P;
      6,  ,  ,  ,  ,  , N, N;
      7,  ,  ,  ,  ,  ,  , P
    )
  $

  Clearly the matrix is symmetric because position $(n, m)$ is equivalent to
  the position $(m, n)$, thus we do not write out the full matrix, only the
  upper right half.

  From the position matrix we make the following conjecture:
  $
    (n, m) in P <==> n equiv 1 mod 2 quad "and" quad m equiv 1 mod 2
  $

  This conjecture can be proven by induction.

  Suppose the conjecture is correct up until some $n_0, m_0 in NN$.

  Given any other position $(n, m)$ if $n equiv 0 mod 2$ then we can split $n$
  into $(1, n-1)$ where this position will be in $P$ both $1$ and $n-1$ are
  odd, concluding $(n, m) in N$.

  If both $n$ and $m$ are odd, then no matter which we choose, we cannot split
  an odd number as a sum of two odd numbers.
]

