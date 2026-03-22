= 4.

$
  cal(F)(bold(u)^(n+1))(s) = 1/(1 + mu i sin s) cal(F)(bold(u)^n)
$

$
  ==> rho(s) = 1/(1 + mu i sin s)
$

$
  abs(rho(s)) <=^checkmark 1
$

= 6.

$
  u_j^(n+1) := u_j^n - mu (u_j^n - u_(j-1)^n)
$

Verify that
$
  norm(bold(u)^(n+1))_max <= norm(bold(u)^n)_max
$

if $0 < mu <= 1$.

_Solution:_
$
  max_j abs(u_j^(n+1)) &:= max_j abs(u_j^n - mu (u_j^n - u_(j-1)^n)) \
  &<= (1 - mu) max_j abs(u_j^n) + mu max_j u_(j-1)^n
$

= 7.

