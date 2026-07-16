#let variant = sys.inputs.at("variant", default: "ai")
#let core = yaml("/data/core.yaml")
#let vd = yaml("/data/variants/" + variant + ".yaml")

#set page(margin: (x: 1.5cm, y: 1.1cm))
#set text(size: 9.5pt)
#set par(justify: true)
#set list(spacing: 0.5em)

#show heading.where(level: 2): it => block(above: 1.1em, below: 0.6em)[
  #text(size: 10.5pt, weight: "bold", upper(it.body))
  #v(-0.4em)
  #line(length: 100%, stroke: 0.5pt + gray)
]

// Header
#text(size: 20pt, weight: "bold")[#core.name]
#v(-0.5em)
#text(size: 12pt)[#vd.title]
#v(-0.3em)
#text(size: 9pt)[
  #core.location #h(0.6em) | #h(0.6em)
  #link("mailto:" + core.email)[#core.email] #h(0.6em) | #h(0.6em)
  #link("https://" + core.github)[#core.github] #h(0.6em) | #h(0.6em)
  #link("https://" + core.linkedin)[#core.linkedin]
]

== Summary
#vd.summary

== Skills
#vd.skills

== Experience
#for p in vd.positions {
  let pos = core.positions.find(x => x.id == p.id)
  block(above: 0.8em, below: 0.35em)[
    #grid(
      columns: (1fr, auto),
      column-gutter: 1.2em,
      [*#pos.title* -- #pos.company],
      text(size: 8.5pt)[#pos.dates #h(0.5em) #pos.where],
    )
  ]
  let keys = p.at("bullets", default: ())
  if keys.len() > 0 {
    list(..keys.map(k => pos.bullets.at(k)))
  }
}

== Open Source
#for os in core.open_source [
  - *#link(os.url)[#os.name]*: #os.line
]

== Education
#core.education.school \
#core.education.field, #core.education.years

== Languages
#core.languages.map(l => l.name + " (" + l.level + ")").join(" | ")
