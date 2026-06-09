# Setup Guide

Step-by-step instructions for getting the AI Job Search framework running.

## 1. Prerequisites

### Claude Code

Install Claude Code (Anthropic's CLI for Claude):

```bash
npm install -g @anthropic-ai/claude-code
```

You'll need an Anthropic API key or a Claude Pro/Team subscription. See the [Claude Code docs](https://docs.anthropic.com/en/docs/claude-code) for details.

### Python

Python 3.10+ is required for the salary lookup tool. Check with:

```bash
python --version
```

### Bun (for job search tools)

The Danish job portal CLIs are written in TypeScript and run with Bun:

```bash
curl -fsSL https://bun.sh/install | bash
```

### uv (for RenderCV & Typst)

Document rendering uses [RenderCV](https://docs.rendercv.com/) for CVs and [Typst](https://typst.app/) for cover letters, installed into a project virtual environment with [uv](https://docs.astral.sh/uv/):

```bash
# Install uv (if you don't have it)
curl -LsSf https://astral.sh/uv/install.sh | sh

# From the repo root: create the venv and install the toolchain
uv venv
uv pip install "rendercv[full]" typst
```

This installs `rendercv` (which bundles its own Typst for CV rendering) and the `typst` Python package used by `cover_letters/render.py` for cover letters. No system LaTeX distribution is required. The classic CV theme and the cover letter both use Source Sans 3, which is bundled in `cover_letters/fonts/`.

## 2. Fork and clone

```bash
gh repo fork MadsLorentzen/ai-job-search --clone
cd ai-job-search
```

Or manually: fork on GitHub, then clone your fork.

## 3. Install job search CLI dependencies

```bash
for tool in jobbank-search jobdanmark-search jobindex-search jobnet-search; do
  cd .agents/skills/$tool/cli && bun install && cd ../../../..
done
```

## 4. Run the setup interview

Start Claude Code in the repository:

```bash
claude
```

Then run the onboarding:

```
/setup
```

Claude will offer two paths:

- **Path A (recommended):** Share your existing CV (mention the file with `@` or paste the text). Claude extracts your information and asks follow-up questions for anything missing.
- **Path B:** Answer structured interview questions section by section.

Both paths produce the same result: fully populated profile files.

> **Already have a RenderCV YAML?** Drop it in `documents/cv/` (or `@`-mention it) and Claude will use it verbatim as your master `cv/main_example.yaml`, in addition to extracting your profile data from it.

### What gets populated

| File | Content |
|------|---------|
| `CLAUDE.md` | Your full candidate profile |
| `01-candidate-profile.md` | Structured education, experience, skills |
| `02-behavioral-profile.md` | Behavioral assessment |
| `04-job-evaluation.md` | Personalized skill match areas and career goals |
| `05-cv-templates.md` | Profile statement templates for your background |
| `07-interview-prep.md` | STAR examples from your experience |
| `cv/main_example.yaml` | Your master RenderCV CV with actual details |
| `search-queries.md` | Job search queries for `/scrape` |

### Re-running setup

You can update specific sections later:

```
/setup --section skills
/setup --section experience
/setup --section search
```

The `--section search` option is especially useful as your priorities evolve. It re-runs the search configuration interview and suggests role types you may not have considered based on your full profile.

## 5. Optional: Set up salary benchmarking

If you have salary data (from a union, salary survey, Glassdoor, or personal research):

1. **Option A:** Create `salary_data.json` manually in the repo root (see `tools/README_SALARY_TOOL.md` for the format)
2. **Option B:** Convert from Excel:
   ```bash
   pip install openpyxl
   python tools/convert_salary_excel.py path/to/salary-data.xlsx --source "My Salary Data 2025"
   ```

This creates `salary_data.json` which the `/apply` workflow uses for salary benchmarking. If you skip this step, salary lookup is simply omitted.

## 6. Test the workflow

Find a job posting you're interested in, then:

```
/apply https://jobindex.dk/job/1234567
```

Or paste the job description directly:

```
/apply [paste job posting text here]
```

Claude will:
1. Evaluate the fit against your profile
2. Ask if you want to proceed
3. Draft a tailored CV and cover letter
4. Have a reviewer agent critique the drafts
5. Revise and present the final output

## 7. Render your documents

`/apply` renders the documents for you, but you can also render manually after editing. Run from the repo root inside the project venv:

```bash
# Render CV (PDF written to cv/rendercv_output/)
.venv/bin/rendercv render cv/main_<company>.yaml -nomd -nohtml -nopng

# Render cover letter (PDF written next to the .typ)
.venv/bin/python cover_letters/render.py cover_letters/cover_<company>_<role>.typ
```

## Troubleshooting

### "salary_data.json not found"
This is expected if you haven't set up salary benchmarking. The `/apply` workflow skips this step automatically.

### Job search CLI tools not working
Make sure Bun is installed and you ran `bun install` in each CLI directory. The tools require network access to fetch job listings.

### Rendering errors
- **`rendercv: command not found`** — activate or reference the venv: run `.venv/bin/rendercv ...`, or `source .venv/bin/activate` first. Re-run `uv pip install "rendercv[full]" typst` if the venv is missing.
- **CV YAML validation error** — RenderCV validates the YAML (e.g. phone numbers must be valid international format). The error message names the offending field; fix it and re-render.
- **Cover letter font looks wrong** — `cover_letters/render.py` supplies the bundled Source Sans 3 from `cover_letters/fonts/`. Make sure that directory still contains the `SourceSans3-*.ttf` files.
