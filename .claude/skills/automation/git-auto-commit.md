---
name: Git Auto Commit
description: Automatically stages, commits, and pushes LaTeX document changes to the remote repository after successful compilation and verification.
---

# Git Auto Commit

This skill handles automated version control management for the thesis and paper directory. It streamlines staging, committing, and pushing changes after LaTeX compilation and verification are complete.

## Execution Steps

Once the LaTeX documents compile successfully without errors or unresolved references, follow these steps:

### Step 1: Stage Changes

1. Run `git status` to verify modified, deleted, and untracked files
2. Stage all relevant changes (source files, figures, and compiled PDFs):
   ```bash
   git add main.tex references.bib NTUST/sections/ NTUST/my_bib.bib NTUST/my_ntust_thesis.tex figures/ build/main.pdf NTUST/build/my_ntust_thesis.pdf
   ```
3. Avoid staging compilation temporary files (.aux, .log, .out, etc.)

### Step 2: Commit Changes

1. Write a concise semantic commit message using the format: `<type>(<scope>): <description>`
   - **Types:** `feat`, `fix`, `docs`, `style`, `refactor`
   - **Scope:** Target area (e.g., `evaluation`, `introduction`, `figures`)
   - **Description:** Clear, lowercase summary of changes
   
   **Examples:**
   - `feat(evaluation): add scenario 4 results with multi-switch topology`
   - `fix(thesis): correct subfigure labels for experiments 5 and 6`
   - `docs(introduction): improve clarity on nFAPI timing constraints`

2. Commit using:
   ```bash
   git commit -m "<commit_message>"
   ```

### Step 3: Push to Remote

1. Push to the active branch:
   ```bash
   git --no-pager push
   ```

### Important: Authentication Handling

- **Background Push Warning**: If `git push` is run in the background, it may hang if credentials are required (SSH passphrase, GitHub token, MFA)
- **Recommended approach**: Run `git push` synchronously in the foreground to ensure interactive authentication prompts are visible
- **If credentials hang**: Check task status first; if authentication prompts appear, terminate the task and ask the user to push manually
- **Success indicator**: Push completes without "FAILURE" or hanging messages in the task log
