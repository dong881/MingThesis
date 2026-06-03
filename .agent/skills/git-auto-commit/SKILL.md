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
  git --no-pager push
  ```

- **⚠️ HANG / PENDING WARNING (背景推送防卡機制)**:
  - Because `git push` in the background shell may require authentication credentials (such as username, password, SSH passphrase, or MFA token), it can hang indefinitely or stay in `tasks pending` status.
  - **Optimized Action Rule**: 
    1. Always run `git push` with a high synchronous wait time (e.g., `WaitMsBeforeAsync: 10000` / 10 seconds) to allow it to finish synchronously if credentials are cached.
    2. If it is sent to the background, check the task log status using the `manage_task` tool first.
    3. If the log shows standard authentication prompts (such as `Username for 'https://github.com'`, `Password for`, or `Enter passphrase for key`), terminate/kill the task immediately using `manage_task` and ask the user to push manually.
    4. If the log does not contain credentials prompts and is just processing the upload, allow it to complete or wait up to 15 seconds before killing.
