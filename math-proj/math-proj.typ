#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")

// Title
#align(center)[
  #text(size: 1.2em)[= Algorithmic Trading with \ Reinforcement Learning]
  #v(0.5em)
  #text(size: 1.2em)[First semester report]

  #v(0.5em)
  #text(size: 1.25em)[Leonardo Toffalini]
  #v(-0.5em)
  #text(size: 1em)[Supervised by András Lukács]
]
#v(2em)

#set heading(numbering: "1.1")

= Introduction
During this semester we continued where we left off after my undergraduate thesis work.
Given the length constraints of the present report, we only focus on defining
the problem at hand and briefly mention some notable achievements.

Consider a modeled financial market wherein the price of a risky asset adheres
to an adapted process $S_t$, where $t in [0, T]$. The trader may trade at
finite rates on the risky asset, though they incur a temporary nonlinear price
impact as a consequence. The family of feasible strategies available to the trader is
$
  S(T) := {phi.alt : phi.alt "is a " RR"-valued optional process and" integral_0^T abs(phi.alt) dif u < infinity "a.s."}.
$

The trader's initial asset position is represented by $z = (z^0, z^1)$, where
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
capital, and with the final position composed exclusively of the riskless
asset, and a well-defined notion of expected terminal riskless asset position, that is
$
  cal(A)(T) := {phi.alt in S(T) : X_T^1 = 0, quad EE[X_T^0(phi.alt)_(-)] < infinity},
$
where $x_(-) = -min(x, 0)$.

The objective of our problem is to identify the strategy $phi.alt in cal(A)(T)$
that realizes maximal expected profits of the riskless asset.

It can be shown that there exists an optimal strategy for any time horizon $T$
that achieves maximal returns @rasonyi_nika. It can also be shown that a
simple contrarian strategy in the anti persistent case, and a momentum strategy
in the persistent case with linear liquidation after $T\/2$ steps achieves
asymptotically optimal returns, that is of order $T^(H (1 + kappa) + 1)$
@rasonyi_nika, when $kappa -> 1\/(alpha - 1)$.

The goal of this project, and that of my undergraduate thesis, is to compete
with the analytical results by learning a strategy that compares in its
expected returns. We will learn such a strategy using reinforcement learning (RL).

= Previous work
During my undergraduate thesis, we showed that with a standard PPO @ppo algorithm
we were able to outcompete the analytical strategy on expected returns for time
horizons $T <= 512$ by training a bespoke model for each tested time horizon,
which is to say that we did not find a general strategy that worked for any
time horizon. For time horizons greater than $512$ the learned strategies were
not able to outperform the simple analytical strategy on expected returns,
which we attributed to the credit assignment problem becoming increasingly
more difficult for longer horizons.

= Current work
Building on the previous work, the overall reinforcement learning approach remains unchanged and continues to rely on PPO as the core algorithm.\
\
The following modifications were introduced:
- The environment was reimplemented in C using the pufferlib framework
  @suarez2025pufferlib, yielding an approximate three orders of magnitude
  increase in simulation speed, from about 1.5k steps per second (SPS) to roughly 1.5M SPS.
- The improved simulation efficiency made it feasible to perform large-scale
  hyperparameter search using a modified variant of CARBS @carbs.
- The liquidation mechanism was redesigned, replacing single-step forced liquidation
  with a user-configurable linear liquidation schedule.
- Thanks to the increased simulation speed, the agent can now evaluate a small
  set of short, plausible future scenarios to assess its performance under
  forced liquidation within a given time horizon for each step.
- The reward function was reformulated to depend on the anticipated liquidation
  cost rather than on the temporal difference in the riskless asset.

#bibliography("refs.bib")

