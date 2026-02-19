import numpy as np
import matplotlib.pyplot as plt
from fbm import fbm  # pip install fbm matplotlib


def main() -> None:
    # Parameters
    n_paths = 10
    n_points = 1000  # increase for smoother curves
    hurst = 0.7
    t_max = 100.0
    highlight_idx = 3  # which path to emphasize (0-based)
    rng_seed = 42

    np.random.seed(rng_seed)

    t = np.linspace(0, t_max, n_points)
    paths = [
        fbm(n=n_points - 1, hurst=hurst, length=t_max, method="daviesharte")
        for _ in range(n_paths)
    ]

    # Aesthetics tuned for slides
    plt.style.use("seaborn-v0_8-whitegrid")
    fig, ax = plt.subplots(figsize=(11, 6))

    for i, path in enumerate(paths):
        if i == highlight_idx:
            ax.plot(t, path, color="#6fa8ff", linewidth=2.8, label="Highlighted path")
        else:
            ax.plot(t, path, color="#b0b0b0", linewidth=1.1, alpha=0.7)

    # Focus cues
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.set_title("Fractional Brownian Motion (H = 0.7)", fontsize=16, weight="bold")
    ax.set_xlabel("Time")
    ax.set_ylabel("Value")
    ax.legend(frameon=False, loc="upper left")
    ax.margins(x=0)

    plt.tight_layout()
    plt.show()
    # To save directly for slides, uncomment:
    # plt.savefig("fbm_paths.png", dpi=200, bbox_inches="tight")


if __name__ == "__main__":
    main()