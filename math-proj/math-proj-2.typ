#import "@preview/cetz:0.3.2"
#import "@preview/intextual:0.1.1": flushr, intertext-rule
#show: intertext-rule

#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")

// Title
#align(center)[
  #text(size: 1.2em)[= Algorithmic Trading with \ Reinforcement Learning]
  #v(0.5em)
  #text(size: 1.2em)[Second semester report]

  #v(0.5em)
  #text(size: 1.25em)[Leonardo Toffalini]
  #v(-0.5em)
  #text(size: 1em)[Supervised by András Lukács]
]
#v(2em)

#set heading(numbering: "1.1")

= Introduction
During this semester we continued where we left off after my undergraduate
thesis and first semester work. Given the length constraints of the present
report, we only focus on defining the problem at hand and briefly mention some
notable achievements.

Consider a modeled financial market wherein the price of a risky asset adheres
to an adapted process $S_t$, where $t in [0, T]$. In our case $S_t$ is a
fractional Brownian motion. The trader may trade at finite rates on the risky
asset, though they incur a temporary nonlinear price impact as a consequence.
The family of feasible strategies available to the trader is
$
  S(T) := {phi.alt : phi.alt "is a " RR"-valued optional process and" integral_0^T abs(phi.alt) dif u < infinity "a.s."}.
$

The trader's initial asset position is represented by $z = (z^0, z^1)$, where
$z^0$ is the number of units of the riskless asset, and $z^1$ represents the
number of units of risky assets.

The number of units of the risky asset at time $t in [0, T]$, after following
the strategy $phi.alt$ is given by
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
asset, and a well-defined notion of expected terminal riskless asset position,
that is
$
  cal(A)(T) := {phi.alt in S(T) : X_T^1 = 0, quad EE[X_T^0(phi.alt)_(-)] < infinity},
$
where $x_(-) = -min(x, 0)$.

The objective of our problem is to identify the strategy $phi.alt in cal(A)(T)$
that realizes maximal expected profits of the riskless asset.

It can be shown that there exists an optimal strategy for any time horizon $T$
that achieves maximal returns @rasonyi_nika. It can also be shown that a simple
contrarian strategy in the anti persistent case, and a momentum strategy in the
persistent case with linear liquidation after $T\/2$ steps achieves
asymptotically optimal returns, that is of order $T^(H (1 + kappa) + 1)$
@rasonyi_nika, when $kappa -> 1\/(alpha - 1)$.

The goal of this project, and that of my undergraduate thesis, is to compete
with the analytical results by learning a strategy that compares in its
expected returns. We will learn such a strategy using reinforcement learning
(RL).

= Previous work
== Bsc
During my undergraduate thesis, we showed that with a standard PPO @ppo algorithm
we were able to outcompete the analytical strategy on expected returns for time
horizons $T <= 512$ by training a bespoke model for each tested time horizon,
which is to say that we did not find a general strategy that worked for any
time horizon. For time horizons greater than $512$ the learned strategies were
not able to outperform the simple analytical strategy on expected returns,
which we attributed to the credit assignment problem becoming increasingly
more difficult for longer horizons.

== First semester
// Building on the previous work, the overall reinforcement learning approach remains unchanged and continues to rely on PPO as the core algorithm.\
// \
// The following modifications were introduced:
// - The environment was reimplemented in C using the pufferlib framework
//   @suarez2025pufferlib, yielding an approximate three orders of magnitude
//   increase in simulation speed, from about 1.5k steps per second (SPS) to roughly 1.5M SPS.
// - The improved simulation efficiency made it feasible to perform large-scale
//   hyperparameter search using a modified variant of CARBS @carbs.
// - The liquidation mechanism was redesigned, replacing single-step forced liquidation
//   with a user-configurable linear liquidation schedule.
// - Thanks to the increased simulation speed, the agent can now evaluate a small
//   set of short, plausible future scenarios to assess its performance under
//   forced liquidation within a given time horizon for each step.
// - The reward function was reformulated to depend on the anticipated liquidation
//   cost rather than on the temporal difference in the riskless asset.

In the first semester of this project we kept the overall methodology with which
we started initially, but reimplemented everything in a more performant manner
achieving a roughly 3 orders of magnitude faster training. The other major
component we changed was that we restricted the problem to finding only the first
part of the strategy, and then we automatically liquidate the amassed position
linearly, as it can be shown that no better liquidation schedule can be given
in the present problem other than linear.

= Current work
One of the major drivers of the current semester's work was to loosen the
constraints of the reinforcement learning problem, of which the action space
was the most drastic change.

Previously, the action space was set to $cal(A) = {-K, ..., 0, ..., K}$, where
$K$ was the largest amount the agent could trade. The problem with this was
that the agent only learnt two different types of trades, one sell order and
one buy order. Essentially, the agent either bought $a$ shares, or sold $b$
shares, no in between. This phenomenon can be explained by the model
architecture see @fig:model-arch, as when the action space is discrete the
agent learns a categorical distribution on the action space. Since the model
does not know that output 2 represents a trade $1$ share less than output 3,
i.e. the model has no knowledge of the ordering of the output, it cannot make
fine adjustments.

The original problem statement defines the action space to be $(-oo, +oo)$,
however, in reinforcement learning there is a great gap in complexity for
problems with discrete versus continuous action spaces, this is why in the
beginning we restricted the problem to strategies restricted to trading fixed
quantities. Clearly, the solution to the problem was to let the action space be
continuous.

In the continuous case the policy architecture does not create a categorical
distribution over $2 K + 1$ actions, but instead it creates a normal
distribution $N(mu, sigma^2)$, where the policy network has a single output
value: $mu$, and $sigma^2$ is set to be a module level learnable parameter,
independent of the input, see @fig:model-arch-2.

The actual policy network architecture consists of three parts: observation
encoder, LSTM brain, and action decoder. The encoder and decoder are of simple
MLP design with 2-3 layers, and the inner LSTM is of a single layer and of 384
hidden layer size, mirroring the architecture used by OpenAI Five
@berner2019dota. For the accurate representation of the policy network
architecture see @fig:model-arch-3 in the Appendix.

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let cartesian(a, b) = {
        let result = ()

        for x in a {
          for y in b {
            result.push((x, y))
          }
        }

        result
      }

      scale(x: 50%, y: 50%)

      let input_neurons = (
        (-4, 1), (-4, -1),
      )

      let inner_layers = (
        ((0, 2), (0, 0), (0, -2)),
        ((4, 3), (4, 1), (4, -1), (4, -3)),
        ((8, 2), (8, 0), (8, -2)),
      )

      let output_neurons = (
        (12, -3),
        (12, -1.5),
        (12, 0),
        (12, 1.5),
        (12, 3),
      )
      let output_probs = (0.00, 0.9, 0.1, 0.15, 0.04)

      for (left_pos, right_pos) in cartesian(input_neurons, inner_layers.at(0)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(0), inner_layers.at(1)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(1), inner_layers.at(2)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(2), output_neurons) {
        line(left_pos, right_pos, stroke: gray)
      }

      for pos in input_neurons {
        circle(pos, radius: 0.5, fill: green.mix(white))
      }

      for inner_neurons in inner_layers {
        for pos in inner_neurons {
          circle(pos, radius: 0.5, fill: white)
        }
      }

      for pos in output_neurons {
        circle(pos, radius: 0.5, fill: blue.mix(white))
      }

      content((-4, 2.5), [obs])
      rect((-5, -2), (-3, 2))

      content((4,4.5), [policy])
      rect((-1,-4), (9,4))

      content((12, 4.5), [action])
      rect((11, -4), (13, 4))

      content((-8, 1),  text(size: 12pt)["current price"])
      content((-8.5, -1), text(size: 12pt)["current position"])
      content((16, 3),  text(size: 12pt)["sell 2 shares"])
      content((16, -1.5),  text(size: 12pt)["buy 1 share"])

      line((16, 0), (20, 0), mark: (end: ">"))
      line((22, -3), (22, 3))


      content((22, 4.5), [distribution])
      for (pos, prob) in output_neurons.zip(output_probs) {
        let x = pos.at(0) + 10
        let y = pos.at(1) - 0.25
        let length = prob
        rect((x, y), (x + prob + 0.25, y + 0.5), fill: red.mix(white))

      }

    })
  ],
  caption: "Schematic representation of the discrete action policy architecture."
)<fig:model-arch>

#v(3em)

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let cartesian(a, b) = {
        let result = ()

        for x in a {
          for y in b {
            result.push((x, y))
          }
        }

        result
      }

      scale(x: 50%, y: 50%)

      let input_neurons = (
        (-4, 1), (-4, -1),
      )

      let inner_layers = (
        ((0, 2), (0, 0), (0, -2)),
        ((4, 3), (4, 1), (4, -1), (4, -3)),
        ((8, 2), (8, 0), (8, -2)),
      )

      let output_neurons = (
        (12, 0),
      )

      for (left_pos, right_pos) in cartesian(input_neurons, inner_layers.at(0)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(0), inner_layers.at(1)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(1), inner_layers.at(2)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(2), output_neurons) {
        line(left_pos, right_pos, stroke: gray)
      }

      for pos in input_neurons {
        circle(pos, radius: 0.5, fill: green.mix(white))
      }

      for inner_neurons in inner_layers {
        for pos in inner_neurons {
          circle(pos, radius: 0.5, fill: white)
        }
      }

      for pos in output_neurons {
        circle(pos, radius: 0.5, fill: blue.mix(white))
      }

      content((-4, 2.5), [obs])
      rect((-5, -2), (-3, 2))

      content((4,4.5), [policy])
      rect((-1,-4), (9,4))

      content((12, 1.5), [action])
      rect((11, -3), (13, 1))

      content((-8, 1),  text(size: 12pt)["current price"])
      content((-8.5, -1), text(size: 12pt)["current position"])

      line((16, 0), (20, 0), mark: (end: ">"))
      line((22, -3), (22, 3))


      content((22, 4.5), [distribution])
      content((21.5, 0), [$mu$])
      content((13.5, 0), [$mu$])
      circle((12, -2), radius: 0.5, fill: blue.mix(white).mix(white))
      content((13.5, -2), [$sigma^2$])
      let output_probs = (0.01, 0.2, 0.8, 1.7, 0.8, 0.2, 0.01)
      let output_prob_pos = (
        (12, -3),
        (12, -2),
        (12, -1),
        (12, 0),
        (12, 1),
        (12, 2),
        (12, 3)
      )

      for (pos, prob) in output_prob_pos.zip(output_probs) {
        let x = pos.at(0) + 10
        let y = pos.at(1)/1.5 - 0.25
        let length = prob
        rect((x, y), (x + prob + 0.25, y + 0.5), fill: red.mix(white))

      }

    })
  ],
  caption: "Schematic representation of the continuous action policy architecture."
)<fig:model-arch-2>


The next biggest improvement that was implemented is that now the time horizon
$T$ is not fixed during training, but it is sampled from a distribution for
each episode while training. The general approach of modifying the problem
setting randomly in hopes of finding a more robust policy is a well studied
approach called domain randomization @elsafi2025evaluating. For simplicity, the
following distribution was used

$
  T = T_min + (T_max - T_min) U^p, quad "where" U ~ U[0, 1].
$

This distribution was chosen to be able to control which time horizons get more
attention during training, with $p=1$ we get a uniform distribution, with $p >
1$ we oversample shorter time horizons, while with $p < 1$ we
oversample longer time horizons, as can be seen in @fig:horizon-dist.

There are different reasons that motivate a biased distribution of the time
horizon, one practical consideration is that if we were to simply train on a
uniform distribution of time horizons, the endings of shorter horizons would be
over represented in each batch as they terminate more often. The other reason
to switch to a biased distribution, is that in the future we aim to employ
curriculum learning, where we train the model on problems of increasing
difficulty, by starting training on a distribution that oversamples shorter
then longer horizons, thus shifting focus on more and more longer horizons.

#figure(
  image("invest_horizon_kde.png", width: 90%),
  caption: [Distribution of time horizons with respect to  $p$.]
)<fig:horizon-dist>

\

A key theoretical result motivating this project is that the returns of any
admissible strategy are bounded by a market-dependent upper bound. More
precisely,
$
  abs(X_T^0 (phi.alt)) <= C integral_0^T abs(S_t)^(alpha \/ (alpha - 1)) dif t = C Q(T),
$
where
$
  C = (alpha - 1)/alpha alpha^(1/(1-alpha)) lambda^(1/(1-alpha)).
$
Furthermore, the scaled contrarian strategy introduced in @rasonyi_nika is asymptotically
optimal in the anti persistent case, in the sense that it achieves the same
asymptotic growth rate as the market bound. This bound therefore serves as the
natural benchmark against which we evaluate the learned policy.

The asymptotically optimal strategy introduced in @rasonyi_nika takes the form
$
  phi.alt_t (T) := "sgn"(S_t (H - 1\/2)) abs(S_t)^(1\/(alpha-1)) flushr((t in [0, T\/2)))
$
for the first half of the trading period, and linear liquidation for the second half $t in [T\/2, T]$.

// @fig:asymptotic shows the strategy defined in @rasonyi_nika as a baseline, and
// the market bound $C Q(T)$ against the trained policy. In our case $C = 25$, and
// $Q(T) = T^(2 H + 1) \/ (2 H + 1)$, since $alpha = 2$ and $lambda = 0.01$.
//
@fig:asymptotic compares the learned policy against the asymptotically optimal
analytical strategy and the market bound. Although the policy was trained only
on trajectories with T=256, it generalizes well to both shorter and
substantially longer horizons, suggesting that the learned strategy is
approximately homogeneous in time t and horizon T.

// The policy was trained on $T=256$ with the set of parameters that were found to
// be best for this time horizon with hyperparameter sweeping, see
// @table:hyperparameters in the Appendix for the full list of parameters.
// Essentially, we see that the policy trained on episodes of medium length
// $T=256$ was able to generalize to smaller and drastically larger time horizons
// likewise, as it learnt a trading strategy homogeneous in time $t$ and trading
// horizon $T$.
//
#figure(
  image("eval_invest_horizon_pairs_loglog.png", width: 90%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic>

#figure(
  image("invest_trajectories_hzm51rjf.png"),
  caption: [Example rollouts showing only the action -- delta riskless units --
  and the fBm prices for increasing time horizons. The achieved return is noted
  in the subtitle of each subplot.]
)

// #v(15em)
#pagebreak()
#set heading(numbering: none)
= Appendix

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *
      let cartesian(a, b) = {
        let result = ()

        for x in a {
          for y in b {
            result.push((x, y))
          }
        }

        result
      }

      scale(x: 40%, y: 40%)

      let input_neurons = (
        (-4, -3),
        (-4, -1.5),
        (-4,  0),
        (-4,  1.5),
        (-4,  3),
      )

      let inner_layers = (
        ((0, 6), (0, 4), (0, 2), (0, 0), (0, -2), (0, -4), (0, -6)),
        ((8, 6), (8, 4), (8, 2), (8, 0), (8, -2), (8, -4), (8, -6)),
      )

      let output_neurons = (
        (12, 0),
      )
      let lstm_output_neurons = (
        (17.5, 0),
      )

      let actor_input_neurons = (
        (22, 4), (22, 5.5), (22, 7)
      )

      let critic_input_neurons = (
        (22, -4), (22, -5.5), (22, -7)
      )

      let action_neuron = (30, 4.5)
      let std_neuron = (30, 2.5)
      let value_neuron = (30, -4.5)

      for (left_pos, right_pos) in cartesian(input_neurons, inner_layers.at(0)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(0), inner_layers.at(1)) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layers.at(1), output_neurons) {
        line(left_pos, right_pos, stroke: gray)
      }

      for (left_pos, right_pos) in cartesian(lstm_output_neurons, actor_input_neurons) {
        line(left_pos, right_pos, stroke: gray)
      }

      for (left_pos, right_pos) in cartesian(lstm_output_neurons, critic_input_neurons) {
        line(left_pos, right_pos, stroke: gray)
      }

      for left_pos in actor_input_neurons {
        line((left_pos.at(0)+5, left_pos.at(1)-1), action_neuron, stroke: gray)
      }

      for left_pos in critic_input_neurons {
        line((left_pos.at(0)+5, left_pos.at(1)+1), value_neuron, stroke: gray)
      }

      for pos in input_neurons {
        circle(pos, radius: 0.5, fill: green.mix(white))
      }

      for inner_neurons in inner_layers {
        for pos in inner_neurons {
          circle(pos, radius: 0.5, fill: white)
        }
      }

      for pos in output_neurons {
        circle(pos, radius: 0.5, fill: blue.mix(white))
      }

      for pos in actor_input_neurons {
        circle(pos, radius: 0.5, fill: white, stroke: white)
      }

      circle(action_neuron, radius: 0.5, fill: blue.mix(white))
      content((action_neuron.at(0)+1, action_neuron.at(1)), text(size: 12pt)[$mu$])

      circle(std_neuron, radius: 0.5, fill: blue.mix(white).mix(white))
      content((std_neuron.at(0)+1.25, std_neuron.at(1)), text(size: 12pt)[$sigma^2$])

      circle(value_neuron, radius: 0.5, fill: red.mix(white))
      content((value_neuron.at(0)+1.5, value_neuron.at(1)), text(size: 12pt)[$delta(s)$])

      for pos in critic_input_neurons {
        circle(pos, radius: 0.5, fill: white, stroke: white)
      }

      content((-4, 5), text(size: 12pt)[obs])
      rect((-5, -4), (-3, 4))

      rect((-1,-8), (9,8), fill: white)
      content((4, 0), align(center)[#text(size: 12pt)[observation\ encoder\ MLP]])

      rect((11.5, -2), (18, 2), fill: white)
      content((14.7, 0), text(size: 12pt)[LSTM])

      rect((21.5, 2), (28, 7.0), fill: white)
      content((24.8, 6.0), text(size: 14pt)[Actor head])
      content((24.8, 4), align(center)[#text(size: 10pt)[action decoder\ MLP]])

      rect((21.5, -2), (28, -7.0), fill: white)
      content((24.8, -3.0), text(size: 14pt)[Critic head])
      content((24.8, -5), align(center)[#text(size: 10pt)[value decoder\ MLP]])

    })
  ],
  caption: "Policy network architecture consisting of an observation encoder,
  recurrent LSTM core, and actor-critic output heads."
)<fig:model-arch-3>

#v(3em)

#figure(
  columns(2)[
  #table(
    columns: (auto, auto),
    align: left,
    table.header([*Name*], [*Value*]),

    [rnn.hidden_size],     [384],
    [adam_beta1],          [0.9951718674696215],
    [adam_beta2],          [0.9413939175583763],
    [adam_eps],            [0.0001],
    [anneal_lr],           ["true"],
    [batch_size],          [auto],
    [bptt_horizon],        [64],
    [checkpoint_interval], [200],
    [clip_coef],           [0.27054937558218256],
    [ent_coef],            [0.20000000000000004],
    [final_eval_passes],   [1],
    [gae_lambda],          [0.9898748083815585],
    [gamma],               [0.9382600900682131],
    [learning_rate],       [0.001051989540888071],
  )

    #colbreak()

  #table(
    columns: (auto, auto),
    align: left,
    table.header([*Name*], [*Value*]),

    [max_grad_norm],       [2.7495165717556604],
    [max_logratio],        [12],
    [max_minibatch_size],  [32768],
    [minibatch_size],      [32768],
    [prio_alpha],          [0.853334170486411],
    [prio_beta0],          [0.8897892497407985],
    [seed],                [42],
    [target_kl],           [0.03],
    [total_timesteps],     [100_000_000],
    [update_epochs],       [1],
    [vf_clip_coef],        [0.1],
    [vf_coef],             [3.4981909434385705],
    [vtrace_c_clip],       [0.1900890933017968],
    [vtrace_rho_clip],     [1.2270571100490357],
  )
  ],
  caption: [List of hyperparameters used for training.]
)<table:hyperparameters>


#pagebreak()
#bibliography("refs.bib", full: true)

