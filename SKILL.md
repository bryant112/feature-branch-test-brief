---
name: feature-branch-test-brief
description: Create concise testing briefs, manual QA checklists, status handoffs, and printable PDF one-pagers for feature branches or sprint slices across projects. Use when the user asks for a testing target list, branch test plan, QA cheat sheet, test handoff, status overview, TODO/TODONTS/TODONE/TOCANTS summary, feedback prompts, or a printable PDF/checklist for manual testing.
---

# Feature Branch Test Brief

Create a short, operator-friendly testing brief for the current project or feature branch.

## Workflow

1. Inspect the current project state before drafting anything.
2. Summarize the feature slice in plain language.
3. Create a brief that is easy to use during live testing.
4. Prefer writing the brief into the target project's `docs/` folder.
5. Produce both:
   - a Markdown source file
   - a printable HTML file
6. When the user asks for a PDF, render the HTML to PDF with `scripts/render-html-to-pdf.ps1`.

## Required Sections

Keep the brief concise. Default to one page when practical.

Include these sections in this order unless the user asks otherwise:

1. `Status Overview`
2. `Testing Targets`
3. `TODONE`
4. `TODO`
5. `TODONTS`
6. `TOCANTS`
7. `Feedback Prompts`

## Content Rules

- Write for active manual testing, not executive reporting.
- Favor checklists and short bullets over long paragraphs.
- Call out feature combinations or toggles when they matter.
- Mention assumptions or uncertain areas explicitly.
- Distinguish clearly between:
  - already working
  - next work
  - known bad ideas
  - current limitations
- If the branch includes dev flags or test toggles, add a short `Feature Combo` note under `Testing Targets`.
- If the user plans to handwrite notes, leave room for short handwritten annotations in the HTML/PDF layout.

## File Naming

Prefer names like:

- `docs/09_feature_branch_testing_brief.md`
- `docs/09_feature_branch_testing_brief.html`
- `docs/09_feature_branch_testing_brief.pdf`

Adjust numbering to match the project's existing docs convention.

## PDF Rendering

Use `scripts/render-html-to-pdf.ps1` with:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-root>\scripts\render-html-to-pdf.ps1 -HtmlPath <html-file> -PdfPath <pdf-file>
```

The script will auto-detect Edge or Chrome.

## Reference

Read `references/brief-template.md` when you need the exact section pattern or want sample prompt wording for feedback capture.
