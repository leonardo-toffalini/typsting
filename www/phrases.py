import circlify
import matplotlib.pyplot as plt
from cmap import Colormap

data = {
    "tán próféta": 14,
    "próféta vagyok": 14,
    "rege róka": 14,
    "azt mondják": 9,
    "mondd mit": 8,
    "nagyon fáj": 8,
    "róka ejtem": 8,
    "amíg munkás": 8,
    "azt hiszem": 7,
    "aludj szépen": 7,
    "szépen kis": 7,
    "kis balázs": 7,
    "most tudom": 7,
    "sok szép": 7,
    "azt hittem": 7,
    "brumma brumma": 7,
    "brumma brummadza": 7,
    "mit érlel": 7,
    "érlel annak": 7,
    "annak sorsa": 7,
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
ax.set_title("Top 25 Phrases", fontsize=14)

num_words = len(data)
colormap = Colormap("pantanal")

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

plt.savefig("phrases.png")
plt.show()
