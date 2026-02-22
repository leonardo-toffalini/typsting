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
    title: [Introduction to reinforcement learning],
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

= Informal introduction to RL
== Characteristics of RL
What makes RL different?
- Not supervised (learning from labeled data)
- Not unsupervised (learning patterns in unlabeled data)
- Only _reward_ signal
- Feedback may be delayed
- Heavily time dependent
- The agent has influence over future data

== Examples of RL
- Robotics
- Video games
- Self-driving
- Finance
- Natural language processing (recently)
- Recommendation systems
- Many more...

= Setting the scene
== Markov decision processes
#definition[
  A Markov decision process (MDP) is defined by the tuple $(cal(S), cal(A),
  cal(P)_a , cal(R)_a)$, where
  - $cal(S)$ is the set of all states
  - $cal(A)$ is the set of all possible actions
  - $cal(P)$ is the transition probability function
    $
      cal(P)_(s s')^a = PP[S_(t+1) = s' | S_t = s, quad A_t = a]
    $
  - $cal(R)$ is the reward function
    $
      cal(R)_s^a = EE[R_(t+1) | S_t = s, quad A_t = a]
    $
]

---

#definition[
  A state $S_t$ is Markov if and only if
  $
    PP[S_(t+1) | S_t] = PP[S_(t+1) | S_1, ..., S_t].
  $
]

#remark[
  In a Markov decision process, the successor state is _solely_ influenced by
  the current state.

  That is, an MDP has no memory of previous states.

  Is this a limitation?
]

== Illustrative step in an MDP

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      circle((0,0), radius: hollow_radius)
      line((hollow_radius, 0), (3,0))

      circle((3, 0), radius: full_radius, fill: black)
      line((3,0), (6-0.25, 2-0.1))
      line((3,0), (6-0.25, -2+0.1))

      circle((6,2), radius: hollow_radius)
      circle((6,-2), radius: hollow_radius)

      content((4, 0), text(size: 18pt)[$cal(R)_(s s')^a$])

      circle((6, 0.0), radius: 0.05, fill: black)
      circle((6, 0.5), radius: 0.05, fill: black)
      circle((6, -0.5), radius: 0.05, fill: black)

      cetz.decorations.brace((3, 2.5), (6, 2.5))
      content((4.5, 3.2), text(size: 18pt)[$cal(P)_(s s')^a$], anchor: "south")

      content((6.5, 2.2), text(size: 18pt)[$s'_1$], anchor: "west")
      content((6.5, -2.2), text(size: 18pt)[$s'_1$], anchor: "west")
      content((-0.5,0), text(size: 18pt)[$s$], anchor: "east")

    })
  ],
  caption: "hollow circles = states, full circles = actions"
)


== Reward hypothesis
#definition[
  The reward hypothesis claims that all goals can be described by the
  maximization of expected cumulative reward.
]

#remark[
  Do you agree?

  Can you find a counterexample?

  Long term goals? Human values? Multiple objectives? Safety constraints?
]

== Policy
#definition[
  A policy $pi$ is a distribution over the action space conditioned on the
  state space, that is
  $
    pi(a|s) = PP[A_t = a | S_t = s].
  $
]

#remark[
  The next action depends _only_ on the current state and nothing else.

  The policy may be deterministic if $pi(a_i | s) = 1$ for some $i$ and $pi(a_j
    | s) = 0$ for any other $j != i$.
]

== Value function
#definition[
  The return $G_t$ is the total discounted reward from time step $t$, that is
  $
    G_t = R_(t+1) + gamma R_(t+2) + ... = sum_(k=0)^infinity gamma^k R_(t+k+1).
  $
]

#remark[
  We can control the importance of _immediate_ versus _future_ rewards with
  $gamma in [0,1]$. Also, $gamma < 1$ helps with the series converging.
]

#definition[
  The state-value function of a state $s$ is the expected discounted return
  starting from state $s$, that is
  $
    v_(pi) (s) := EE_(pi) [G_t | S_t = s].
  $
]

#definition[
  The action-value function of a state-action pair $(s, a)$ is the expected
  discounted return starting from state $s$ and taking action $a$, that is
  $
    q_pi (s, a):= EE_(pi)[G_t | S_t = s, A_t = a]
  $
]

= Bellman equations
== Bellman expectation equations
#proposition[
  $
    v_pi (s) = EE_pi [R_(t+1) + gamma v_pi (S_(t+1)) | S_t = s]
  $
]

#proof[
  $
    v_pi (s) &:= EE_pi [G_t | S_t = s] \
    &= EE_pi [R_(t+1) + gamma G_(t+1) | S_t = s] \
    &= EE_pi [R_(t+1) + gamma EE_pi [G_(t+1) | S_(t+1)] | S_t = s] \
    &= EE_pi [R_(t+1) + gamma v_pi (S_(t+1)) | S_t = s]
  $
]

---

#proposition[
  $
    q_pi (s, a) = EE_pi [R_(t+1) + gamma q_pi (S_(t+1), A_(t+1)) | S_t = s, A_t = a]
  $
]

#proof[
  $
    q_pi (s, a) &:= EE_pi [G_t | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma G_(t+1) | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma EE_pi [G_(t+1) | S_(t+1), A_(t+1)] | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma q_pi (S_(t+1), A_(t+1)) | S_t = s, A_t = a]
  $
]

---

#proposition[
  $
    v_pi (s) = sum_(a in cal(A)) pi(a|s) q_pi (s, a)
  $
]

#proof[
  $
    v_pi (s) &:= EE_pi [G_t | S_t = s] \
    &= EE_pi [EE_pi [G_t | S_t, A_t] | S_t = s] \
    &= sum_(a in cal(A)) pi(a|s) q_pi (s, a)
  $
]

== Backup diagram

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-5, -5))
      line((0,0), (5, -5))
      circle((0,0), radius: hollow_radius, fill: white)
      circle((-5, -5), radius: full_radius, fill: black)
      circle((5, -5), radius: full_radius, fill: black)

      content((-0.5,0), [$v_pi (s) arrow.l.bar s$], anchor: "east")
      content((-5.5, -5), [$q_pi (s, a) arrow.l.bar a$], anchor: "east")
    })
  ],
)

== Bellman expectation equations

#proposition[
  $
    q_pi (s, a) = cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)^a_(s s') v_pi (s')
  $
]

---

#proof[
  $
    q_pi (s, a) &:= EE_pi [G_t | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma G_(t+1) | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma EE_pi [G_(t+1) | S_(t+1) = s] | S_t = s, A_t = a] \
    &= EE_pi [R_(t+1) + gamma v_pi (S_(t+1)) | S_t = s, A_t = a] \
    &= cal(R)_s^a + gamma EE_pi [v_pi (S_(t+1)) | S_t = s, A_t = a] \
    &= cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)_(s s')^a v_pi (s')
  $
]

== Backup diagram

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-5, -5))
      line((0,0), (5, -5))
      circle((0,0), radius: full_radius, fill: black)
      circle((-5, -5), radius: hollow_radius, fill: white)
      circle((5, -5), radius: hollow_radius, fill: white)

      content((-0.5,0), [$q_pi (s, a) arrow.l.bar s, a$], anchor: "east")
      content((-5.5, -5), [$v_pi (s') arrow.l.bar s'$], anchor: "east")
      content((-3.0, -2.5), [$r$], anchor: "east")
    })
  ],
)

== Bellman expectation equations

#proposition[
  $
    v_pi (s) = sum_(a in cal(A)) pi(a|s) (cal(R)_s^a + gamma sum_(s' in S)
  cal(P)_(s s')^a v_pi (s'))
  $
]

#proposition[
  $
    q_pi (s, a) = cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)_(s s')^a sum_(a'
  in cal(A)) pi(a'|s') q_pi (s', a')
  $
]

== Backup diagram

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-2.5, -2.5))
      line((0,0), (2.5, -2.5))
      line((-2.5,-2.5), (-4, -5))
      line((-2.5,-2.5), (-1.0, -5))
      line((2.5,-2.5), (4, -5))
      line((2.5,-2.5), (1.0, -5))

      circle((0,0), radius: hollow_radius, fill: white)
      circle((-2.5, -2.5), radius: full_radius, fill: black)
      circle((2.5, -2.5), radius: full_radius, fill: black)
      circle((-4.0, -5), radius: hollow_radius, fill: white)
      circle((4, -5), radius: hollow_radius, fill: white)
      circle((1.0, -5), radius: hollow_radius, fill: white)
      circle((-1.0, -5), radius: hollow_radius, fill: white)

      content((0 - 0.5, 0), [$v_pi (s) arrow.l.bar s$], anchor: "east")
      content((-4.0 - 0.5, -5), [$v_pi (s') arrow.l.bar s'$], anchor: "east")
      content((-2.5 - 0.5, -2.5), [$a$], anchor: "east")
      content((-3.0 - 0.5, -3.75), [$r$], anchor: "east")
    })
  ],
)

---

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-2.5, -2.5))
      line((0,0), (2.5, -2.5))
      line((-2.5,-2.5), (-4, -5))
      line((-2.5,-2.5), (-1.0, -5))
      line((2.5,-2.5), (4, -5))
      line((2.5,-2.5), (1.0, -5))

      circle((0,0), radius: full_radius, fill: black)
      circle((-2.5, -2.5), radius: hollow_radius, fill: white)
      circle((2.5, -2.5), radius: hollow_radius, fill: white)
      circle((-4.0, -5), radius: full_radius, fill: black)
      circle((4, -5), radius: full_radius, fill: black)
      circle((1.0, -5), radius: full_radius, fill: black)
      circle((-1.0, -5), radius: full_radius, fill: black)

      content((0 - 0.5, 0), [$q_pi (s, a) arrow.l.bar s, a$], anchor: "east")
      content((-4.0 - 0.5, -5), [$q_pi (s', a') arrow.l.bar a'$], anchor: "east")
      content((-2.5 - 0.5, -2.5), [$s'$], anchor: "east")
      content((-1.25 - 0.5, -1.25), [$r$], anchor: "east")
    })
  ],
)

== Bellman optimality equations
#definition[
  The optimal state-value function is defined as
  $
    v_* (s) = max_pi v_pi (s)
  $
]

#definition[
  The optimal action-value function is defined as 
  $
    q_* (s, a) = max_pi q_pi (s, a).
  $
]

---

#definition[
  A policy $pi^*$ is optimal if for all other policies $pi$
  $
    v_(pi^*) (s) >= v_pi (s) quad forall s in cal(S).
  $
]

#remark[
  That is, $pi^*$ is optimal if the value function induced by following $pi^*$
  is optimal.
]

---

#proposition[
  $
    v_* (s) = max_a q_* (s, a)
  $
]

#proposition[
  $
    q_* (s, a) = cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)_(s s')^a v_* (s')
  $
]

== Backup diagrams

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-5, -5))
      line((0,0), (5, -5))
      // arc((-1,-1), start: 200deg, stop: 340deg)
      arc((-0.858, -0.87), start: 210deg, stop: 330deg)

      circle((0,0), radius: hollow_radius, fill: white)
      circle((-5, -5), radius: full_radius, fill: black)
      circle((5, -5), radius: full_radius, fill: black)

      content((-0.5,0), [$v_* (s) arrow.l.bar s$], anchor: "east")
      content((-5.5, -5), [$q_* (s, a) arrow.l.bar a$], anchor: "east")
      // content((-3.0, -2.5), [$r$], anchor: "east")
    })
  ],
)

---

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-5, -5))
      line((0,0), (5, -5))
      circle((0,0), radius: full_radius, fill: black)
      circle((-5, -5), radius: hollow_radius, fill: white)
      circle((5, -5), radius: hollow_radius, fill: white)

      content((-0.5,0), [$q_* (s, a) arrow.l.bar s, a$], anchor: "east")
      content((-5.5, -5), [$v_* (s') arrow.l.bar s'$], anchor: "east")
      content((-3.0, -2.5), [$r$], anchor: "east")
    })
  ],
)

== Bellman optimality equations

#proposition[
  $
    v_* (s) = max_a (cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)_(s s')^a v_* (s') )
  $
]

#proposition[
  $
    q_* (s, a) = cal(R)_s^a + gamma sum_(s' in cal(S)) cal(P)_(s s')^a max_(a') q_* (s', a')
  $
]

== Backup diagrams

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-2.5, -2.5))
      line((0,0), (2.5, -2.5))
      line((-2.5,-2.5), (-4, -5))
      line((-2.5,-2.5), (-1.0, -5))
      line((2.5,-2.5), (4, -5))
      line((2.5,-2.5), (1.0, -5))
      arc((-0.858, -0.87), start: 210deg, stop: 330deg)

      circle((0,0), radius: hollow_radius, fill: white)
      circle((-2.5, -2.5), radius: full_radius, fill: black)
      circle((2.5, -2.5), radius: full_radius, fill: black)
      circle((-4.0, -5), radius: hollow_radius, fill: white)
      circle((4, -5), radius: hollow_radius, fill: white)
      circle((1.0, -5), radius: hollow_radius, fill: white)
      circle((-1.0, -5), radius: hollow_radius, fill: white)

      content((0 - 0.5, 0), [$v_* (s) arrow.l.bar s$], anchor: "east")
      content((-4.0 - 0.5, -5), [$v_* (s') arrow.l.bar s'$], anchor: "east")
      content((-2.5 - 0.5, -2.5), [$a$], anchor: "east")
      content((-3.0 - 0.5, -3.75), [$r$], anchor: "east")
    })
  ],
)

---

#figure(
  align(center)[
    #cetz.canvas({
      import cetz.draw: *

      scale(x: 180%, y: 180%)

      let hollow_radius = 0.3
      let full_radius = 0.15

      line((0,0), (-2.5, -2.5))
      line((0,0), (2.5, -2.5))
      line((-2.5,-2.5), (-4, -5))
      line((-2.5,-2.5), (-1.0, -5))
      line((2.5,-2.5), (4, -5))
      line((2.5,-2.5), (1.0, -5))
      arc((-3.08,-3.45), start: 235deg, stop: 305deg)
      arc((3.08 - 1.15,-3.45), start: 235deg, stop: 305deg)

      circle((0,0), radius: full_radius, fill: black)
      circle((-2.5, -2.5), radius: hollow_radius, fill: white)
      circle((2.5, -2.5), radius: hollow_radius, fill: white)
      circle((-4.0, -5), radius: full_radius, fill: black)
      circle((4, -5), radius: full_radius, fill: black)
      circle((1.0, -5), radius: full_radius, fill: black)
      circle((-1.0, -5), radius: full_radius, fill: black)

      content((0 - 0.5, 0), [$q_* (s, a) arrow.l.bar s, a$], anchor: "east")
      content((-4.0 - 0.5, -5), [$q_* (s', a') arrow.l.bar a'$], anchor: "east")
      content((-2.5 - 0.5, -2.5), [$s'$], anchor: "east")
      content((-1.25 - 0.5, -1.25), [$r$], anchor: "east")
    })
  ],
)

== Onto the practice session
From the Bellman equations to:

- Value iteration,

- Q-learning.

