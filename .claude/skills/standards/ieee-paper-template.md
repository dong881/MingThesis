---
name: IEEE Academic Paper Template
description: A comprehensive guide for structuring and writing IEEE-format academic papers, including section-by-section instructions, LaTeX templates, and best practices for technical research papers.
---

# IEEE Academic Paper Template Skill

This skill provides structured guidance for writing IEEE-format academic papers, based on best practices for technical research writing.

## Document Structure Overview

```
1. Abstract
2. Introduction
   2.1 Background and Motivation
   2.2 Related Works
   2.3 Contributions
   2.4 Paper Organization
3. System Model/Architecture
4. Proposed Method/Solution
5. Numerical/Simulation/Experimental Results
6. Conclusion
7. References
```

---

## Section-by-Section Guide

### Abstract

**Purpose:** Briefly summarize the problem, method, results, and contribution.

**Guidelines:**
- Word count: 150–250 words
- Include: problem statement, proposed approach, key results, main contribution
- Add 3–6 keywords after abstract

**Template:**
```
This paper addresses [PROBLEM]. We propose [METHOD/APPROACH] 
to [OBJECTIVE]. The proposed method [KEY FEATURE]. Experimental 
results show that [MAIN RESULTS]. The main contribution is 
[CONTRIBUTION].
```

---

### 1. Introduction

**Purpose:** Explain **what** the paper is about, **why** the problem matters, and **what** others have done to address it.

**Typical Content:**
- Background and motivation
- Problem statement
- Goals of the paper
- High-level overview of the approach or results

**Example Phrases:**
- "In recent years, ..."
- "This paper addresses the problem of ..."
- "The main challenge is ..."

**Structure:**
1. Start with broad context (2-3 sentences)
2. Narrow down to specific problem (1-2 paragraphs)
3. State your approach briefly (1 paragraph)
4. Preview contributions (see below)

---

### 1.1 Related Works

**Purpose:** Show how your work fits into existing knowledge and how it differs from or improves upon previous work.

**Typical Content:**
- Summary of key prior research
- Strengths and limitations of existing approaches
- Comparison to your approach
- Justification for why a new approach is needed

**Example Phrases:**
- "Several studies have explored ..."
- "Unlike [Author], we propose ..."
- "Prior work has not considered ..."
- "[Reference] addressed X but did not consider Y"

**Best Practices:**
- Group related works by approach or theme
- Be fair and objective about prior work
- Clearly state gaps that your work fills

---

### 1.2 Contributions

**Location:** Last TWO paragraphs of Introduction

**Template:**
```latex
The main contributions of this paper are summarized as follows.
\begin{itemize}
\item Contribution 1: [Specific technical contribution]
\item Contribution 2: [Specific technical contribution]
\item Contribution 3: [Specific technical contribution]
\end{itemize}

The rest of the paper is organized as follows. Section II defines 
the system model/architecture considered in this paper. The proposed 
analytical model/method is given in Section III. Section IV shows 
the numerical results. Concluding remarks are given in Section V.
```

**Guidelines:**
- List 2-4 specific, measurable contributions
- Avoid vague claims ("novel", "efficient") without quantification
- Each contribution should map to results section

---

### 2. System Model/Architecture

**Purpose:** Define the problem formally with inputs, outputs, and constraints.

**Content Structure:**
1. **System diagram:** Show key components and relationships
2. **Assumptions:** List all assumptions clearly
3. **Problem formulation:** Define variables, parameters, constraints
4. **Notation table:** If using many symbols

**Template:**
```latex
\section{System Model}

Figure~\ref{fig:system} shows the system architecture considered 
in this paper.

% Insert figure here

The following assumptions were made in this paper.
\begin{itemize}
\item Assumption 1: [Clear statement]
\item Assumption 2: [Clear statement]
\item Assumption 3: [Clear statement]
\end{itemize}

% Define variables and problem formulation
```

**Best Practices:**
- Define variables **before** using them
- Distinguish between: Input (I/P), Output (O/P), and intermediate variables
- Use consistent notation throughout
- Include a figure showing system architecture

---

### 3. Proposed Method/Solution

**Purpose:** Explain **how** your solution works.

**Content Structure:**
1. Overview of the approach
2. Detailed algorithm/method description
3. Mathematical derivations (if applicable)
4. Complexity analysis (if applicable)

**Guidelines:**
- Use algorithms, flowcharts, or pseudocode for clarity
- Explain the intuition before diving into details
- Break complex methods into subsections
- Distinguish between "problem" (System Model), "solution" (Proposed Method), and "validation" (Results)

---

### 4. Numerical/Simulation/Experimental Results

**Purpose:** Validate your contributions through experiments.

**Template:**
```latex
\section{Numerical Results}

Computer simulations were conducted to verify [the effectiveness 
of the proposed method]. In the following figures, each point 
represents the average value of $10^5$ samples. Symbols and lines 
show the simulation and analytical results, respectively.

[Number] scenarios were investigated. Scenario I was designed to 
demonstrate/verify the accuracy/effectiveness of Contribution 1.
```

**Structure for Each Contribution:**

```latex
\subsection{Contribution 1: [Name]}

Figure X shows [what the figure demonstrates].
- X-axis: [What it represents]
- Y-axis: [What it represents]
- Key observation: [What the results show]

The results demonstrate that [interpretation supporting contribution].
```

**Best Practices:**
- One subsection per contribution
- Clearly label all axes with units
- Explain **why** the results support your claims
- Compare with baseline/existing methods
- Discuss unexpected results honestly

**Planning Questions:**
1. What contribution do you want to demonstrate?
2. What phenomenon would prove this contribution?
3. What figure/data would show this phenomenon?
4. What experiments generate this data?

---

### 5. Conclusion

**Purpose:** Summarize findings and suggest future work.

**Content:**
- Restate the problem briefly
- Summarize key contributions
- Highlight main results
- Suggest future research directions

**Length:** 1 paragraph (short papers) to 1 section (long papers)

---

## LaTeX Best Practices

### Required Packages

```latex
\documentclass[conference]{IEEEtran}
\usepackage[encapsulated]{CJK}  % For Chinese characters
\usepackage{cite}
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{algorithmic}
\usepackage{graphicx}
\usepackage{tabularx}
\usepackage{booktabs}  % Better table lines
\usepackage{array}
\usepackage{multirow}
```

### Table Template

```latex
\begin{table}[h]
\caption{Your Table Caption}
\label{tab:yourlabel}
\centering
\begin{tabular}{l|c|r}
\toprule
\textbf{Column 1} & \textbf{Column 2} & \textbf{Column 3} \\
\midrule
Data 1 & Data 2 & Data 3 \\
Data 4 & Data 5 & Data 6 \\
\bottomrule
\end{tabular}
\end{table}
```

### Long Table Template

```latex
\begin{longtable}{l|l|p{4cm}}
\caption{Your Long Table Caption} \\
\toprule
\textbf{Parameter} & \textbf{Type} & \textbf{Description} \\
\midrule
\endfirsthead

\caption[]{Your Long Table Caption (continued)} \\
\toprule
\textbf{Parameter} & \textbf{Type} & \textbf{Description} \\
\midrule
\endhead

\bottomrule
\endfoot

param1 & type1 & Description of parameter 1 \\
param2 & type2 & Description of parameter 2 \\
\end{longtable}
```

---

## Writing Workflow

### Recommended Order

1. **System Model** - Define the problem clearly
2. **Proposed Solution** - Explain your method
3. **Numerical Results** - Validate your approach
4. **Contributions** - Summarize what you achieved
5. **Introduction** - Write last, keep only essential information

### Color Coding System (for drafts)

- **Blue text:** Your own additions
- **Red text:** Advisor's changes requiring confirmation
- **Black text:** Confirmed, finalized content

### Pre-Submission Checklist

- [ ] All acronyms defined on first use
- [ ] All variables defined before use
- [ ] Consistent terminology throughout
- [ ] All figures/tables referenced in text
- [ ] All claims supported by results
- [ ] References formatted correctly
- [ ] Abstract within word limit
- [ ] Contributions clearly stated
- [ ] Results validate all contributions

---

## Common Mistakes to Avoid

1. **Writing Introduction first** - Write it last when you know what you actually accomplished
2. **Undefined variables** - Always define before using
3. **Mixing problem/solution/validation** - Keep them in separate sections
4. **Vague contributions** - Be specific and quantifiable
5. **Results without interpretation** - Always explain what results mean
6. **Inconsistent notation** - Use same symbols throughout
7. **Missing figure/table captions** - Every figure needs a descriptive caption
8. **Overcomplicated Introduction** - Keep only essential background

---

## Quick Reference

### Variable Definition Guidelines

- **Problem (I/P):** Define in System Model
- **Answer (O/P):** Define in System Model
- **Algorithm/Process:** Explain in Proposed Method
- **Examples/Validation:** Show in Numerical Results

### Section Length Guidelines (for conference papers)

- Abstract: 150-250 words
- Introduction: 1-1.5 columns
- System Model: 0.5-1 column
- Proposed Method: 1-2 columns
- Results: 1-2 columns
- Conclusion: 0.5 column
