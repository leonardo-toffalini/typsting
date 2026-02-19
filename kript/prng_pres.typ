#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import "@preview/intextual:0.1.0": flushr, intertext-rule
#import "common.typ": *
#show: intertext-rule
#import cosmos.clouds: *
#show: show-theorion

// #import "@preview/lemmify:0.1.8": *
// #let (
//   theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules
// ) = default-theorems("thm-group", lang: "en")
//
// #show: thm-rules

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  config-common(handout: true),
  // config-common(show-notes-on-second-screen: right),
  config-common(frozen-counters: (theorem-counter,)),  // freeze theorem counter for animation
  config-info(
    title: [Pseudo random number generators],
    author: [Leonardo Toffalini],
    date: datetime.today(),
  ),
)

// #set heading(numbering: "1.")
#set heading(numbering: numbly("{1}.", default: "1.1"))


#title-slide()

== Outline <touying:hidden>
#components.adaptive-columns(outline(title: none, depth: 1))

= Intuition
== What we expect from a PRNG
1. Given a short input (seed) it produces a long _seemingly random_ sequence.
2. Generation should be really fast.
3. The sequence must be reproducible just from the seed.

== The sad truth
What does _seemingly random_ mean?

We cannot use Kolmogorov complexity to measure randomness, because that would not satisfy 1.

We cannot use physical methods like radioactive radiation as they would not satisfy 2. and 3.

== Reconciliation
We need to redefine what _seemingly random_ means.

"There must not exist a polynomial time algorithm that can differentiate
between truly random and generated sequences."

"There must not exists a polynomial time algorithm that can guess the next bit given the previous bits."

= The classics

== Middle square method (1946)
#figure(
  image("Middle-square_method.png", width: 70%)
)

== Problem with middle square
- short period
- often enters a short cycle
- if middle digits are $0 0 ... 0$ it no longer produces meaningful numbers

#set quote(block: true)
#quote(attribution: [John von Neumann])[
  "Anyone who considers arithmetical methods of producing random digits is, of course, in a state of sin."
]


== Linear congruential generator (1951)
$
  X_i = a X_(i-1) + b quad (mod m)
$

== RANDU (1960-1970)
$
  X_(i) = 65539 dot X_(i-1) quad (mod 2^31)
$

#link("file:///Users/tleo/Downloads/git/school/typsting/kript/randu_planes.gif")

== Park--Miller (1988)
$
  X_(i) = 7^5 dot X_(i-1) quad (mod 2^31-1)
$

#quote(attribution: [Park--Miller])[
  "Give me something I can understand, implement and port... it needn't be state-of-the-art, just make sure it's reasonably good and efficient."
]

== Problem with LCG
The elements of LCG sequences can be guessed in polynomial time with polynomial
many known elements of the sequence with a sufficiently complicated algorithm.

== Shift register (1965)
$
  a_k = f(a_(k-1), a_(k-2), ..., a_(k-n))
$

== Linear shift register

$
  f(x_0, ..., x_(n-1)) = b_0 x_0 + b_1 x_1 + ... + b_(n-1) x_(n-1)
$

$
  b_i in {0,1}
$

== Xorshift
$
  y_1 &= x_n xor (x_n << 13) \
  y_2 &= y_1 xor (y_1 >> 17) \
  x_(n+1) &= x_2 xor (x_2 << 5)
$

Alternatively, in $FF^32_2$
$
  x_(n+1) = (1 xor 2^5) (1 xor 2^(32-17)) (1 xor 2^13) x_n
$

== Problem with shift registers
$
  b_0 a_0 &+ b_1 a_1 &+ ... &+ b_(n-1) a_(n-1) &= a_n \
  b_0 a_1 &+ b_1 a_2 &+ ... &+ b_(n-1) a_(n) &= a_n \
  &dots.v &dots.v \
  b_0 a_(n-1) &+ b_1 a_n &+ ... &+ b_(n-1) a_(2-2) &= a_n \
$

== Square root generator
$
  sqrt(5) = 10.overbrace(0011100011011, f(5)) ...
$

$
  f(a) = sqrt(a) - floor(sqrt(a))
$

== Problem with square root generator
Seems random but is still _breakable_ with a sufficiently complicated number theoretic approach.


= Formalism
== Definitions

#definition[
  A function $f : ZZ^+ -> RR$ is negligible if for all fixed $k$ $lim_(n->infinity) n^k f(n) -> 0$.

  $f(n) = #NEGL\(n)$
]

#definition[
  A function $G : {0, 1}^* -> {0, 1}^*$ is a generator if $abs(G(x))$ only
  depends on $abs(x)$ and $abs(x) < abs(G(X)) < abs(x)^c$ for some constant
  $c$.
]

---

#definition[
  Let $cal(A)$ be a randomized polynomial time algorithm that for each $z in
  {0, 1}^*$ input it outputs a bit $cal(A)(z) in {0,1}$ meaning the input was
  random ($1$) or not ($0$). $cal(A)$ is called a test.
]

---

#definition[
  For a fixed $n >= 1$ chose uniformly at random $x$ from ${0, 1}^n$ and $y$
  from ${0, 1}^N$ where $N = abs(G(x))$. With equal probability give either
  $G(x)$ or $y$ as input to $cal(A)$. We say that $cal(A)$ was a successful
  test if it correctly determined whether it had a random input or not.
]

---

#definition[
  We say that a generator $G$ is secure if for all randomized polynomial time
  algorithms $cal(A)$ the probability of $cal(A)$ being successful is $1/2 +
  #NEGL\(n)$.
]

#remark[In essence, $G$ passes all _meaningful_ tests, that is, the best test is to
guess at random.]

== Equivalent definition of secure generator

#definition[
  unpredictable...
]

#theorem(title: [Yao])[
  A generator $G$ is secure if and only if it is unpredictable.
]

== How hard could it be?

#proposition[
  If $#P = #NP$, then there is no secure generator.
]

#proof[
  Fix a generator $G$.

  Define $L := {y : exists x in {0,1}^* "such that " y = G(x)}$.
  Clearly $L in #NP$, since $x$ is a polynomial proof for $y in L$.

  By $#P = #NP ==> L in #P ==> exists cal(A)$ PTA that decides $x in^? L$.

  From this we have that $cal(A)$ is always successful in recognizing $G(x)$, that is $G$ is not secure.
]

#remark[
  If you find a secure generator you have proven
  $#P != #NP$ and you can claim your \$1M.
]

== One-way functions

#definition[
  We say that $f : {0,1}^* -> {0,1}^*$ is a one-way function, if
  - $exists c >= 1$ such that $abs(x)^(1/c) < abs(f(x)) < abs(x)^c$
  - $f(x)$ is polynomial time computable
  - $forall cal(A) : {0,1}^* -> {0,1}^*$ RPA and
    $y in_R {0,1}^*$ the following holds:
    $
      PP(f(cal(A)(f(y))) = f(y)) = #NEGL\(n)
    $
]

#remark[
  Since $f$ must not be invertible we could not write $cal(A)(f(y)) = y$.
]

---

#definition[
  We say that $f$ is a one-way permutation if it is a bijection and $abs(f(x)) = abs(x) quad forall x$.
]

#theorem(title: [Goldreich--Levin])[
  If $f$ is a one-way permutation then there is a secure
  generator created from $f$.
]

== Construction of Goldreich--Levin
Choose a seed $(x, p) in_R {0,1}^n times {0,1}^n$

Define $y^((t)) = f^t (x) quad t = 1, ..., N$

Output $g(x, p) = overline(G_1 G_2 ... G_N)$, where $G_t = p dot y^((t))$

Where
$
  (a_i)_(i=1)^n dot (b_i)_(i=1)^n := xor.big_(i = 1)^n a_i b_i
$

Even if someone knows $p$ and $y^((k))$ they cannot predict
$
  G_(k+1) = p dot f(y^((k)))
$

= One-way function candidates
== Factorization
Let $p$ and $q$ be two $n$ long prime numbers.

Let $f(n, p, q) = p q$

Given $f(n, p, q)$ try to guess $p$ and $q$.

#remark[
  Shor's algorithm shows that this function is reversible in polynomial time
  with a quantum computer.
]

== Discrete logarithm
Given a prime $p$ and a primitive root $g$ and $k < p$, let $y = g^k mod p$ the
output is $(p, g, y)$.

Try to guess $k$, that is the discrete logarithm of $y$ modulo $p$.

#remark[
  Shor's algorithm solves this problem too.
]

== Discrete square root
Given $m$ and $x < m$ the output is $m$ and $y = x^2 mod m$.

Try to find $x$ such that $x^2 equiv y quad (mod m)$

== Most commonly used
Mersenne twister

= Beyond random bits
== Uniform distribution
Generate a random number $X ~ U(0,1)$

Generate an $n$ long binary sequence $(a_i)_(i=1)^n$

$
  X = sum_(i=1)^n a_i/2^i
$

$
  X = overline(0.a_1a_2a_3...a_n)_2
$

This has precision $2^(-n)$.

== Box--Muller transform
foobar

