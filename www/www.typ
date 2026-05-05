#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: node, edge
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import "@preview/intextual:0.1.0": flushr, intertext-rule
#show: intertext-rule
#import cosmos.clouds: *
#show: show-theorion

// #import "@preview/lemmify:0.1.8": *
// #let (
//   theorem, lemma, corollary, remark, proposition, example, proof, rules: thm-rules
// ) = default-theorems("thm-group", lang: "en")
//
// #show: thm-rules

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: university-theme.with(
  aspect-ratio: "16-9",
  // align: horizon,
  config-common(handout: true),
  // config-common(show-notes-on-second-screen: right),
  config-common(frozen-counters: (theorem-counter,)),  // freeze theorem counter for animation
  config-info(
    title: [Jozsef Attila poems analysis],
    author: [Leonardo Toffalini],
    date: datetime.today(),
  ),
)

// #set heading(numbering: "1.")
#set heading(numbering: numbly("{1}.", default: "1.1"))
#set text(size: 24pt)

#title-slide()

== Outline <touying:hidden>
#components.adaptive-columns(outline(title: none, depth: 2))

= Jozsef Attila versek
== Why this matters
- Text search $!=$ simple keyword matching
- Literature is ambiguous and contextual
- Same word $==>$ different meanings
- *Goal:* Find meaningful lines, not just one to one matches

*Question:* How to search poetry in a meaningful manner?

// Speaker notes:
// If you Cmd + F a poem you only find exact mathes
// Poetry uses metaphors, allegories, repetition, and variations
// A simple search misses meaning
// We want something closer to understanding, not just matching

== The data
#figure(
  image("jozsef_attila_osszes_dataset_card.png", width: 85%),
  caption: [József Attila összes -
  #text(blue.mix(white))[#link("https://huggingface.co/datasets/tleo/jozsef_attila_osszes",
    [hf.co/tleo/jozsef_attila_osszes])]]
)

- Source: scraped from
  (#text(blue.mix(white))[#link("https://mek.oszk.hu/11800/11864/html/index.html",
  "mek.oszk.hu")])
- Preprocessing:
  - Clean formatting
  - Chunked into poems
  - Extracted metadata (title, contents, date) // author is the same...
  - Sanitized dates

- Goals:
  - Search across poems
  - Retrieve lines
  - Extract titles, highlights

// Speaker notes
// “We start with raw text — not structured.”
// “We need to transform it into something searchable.”
// “Each poem becomes a document.”
// “Each line can also be treated as a searchable unit.”
//
// If your notebook does it: mention
//
// tokenization
// removing punctuation
// handling Hungarian language specifics

== Elasticsearch
- Full-text search engine
- Handles:
  - Tokenization
  - Ranking relevance
  - Fuzzy matching

- Features:
  - Ranked results
  - Highlighting
  - Fast queries

// Speaker notes
// “Elasticsearch doesn’t just match words.”
// “It ranks results by relevance.”
// “It can match similar words, not just exact ones.”
// “And it highlights results automatically.”

== From data to searchable system
- Convert poems → documents
- Define fields:
  - title
  - full text
  - lines
  - year (if available)
- Index into Elasticsearch

// Speaker notes
// “This is the pipeline step.”
// “We structure the data so Elasticsearch understands it.”
// “Once indexed, it becomes queryable instantly.”

== Elasticsearch in action

#text(size: 20pt)[
`
query = {
    "multi_match": {
        "query": "Duna",
        "fields": ["title^2", "content"]
    }
}
`
]

#text(size: 18pt)[
`
[{'score': 5.836489, 'title': 'Népdalok à la Ringelnatz Morgenstern', 'date': '1928. szept. 30.'},
 {'score': 5.174677, 'title': 'Tavasz van! Gyönyörű!', 'date': '1924 tavasza'},
 {'score': 4.837141, 'title': 'Hajón megyek Pestre','date': '1924 első fele'},
 {'score': 4.278927, 'title': 'A csodaszarvas', 'date': '1933. júl. [?]'},
 {'score': 3.626894, 'title': 'A Dunánál', 'date': '1936. jún.'}]
`
]


---

#text(size: 20pt)[
`
query = {
    "match_phrase": {
        "content": "A rakodópart alsó kövén ültem"
    }
}
`
]

#text(size: 20pt)[
`
TITLE: A Dunánál
DATE: 1936. jún.
HIGHLIGHT:
### 1

<em>A</em> <em>rakodópart</em> <em>alsó</em> <em>kövén</em> <em>ültem</em>,  
néztem, hogy úszik el a dinnyehéj.
`
]

---

#columns(2)[
    // Query types

    *Keyword search*  \
    `Duna`  
    → searches title + content  

    #v(3.7em)

    *Phrase search*  \
    `"A rakodópart alsó kövén ültem"`  
    → exact sequence only  

#colbreak()
    // Results

    *Keyword search*  
    - Multiple poems returned  
    - Ranked by relevance  
    - Different contexts  

    #v(1em)

    *Phrase search*  
    - Exact match found  
    - Highlighted text  
    - Shows full context  

    #v(0.5em)

    #box[
      [...] _rakodópart alsó kövén ültem_ [...]
    ]
]

// Speaker notes
// Walk through ONE concrete example:
// “Search for a word like ‘love’ or ‘death’”
// Explain:
// why certain poems rank higher
// what highlighting shows
// Emphasize:
// “This already gives insight into themes”

== Most common words and phrases
#figure(
  image("short.png", width: 65%)
)

#figure(
  image("long.png", width: 65%)
)

#figure(
  image("phrases.png", width: 65%)
)

== Trends
#figure(
  image("poem_per_year.png", width: 90%)
)

#figure(
  image("poems_per_year_with_highlights.png", width: 90%)
)

#figure(
  image("poem_len_per_year.png", width: 90%)
)

#figure(
  image("lexical_richness_per_year.png", width: 90%)
)

#figure(
  image("title_len_vs_poem_len.png", width: 90%)
)

