#import "@preview/lemmify:0.1.8": *
#let (
  theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules
) = default-theorems("thm-group", lang: "en")

#show: thm-rules
#set heading(numbering: "1.1")

= Introduction

#theorem(name: "Banach")[
  If $f$ is a contraction, then it has a fixpoint.
]<thm:banach>

