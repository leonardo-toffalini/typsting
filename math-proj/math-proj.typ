#set text(size: 12pt)
#set text(font: "New Computer Modern Math")

// Title
#align(center)[
  #text(size: 1.5em)[= Math projects report]
  #v(0.5em)
  #text(size: 1.25em)[Toffalini Leonardo]
  #v(-0.5em)
  #text(size: 1em)[Supervised by Lukács András]
]
#v(3em)

#set heading(numbering: "1.1")

= Introduction
During the semester we continued where we left off after my undergraduate thesis work.

Consider a modeled financial market wherein the price of a risky asset adheres
to an adapted process $S_t$, where $t in [0, T]$. The trader may trade at
finite rates on the risky asset, tough they incure a temporary nonlinear price
impact as a consequence. The family of feasible strategies available to the trader is as follows
$
  S(T) := {phi.alt : phi.alt "is a " RR"-valued optional process and" integral_0^T abs(phi.alt) dif u < infinity "a.s."}.
$

The traders's initial asset position is represented by $z = (z^0, z^1)$, where
$z^0$ is the number of units of the riskless asset, and $z^1$ represents the
number of units of risky assets.

The number of units of the risky asset at time $t in [0, T]$, after following the strategy $phi.alt$ is given by
$
  X_t^1(phi.alt) := z^1 + integral_0^t phi.alt_u dif u.
$

The aggregate position in the riskless asset is defined in a comparable manner,
albeit incorporating the effect of price impact. The trader incurs a
superlinear penalty associated with the trading speed, as determined by
parameters $alpha > 1$ and $lambda > 0$. The aggregate position in the riskless
asset at time $t in [0, T]$ is given by
$
  X_t^0(phi.alt) := z^0 - integral_0^t phi.alt_u S_u dif u - integral_0^t lambda abs(phi.alt_u)^alpha dif u.
$

Let $cal(A)(T)$ be the family of feasible strategies starting with zero initial
capital, and with the final position composed exclusibley of the riskless
asset, and a well-defined notion of expected terminal riskless asset position, that is
$
  cal(A)(T) := {phi.alt in S(T) : X_T^1 = 0, quad EE[X_T^0(phi.alt)_(-)] < infinity},
$
where $x_(-) = -min(x, 0)$.

The objective of our problem is to identify the strategy $phi.alt in cal(A)(T)$
that realizes maximal expected profits of the riskless asset.

It can be shown that there exists an optimal strategy for any time horizon $T$ that achieves maximal returns. @rasonyi_nika
It can also be shown that a simple contrarian strategy with linear liquidation
after $T\/2$ steps achieves asymptotically optimal returns, that is $T^(H (1 + kappa) + 1)$. @rasonyi_nika

The goal of this project, and that of my undergraduate thesis, is to compete
with the analytical results by learning a strategy that compares in its
expected returns. We will learn such a strategy using Reinforcement Learning (RL).

= Previous work
During my undergraduate thesis we have shown that with a simple PPO algorithm
we were able to outcompete the analytical strategy on expected returns for time
horizons $T <= 512$ by training a bespoke model for each tested time horizon,
which is to say that we did not find a general strategy that worked for any
time horizon. For time horizons greater than $512$ the learned strategies were
not able to outperform the simple analytical strategy on expected returns,
which we attributed to the credit assignment problem becoming increasingly
harder for long horizons in RL.

= Current work
Following from the previous work done in previous semesters, we did not
drastically change our approach to the problem, we continued using PPO as the
base of our RL method.

What changed:
- rewrote everything in C in the framework of pufferlib @suarez2025pufferlib, this enabled a roughly `1000x` speedup (`~1.5k SPS` $==>$ `~1.5M SPS`)
- the simulation speedup enabled large scale hyperparameter sweeping using a modified version of CARBS @carbs
- changed how we handle liquidation, from single step to user defineable linear liquidation
- by the simulation speedup we can allow the agent to simulate a handful of
  short foreseeable futures to see how it would do if it had to liquidate in
  that time period


#bibliography("refs.bib")

