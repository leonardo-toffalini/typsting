#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")

// Title
#align(center)[
  #text(size: 1.2em)[= Backtest review]
]
#v(2em)

#set heading(numbering: "1.1")

= OLS in log space

$
  log (P_A) = alpha + beta dot log (P_B) + epsilon
$

$
  \/ e^(\(dot\))
$

$
  P_A = e^(alpha + beta dot log (P_B) + epsilon)
$

$
  P_A = e^alpha dot e^(beta dot log (P_B)) dot e^epsilon
$

#v(2em)

$
  s_t = log (P_(A_t)) - alpha - beta dot log(P_(B_t))
$

$
  hat(sigma) = sqrt((sum_(i=1)^(n) epsilon^2_t)/(n-2))
$


#v(2em)

$
  R := "return"
$

$
  S := "Sharpe ratio"
$

$
  S = (EE(R))/(sigma(R)) approx (overline(R))/(s_n (R))
$

where

$
  overline(X) := 1/n sum X, quad s_n^2 (S) := 1/(n-d) (sum X_i - overline(X))^2
$

