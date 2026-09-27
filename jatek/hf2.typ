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
  #text(blue, size: 25pt)[*Homework 2*] \

  Toffalini Leonardo
]




#exercise[
  Consider the $2 times n$ Chomp game.
  #set enum(numbering: "a)")
    + What is a winning strategy for the first player?
    + What are the Grundy numbers of the possible positions in the game?

  #set enum(numbering: "1.")
]

#solution[
  #set enum(numbering: "a)")
  + The winning strategy for the first player in the case of the $2 times n$
    chomp game is to first take off the top right most square, then always
    reestablish a position where only the top right square is missing.

    It is clear to see that this reestablishing can always be done in the case of
    the $2 times n$ chomp game. There are two types of moves the second player can play from this position:
    #set enum(numbering: "1.")
    + If the second player makes a $2 times n'$ rectangle then we are back to the starting position.
    + If the second player makes a position where the top row is shorter than the
      bottom row, then the first player takes off just enough of the bottom row's
      right hand side to make the rectangle with the missing corner again.

    Since the first player can maintain this position of the rectangle with the
    missing corner, we end up in the position where the second player is to play
    in the L shape position with 3 squares.

    By checking all possible moves of the second player we see that the first
    player wins in all cases.

  + Let us number the positions with the tuple $(n, m)$ where $n$ represents
    how many squares are in the bottom row, and $m$ represents how many squares
    are in the top row. For example, $(2, 1)$ represents the L shape 3 square
    position.

    By writing out the Grundy number for the first few position we can make an
    educated guess for a general position's Grundy number:

    $
      mat(
        n \\ m, 0, 1, 2, 3, 4, 5, 6;
        1, 0, 1;
        2, 1, 0, 2;
        3, 2, 3, 0, 4;
        4, 3, 2, 4, 0, 5;
        5, 4, 5, 3, 6, 0, 7;
        6, 5, 4, 6, 3, 7, 0, 8;

      )
    $

    We can see that in the diagonals where $d = n - m$ is constant there are
    two kinds of patterns, the one when $d$ is even and when $d$ is odd.

    It remains to be shown what the patterns are and that they truly constitute
    the Grundy numbering for the $2 times n$ Chomp game.

]

#pagebreak()

#exercise[
  Let game $G$ be the sum of ${1,2}$-nim and ${2,3}$-nim. Compute the Grundy
  number and the winning first move (if it exists) for starting positions
  $(2,2)$, $(4,4)$, and $(101,101)$.
]

#solution[
  Using the Sprague--Grundy theorem we need only find the Grundy numbers of the
  single game positions $g_1 (2), g_2 (2)$, then $g((2, 2)) = g_1 (2) xor g_2
  (2)$, and likewise for the other two positions.

  It can be showed that $g_1 (p) = p (mod 3)$ and $g_2 (p) = floor((p (mod 5)) / 2)$.
  This can be seen by writing out the first few positions and calculating the
  Grundy numbers, then proving the guess by induction.

  The Grundy numbers for the asked positions of the game sum are:
  $
    g((2, 2)) &= 2 (mod 3) xor floor((2 (mod 5)) / 2) = 2 xor 1 = 3 \ 
    g((4, 4)) &= 4 (mod 3) xor floor((4 (mod 5)) / 2) = 1 xor 2 = 3 \
    g((101, 101)) &= 101 (mod 3) xor floor((101 (mod 5)) / 2) = 2 xor 0 = 2.
  $

  Since all of the Grundy numbers for the position pairs are positive, this means
  that the first player has a winning move in each position. The winning move
  is the one that takes us to a position where $g((p_1, p_2)) = 0$, that is
  $g_1 (p_1) xor g_2 (p_2) = 0$.

  For position $(2, 2)$ the winning first move is to go to $(1, 2)$, since $1
  (mod 3) xor 1 = 1 xor 1 = 0$.

  For position $(4, 4)$ the winning first move is to go to $(2, 4)$, since $2
  (mod 3) xor 2 = 2 xor 2 = 0$.

  For position $(101, 101)$ the winning first move is to go to $(99, 101)$
  since $99 (mod 3) xor 0 = 0 xor 0 = 0$.
]

// #pagebreak()
//
// #exercise[
//   Consider the following two-player game. There are $k$ piles of chips, of sizes
//   $n_1,n_2,...,n_k$. The two players take turns. In each turn, the player removes
//   an arbitrary positive number of chips, from at most two piles (there is no
//   restriction on how much from each pile). The player who takes the last chip
//   wins. What are the $P$ positions and the $N$ positions in this game?
// ]
//
// #solution[
//   TODO
// ]
//
