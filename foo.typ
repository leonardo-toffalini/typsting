= Notes

1. Extend the time horizons to include larger time horizons, for example $T ~
   U(128, 2048)$, as opposed to before it was $T ~ U(128, 512)$.

2. We might need to overcompensate the smaller time horizons to not run into
   the problem where most of the steps are from episodes with large time
   horizons.

3. We can also try to sample time horizons not starting from $128$.

4. Try to make the Hurst vary across episodes, so at each episode generation
   sample $H ~ U(a, b)$. Where $a$ and $b$ can be very far apart, e.g. $H ~
   U(0.05, 4.95)$.


