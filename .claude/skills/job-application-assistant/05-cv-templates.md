# CV Templates and Tailoring Guide

<!-- SETUP: Profile statements and section ordering are personalized by running /setup -->

## Template: RenderCV (classic theme)

All CVs are written as **RenderCV YAML** and rendered to PDF via Typst. For the full
RenderCV schema, entry types, design fields, and CLI options, use the bundled
**`rendercv` skill** (`.claude/skills/rendercv/SKILL.md`) — this file only covers the
repo-specific conventions and tailoring rules.

**Output file:** `cv/main_<company>.yaml`
**Theme:** `classic` with the default blue accent (`rgb(0, 79, 144)`), A4 page. The
cover letter (`cover_letters/template.typ`) matches the same colour and font (Source
Sans 3), so do not change the theme/accent per application — keep CV and letter visually
consistent.
**Master reference:** `cv/main_example.yaml` (comprehensive CV with all competencies,
experience, and achievements — copy it as the starting point when building a targeted CV).

### Render command

Run inside the project venv (see `SETUP.md` for the one-time `uv venv` setup):

```bash
.venv/bin/rendercv render cv/main_<company>.yaml -nomd -nohtml -nopng
```

The PDF (and Typst source) is written to `cv/rendercv_output/`; the `-nomd -nohtml -nopng`
flags suppress the Markdown, HTML, and PNG outputs we don't need. Read the PDF via the
Read tool to check the page count. The CV must be **1 or 2 pages**; 3+ pages is a failure
that must be fixed before presenting to the user (see relevance-weighted cutting below).

### YAML structure

The master `cv/main_example.yaml` defines the canonical section set. Tailor a copy by
editing content, not structure:

```yaml
cv:
  name: "..."
  location: "..."
  email: "..."
  phone: "..."          # must be a valid international number (RenderCV validates it)
  social_networks:
    - {network: LinkedIn, username: "..."}
    - {network: GitHub, username: "..."}
  sections:
    profile: ["..."]              # TextEntry — the tailored elevator pitch
    core_competencies: [...]      # OneLineEntry (label + details)
    experience: [...]             # ExperienceEntry (company, position, dates, highlights)
    education: [...]              # EducationEntry (institution, area, degree, dates)
    languages: [...]              # OneLineEntry
    publications: [...]           # PublicationEntry (title, authors, journal, date)
    honors_and_awards: [...]      # NormalEntry (name)
    references: ["..."]           # TextEntry
design:
  theme: classic
  page: {size: a4}
```

**YAML gotcha:** always wrap any string containing a colon in double quotes, or the YAML
parser breaks (highlights and summaries often contain colons). Inline Markdown
(`**bold**`, `*italic*`, `[text](url)`) works in any text field; block Markdown does not.

## Section-by-Section Tailoring

### Profile Statement / Elevator Pitch (Best Practice)
This is the most important section to customize. It is the `profile` TextEntry at the top.

Write 5-7 lines that function as an "elevator pitch": a concise, compelling introduction
explaining why you're qualified for *this specific role*. Focus on what the employer gains.

**Create 2-3 profile statement templates for your main role types:**

<!-- SETUP: These are populated based on your background -->
**For [YOUR_PRIMARY_ROLE_TYPE] roles:**
> [YOUR_PROFILE_STATEMENT_TEMPLATE_1]

**For [YOUR_SECONDARY_ROLE_TYPE] roles:**
> [YOUR_PROFILE_STATEMENT_TEMPLATE_2]

### Core Competencies / Skills Section (Best Practice)
Reorder and emphasize based on the role. Each is a OneLineEntry with a bold `label` and
`details`. List **5-7 key competencies**, tailored to the specific job.

### Education
- Always include your highest degrees
- For senior roles, keep education brief (dates and titles only)
- Include thesis topics (in `highlights`) when relevant to the target role

### Professional Experience
- Rewrite `highlights` to emphasize aspects most relevant to the target role
- Use 4-6 highlights for the most recent role, 3-4 for previous, 2-3 for older
- **Emphasize measurable results**: "Reduced processing time by X%", "Model adopted by the team"

### Handling Employment Gaps (Best Practice)
If there is a gap in your employment history:
- Explain it matter-of-factly if needed
- Describe how professional development continued during the gap
- Frame as deliberate skill-building and career repositioning

### Publications
- Include a DOI or `url` if applicable
- Select 3-4 most relevant publications (not always all of them)
- For non-academic roles, keep brief

### Honors and Awards
- Keep format brief, one line each (a NormalEntry `name`)

### References
- List 2-4 references with name, title, company, and contact, or "Available upon request."
- **Do not attach reference letters** — employers typically contact references directly

## Render-and-Inspect Loop (MANDATORY)

After writing the CV and before presenting to the user, always render and visually inspect
the PDF. Iterate until the layout is clean. Workflow:

1. Run `.venv/bin/rendercv render cv/main_<company>.yaml -nomd -nohtml -nopng`
2. Read `cv/rendercv_output/<name>_CV.pdf` via the Read tool — it reports the page count, which must be **1 or 2**
3. Visually inspect every page of the PDF
4. Check that the content ends cleanly — no nearly-empty final page, no single orphaned
   section stranded on a third page

### Fixing page-count problems

RenderCV controls layout from content and the `design` block — there are no manual
page-break commands to babysit. So:

- **3+ pages:** cut content using relevance-weighted cutting (below). Do not shrink the
  font or margins to force-fit.
- **Trailing content barely spills onto a 3rd page:** trim one or two low-relevance
  highlights first. As a last resort you may tighten spacing via `design.sections`
  (e.g. `space_between_regular_entries`) or `design.page` margins — but prefer cutting.
- **CV ends very early on page 2 (feels thin):** restore the highest-relevance item that
  was previously cut.

## Page Budget — 1-2 page target

The CV should fit on **1 or 2 pages**. Use these content limits as a guide:

| Section | Max budget |
|---------|-----------|
| Profile statement | 3-4 lines |
| Skills | 5 items, each 1-2 lines |
| Most recent role | 4-5 highlights |
| Previous role | 2-3 highlights |
| Older roles | 2 highlights (1 line each) |
| Education | 2-3 entries |
| Publications | 2-3 entries |
| Awards | 3 entries, single line each |
| References | "Available upon request." (single line) |

**If in doubt, cut rather than squeeze.** Reducing spacing to force-fit content makes the
CV look cramped.

## Relevance-weighted cutting (the right way to shrink a CV)

**Cut by signal, not by section.** Static priority lists ("remove oldest education first,
then shorten the earliest role...") are wrong when a relevant "lower-priority" item is
competing with an irrelevant "higher-priority" item. An older-role highlight that speaks
directly to the posting is worth more than a recent-role highlight that does not.

For every candidate line, score three things:

1. **Relevance to THIS posting** — does the line hit a named tool, keyword, or stated
   responsibility in the job ad?
2. **Uniqueness** — is it the only place this claim appears, or is it duplicated?
3. **Narrative load** — does the cover letter depend on it? If cutting the line would
   force you to rewrite a cover-letter paragraph, it is load-bearing.

Cut the lowest-total-score line first, regardless of which section it sits in.

### Practical order of cuts (easiest → last resort)

1. **Redundancy.** If an achievement appears in both Core Competencies AND a role
   highlight, the Core Competencies version is usually the cleaner cut.
2. **Profile-statement fluff.** A sentence that just restates what Publications or Skills
   will show.
3. **Low-relevance experience highlights.** A highlight about work that does not touch
   posting keywords, wherever it sits.
4. **Low-relevance supporting content.** An older-role highlight that does not speak to
   the target role; a certification that does not touch the posting's stack; a language
   entry that can be condensed.
5. **Low-relevance publications.** Keep 1-2 that best match the posting; cut the rest
   before touching experience highlights.
6. **Last-resort structural cuts.** Oldest education entry, tightening an older role to 2
   highlights, collapsing certifications into a single line.

### Pitfalls to avoid

- Do not mechanically cut from the bottom of a static section list without checking
  relevance. "Cut the oldest role first" is wrong if that role is literally about the
  skill the posting asks for.
- Do not cut the one concrete example the cover letter leans on. Relevance is measured
  against the cover letter you wrote, not just the job posting.
- Do not cut to fit if it is a borderline near-miss — trim a highlight or nudge
  `design` spacing before sacrificing a whole entry.

## Recommended Section Order

The section order (the order of keys under `cv.sections`) varies by role type:

**For technical / data science / ML roles:**
1. Profile statement / elevator pitch
2. Core competencies / Skills
3. Professional Experience (reverse chronological)
4. Education (reverse chronological)
5. Languages
6. Publications & Awards
7. References

**For domain-specific / specialist roles:**
1. Profile statement / elevator pitch
2. Core competencies / Skills
3. Education (reverse chronological) — credentials are a key qualifier
4. Professional Experience (reverse chronological)
5. Publications & Awards
6. References
