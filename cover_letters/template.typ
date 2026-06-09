// Cover letter template — visually matched to the RenderCV `classic` CV theme.
//
// Same accent colour (rgb(0, 79, 144)) and font (Source Sans 3) as cv/main_example.yaml,
// with a centered name header echoing the classic theme. Source Sans 3 is bundled in
// cover_letters/fonts/ and supplied to Typst via render.py's --font-path.
//
// Usage — see cover_letters/cover_example.typ. Each letter does:
//   #import "template.typ": cover-letter
//   #show: cover-letter.with(name: "...", date: "...", recipient: (...), ...)
//   <body paragraphs and lists as normal Typst markup>
//
// Render with (from the repo root, inside the project venv):
//   .venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ --png

#let accent = rgb(0, 79, 144)
#let muted = rgb(90, 90, 90)

#let cover-letter(
  name: "",
  headline: none, // optional subtitle under the name (e.g. your professional tagline)
  date: none, // e.g. "9 June 2026"
  recipient: (), // array of content lines, e.g. ([Anthropic], [San Francisco, CA])
  salutation: "Dear Hiring Manager,",
  closing: "Sincerely,",
  signature: "",
  body,
) = {
  set page(paper: "a4", margin: 2.3cm)
  set text(font: "Source Sans 3", size: 10.5pt, fill: black, lang: "en")
  set par(justify: true, leading: 0.65em, spacing: 1.1em)

  // Header: centered name in the CV's blue, optional headline, partial rule.
  align(center)[
    #text(size: 26pt, weight: "bold", fill: accent)[#name]
    #if headline != none {
      linebreak()
      v(0.2em)
      text(size: 10.5pt, fill: muted)[#headline]
    }
  ]
  v(0.3em)
  line(length: 100%, stroke: 0.5pt + accent)
  v(1.2em)

  // Date, right-aligned.
  if date != none {
    align(right)[#text(fill: muted)[#date]]
    v(0.8em)
  }

  // Recipient block, left-aligned.
  if recipient.len() > 0 {
    for (i, l) in recipient.enumerate() {
      if i == 0 { text(weight: "bold")[#l] } else { l }
      linebreak()
    }
    v(0.8em)
  }

  // Salutation.
  salutation
  v(0.6em)

  // Body (everything after the #show rule in the calling file).
  body

  // Closing + signature.
  v(0.6em)
  closing
  v(1.4em)
  text(weight: "bold")[#signature]
}
