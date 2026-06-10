---
name: Dual Paper Writing Starter
description: A comprehensive entry-point skill for drafting new concepts into both the short IEEE paper and the detailed NTUST master's thesis concurrently. It integrates all related writing skills, handles context-aware drafting for both versions, and manages bibliography additions and citations.
---

# Dual Paper Writing Starter

This skill serves as the central orchestration point for integrating new ideas, experimental findings, or methodological insights into both your IEEE conference paper and NTUST Master's thesis concurrently.

Use this skill to ensure consistency, proper attribution, and alignment between two versions of your research while maintaining distinct writing styles and depth levels appropriate to each format.

## Integrated Skills Reference

The workflow below automatically applies guidance from all related writing skills:

- **Thesis Idea Database** — Validates alignment with your original intent, tone, and reasoning
- **Content Research Writer** — Provides structure and research integration strategies
- **Technical Writing Checklist** — Ensures quality and clarity at every stage
- **Paper and Thesis Writing Guide** — Applies comprehensive section-by-section standards
- **IEEE Academic Paper Template** — Enforces IEEE formatting and page constraints
- **Advisor Paper Guidelines** — Incorporates advisor's strict academic and structural rules
- **Vocabulary Level Guide** — Maintains "junior high school" level simple English throughout
- **Academic Paper Writing Workflow** — Guides systematic multi-version drafting
- **Git Auto Commit** — Automates final staging, committing, and pushing of verified changes

## Target Documents

You maintain two concurrent versions of your research work:

### 1. Short Version (IEEE Conference Paper)
- **Location:** `main.tex`
- **Audience:** International computer science conference reviewers
- **Constraints:** 6–8 pages, strict formatting, concise technical presentation
- **Content:** Essential problem, proposed method, core results, key conclusions
- **Writing style:** Direct, concise, quantitative, formal academic tone

### 2. Detailed Version (NTUST Master's Thesis)
- **Location:** `NTUST/my_ntust_thesis.tex` and `NTUST/sections/`
- **Audience:** Academic committee, thesis examiners, future researchers
- **Format:** Comprehensive thesis structure with extended background, full derivations, extensive figures/tables
- **Content:** Complete narrative, detailed methodology, comprehensive results, future research directions
- **Writing style:** Thorough explanation, pedagogical clarity, detailed context

## Critical Style Rules

### Quotation Mark Usage
Never enclose standard technical terms, mechanism names, or parameter references in double quotes. This common error makes them appear as direct citations or ironic asides.

**Correct examples:**
- "The scheduler adapts the slots ahead dynamically."
- "Delay management ensures timely message delivery."
- "Node sync aligns state across distributed components."

**Incorrect examples:**
- ❌ "The scheduler adapts the 'slots ahead' dynamically."
- ❌ "''Delay management'' ensures timely message delivery."

**Exceptions:** Use italics or code formatting only when introducing brand-new terminology or marking configuration variables:
- `\textit{slots ahead}` — When formally defining a new term
- `\texttt{slot.indication}` — For protocol-level message names

### Unified Terminology Requirements
Strict consistency across all documents:
- **slots ahead** (never: slots-ahead, slotsahead, slot ahead, slot-ahead)
- **proposed method** (never: proposed controller, adaptive controller, slots-ahead controller)
- **delay management** (never: delay-management, delay management mechanism) — exception: only when citing SCF standards directly
- **node sync** (never: node-sync, Node sync)

## Standard Workflow

When you invoke this skill with a new concept, the execution follows these steps:

### Step 1: Concept and Context Analysis
1. Cross-reference the new concept with the thesis idea database
2. Review current context in `main.tex` (IEEE version) to assess page pressure and narrative position
3. Review relevant sections in `NTUST/sections/` to identify optimal insertion point
4. Determine narrative flow: does this concept fit in introduction, methodology, results, or discussion?
5. Identify prerequisite background that may already exist or needs introduction

### Step 2: Reference Management
1. Format any provided sources (links, DOIs, PDFs, papers) into proper BibTeX entries
2. Add entries to appropriate `.bib` files (typically `references.bib` for IEEE, `NTUST/my_bib.bib` for thesis)
3. Create citation keys following pattern: `Author_Year_Topic` (e.g., `Smith_2022_EdgeComputing`)
4. Document citation keys for use in drafting steps

### Step 3: Drafting the Detailed Version (NTUST Thesis)
1. Write a comprehensive explanation tailored for the thesis audience
2. Include necessary background, step-by-step logic, and detailed observations
3. Use clear hierarchical structure (sections, subsections, paragraphs)
4. Suggest specific locations for figures, tables, or equations with brief descriptions
5. Insert citations using `\cite{key}` format
6. Maintain "junior high school" vocabulary level per advisor guidelines
7. Cross-reference adjacent sections where appropriate

### Step 4: Drafting the Short Version (IEEE Conference Paper)
1. Distill the detailed draft to its essential core: problem, method, key results
2. Remove tangential explanations, detailed derivations, and background
3. Write a concise paragraph or section that fits page constraints
4. Use quantitative results and specific technical contributions
5. Insert citations using same keys as detailed version
6. Maintain formal, academic tone appropriate to international audience
7. Verify page count constraints are not violated

### Step 5: Verification and Error Correction
1. Compile both documents:
   ```bash
   latexmk main.tex
   latexmk -output-directory=build NTUST/my_ntust_thesis.tex
   ```
2. Analyze compilation logs for:
   - Undefined citations (e.g., `\cite{key}` with no matching `.bib` entry)
   - Unresolved references (displayed as `[?]`)
   - LaTeX syntax errors (missing `$`, unmatched braces, etc.)
3. Fix identified issues immediately in the `.tex` or `.bib` files
4. Recompile until both documents produce PDF outputs without errors
5. Spot-check PDF output: verify figures display, references resolve, formatting is clean

### Step 6: Version Control and Archival
1. Review all changes: `git status`, `git diff main.tex NTUST/sections/`
2. Verify terminology consistency using grep:
   ```bash
   grep -rn "slots.ahead\|timing.info\|delay.management" NTUST/sections/ main.tex
   ```
3. Stage all relevant files (sections, figures, compiled PDFs)
4. Create semantic commit message (see `/git-auto-commit` skill for format rules)
5. Commit and push to remote repository

## How to Invoke This Skill

When you have a new idea or experimental finding ready to integrate:

```
/dual-paper-writing-starter

**Concept/Idea:** [Describe your new idea, experimental observation, or methodology insight]

**Target Section:** [Specify where this fits: Introduction, Method, Results, Discussion, etc.]

**References:** [Provide links, DOI URLs, or paper titles to be added to bibliography]

**Additional Context:** [Any specific requirements, constraints, or connections to other sections]
```

## Example Usage

```
/dual-paper-writing-starter

**Concept/Idea:** An EWMA-based jitter estimation algorithm that adapts the scheduling lead time based on observed timing information. Preliminary experiments show a 12% improvement in throughput with only a 3% increase in HARQ RTT.

**Target Section:** Method section (describing the algorithm), and Results section (presenting the EWMA adaptation performance)

**References:** 
- RFC 3550 (RTP jitter calculations)
- nFAPI specification P7 timing requirements
- O-RAN Working Group 2 technical documentation on timing feedback

**Additional Context:** This builds on our baseline method. The improvement is specifically relevant to our contribution claim about adaptive timing control.
```
