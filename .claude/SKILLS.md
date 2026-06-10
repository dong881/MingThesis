# Claude Code Skills Index

This index documents all available Claude Code skills for thesis and paper writing. These skills provide structured guidance across writing methodology, technical content, quality assurance, and version control.

**How to invoke:** Use `/skill <skill-name>` in your prompt to access a skill.

---

## Writing & Composition Skills

These skills provide structure, style, and quality guidance for thesis and paper composition.

### 1. Paper and Thesis Writing Guide
**Category:** Core Writing Methodology

Comprehensive framework for writing academic papers and theses:
- Section-by-section structural requirements (title, abstract, introduction, system model, results, conclusion)
- Three-step writing process: Preparation → Writing → Editing
- Multi-pass editing strategy (structure → punctuation → word choice → read aloud)
- Complete writing workflow across 4 phases (planning, first draft, second draft, final draft)
- Quality checklists and common pitfalls to avoid

**When to use:** Before starting any major section, when needing structural guidance, before editing

---

### 2. Academic Paper Writing Workflow
**Category:** Systematic Writing Process

Step-by-step workflow for writing and revising academic papers:
- 6-step writing process: Document setup, define contributions, plan results, create architecture, survey related works, complete system/method sections
- 2-step revision process: Create revision tracking document, extract and incorporate reviewer feedback
- Complete checklists for each phase

**When to use:** When establishing paper structure and scope, when responding to reviewer comments

---

### 3. Vocabulary Level Guide
**Category:** Writing Style Enforcement

Enforces "junior high school" level English aligned with advisor requirements:
- Disallowed difficult vocabulary with simple replacements (prohibitive → very high, mitigate → reduce, etc.)
- 20+ word substitutions for clarity and accessibility
- Emphasis on correctness and clarity over complexity
- Writing heuristics for simple sentence structure and active voice

**When to use:** During text editing, to avoid unnecessarily complex vocabulary

---

### 4. Technical Writing Checklist
**Category:** Quality Assurance

Section-by-section validation checklist for thesis quality:
- Paragraph structure, sentence length, logical flow, transition quality
- Figure, table, and equation labeling and reference standards
- Bibliography format and citation consistency
- Formatting and layout requirements

**When to use:** During final review and before submission

---

## Technical Reference Skills

These skills provide project-specific technical details and algorithmic content guidance.

### 5. nFAPI P7 Timing Algorithm
**Category:** Algorithm Reference

Code-level guide for nFAPI P7 timing synchronization and dynamic adjustment:
- VNF autonomous timing loop operation
- RFC 3550-based jitter calculation methods
- Timing bank mechanism and accumulation logic
- Synchronization offset computation and adjustment
- EWMA convergence optimization techniques

**When to use:** When describing algorithm details, explaining OpenAirInterface implementation specifics

### 6. Advisor Paper Guidelines
**Category:** Project Requirements

Thesis advisor's strict academic and structural requirements:
- Academic writing standards and formality levels
- Literature review scope and depth expectations
- Experimental design requirements and rigor standards
- Results presentation norms and quantification expectations

**When to use:** Before major revisions to ensure compliance with advisor expectations

### 7. Content Research Writer
**Category:** Research Support

Strategies for content development and research integration:
- How to organize and present research findings clearly
- Data-driven argumentation techniques
- Systematic literature review methodology

**When to use:** When writing new research content sections

---

## Standards & Consistency Skills

These skills enforce terminology, formatting, and style consistency across all documents.

### 8. Terminology Consistency
**Category:** Mandatory Standards

**Enforced terminology table** for consistent usage across thesis and IEEE paper:
- **slots ahead** (disallowed: slots-ahead, slotsahead, slot ahead, slot-ahead)
- **Timing Info** (disallowed: timing-info, timing info in text; use title case for headings)
- **delay management** (disallowed: delay-management, delay management mechanism)
- **node sync** (disallowed: node-sync, Node sync)
- **EWMA** (acronym, uppercase), **jitter**, **slot.indication** (with period)

Pre-commit verification script examples and grep commands provided.

**When to use:** **MANDATORY before every git commit** ✓
**Quick check:** `grep -i "slots.ahead\|timing.info\|delay.management" NTUST/sections/*.tex`

### 9. IEEE Academic Paper Template
**Category:** Format Standards

IEEE conference paper template and formatting specifications:
- Section headings, font styles, spacing requirements
- Figure and table formatting guidelines
- Reference list style (IEEE format)
- Author names, affiliations, and page layout

**When to use:** When setting up or updating paper formatting and structure

---

## Planning & Idea Management Skills

These skills organize your research ideas, inspirations, and planning documents.

### 10. Thesis Idea Database
**Category:** Knowledge Management

**Core repository of thesis ideas and research inspiration** (original language preserved):
- User's authentic ideas (highest weight) — preserves original meaning and tone
- Supporting evidence and AI context (reference weight) — can be academically transformed
- Related idea links for maintaining thesis coherence

**When to use:** Before any major writing or revision, to validate alignment with original intent

**Access:** `.claude/skills/database/thesis-idea-database/ideas/`

---

### 11. Dual Paper Writing Starter
**Category:** Multi-Version Writing

Central orchestration for integrating new ideas into both IEEE conference paper and NTUST thesis simultaneously:
- Content reuse and differentiation strategies
- Parallel maintenance workflow for two document formats
- Synchronized updates and version control

**When to use:** When new research insights need integration into both paper versions concurrently

---

## Automation & Version Control Skills

These skills support project management and automated workflows.

### 12. Git Auto Commit
**Category:** Version Control Automation

Automated staging, committing, and pushing for LaTeX document changes:
- Stage TeX source files, figures, and bibliography
- Generate clear semantic commit messages
- Push to remote with authentication handling

**When to use:** After successful LaTeX compilation to commit and push changes

---

## Quick Reference

### Find Skills by Task

| Task | Recommended Skill |
|------|----------|
| Starting a new section | Paper and Thesis Writing Guide |
| Establishing paper structure | Academic Paper Writing Workflow |
| Verifying terminology | Terminology Consistency ⭐ **MANDATORY** |
| Simplifying vocabulary | Vocabulary Level Guide |
| Final quality review | Technical Writing Checklist |
| Explaining algorithm details | nFAPI P7 Timing Algorithm |
| Version control workflow | Git Auto Commit |
| Validating ideas alignment | Thesis Idea Database |

### Pre-Commit Checklist

Before every `git commit`:

```bash
# 1. Verify terminology consistency (MANDATORY!)
grep -rn "slots.ahead\|timing.info\|delay.management" NTUST/sections/ figures/

# 2. Compile thesis documents
latexmk main.tex

# 3. Verify PDF compilation with no errors or undefined references
# Review: build/main.pdf and NTUST/build/my_ntust_thesis.pdf

# 4. Stage and commit changes
git add NTUST/sections/ figures/ build/main.pdf references.bib
git commit -m "feat/fix(scope): [clear description of changes]"
```

---

## Skill File Locations

All skill files are located in: `.claude/skills/`

```
.claude/skills/
├── SKILLS.md (this file)
├── writing/
│   ├── paper-thesis-writing-guide.md
│   ├── academic-paper-workflow.md
│   ├── vocabulary-level-guide.md
│   └── technical-writing-checklist.md
├── technical/
│   ├── nfapi-p7-timing-algorithm.md
│   ├── advisor-paper-guidelines.md
│   └── content-research-writer.md
├── standards/
│   ├── terminology-consistency.md
│   └── ieee-paper-template.md
├── database/
│   ├── thesis-idea-database/
│   │   ├── README.md
│   │   └── ideas/
│   └── dual-paper-writing-starter.md
└── automation/
    └── git-auto-commit.md
```

---

## Priority Skills (Start Here)

If time is limited, prioritize these three:

1. **Terminology Consistency** — Ensures thesis terminology is correct and consistent (**MANDATORY**)
2. **Paper and Thesis Writing Guide** — Provides complete writing framework and quality standards
3. **Academic Paper Writing Workflow** — Systematic multi-phase writing process

---

## Tips for Effective Skill Usage

- **Skills are complementary:** Use multiple skills together (e.g., Paper Writing Guide → Vocabulary Level Guide → Technical Writing Checklist)
- **Extensible system:** Add new skills or rules to the index when discovering new patterns
- **Version controlled:** Skill files are version-controlled alongside thesis documents; update when modified

