#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import "@preview/intextual:0.1.0": flushr, intertext-rule
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
    title: [Policy gradient methods in reinforcement learning],
    author: [Leonardo Toffalini],
    date: datetime.today(),
  ),
)

// #set heading(numbering: "1.")
#set heading(numbering: numbly("{1}.", default: "1.1"))
#set text(size: 24pt)


#title-slide()

== Outline <touying:hidden>
#components.adaptive-columns(outline(title: none, depth: 1))

= Policy gradient methods
== Problems with value based methods
- value iteration requires transition probabilities
- q-learning computes max over action space
- what to do for huge/continuous action spaces?

== Value based vs policy based methods
#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      circle((-3, 0), radius: 6)
      circle((3, 0), radius: 6)

      content((-8, 4), text(size: 26pt)[*Value function*])
      content((8, 4), text(size: 26pt)[*Policy*])

      content((0, -1),  text(size: 22pt)[*Actor Critic*])
      content((-6, -1), text(size: 22pt)[*Value based*])
      content((6, -1),  text(size: 22pt)[*Policy based*])
    })
  ]
)

---

- Value based:
  - learnt value function
  - implicit policy

- Policy based:
  - no value function
  - learnt policy

- Actor Critic:
  - learnt value function
  - learnt policy

== Parametric policy
We can say that a policy depends on a set of parameters $theta$

This could be the weights and biases of a neural net

We want the policy to be diff'able wrt the parameters

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
      rect((11, -1), (13, 1))

      content((-8, 1),  text(size: 19pt)["wall ahead"])
      content((-8, -1), text(size: 19pt)["speed = 2 m/s"])
      content((15, 0),  text(size: 19pt)["turn left"])

    })
  ]
)

== Loss functions
Define the following objective functions

$
  J_1 (theta) &= v_(pi_theta) (s_1) = EE_(pi_theta) [v_1] flushr("(start value)") \
  J_2 (theta) &= sum_(s in cal(S)) d^(pi_theta) v_(pi_theta) (s) flushr("(avg value)") \
  J_3 (theta) &= sum_(s in cal(S)) d^(pi_theta) (s) sum_(a in cal(A)) pi_theta
(s, a) cal(R)_s^a flushr("(avg reward)")
$

where $d^(pi_theta) (s)$ is the stationary distribution of the Markov chain for $pi_theta$.

*Goal:* Find $theta$ that maximizes $J(theta)$.

== Policy gradient theorem
#theorem[
  $
    nabla_theta J(theta) prop sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) q_pi (s, a) nabla_theta pi_theta (a|s)
  $
]

#proof[
  maybe
]

---
Notice the previous theorem says that _"the gradient of the objective function is
an expectation"_:
$
  nabla J(theta) = EE_pi [sum_(a in cal(A)) nabla_theta pi(a|s) q_pi (s, a)]
$

$
  nabla_theta J(theta) &= EE_pi [sum_(a in cal(A)) pi(a|s) q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))] \
  &= EE_pi [EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]] \
  &= EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]
$

== Log derivative trick
With the reverse application of the chain rule we can notice the following
$
  nabla_theta log pi(a|s) &= (nabla_theta pi(a|s))/(pi_theta (a|s)) \
  nabla_theta pi(a|s) &= pi_theta (a|s) nabla_theta log pi(a|s).
$

Applying this little trick in the formula for the gradient of the objective
function we get
$
  nabla_theta J(theta) = EE_pi [q_pi (s, a) nabla_theta log pi(a|s)].
$
*Remark:* Often the policy gradient theorem is stated in this form, since this is
the form that is used in practice.

---

$
  nabla_theta J(theta) &= EE_pi [q_pi (s, a) nabla_theta log pi(a|s)] \
  nabla_theta J(theta) &= EE_pi [EE_pi [G_t | S_t = s, A_t = a] dot nabla_theta log pi(a|s)] \
  nabla_theta J(theta) &= EE_pi [G_t dot nabla_theta log pi (a|s)]
$

$==>$ REINFORCE

== Baselines
show why they work: gradient of a function only dependent on the state is zero thus it does not change the policy gradient theorem

== Advantage Actor Critic
use the state-value function as the baseline $==>$ advantage function

= PPO
== Motivation
foobar

== Loss function of PPO
maybe

== Generalized advantage estimate
maybe

== Onto the practice session 
Lets see REINFORCE and A2C

