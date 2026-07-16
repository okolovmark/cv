#let variant = sys.inputs.at("variant", default: "ai")
#let core = yaml("/data/core.yaml")
#let vd = yaml("/data/variants/" + variant + ".yaml")

#let accent = rgb("#1f4e79")
#let ink = rgb("#1f2328")
#let muted = rgb("#6a737d")
#let hairline = rgb("#d0d7de")

#set page(margin: (x: 1.6cm, y: 1.3cm))
#set text(font: "Source Sans 3", size: 9.3pt, fill: ink)
#set par(justify: false, leading: 0.6em)
#set list(spacing: 0.68em, indent: 0.1em, body-indent: 0.55em, marker: text(fill: muted, size: 8pt)[•])
#show link: set text(fill: accent)

#show heading.where(level: 2): it => block(above: 1.6em, below: 0.9em)[
  #text(size: 9.2pt, weight: "bold", fill: accent, tracking: 0.13em, upper(it.body))
  #v(-0.5em)
  #line(length: 100%, stroke: 0.6pt + hairline)
]

#let position(pos, keys) = {
  block(above: 1.15em, below: 0.5em)[
    #grid(
      columns: (1fr, auto),
      column-gutter: 1.2em,
      align: (left, right),
      [
        #text(weight: "bold", size: 10pt)[#pos.title]
        #text(fill: muted)[ · #pos.company]
      ],
      text(size: 8.3pt, fill: muted)[#pos.dates #h(0.6em) · #h(0.6em) #pos.where],
    )
  ]
  if keys.len() > 0 {
    list(..keys.map(k => pos.bullets.at(k)))
  }
}

// ---------- header ----------
#text(size: 23pt, weight: "bold", fill: accent)[#core.name]
#v(0.1em)
#text(size: 12pt, weight: "medium")[#vd.title]
#v(0.4em)
#text(size: 8.6pt, fill: muted)[
  #core.location
  #h(0.7em) · #h(0.7em) #link("mailto:" + core.email)[#core.email]
  #h(0.7em) · #h(0.7em) #link("https://" + core.github)[#core.github]
  #h(0.7em) · #h(0.7em) #link("https://" + core.linkedin)[#core.linkedin]
]

== Summary
#vd.summary

== Skills
#vd.skills

== Experience
#for p in vd.positions {
  let pos = core.positions.find(x => x.id == p.id)
  position(pos, p.at("bullets", default: ()))
}

== Open Source
#for os in core.open_source [
  - #link(os.url)[*#os.name*] -- #os.line
]

#grid(
  columns: (1.4fr, 1fr),
  column-gutter: 2.5em,
  [
    == Education
    #text(weight: "semibold")[#core.education.school] \
    #text(fill: muted)[#core.education.field, #core.education.years]
  ],
  [
    == Languages
    #core.languages.map(l => l.name + " (" + l.level + ")").join(" · ")
  ],
)
