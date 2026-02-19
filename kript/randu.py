import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation


def randu(n, seed=1):
    m = 2**31
    a = 65539
    x = seed
    out = np.empty(n)
    for i in range(n):
        x = (a * x) % m
        out[i] = x / m
    return out


N = 6000
r = randu(N + 2, seed=1)

x = r[:-2]
y = r[1:-1]
z = r[2:]


# ============================================================
# Set up 3D plot
# ============================================================
fig = plt.figure(figsize=(8, 8))
ax = fig.add_subplot(111, projection="3d")

scatter = ax.scatter(x, y, z, s=3)

ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.set_zlim(0, 1)

ax.set_xlabel("$x$")
ax.set_ylabel("$y$")
ax.set_zlabel("$z$")

plt.tight_layout()


# ============================================================
# Animation
# First: look face-on at the planes
# Then: slowly rotate to reveal planar structure
# ============================================================
def update(frame):
    t = frame
    # elev = 10 + 0.4 * t
    azim = 10 + 0.45 * t
    elev = t / 200 * 70 + (1 - t / 200) * 10

    ax.view_init(elev=elev, azim=azim)
    return (scatter,)


ani = FuncAnimation(fig, update, frames=130, interval=50, blit=False)
ani.save("randu_planes.gif", writer="pillow", fps=20)

plt.show()
