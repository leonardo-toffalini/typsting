import matplotlib.pyplot as plt
import numpy as np


def middle_square(n, digits=2):
    n_str = str(n).zfill(digits)
    squared = str(int(n_str) ** 2).zfill(2 * digits)
    start = (len(squared) - digits) // 2
    res = int(squared[start : start + digits])
    return res


iterations = 200
digits = 4
seeds = list(range(1000, 10000))

plt.figure(figsize=(24, 12))

# Generate 90 colors from the GnBu colormap
cmap = plt.cm.GnBu
colors = cmap(np.linspace(0.2, 0.9, len(seeds)))

for seed, color in zip(seeds, colors):
    values = []
    current = seed

    for _ in range(iterations):
        values.append(current)
        current = middle_square(current, digits=digits)

    # plt.plot(range(iterations), values, color=color, alpha=0.5, linewidth=1.0)
    plt.scatter(range(iterations), values, color=color, alpha=0.5, s=1.0)

plt.xlabel("Iteration")
plt.ylabel("Value")
plt.title("Middle-Square RNG Paths")
plt.grid(True)
plt.savefig("middle_square_paths_10000")
plt.show()
