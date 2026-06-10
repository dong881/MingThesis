# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

This is a **thesis repository** on adaptive timing control for nFAPI-based 5G RAN functional split architectures. The thesis proposes dynamic scheduling algorithms to adapt to variable network latency and jitter in O-RAN split deployments. The repository is synchronized with Overleaf and managed through GitHub Actions.

**Thesis Title:** "Adaptive Timing Control for Throughput–Latency Trade-off in nFAPI Split"

**Primary Document:** IEEE conference paper format (`main.tex`)
**Thesis Format:** NTUST thesis template (`NTUST/my_ntust_thesis.tex`)

---

## Build & Compilation

### Building the Thesis

```bash
# Compile IEEE conference paper (outputs to build/main.pdf)
latexmk -synctex=1 -interaction=nonstopmode -file-line-error main.tex

# Or use the configured latexmkrc (default output directory: build/)
latexmk main.tex

# Clean build artifacts
latexmk -c main.tex

# Full clean (removes PDF)
latexmk -C main.tex
```

**Configuration:**
- LaTeX config: `.latexmkrc` (sets output directory to `build/`)
- VSCode LaTeX Workshop configured in `.vscode/settings.json`
- Build output: `build/main.pdf` (IEEE paper) and `NTUST/build/my_ntust_thesis.pdf` (NTUST version)

### Monitoring Compilation

- **Unresolved references:** Always check for `[?]` citations or cross-references after compilation
- **Overfull hboxes:** Watch for warnings about line overflow — may indicate figures or tables exceed margins
- **Missing packages:** The build will fail if required LaTeX packages are missing

---

## Repository Structure

### Main Files

| File | Purpose |
|------|---------|
| `main.tex` | IEEE conference paper (primary submission format) |
| `references.bib` | BibTeX bibliography database |
| `NTUST/my_ntust_thesis.tex` | National Taiwan University thesis template version |
| `NTUST/sections/` | Modular thesis content (see below) |
| `figures/` | Experiment results, diagrams, and visualizations |
| `build/` | Compiled PDF outputs (git-tracked) |
| `source/` | Research papers and reference materials |
| `.github/workflows/sync-overleaf.yml` | GitHub Actions for Overleaf sync (1-hour poll) |

### Thesis Sections

Files in `NTUST/sections/` (included in both `main.tex` and `NTUST/my_ntust_thesis.tex`):

- **`introduction.tex`** — Background, motivation, related works, and contributions
- **`system.tex`** — System model, assumptions, problem definition (nFAPI Split Option 6 architecture)
- **`method.tex`** — Proposed adaptive timing control algorithm and EWMA-based feedback mechanism
- **`experiment.tex`** — Evaluation scenarios, experimental setup (OpenAirInterface testbed, O-RU, COTS UE), results with multiple deployment topologies
- **`conclusion.tex`** — Summary, findings, and future research directions

### Supporting Files

- **`term_consistency_table.md`** — Mandatory terminology standards for this thesis (see below)
- **`.agent/skills/`** — Custom writing guides and workflows for thesis composition
- **`sop/`** — Standard operating procedures for writing and submission

---

## Terminology Consistency (MANDATORY)

This thesis enforces strict terminology to ensure clarity and consistency. **Before committing ANY changes**, verify these terms match the preferred forms:

| Preferred Term | Avoid | Context |
|---|---|---|
| **slots ahead** | slots-ahead, slotsahead, slot ahead | Lowercase. "The scheduler adapts slots ahead to handle jitter." |
| **Timing Info** | timing-info, timing info (in text) | Title case in headings; lowercase in running text: "timing info feedback" |
| **delay management** | delay-management, Delay management | Lowercase, no hyphen. "Effective delay management is critical." |
| **node sync** | node-sync, Node sync | Lowercase, no hyphen. "Periodic node sync ensures state alignment." |
| **excess allocation** | over-provisions, over-provisioning | For resource over-allocation scenarios |
| **insufficient allocation** | under-provisions, under-provisioning | For resource under-allocation scenarios |

**Enforcement:**
- Before finalizing any section, grep for common violations: `grep -i "slots.ahead\|timing.info\|delay.management" NTUST/sections/*.tex`
- The term table is the source of truth — update it when new terminology is introduced

---

## Domain Context: nFAPI & Functional Split

### Key Concepts

**nFAPI Split Option 6:**
- Separates MAC scheduler (centralized) from High-PHY (distributed RU)
- Scheduler sends control messages over packet-switched fronthaul/midhaul
- Messages must arrive within a strict timing window (deadline)
- Late arrivals cause missing-slot events and throughput degradation

**Problem Being Solved:**
- Static "slots ahead" (scheduling lead time) creates throughput-latency trade-off
- Variable network delay and jitter violate strict timing constraints
- HARQ RTT increases unnecessarily with larger static lead times

**Proposed Solution:**
- Adaptive timing control using PNF Timing Info feedback
- EWMA-based jitter estimation and dynamic offset adjustment
- Evaluated on OpenAirInterface testbed with O-RU and COTS UE

### Key Files to Understand

- **`NTUST/sections/system.tex`** — Contains the nFAPI architectural model and timing constraints
- **`NTUST/sections/method.tex`** — Describes the adaptive algorithm (EWMA filter, adjustment rules)
- **`NTUST/sections/experiment.tex`** — Details experimental scenarios (Scenario I–VI) and topologies (single/multi-hop, multi-switch)

---

## Experimental Structure

The evaluation uses **6 experimental scenarios** with 3 main topologies:

1. **Scenario I (Baseline):** Single router, no delay/jitter injection
2. **Scenarios II–III:** Variable delay injection (Scenario II vs Scenario III = different delay profiles)
3. **Scenarios IV–VI:** Multi-switch/router deployments with realistic delay characteristics

**Key Metrics:**
- **Throughput:** Resource block utilization and data rate
- **Latency:** MAC HARQ RTT
- **Robustness:** Performance under injected delay and jitter

**Result Format:**
- Figures in `figures/` directory
- Subfigures for each scenario comparison
- X-axis: Parameter variation (e.g., delay, offset value)
- Y-axis: Measured metric (throughput, latency)

---

## Writing & Revision Workflow

### Using Custom Agent Skills

This repository includes agent skills (in `.agent/skills/`) that provide guidance on:

- **`paper-thesis-writing-guide/`** — Comprehensive structure and quality checklist for thesis sections
- **`academic-paper-workflow/`** — Step-by-step process for contributions, results planning, and revision responses
- **`git-auto-commit/`** — Automated staging and pushing after successful compilation

**When writing or revising:**
1. Refer to `paper-thesis-writing-guide` for section requirements and quality standards
2. Ensure each contribution in Introduction is validated by an experimental scenario
3. Follow the multi-pass editing strategy (structure → punctuation → word choice)
4. Use the terminology table before every commit

### Common Revision Tasks

**Adding a New Experiment:**
1. Design scenario (define constants, variables, metrics)
2. Create figure with proper labels and caption (X-axis, Y-axis with units)
3. Add interpretation in `experiment.tex` (how results support contribution)
4. Update experiment overview table if applicable

**Updating Figures:**
- Figures live in `figures/` directory
- Always include descriptive captions with units and parameter values
- Reference figures in text: "Figure X shows..." or "As illustrated in Figure X,..."
- Check subfigure labels match scenario names

**Fixing Terminology Issues:**
- Search for problematic variants: `grep -rn "slots.ahead\|timing.info" NTUST/sections/ figures/`
- Update both the LaTeX and image captions (if embedded text)
- Verify in term_consistency_table.md before committing

### Submission Checklist

Before pushing changes:

- [ ] LaTeX compiles without errors or unresolved references
- [ ] All figures have descriptive captions with parameter values and units
- [ ] All figure references are in the text (e.g., "Figure 1 shows...")
- [ ] Contribution claims are validated by experimental results
- [ ] Terminology matches the consistency table (especially slots ahead, Timing Info, delay management)
- [ ] Git status shows only intended changes (check `.gitignore`)

---

## Git Workflow & Overleaf Sync

### Commit Conventions

Use semantic commit messages:

```bash
git add NTUST/sections/experiment.tex figures/ build/main.pdf

# Examples:
git commit -m "feat(evaluation): add Scenario IV results with multi-switch topology"
git commit -m "fix(thesis): correct subfigure labels for Exp 5 and Exp 6"
git commit -m "docs(introduction): clarify nFAPI timing constraints and assumptions"
```

**Prefixes:**
- `feat:` — New experiment, scenario, or major contribution
- `fix:` — Corrected errors, terminology, or figure labels
- `docs:` — Content updates, restructuring, clarity improvements
- `style:` — LaTeX formatting, spacing, punctuation

### Overleaf Synchronization

- **Automated:** GitHub Actions syncs Overleaf → GitHub every hour
- **Conflict Resolution:** Overleaf changes take precedence in case of conflicts
- **Manual Push:** Changes committed here are pushed to Overleaf via the next sync cycle
- **Setup:** Requires GitHub Secrets configured (see `README.md` for token setup)

### Important: Avoid Merge Conflicts

- Work primarily in GitHub (files in `NTUST/sections/` and `main.tex`)
- Overleaf changes are merged automatically; local edits may conflict
- Always pull before making large changes: `git pull`
- If conflicts occur, communicate with collaborators before resolving

---

## LaTeX Packages & Utilities

### Key Packages Used

- **`IEEEtran`** — IEEE conference paper formatting (main.tex)
- **`tikz` / `pgfplots`** — Diagrams, network topologies, timing diagrams
- **`subfig`** — Multi-panel figures (subfigures for scenario comparisons)
- **`booktabs`** — Professional table formatting
- **`algorithm` / `algpseudocode`** — Algorithm pseudocode blocks
- **`color`** — Draft mode: blue highlighting for new/modified text (toggle in main.tex)

### Draft vs. Final Mode

**Draft Mode (Default):**
```latex
% In main.tex, near line 22 (default state):
% \definecolor{blue}{rgb}{0,0,0}  % <-- COMMENTED OUT
```
- Blue text (`\textcolor{blue}{...}`) shows new/edited content

**Final Mode:**
```latex
% Uncomment the line to switch to final mode:
\definecolor{blue}{rgb}{0,0,0}  % Blue becomes black
```
- All blue text renders as black

---

## Common Development Tasks

### Adding a New Section

1. Create `NTUST/sections/new_section.tex`
2. Include in both `main.tex` and `NTUST/my_ntust_thesis.tex`: `\input{NTUST/sections/new_section.tex}`
3. Rebuild: `latexmk main.tex`

### Updating References

1. Edit `references.bib` using standard BibTeX format
2. Cite in text: `\cite{key}` or `\cite{key1,key2,...}`
3. Compile to generate references: `latexmk main.tex`

### Creating Figures

**Guidelines:**
- Use TikZ for diagrams (network topologies, timing diagrams) — scales without quality loss
- Use PNG/PDF for plots and photos
- Always include descriptive caption with units, parameter values, and interpretation
- Label axes clearly (include units)

**Example TikZ Network Diagram:**
```latex
\begin{figure}[tbh]
  \centering
  \begin{tikzpicture}
    % ... diagram code ...
  \end{tikzpicture}
  \caption{System topology showing [components, parameters with values].}
  \label{fig:topology}
\end{figure}
```

### Subfigures (Multi-Panel Results)

```latex
\begin{figure}[tbh]
  \centering
  \subfloat[Scenario I: Baseline]{
    \includegraphics[width=0.45\linewidth]{figures/scenario1.pdf}
    \label{fig:s1}
  } \\
  \subfloat[Scenario II: Delay variant 1]{
    \includegraphics[width=0.45\linewidth]{figures/scenario2.pdf}
    \label{fig:s2}
  }
  \caption{Throughput comparison across scenarios with [parameter variation].}
  \label{fig:comparison}
\end{figure}
```

---

## Tips for Effective Collaboration

### Before Making Large Changes

1. **Check latest version:** `git status`, `git pull`
2. **Verify Overleaf sync:** Confirm no pending Overleaf changes (check GitHub Actions)
3. **Communicate:** If rewriting a section, notify collaborators

### Working with Figures

- Store figure source files (Python scripts, data) in `figures/` or `source/`
- Commit both source and output PDF/PNG
- Update captions to reflect any parameter or scenario changes
- Verify figure labels match the scenario names in `experiment.tex`

### Quick Verification Workflow

```bash
# 1. Compile thesis
latexmk main.tex

# 2. Check for warnings/errors
# Watch for: unresolved citations [?], overfull hboxes, missing packages

# 3. Verify terminology
grep -rn "slots.ahead\|timing.info" NTUST/sections/ figures/

# 4. View output
open build/main.pdf  # or use your preferred PDF viewer

# 5. Commit if satisfied
git add NTUST/sections/ figures/ build/main.pdf references.bib
git commit -m "Your message here"
```

---

## Troubleshooting

### LaTeX Compilation Errors

**Issue:** `Undefined control sequence` or missing package
- **Solution:** Check that all required packages are imported in the preamble (top of `main.tex` or `NTUST/my_ntust_thesis.tex`)

**Issue:** `File not found` (figures, sections, bib)
- **Solution:** Verify file paths are relative to the repository root. Check `.gitignore` to ensure files aren't excluded

**Issue:** Unresolved citations `[?]`
- **Solution:** Rebuild with `latexmk -c main.tex && latexmk main.tex` (cleans and rebuilds)

### Git Sync Issues

**Issue:** Merge conflicts between GitHub and Overleaf
- **Solution:** Pull latest, communicate with collaborators, rebase if necessary. Overleaf takes precedence per sync workflow.

**Issue:** Cannot push to GitHub
- **Solution:** Verify credentials (SSH key or GitHub token), check that you have write access

---

## Key Resources

- **Writing Guide:** Refer to `.agent/skills/paper-thesis-writing-guide/SKILL.md` for section structure and quality standards
- **Workflow:** See `.agent/skills/academic-paper-workflow/SKILL.md` for step-by-step contribution/results/revision process
- **Terminology:** Always consult `term_consistency_table.md` before finalizing changes
- **Overleaf Setup:** See `README.md` for GitHub Secrets configuration

---

## Quick Reference: Key Files

| File | Edit When |
|------|-----------|
| `main.tex` | Updating preamble, main structure, or adding new includes |
| `NTUST/sections/introduction.tex` | Updating background, related works, or contributions |
| `NTUST/sections/system.tex` | Clarifying nFAPI model, assumptions, or problem definition |
| `NTUST/sections/method.tex` | Updating algorithm, EWMA filter, or adjustment rules |
| `NTUST/sections/experiment.tex` | Adding scenarios, updating results, or changing evaluation metrics |
| `references.bib` | Adding new citations or updating reference information |
| `figures/` | Adding/updating experiment result figures and diagrams |
| `term_consistency_table.md` | Introducing new terminology standards |

