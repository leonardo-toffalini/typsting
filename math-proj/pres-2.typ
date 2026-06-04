#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import "@preview/intextual:0.1.0": flushr, flushl, intertext-rule
#show: intertext-rule
#import cosmos.clouds: *
#show: show-theorion

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
    title: [Algorithmic Trading with Reinforcement Learning],
    subtitle: [Second semester report],
    author: [Leonardo Toffalini],
    date: datetime.today(),
  ),
)

// #set heading(numbering: numbly("{0}", default: "1."))
#set heading(numbering: none)

#title-slide()

= Problem statement
// #figure[
//   #image("fbm_highlighted_path.png")
// ]
//
// ---

== Fractional Brownian motion
#figure[
  #image("mmfbb_volatility_visualisation.png")
]

// ---
// #figure[
//   #image("what_to_do.png")
// ]

== Market model
Market model @rasonyi_nika:
$
  X_t^1(phi.alt) &:= z^1 + integral_0^t phi.alt_u dif u #flushr("(risky)") \
  X_t^0(phi.alt) &:= z^0 - integral_0^t phi.alt_u S_u dif u - integral_0^t lambda abs(phi.alt_u)^alpha dif u #flushr("(riskless)")
$

Goal:
$
   max_(phi.alt in S(t)) EE[X_T^0(phi.alt)]
$

= Previous work
== Bsc
#figure[
  #image("asymptotic_evaluation_thesis_image.png")
]

== 1st semester

- The code base was rewritten in C from Python @suarez2025pufferlib
- Liquidation strategy is now a linear schedule
- Smarter rewards: anticipating liquidation value

- Three orders of magnitude speedup (1.5k $=>$ 1.5M SPS)
- Large-scale hyperparameter search with CARBS @carbs
- Better performance for fixed time horizons

= Current work
== Discrete action policy schematic diagram

#set text(size: 16pt)
#align(center+horizon)[
  #figure(
  align(center+horizon)[
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

      scale(x: 80%, y: 80%)
      let text_size = 16pt

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

      content((-4, 2.5), text(size: text_size)[obs])
      rect((-5, -2), (-3, 2))

      content((4,4.5), text(size: text_size)[policy])
      rect((-1,-4), (9,4))

      content((12, 4.5), text(size: text_size)[action])
      rect((11, -4), (13, 4))

      content((-8, 1),  text(size: text_size)["current price"])
      content((-8.5, -1), text(size: text_size)["current position"])
      content((16, 3),  text(size: text_size)["sell 2 shares"])
      content((16, -1.5),  text(size: text_size)["buy 1 share"])

      line((16, 0), (20, 0), mark: (end: ">"))
      line((22, -3), (22, 3))


      content((22, 4.5), text(size: text_size)[distribution])
      for (pos, prob) in output_neurons.zip(output_probs) {
        let x = pos.at(0) + 10
        let y = pos.at(1) - 0.25
        let length = prob
        rect((x, y), (x + prob + 0.25, y + 0.5), fill: red.mix(white))

      }

    })
  ],
  // caption: "Schematic representation of the discrete action policy architecture."
)<fig:model-arch>
]

== Continuous action policy schematic diagram
#align(center+horizon)[
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

      scale(x: 80%, y: 80%)
      let text_size = 16pt

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

      content((-4, 2.5), text(size: text_size)[obs])
      rect((-5, -2), (-3, 2))

      content((4,4.5), text(size: text_size)[policy])
      rect((-1,-4), (9,4))

      content((12, 1.5), text(size: text_size)[action])
      rect((11, -3), (13, 1))

      content((-8, 1),  text(size: text_size)["current price"])
      content((-8.5, -1), text(size: text_size)["current position"])

      line((16, 0), (20, 0), mark: (end: ">"))
      line((22, -3), (22, 3))


      content((22, 4.5), text(size: text_size)[distribution])
      content((21.5, 0), text(size: text_size)[$mu$])
      content((13.5, 0), text(size: text_size)[$mu$])
      circle((12, -2), radius: 0.5, fill: blue.mix(white).mix(white))
      content((13.5, -2), text(size: text_size)[$sigma^2$])
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
  // caption: "Schematic representation of the continuous action policy architecture."
)<fig:model-arch-2>
]


== Accurate continuous action policy diagram
#align(center+horizon)[
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

      scale(x: 60%, y: 60%)

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
  caption: [Policy network architecture consisting of an observation encoder,
  recurrent LSTM core, and actor-critic output heads @berner2019dota.]
)<fig:model-arch-3>
]

== Analytic strategy vs market bound
#figure(
  image("eval_invest_horizon_pairs_loglog_without_policy.png", width: 75%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound @rasonyi_nika.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic-no-policy>

== Analytic strategy vs trained policy
#figure(
  image("eval_invest_horizon_pairs_loglog.png", width: 75%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic>

#figure(
  image("eval_invest_horizon_pairs_loglog_262144.png", width: 75%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic-2>

#figure(
  image("eval_invest_horizon_pairs_loglog_H08.png", width: 75%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic-3>

#figure(
  image("eval_invest_horizon_pairs_loglog_H09.png", width: 75%),
  caption: [Learnt policy versus asymptotically optimal strategy versus market
  bound.\ Each dot represents the mean return of 500 rollouts.]
)<fig:asymptotic-3>

== Example rollouts
#figure(
  image("invest_trajectories_hzm51rjf.png", width: 60%),
  caption: [Example rollouts showing only the action -- delta riskless units --
  and the fBm prices for increasing time horizons. The achieved return is noted
  in the subtitle of each subplot.]
)

---

#align(center+horizon)[
#figure(
  [
    #image("images/delta_risky_vs_price_T128.png")
    #image("images/delta_risky_vs_price_T256.png")
  ],
  caption: [Example rollouts zoomed in showing only the action and the fBm prices.]
)
]

== Autocorrelation of the strategy
#figure(
  image("invest_action_autocov_T512.png", width: 85%),
  caption: [Autocorrelation of the strategy $phi.alt(t)$]
)

#figure(
  image("images/invest_action_autocov_T512_simplified.png", width: 80%),
  caption: [Autocorrelation of the strategy $phi.alt(t)$]
)

== Skewed time horizon distribution
#figure(
  image("invest_horizon_kde.png", width: 90%),
  caption: [Distribution of time horizons with respect to  $p$ @elsafi2025evaluating.]
)<fig:horizon-dist>

#figure(
  image("images/invest_horizon_beta_pdf.png", width: 90%),
  caption: [Distribution of time horizons with respect to  $alpha$ and $beta$ @elsafi2025evaluating.]
)<fig:horizon-dist>


#bibliography("refs.bib", full: true)

#set text(size: 25pt)
== Usage of AI tools
- ChatGPT -- Research and review
- Cursor -- Programming

