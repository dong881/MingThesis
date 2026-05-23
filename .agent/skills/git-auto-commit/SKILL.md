---
name: Git Auto Commit
description: Automatically stages, commits, and pushes LaTeX document changes to the remote repository after successful compilation and verification.
---

# Git Auto Commit (自動 Git 提交與推送)

This skill handles automated version control management for the thesis and paper directory. It runs after verification steps to save, commit, and push modifications in one step.

## ⚙️ Execution Steps (執行步驟)

Once the LaTeX documents compile successfully without errors or unresolved references, follow these steps to commit and push changes:

### Step 1: Stage Changes (暫存變更)
- Run `git status` to verify modified, deleted, and untracked files.
- Stage the changed TeX, bib, figures, source files, and the compiled PDF outputs using:
  ```bash
  git add main.tex references.bib NTUST/sections/ NTUST/my_bib.bib NTUST/my_ntust_thesis.tex figures/ build/main.pdf NTUST/build/my_ntust_thesis.pdf
  ```
  *(Avoid adding other compilation temporary files, but always include the compiled PDF files)*

### Step 2: Commit Changes (提交變更)
- Generate a concise commit message summarizing the changes (e.g., "feat(evaluation): update scenario 3 figures and text description").
- Commit the staged changes using:
  ```bash
  git commit -m "<commit_message>"
  ```

### Step 3: Push to Remote (推送至遠端)
- Push the committed changes to the active branch on the remote repository:
  ```bash
  git push
  ```
