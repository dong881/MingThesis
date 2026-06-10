---
name: Advisor Paper Guidelines
description: Strict guidelines and writing rules extracted from the advisor's comments in the drafting template. Follow these specific instructions for structure, color coding, and content order.
---

# Advisor's Paper Writing Guidelines

These guidelines are extracted directly from the advisor's comments in the LaTeX template. You **MUST** follow these rules strictly.

## 1. General Rules

1.  **Follow the Template**: Copy the template and follow the outline exactly. Do not include irrelevant content.
2.  **Color Coding**:
    *   **Blue (`\color{blue}`)**: Content you added or modified in **non-template** areas. **IMPORTANT**: Only user-drafted content should be blue. Original template text, placeholders, and instructions must remain in the default font color. Do **NOT** use blue color for **Tables** or **Formulas/Equations**. Keep them in the default font color.
    *   **Red (`\color{red}`)**: Content corrected by the advisor. **DO NOT** proactively use red font. It is only for preserving existing advisor corrections found in the document.
    *   **Black**: Red content that you have confirmed is correct and accepted.
    *   *Note*: If you have a question about a correction (red text), changed it to **Blue**.
3.  **Abbreviations**: Define abbreviations before the first use. In principle, capitalize only the first letter of the sentence (do not misuse Title Case for common terms).
4.  **Language Style**: Use "Junior High School" level English (Simple Direct Sentences). **Correctness** is the most important factor. Avoid complex sentence structures.
5.  **Table Style**: Tables must be **concise and condensed**. Use compact descriptions and combine value ranges into the main description where possible. Avoid verbose row-spanning text.
6.  **Order of Writing** (Strict):
    1.  **System Model** (Problem & Answer)
    2.  **Proposed Solution / Analytical Model** (Derivations)
    3.  **Numerical/Experimental Results** (Examples/Verification)
    4.  **Introduction** (Write this **LAST**)
6.  **Variables & Definitions**:
    *   Define **ANY** variable before using it.
    *   Before writing a variable/formula, classify it:
        *   **Problem (I/P)** -> Goes in **System Model**
        *   **Answer (O/P)** -> Goes in **System Model**
        *   **Derivation (Algorithm)** -> Goes in **Analytical Model**
        *   **Example** -> Goes in **Numerical Results**
7.  **Auto-numbering**: Do not manually type section letters (like A. B. C. or 1. 2.) in `\section` or `\subsection` titles because LaTeX handles numbering automatically.

---

## 2. Section Specific Guidelines

### Abstract
*   **Timing**: Write this before the Introduction? (Template places it first, but logic implies summary of finished work).
*   **Content**: Briefly summarize Problem, Method, Results, and Contribution.
*   **Length**: 150–250 words.
*   **Keywords**: List 3–6 keywords.

### I. Introduction
*   **Keep it Minimal**: Only include **absolutely necessary** information. If the paper can continue without mentioning something, remove it.
*   **Purpose**: Explain **WHAT** the paper is about, **WHY** it matters, and **WHAT** others have done.
*   **Content**: Background/Motivation, Problem Statement, Goals, Contributions, Overview.

### Related Works
*   **Purpose**: Position your work.
*   **Content**: Summary of key research, Strengths/Limitations of existing work, Comparison to your approach, Justification for new approach.

### II. System Model / Architecture
*   **Content**: Problem (I/P) and Answer (O/P).
*   **Visuals**: **MUST** include a figure showing key components and their relationships (I/P and O/P).
*   **Assumptions**: List assumptions clearly (Assumption 1, 2, 3...).
*   **Tables**: Use tables for parameters (e.g., Timing Window, Mode, Period) with strict types (use `uint16_t` etc if code related).

### III. Proposed Method / Analytical Model
*   **Content**: The "Derivation" or "Your Algorithm".

### IV. Numerical / Experimental Results
*   **Planning**: Do not just draw figures blindly. Plan from the goal backwards:
    1.  What is the **Contribution**?
    2.  What **Phenomena** in the data prove this contribution?
    3.  What **Figure** shows these phenomena?
    4.  How to plot it? (X-axis, Y-axis, Data needed).
*   **Explanation**: For each contribution, explain **HOW** the experiment is designed to demonstrate it and **WHY** the results support it.
*   **Format**:
    *   Points: Average of $10^5$ samples (typical).
    *   Symbols: Simulation results.
    *   Lines: Analytical results.

## 3. Review Process
*   Self-Correction: When the advisor corrects text (Red), check it. If consistent/correct, change to Black. If doubtful, change to Blue.
