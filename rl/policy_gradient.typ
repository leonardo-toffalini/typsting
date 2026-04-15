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
#components.adaptive-columns(outline(title: none, depth: 2))

= Policy gradient methods
== Problems with value based methods
- Value iteration requires transition probabilities.

- Q-learning computes max over action space.

- What to do for huge/continuous action spaces?

== Value based vs policy based methods
#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      circle((-3, 0), radius: 6, stroke: red)
      circle((3, 0), radius: 6, stroke: blue)

      content((-8, 4), text(red, size: 26pt)[*Value function*])
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

#pause

- Policy based:
  - no value function

  - learnt policy

#pause

- Actor Critic:
  - learnt value function

  - learnt policy

== Parametric policy
- We can say that a policy depends on a set of parameters $theta$.

- This could be the weights and biases of a neural net.

- We want the policy to be differentiable with respect to the parameters.

#pause

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
  J_1 (theta) &= v_(pi_theta) (s_1) = EE_(pi_theta) [v_1] flushr("(start value)") #pause\
  J_2 (theta) &= sum_(s in cal(S)) d^(pi_theta) v_(pi_theta) (s) flushr("(avg value)") #pause\
  J_3 (theta) &= sum_(s in cal(S)) d^(pi_theta) (s) sum_(a in cal(A)) pi_theta
(s, a) cal(R)_s^a flushr("(avg reward)")
$

#meanwhile
where $d^(pi_theta) (s)$ is the stationary distribution of the Markov chain for $pi_theta$.

*Goal:* Find $theta$ that maximizes $J(theta)$.

== Policy gradient theorem
#theorem[
  $
    nabla_theta J(theta) prop sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) q_pi (s, a) nabla_theta pi_theta (a|s)
  $
]

#proof[
  See #text(blue.mix(white).mix(blue))[#link("http://www.incompleteideas.net/book/RLbook2020.pdf", "Sutton-Barto RL bible")] chapter 13.2.
]

---
Notice the previous theorem says that _"the gradient of the objective function is
an expectation"_:
$
  nabla J(theta) = EE_pi [sum_(a in cal(A)) nabla_theta pi(a|s) q_pi (s, a)]
$
#pause

$
  nabla_theta J(theta) &= EE_pi [sum_(a in cal(A)) pi(a|s) q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))] \
  &= EE_pi [EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]] \
  &= EE_pi [q_pi (s, a) (nabla_theta pi(a|s))/(pi(a|s))]
$

== Log derivative trick
With the reverse application of the chain rule we can notice the following
$
  nabla_theta log pi(a|s) &= (nabla_theta pi(a|s))/(pi_theta (a|s)).
$
#pause

Applying this little trick in the formula for the gradient of the objective
function we get
$
  nabla_theta J(theta) = EE_pi [q_pi (s, a) nabla_theta log pi(a|s)].
$
#pause
*Remark:* Often the policy gradient theorem is stated in this form, since this is
the form that is used in practice.

== REINFORCE
*Problem:* In the previous formula to calculate the gradient of the objective
function we need to know the action-value function $q_pi$, instead we want to
estimate it as follows

$
  nabla_theta J(theta) &= EE_pi [q_pi (s, a) nabla_theta log pi(a|s)] \
  nabla_theta J(theta) &= EE_pi [EE_pi [G_t|S_t = s, A_t = a] dot nabla_theta log pi(a|s)] \
  nabla_theta J(theta) &= EE_pi [G_t dot nabla_theta log pi (a|s)].
$

$==>$ *REINFORCE*

*Remark:* We will implement this in the practice.

== Baselines
By definition
$
  q_pi (s, a) = EE[G_t|S_t=s, A_t=a],
$
that is the sampled $G_t$ is an unbiased estimator for $q_pi$.
#pause

*Problem:* What about the variance of the sample?
#pause

What if instead of $q_pi (s,a)$ we use $q_pi (s, a) - b(s)$  in the policy gradient theorem?
$
  nabla_theta J(theta) prop^? sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) (q_pi (s, a) - b(s)) nabla_theta pi_theta (a|s)
$

---

Split the formula
$
  sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) (q_pi (s, a) - b(s)) nabla_theta pi_theta (a|s) = \
  = sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) q_pi (s, a) nabla_theta pi_theta (a|s) -
  sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) b(s) nabla_theta pi_theta (a|s).
$
#pause

The latter part vanishes
$
  sum_(a in cal(A)) b(s) nabla_theta pi_theta (a|s) &= b(s) nabla_theta sum_(a in cal(A)) pi_theta (a|s) \
  &= b(s) nabla_theta 1 = b(s) dot 0 = 0.
$

---

With this we can see that 
$
  sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) (q_pi (s, a) - b(s)) nabla_theta pi_theta (a|s) = \
  sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) q_pi (s, a) nabla_theta pi_theta (a|s).
$

So the policy gradient theorem is true with the baseline too
$
  ==> nabla_theta J(theta) prop^checkmark sum_(s in cal(S)) d^pi (s) sum_(a in cal(A)) (q_pi (s, a) - b(s)) nabla_theta pi_theta (a|s).
$


== Advantage Actor Critic

*Question:* What should $b(s)$ be? \
Have we seen a function before that depends
only on the current state?
#pause

Lets use $v_pi (s)$ as the baseline. With it we will have $q_pi (s, a) - v_pi (s)$ in the policy gradient theorem, this is called the _advantage_
$
  A(s, a) := q_pi (s, a) - v_pi (s).
$
#pause

*Remark:* Informally speaking, the advantage measures how much better an action
$a$ is with respect to how good the current state $s$ is.

*Problem:* Do we need to estimate both $q_pi$ and $v_pi$? \
$==>$ Not necessarily!

---

We can write up the definition of $q_pi$ and unroll a half step of the Bellman
equation
$
  q_pi (s, a) &:= EE_pi [G_t|S_t=s, A_t = a] \
  &= EE_pi [R_t + gamma v_pi (S_(t+1))|S_t=s, A_t = a].
$

$
  ==> A(s, a) = EE_pi [R_t + gamma v_pi(S_(t+1))|S_t = s, A_t = a] - v_pi (s)
$

Let us define the _temporal difference (TD) error_
$
  delta_pi := R_t + gamma v_pi (S_(t+1)) - v_pi (S_t).
$

---

With the TD error we get the following reformulation for the advantage
$
  EE_pi [delta_pi|S_t = s, A_t = a] &= EE_pi [R_t + gamma v_pi (S_(t+1)) - v_pi (S_t)|S_t = s, A_t = a] \
  &= EE_pi [R_t + gamma v_pi (S_(t+1))|S_t = s, A_t = a] - v_pi (s) \
  &= q_pi (s, a) - v_pi (s) \
  &:= A(s, a).
$
#pause

The previous means that the TD error is an unbiased estimator for the
advantage. With this said, we can give the formula for the gradient of the
objective yet again
$
  nabla J(theta) = EE_pi [delta_pi nabla log pi(a|s)].
$

---
Having established the reformulation of the gradient step only in terms of the
state-value function it is sufficient to estimate only that.

*Problem:* How do we estimate the state-value function?

$==>$ Homework for the curious.

*Problem:* The TD error is an unbiased estimator for the advantage _only if_ we
have access to the true value function $v_pi$, but we only have an estimate of
that too: $hat(v)_pi$.

$==>$ If $hat(v)_pi$ has high bias then so will $hat(A)(s, a)$.

---

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

      let input_neurons_policy = ((-1, 0.5), (-1, -0.5),)
      let inner_layer_policy = ((0, 1), (0, 0), (0, -1))
      let output_neurons_policy = ((1, 0),)

      let offset = 5
      let input_neurons_critic = ((-1, 0.5 - offset), (-1, -0.5 - offset),)
      let inner_layer_critic = ((0, 1 - offset), (0, 0-offset), (0, -1-offset))
      let output_neurons_critic = ((1, 0-offset),)

      rect((-3.5, -2.25),           (3.5, 2.5), fill: purple.transparentize(70%))
      rect((-3, -1.5),              (3, 1.5))
      rect((-3.5, -2.25 - offset),  (3.5, 2.5-offset), fill: red.transparentize(70%))
      rect((-3, -1.5-offset),       (3, 1.5-offset))
      rect((-3.5, -1 - 2 * offset), (3.5, 2.0 - 2 * offset), fill: yellow.transparentize(70%))

      for (left_pos, right_pos) in cartesian(input_neurons_policy, inner_layer_policy) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layer_policy, output_neurons_policy) {
        line(left_pos, right_pos, stroke: gray)
      }

      for pos in input_neurons_policy {
        circle(pos, radius: 0.25, fill: green.mix(white))
      }
      for pos in inner_layer_policy {
        circle(pos, radius: 0.25, fill: white)
      }
      for pos in output_neurons_policy {
        circle(pos, radius: 0.25, fill: blue.mix(white))
      }

      for (left_pos, right_pos) in cartesian(input_neurons_critic, inner_layer_critic) {
        line(left_pos, right_pos, stroke: gray)
      }
      for (left_pos, right_pos) in cartesian(inner_layer_critic, output_neurons_critic) {
        line(left_pos, right_pos, stroke: gray)
      }

      for pos in input_neurons_critic {
        circle(pos, radius: 0.25, fill: green.mix(white))
      }
      for pos in inner_layer_critic {
        circle(pos, radius: 0.25, fill: white)
      }
      for pos in output_neurons_critic {
        circle(pos, radius: 0.25, fill: orange.mix(white))
      }

      content((0, 2.0), text(size: 20pt)[Actor])
      content((0, -1.9), text(size: 16pt)[policy])
      content((0, 2.0-offset), text(size: 20pt)[Critic])
      content((0, -1.9-offset), text(size: 16pt)[value function])
      content((0, 0.5-2*offset), text(size: 20pt)[Environment])

      // action
      line((3, 0), (10, 0), (10, 0.5 -2 * offset), (3.5, 0.5 - 2 * offset), mark: (end: ">"))
      circle((5.5, 1.0 - 2 * offset), radius: (1, 0.5), fill: blue.mix(white), stroke: none)
      content((5.5, 1.0 - 2 * offset), text(size: 16pt)[action])

      // obs
      line((-3.5, 0.5 - 2 * offset), (-10, 0.5 - 2 * offset), (-10, 0), (-3, 0), mark: (end: ">"))
      line((-3.5, 0.5 - 2 * offset), (-10, 0.5 - 2 * offset), (-10, -offset), (-3, -offset), mark: (end: ">"))

      circle((-5.5,  0.5 - 0 * offset), radius: (1, 0.5), fill: green.mix(white), stroke: none)
      content((-5.5, 0.5 - 0 * offset), text(size: 16pt)[obs])
      circle((-5.5,  0.5 - 1 * offset), radius: (1, 0.5), fill: green.mix(white), stroke: none)
      content((-5.5, 0.5 - 1 * offset), text(size: 16pt)[obs])

      // reward
      line((-3.5, 1.0 - 2 * offset), (-6.5, 1.0 - 2 * offset), (-6.5, -0.5-offset), (-3.5, -0.5-offset), mark: (end: ">"))
      circle(( -5.0, 1.5-2*offset), radius: (1, 0.5), fill: eastern.mix(white), stroke: none)
      content((-5.0, 1.5-2*offset), text(size: 16pt)[reward])

      // TD error
      line((3.5, -offset), (6.5, -offset), (6.5, -0.5), (3.5, -0.5), mark: (end: ">"))
      circle((5.0, 0.5-offset), radius: (1, 0.5), fill: orange.mix(white), stroke: none)
      content((5.0, 0.5-offset), text(size: 16pt)[TD error])


    })
  ]
)

== Generalized advantage estimator
The advantage estimate had the issue that if we estimate $hat(v)_pi$ then the
bias of that estimate will propagate to the advantage estimate $hat(A)$. \
$==>$ We can reduce this bias by taking more steps as follows
$
  hat(A)_t^((k)) &:= sum_(l=0)^(k-1) gamma^l delta_(t+l) \
  &= -hat(v)_pi (S_t) + R_t + gamma R_(t+1) + gamma^2 R_(t+2) + ... + gamma^k hat(v)_pi (S_(t+k)).
$

We can see that the contribution of $hat(v)_pi$ is discounted by a factor of
$gamma^k$, thus the bias will be reduced.

*Problem:* If we take many steps then the variance of the estimate will
increase. How do we find a balance between variance and bias?

---
$==>$ Take an exponentially-weighted average of the $k$-step estimators:
$
  hat(A)_t^("GAE"(gamma, lambda)) := (1 - lambda) (hat(A)_t^((1)) + lambda hat(A)_t^((2)) + lambda^2 hat(A)_t^((3)) + ... )
$

#proposition[
  $
    hat(A)_t^("GAE"(gamma, lambda)) = sum_(l=0)^oo (gamma lambda)^l delta_(t+l)
  $
]

//
// $
//   hat(A)_t^("GAE"(gamma, lambda)) &:= (1 - lambda) (hat(A)_t^((1)) + lambda hat(A)_t^((2)) + lambda^2 hat(A)_t^((3)) + ... ) \
//   &= (1 - lambda) (delta_t + lambda (delta_t + gamma delta_(t+1)) + lambda^2 (delta_t + gamma delta_(t+1) + gamma^2 delta_(t+2)) + ...) \
//   &= (1 - lambda) (delta_t (1 + lambda + lambda^2 + ...) + gamma delta_(t+1) (lambda + lambda^2 + lambda^3 + ...) \
//   &quad + gamma^2 delta_(t+2) (lambda^2 + lambda^3 + lambda^4 + ...) + ...) \
//   &= (1 - lambda) (delta_t (1/(1-lambda)) + gamma delta_(t+1)(lambda/(1 - lambda)) + gamma^2 delta_(t+2)(lambda^2/(1 - lambda)) + ...) \
//   &= sum_(l = 0)^oo (gamma lambda)^l delta_(t + l)
// $

$
  hat(A)_t^(gamma, lambda) &:= (1 - lambda) sum_(k=1)^oo lambda^(k - 1) hat(A)_t^((k)) \
  &= (1 - lambda) sum_(k=1)^oo lambda^(k-1) (sum_(l=0)^(k-1) gamma^l delta_(t+l)) \
  &= (1 - lambda) sum_(l=0)^oo gamma^l delta_(t+l) (sum_(k=l+1)^oo lambda^(k-1)) \
  &= (1 - lambda) sum_(l=0)^oo gamma^l delta_(t+l) lambda^l/(1 - lambda) \
  &= sum_(l=0)^oo (gamma lambda)^l delta_(t + l)
$

== Importance sampling
- In REINFORCE we collect a new batch for each training step.
  - This is terribly wasteful. 

- We want to run multiple training steps on the same batch.
  - We have a batch $(s_t, a_t) ~ pi_(theta_"old")$

#proposition[
  $
    EE_(pi_theta)[f(s, a)] approx EE_(pi_theta_"old") [(pi_theta (a|s))/(pi_theta_"old" (a|s)) f(s, a)]
  $
]

---

#proof[
  $
    EE_(pi_theta)[f(s, a)] &:= sum_(s in cal(S)) d^(pi_theta)(s) sum_(a in cal(A)) pi_theta (a|s) f(s, a) \
    &= sum_(s in cal(S)) d^(pi_"old") (s) dot (d^(pi_theta)(s))/(d^(pi_"old")(s)) sum_(a in cal(A)) pi_"old" (a|s) dot (pi_theta (a|s))/(pi_"old" (a|s)) f(s, a) \
    &= EE_(pi_"old") [ (d^(pi_theta)(s))/(d^(pi_"old")(s)) dot (pi_theta (a|s))/(pi_"old" (a|s)) dot f(s, a) ] \
    &approx EE_(pi_"old") [(pi_theta (a|s))/(pi_"old" (a|s)) dot f(s, a)]
  $
]

---
Let $f(s, a) = nabla_theta log pi_theta (a|s) A_t$, then
$
  nabla_theta J(theta) &= EE_(pi_theta) [nabla_theta log pi_theta (a_t|s_t) dot A_t] flushr("(PG theoerm)") \
  &approx EE_(pi_"old") [(pi_theta (a_t|s_t))/(pi_"old" (a_t|s_t)) dot nabla_theta log pi_theta (a_t|s_t) dot A_t] \
  &approx EE_(pi_"old") [r_t (theta) dot nabla_theta log pi_theta (a_t|s_t) dot A_t],
$
where
$
  r_t (theta) = (pi_theta (a_t|s_t))/(pi_"old" (a_t|s_t)).
$

---

Notice the following
$
  nabla_theta r_t (theta) &= nabla_theta ((pi_theta (a_t|s_t))/(pi_"old" (a_t|s_t))) \
  &= 1/(pi_"old" (a_t|s_t)) nabla_theta pi_theta (a_t|s_t) \
  &= (pi_theta (a_t|s_t))/(pi_"old" (a_t|s_t)) dot nabla_theta log pi_theta (a_t|s_t) \
  &= r_t (theta) nabla_theta log pi_theta (a_t|s_t).
$

With this we have
$
    nabla_theta J(theta) approx EE_(pi_"old") [nabla_theta r_t (theta) A_t] = nabla_theta EE_(pi_"old") [r_t (theta) A_t]
$

With the previous arguments we can see that the following loss function has approximately the same gradient as the original
$
  L^"CPI" (theta) = EE_(pi_"old") [r_t (theta) A_t].
$

This loss function is called _conservative policy iteration_.

Since we cannot compute $EE [dot]$  exactly and we don't know $A_t$ exactly we
must approximate $EE$ with the sample average and $A_t$ with $hat(A)_t$.

*Intuition:* We reuse data sample with the _old policy_ but we want expectation
under the _new policy_. For this we correct with _how much more likely_ we are to
take action $a$ at state $s$ following the new strategy than with the old
strategy.

== Trust region
During training $r_t (theta)$ becomes either huge or tiny:
- If $A_t > 0$, then optimizer moves $r_t -> oo$.
- If $A_t < 0$, then optimizer moves $r_t -> 0$.

Solution: *TRPO*, *PPO*.

*PPO*: Let's prevent huge updates by clipping the ratio.

We define the _PPO clipped surrogate loss function_ as follows
$
  L^"CLIP" (theta) = EE [min(r_t (theta) A_t), quad "clip" (r_t (theta), 1-epsilon, 1+epsilon) A_t].
$

== Clipped surrogate

#figure(
  image("ppo_clipped_surrogate.png")
)

== Recap
- Value based methods don't work well for big or continuous action spaces.
  - Policy gradient methods.
- REINFORCE
  - Maximize returns weighted by log-probs.
- Advantage
  - Reduce variance.
- Importance sampling.
  - Reuse old data, correct with $r_t (theta)$.
- Trust region.
  - Keep policy changes conservative.
- Clipped surrogate (PPO)
  - Simplest was to enforce trust region.

