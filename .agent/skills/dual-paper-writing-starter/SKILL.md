---
name: Dual Paper Writing Starter
description: A comprehensive entry-point skill for drafting new concepts into both the short IEEE paper and the detailed NTUST master's thesis concurrently. It integrates all related writing skills, handles context-aware drafting for both versions, and manages bibliography additions and citations.
---

# Dual Paper Writing Starter (雙版本論文同步撰寫起手式)

This skill serves as the central entry point when you have a new idea, inspiration, or experimental result that needs to be incorporated into both your IEEE conference paper and your NTUST Master's thesis simultaneously. 

By invoking this skill, you inform the LLM of all your established writing standards and set the stage for context-aware drafting across both documents.

## 🔗 Integrated Skills (關聯技能矩陣)
Before drafting, the Agent will automatically consider the guidelines from the following skills:
- **Core Idea Alignment:** @[/thesis-idea-database] (Ensure alignment with the author's true intent and tone)
- **Drafting & Research Support:** @[/content-research-writer]
- **Quality & Style Assurance:** @[/Technical Writing Checklist]
- **Overall Writing Strategy:** @[/Paper and Thesis Writing Guide]
- **IEEE Formatting Standards:** @[/IEEE Academic Paper Template]
- **Advisor's Strict Rules:** @[/Advisor Paper Guidelines]
- **Vocabulary Level Control:** @[/Vocabulary Level Guide] (Ensures simple, junior high school level English)
- **Writing Process Flow:** @[/Academic Paper Writing Workflow]
- **Git Automation:** @[/git-auto-commit] (Automatically stages, commits, and pushes changes after validation)

## 🎯 Target Documents (目標文件)
You are maintaining two concurrent versions of your research:
1. **Short Version (IEEE Format):** `@[main.tex]`
   - Requires concise, direct writing adhering to strict page limits.
2. **Detailed Version (NTUST Thesis):** `@[NTUST/my_ntust_thesis.tex]` and `@[NTUST/sections]`
   - Requires comprehensive background, detailed derivations, extensive figures/tables, and full references.

## ⚠️ Style Guardrails (寫作風格防錯防線)
To ensure compliance with IEEE and NTUST thesis writing standards:
- **No Double Quotes on General Technical Nouns**: Never enclose standard technical terms, names of mechanisms, or parameters (e.g., "Functional Split Options", "slots ahead", "Adaptive Slots Ahead Control Mechanism") in double quotes ("..."). This is a common error that makes them look like direct quotes or irony/sarcasm.
  - *Correct*: Use them as normal nouns/noun phrases (e.g., functional split options, slots ahead parameter, Adaptive Slots Ahead Control Mechanism) without quotes.
  - *Exceptions*: If you must define a brand new term or specifically call attention to a configuration variable, use italics (e.g., `\textit{slots ahead}`) or parentheses. Never use double quotes for general description or emphasis.

## ⚙️ Standard Workflow (執行流程)

When you provide a new concept to this skill, the Agent will execute the following steps:

### Step 1: Concept & Context Analysis (概念與上下文理解)
- Cross-reference the new concept with `@[/thesis-idea-database]`.
- Analyze the current context of both `@[main.tex]` and the relevant section in `@[NTUST/sections]` to determine the optimal insertion point and narrative flow.

### Step 2: Reference Management (文獻與引用管理)
- Format any provided source materials or links into proper BibTeX entries.
- Add these new entries to the shared bibliography (`.bib`) file(s).
- Keep track of the citation keys to be used in the following drafting steps.

### Step 3: Drafting the Detailed Version (撰寫 NTUST 碩論詳細版)
- Write a comprehensive explanation of the concept tailored for `@[NTUST/sections]`.
- Include necessary background information, step-by-step logic, and detailed observations.
- Suggest or describe where figures/tables should be added to support the text.
- Insert the appropriate citations from Step 2.
- **Strictly adhere to:** @[/Paper and Thesis Writing Guide] and @[/Advisor Paper Guidelines].

### Step 4: Drafting the Short Version (撰寫 IEEE 精簡版)
- Distill the detailed draft into its core contribution, key methodology, and primary results.
- Write a concise, impactful paragraph tailored for `@[main.tex]`.
- Insert the appropriate citations from Step 2.
- **Strictly adhere to:** @[/IEEE Academic Paper Template] and @[/Technical Writing Checklist] (focusing on Clarity, Conciseness, and Objectivity).

### Step 5: Verification & Iterative Correction (驗證與迭代修復)
- Run `latexmk -xelatex -output-directory=build my_ntust_thesis.tex` and `latexmk -pdf main.tex` to verify the build of both documents.
- Analyze the build log for any syntax errors (e.g., missing `$`, `{`, `}`), undefined citations, or missing references.
- Proactively fix all identified issues in the respective `.tex` or `.bib` files.
- Repeat the build and correction cycle until both documents compile successfully without critical errors or undefined references.

### Step 6: Git Version Control Automation (Git 提交與推送自動化)
- Run the `Git Auto Commit` skill to automatically stage, commit, and push the verified changes to the remote repository.

## 🚀 How to Use (使用方式)
When you have a new inspiration, simply prompt the Agent like this:

> **/dual-paper-writing-starter**
> 
> **Concept/Idea:** [Describe your new idea, experimental observation, or concept]
> **Target Section:** [e.g., Introduction, Proposed Method, Results]
> **References:** [Provide links, DOIs, or PDF titles to be cited]
> 
> Please process this concept, add the references to the bib file, and draft the respective paragraphs for both my IEEE paper and my NTUST thesis.
