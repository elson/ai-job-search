// Example cover letter — copy this to cover_<company>_<role>.typ and edit.
// Render: .venv/bin/python cover_letters/render.py cover_letters/cover_example.typ --png

#import "template.typ": cover-letter

#show: cover-letter.with(
  name: "[YOUR_NAME]",
  headline: "[Your professional tagline, e.g. Data Scientist · Machine Learning]",
  date: "[9 June 2026]",
  recipient: ([\[Company\]], [\[City, Country\]]),
  salutation: "Dear Hiring Manager,",
  closing: "Sincerely,",
  signature: "[YOUR_NAME]",
)

[Opening paragraph: why this role and this company, and the single strongest
reason you are a fit. Keep it specific to the posting.]

[Second paragraph: connect your most relevant experience to the role's core
requirements. Reference concrete achievements.]

Here is how my background maps to what you are looking for:

- *[Requirement 1]* — [your matching experience, briefly].
- *[Requirement 2]* — [your matching experience, briefly].
- *[Requirement 3]* — [your matching experience, briefly].

[Closing paragraph: reiterate enthusiasm, mention availability, and thank the
reader. When referencing agentic coding or AI tooling, name *Claude Code*.]
