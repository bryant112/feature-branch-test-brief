# Feature Branch Test Brief

Reusable Codex skill for generating concise feature-branch testing briefs with:

- `Status Overview`
- `Testing Targets`
- `TODONE`
- `TODO`
- `TODONTS`
- `TOCANTS`
- `Feedback Prompts`

The skill also includes shell and PowerShell helpers for rendering an HTML brief to PDF with Chrome, Chromium, or Edge.

## Files

- `SKILL.md`
- `agents/openai.yaml`
- `references/brief-template.md`
- `scripts/render-html-to-pdf.sh`
- `scripts/render-html-to-pdf.ps1`

## Typical Use

- `use $feature-branch-test-brief`
- `make a feature branch testing brief PDF`
- `give me a testing target list with TODONE/TODO/TODONTS/TOCANTS`

## Dev Toolbar

- Run common workflows from terminal:
  - `./scripts/dev-toolbar.sh start`
  - `./scripts/dev-toolbar.sh build`
  - `./scripts/dev-toolbar.sh test`
  - `./scripts/dev-toolbar.sh lint`
  - `./scripts/dev-toolbar.sh deploy` (safe stub)
  - `./scripts/dev-toolbar.sh git-pull`
  - `./scripts/dev-toolbar.sh git-push`
- VS Code task labels use the same command set: `dev:*` and `git:*`.
