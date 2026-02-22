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

      content((-3, 2), [*Value function*])
      content((3, 2), [*Policy*])

      content((0, -1),  [*Actor Critic*])
      content((-6, -1), [*Value based*])
      content((6, -1),  [*Policy based*])
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

== Loss functions
Define the following 

$
  J_1 (theta) = v_(pi_theta) (s_1) = EE_(pi_theta) [v_1]
$

$
  J_2 (theta) = sum_(s in cal(S)) d^(pi_theta) v_(pi_theta) (s)
$

$
  J_3 (theta) = sum_(s in cal(S)) d^(pi_theta) (s) sum_(a in cal(A)) pi_theta (s, a) cal(R)_s^a
$

where $d^(pi_theta) (s)$ is the stationary distribution of the Markov chain for $pi_theta$.

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
$
  nabla J(theta) = EE_pi [sum_(a in cal(A)) nabla_theta pi(a|s) q_pi (s, a)]
$

$
  nabla_theta J(theta) &= EE_pi [sum_(a in cal(A)) pi(a|s) q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))] \
  &= EE_pi [EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]] \
  &= EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]
$

== Log derivative trick
$
  nabla_theta log pi(a|s) &= (nabla_theta pi(a|s))/(pi_theta (a|s)) \
  nabla_theta pi(a|s) &= pi_theta (a|s) nabla_theta log pi(a|s)
$

$
  nabla_theta J(theta) = EE_pi [q_pi (s, a) nabla_theta log pi(a|s)]
$

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

