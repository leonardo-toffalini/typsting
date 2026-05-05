import circlify
import matplotlib.pyplot as plt
from cmap import Colormap

data = {
    "vagyok": 168,
    "minden": 153,
    "nagyon": 88,
    "mindig": 70,
    "tiszta": 58,
    "vagyunk": 58,
    "legyen": 58,
    "lassan": 54,
    "lelkem": 54,
    "egyszer": 52,
    "szegény": 52,
    "asszony": 51,
    "mintha": 51,
    "nincsen": 49,
    "szerelem": 43,
    "szivem": 42,
    "kedves": 42,
    "gyermek": 42,
    "bennem": 40,
    "tovább": 39,
    "magyar": 39,
    "tenger": 39,
    "hogyha": 39,
    "szívem": 38,
    "szabad": 38,
}

SIZE_EXPONENT = 1.35
scaled_items = [(word, value, value**SIZE_EXPONENT) for word, value in data.items()]
scaled_values = [scaled_value for _, _, scaled_value in scaled_items]

circles = circlify.circlify(
    scaled_values,
    show_enclosure=True,
    target_enclosure=circlify.Circle(x=0, y=0, r=1),
)


fig, ax = plt.subplots(figsize=(8, 8))
ax.set_title("Top 25 Long Words", fontsize=14)

num_words = len(data)
colormap = Colormap("viridis")

# circlify returns one enclosing circle; map words by rank to avoid mismatched labels.
enclosure_circle = max(circles, key=lambda c: c.r)
data_circles = sorted(circles, key=lambda c: c.r, reverse=True)[1 : num_words + 1]
sorted_items = sorted(scaled_items, key=lambda item: item[2], reverse=True)

ax.add_patch(
    plt.Circle(
        (enclosure_circle.x, enclosure_circle.y),
        enclosure_circle.r,
        fill=True,
        color="gray",
        alpha=0.2,
        edgecolor="black",
        linewidth=1.0,
    )
)

for idx, (circle, (word, value, _)) in enumerate(zip(data_circles, sorted_items)):
    x, y, r = circle.x, circle.y, circle.r
    color = colormap(idx / max(num_words - 1, 1))
    ax.add_patch(plt.Circle((x, y), r, color=color, alpha=0.6))
    ax.text(x, y, word, ha="center", va="center", fontsize=10)

ax.add_patch(
    plt.Circle(
        (enclosure_circle.x, enclosure_circle.y),
        enclosure_circle.r,
        fill=False,
        edgecolor="black",
        linewidth=1.0,
    )
)

ax.set_xlim(-1, 1)
ax.set_ylim(-1, 1)
ax.axis("off")

plt.savefig("long.png")
plt.show()
