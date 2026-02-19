import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from fbm import fbm  # pip install fbm matplotlib


def main() -> None:
    hurst = 0.7
    steps = 100
    decision_step = 80  # cutoff point to display
    rng_seed = 7

    np.random.seed(rng_seed)

    # Generate a single FBM path over [0, 100]
    path = fbm(n=steps, hurst=hurst, length=steps, method="daviesharte")

    # Only show up to the cutoff (e.g., 0..80)
    t = np.arange(decision_step + 1)
    first_half = path[: decision_step + 1]

    plt.style.use("seaborn-v0_8-whitegrid")
    fig, ax = plt.subplots(figsize=(9, 5))

    path_color = "#4a90e2"  # price path color
    decision_color = path_color

    ax.plot(t, first_half, color=path_color, linewidth=2.0, label="Price path")

    # Hollow dashed circle at the decision point
    decision_circle = Circle(
        (decision_step, first_half[-1]),
        radius=0.5,
        fill=False,
        linestyle="--",
        linewidth=1.0,
        edgecolor=decision_color,
        zorder=3,
    )
    ax.add_patch(decision_circle)

    # Simple projected paths for a "buy" (up) vs "sell" (down) decision
    projection_horizon = 10
    buy_target = first_half[-1] * 1.06
    sell_target = first_half[-1] * 0.94

    ax.plot(
        [decision_step, decision_step + projection_horizon],
        [first_half[-1], buy_target],
        linestyle="--",
        linewidth=1.6,
        color="#1b9e3a",
        label="Buy projection",
    )
    ax.plot(
        [decision_step, decision_step + projection_horizon],
        [first_half[-1], sell_target],
        linestyle="--",
        linewidth=1.6,
        color="#d64541",
        label="Sell projection",
    )
    ax.text(
        decision_step + projection_horizon + 0.6,
        buy_target,
        "Buy",
        fontsize=10,
        color="#1b9e3a",
        ha="left",
        va="center",
    )
    ax.text(
        decision_step + projection_horizon + 0.6,
        sell_target,
        "Sell",
        fontsize=10,
        color="#d64541",
        ha="left",
        va="center",
    )

    ax.set_xlabel("Step")
    ax.set_ylabel("Value")
    ax.set_xlim(0, steps)
    ax.legend(frameon=False, loc="upper left")
    ax.margins(x=0)

    plt.tight_layout()
    plt.show()
    # To save instead of showing:
    # plt.savefig("fbm_first_half_decision.png", dpi=200, bbox_inches="tight")


if __name__ == "__main__":
    main()

