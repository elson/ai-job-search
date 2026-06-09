# Cover Letter Templates and Tailoring Guide

## Template: Typst (matched to the RenderCV CV)

Cover letters are written in **Typst**, using the shared template at
`cover_letters/template.typ`. It matches the RenderCV `classic` CV — same blue accent
(`rgb(0, 79, 144)`), Source Sans 3 font, and a centered name header — so the CV and
letter look like one set. Fonts are bundled in `cover_letters/fonts/`.

**Output file:** `cover_letters/cover_<company>_<role>.typ`
**Starting point:** copy `cover_letters/cover_example.typ`.

### Render command

Run inside the project venv (see `SETUP.md`). The `typst` PyPI package has no CLI, so the
repo ships a thin wrapper, `cover_letters/render.py`, which points Typst at the bundled
fonts:

```bash
.venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ
```

The PDF is written next to the `.typ`. Read it via the Read tool to confirm it is exactly
1 page. (Add `--png` if you want a PNG preview plus a printed page count, but it is not
needed for the normal flow.)

## Document structure

Each letter imports the template, applies it with `#show`, then writes the body as plain
Typst markup. Because the whole document uses one font, lists and bold text inherit the
body font automatically — there is no font-mismatch footgun to manage.

```typst
#import "template.typ": cover-letter

#show: cover-letter.with(
  name: "[YOUR_NAME]",
  headline: "[Your professional tagline]",   // optional
  date: "[9 June 2026]",
  recipient: ([\[Company\]], [\[City, Country\]]),
  salutation: "Dear Hiring Manager,",
  closing: "Sincerely,",
  signature: "[YOUR_NAME]",
)

[Opening paragraph — role, connection to background, 2-3 sentences.]

[Body paragraph — most relevant experience, then a bullet list.]

- *[Concrete achievement / skill 1]*
- *[Concrete achievement / skill 2]*
- *[Concrete achievement / skill 3]*

[Personal fit paragraph — behavioral strengths, team contribution.]

[Closing paragraph — enthusiasm, availability, thanks.]
```

### Template arguments

| Argument | Purpose |
|---------|---------|
| `name` | Centered header name (rendered in the CV's blue) |
| `headline` | Optional subtitle under the name |
| `date` | Date line, right-aligned |
| `recipient` | Array of content lines (first line bold), e.g. `([Company], [City])` |
| `salutation` | e.g. `"Dear Hiring Manager,"` |
| `closing` | e.g. `"Sincerely,"` |
| `signature` | Printed name below the closing |

Typst markup in the body: `*bold*`, `_italic_`, `#link("url")[text]`, and `- ` for
bullet lists.

## Render-and-Inspect Loop (MANDATORY)

After writing the cover letter and before presenting to the user, always render and
visually inspect the PDF. Iterate until clean:

1. Run `.venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ`
2. Read the PDF via the Read tool — confirm it is exactly 1 page
3. Visually check: signature fits at the bottom, no text cut off, accent colour and font match the CV

If the letter spills onto a second page, **trim content** (see Length below) — do not
shrink the font or margins.

## Tailoring Guidelines

### Salutation
- If you know the hiring manager's name: "Dear [First Last],"
- If you know the team: "Dear [Company] hiring team,"
- Generic: "Dear Hiring Manager," (avoid "To whom it may concern")

### Length — 1-Page Limit
- Target: 1 page including the signature block. **Never exceed 1 page.**
- **Word budget: 250-300 words** of body text. 350+ words will overflow.
- Count your blocks: opening + body-with-bullets + closing = 3. Add a 4th only if the
  others are short.
- When adding company-specific content, trim elsewhere to compensate rather than adding
  net length.

### Bullet Lists
- 3-5 bullets is ideal. Start each with a bold label or action verb (`*Label* — ...`).
- Lists are plain Typst markup in the body; they inherit the document font automatically.

### Non-English Cover Letters
- Same template, just write the content in the posting's language
- Adjust the `date` format to local convention
- Adjust the `closing` to local convention (e.g. "Med venlig hilsen," for Danish)

## Checklist Before Finalizing
- [ ] No em-dashes (use commas or periods instead)
- [ ] No cliches or empty filler
- [ ] Every claim backed by a specific example
- [ ] Forward-looking framing: focuses on tasks you'll solve, not just past duties
- [ ] Motivation references this specific company's mission/values
- [ ] Company name and role are correct throughout
- [ ] Date is current
- [ ] Fits on one page
- [ ] Language matches the job posting language
- [ ] Salutation is appropriate (named person if possible)

## Submission Guidelines (Best Practice)
- Submit only the documents the employer requests
- Export as PDF to preserve formatting
- Name files clearly: "[Your Name] CV" and "[Your Name] Cover Letter"
- Follow all employer instructions regarding anonymity or specific materials
