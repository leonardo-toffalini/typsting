#import "@preview/pavemat:0.2.0": pavemat

#let a = math.mat((1, 2, 3), (4, 5, 6), (7, 8, 9), (10, 11, 12))

#pavemat(
  a,
  pave: "DDDSSSSAAAWWWDDSSAW",
  stroke: (dash: "dashed", thickness: 0.5pt),
  fills: (
    "0-0": red.transparentize(80%),
  ),
)
