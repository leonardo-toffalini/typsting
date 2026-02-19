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
    subtitle: [First semester report],
    author: [Leonardo Toffalini],
    date: datetime.today(),
  ),
)

// #set heading(numbering: numbly("{0}", default: "1."))
#set heading(numbering: none)

#title-slide()

== Problem statement
#figure[
  #image("fbm_highlighted_path.png")
]

---
#figure[
  #image("what_to_do.png")
]

---
$
  X_t^1(phi.alt) := z^1 + integral_0^t phi.alt_u dif u #flushr("(risky)")
$
$
  X_t^0(phi.alt) := z^0 - integral_0^t phi.alt_u S_u dif u - integral_0^t lambda abs(phi.alt_u)^alpha dif u #flushr("(riskless)")
$
$
   max_(phi.alt in S(t)) EE[X_T^0(phi.alt)]
$

== Previous work
#figure[
  #image("asymptotic_evaluation_thesis_image.png")
]

== Current work
- The code base was rewritten in C from Python
- Liquidation strategy is now a linear schedule
- Smarter rewards: anticipating liquidation value

== Results
- Three orders of magnitude speedup (1.5k $=>$ 1.5M SPS)
- Large-scale hyperparameter search with CARBS
- So far better performance for fix time horizons

== Example hyperparameter sweep (T = 512)
#figure[
  #image("example_sweep.png")
]

---
#figure[
  #image("sweep_gae_lambda_vs_terminal_riskless.png")
]


== Usage of AI tools
- Perplexity -- Research
- Cursor -- Programming

