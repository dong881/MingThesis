---
name: Academic Paper Writing Workflow
description: A step-by-step workflow for writing and revising academic papers, from initial draft to responding to reviewer comments. Includes systematic procedures for organizing contributions, results, and references.
---

# Academic Paper Writing Workflow

This skill provides a systematic workflow for writing and revising academic papers. Follow these steps to ensure a well-structured, complete submission.

---

## Part 1: Writing Your Paper

### Step 1: Set Up Your Document

**Action:** Copy the template for paper submission and create your own version.

**Tasks:**
- [ ] Copy the IEEE conference/journal template
- [ ] Set up document structure with all required sections
- [ ] Configure LaTeX packages and formatting
- [ ] Add your title, authors, and affiliations

---

### Step 2: Define Your Contributions

**Action:** List your contributions at the end of Section I (Introduction).

**Guidelines:**
- Write 2-4 specific, measurable contributions
- Each contribution should be validated in your results section
- Avoid vague terms like "novel" or "efficient" without quantification
- Use the standard format:

```latex
The main contributions of this paper are summarized as follows.
\begin{itemize}
\item Contribution 1: [Specific technical achievement]
\item Contribution 2: [Specific technical achievement]
\item Contribution 3: [Specific technical achievement]
\end{itemize}
```

**Checklist:**
- [ ] Each contribution is specific and measurable
- [ ] Contributions are listed in logical order
- [ ] Each contribution maps to a result scenario
- [ ] Avoid subjective claims without evidence

---

### Step 3: Plan Your Results Section

**Action:** List the scenarios used to demonstrate your results in Section IV.

**For Each Scenario:**

#### 3.1 Define the Goal
- [ ] State what this scenario demonstrates
- [ ] Align with one or more contributions
- [ ] Explain why this scenario is important

#### 3.2 List Parameters
- [ ] **Constants:** Fixed values used in the scenario
- [ ] **Variables:** Parameters that will be varied
- [ ] **Metrics:** What you will measure

#### 3.3 Design the Figure
- [ ] **X-axis:** What parameter varies (with units)
- [ ] **Y-axis:** What metric is measured (with units)
- [ ] **Expected results:** What trend/pattern you expect to see
- [ ] **Interpretation:** How this supports your contribution

**Template:**
```
Scenario [N]: [Name]
Goal: Demonstrate [which contribution]
Constants: [list fixed parameters]
Variables: [list varying parameters]
Figure [N]:
  - X-axis: [parameter] ([units])
  - Y-axis: [metric] ([units])
  - Expected: [trend/pattern]
  - Interpretation: [how this proves contribution]
```

---

### Step 4: Create System Architecture Diagram

**Action:** Draw a figure showing the system architecture/model considered in this paper.

**Requirements:**
- [ ] Show all key components of your system
- [ ] Indicate relationships and data flow
- [ ] Label inputs and outputs
- [ ] Highlight your contributions in the diagram
- [ ] Include in Section II (System Model)

**Best Practices:**
- Use clear, professional diagrams (not hand-drawn)
- Use consistent notation and symbols
- Add a descriptive caption explaining the figure
- Reference the figure in the text: "Figure X shows..."

---

### Step 5: Review and Summarize Related Work

**Action:** List references and summarize each paper in Section I.

**For Each Reference:**

#### 5.1 Format the Citation
- [ ] Follow IEEE Referencing Style Sheet
- [ ] Include all required fields (authors, title, venue, year, pages)
- [ ] Maintain consistent formatting

#### 5.2 Summarize the Contribution
- [ ] What has been done related to your work?
- [ ] What approach did they use?
- [ ] What results did they achieve?

#### 5.3 Identify Limitations
- [ ] What gaps exist in their work?
- [ ] What scenarios were not considered?
- [ ] Why is your work needed?

**Template:**
```
[Reference Number]: [Authors], "[Title]," [Venue], [Year].
- Contribution: [What they did related to your work]
- Limitation: [Why your work is still needed]
- Difference: [How your approach differs]
```

**Organization Tips:**
- Group related works by theme or approach
- Discuss chronologically or by similarity to your work
- Be fair and objective about prior work
- Clearly state the research gap your work fills

---

### Step 6: Write System Model and Proposed Method

**Action:** Complete Section II (System Model) and Section III (Proposed Method).

#### 6.1 System Model (Section II)
- [ ] Include the system architecture diagram (from Step 4)
- [ ] List all assumptions clearly
- [ ] Define all input parameters
- [ ] Define all output parameters
- [ ] Specify constraints and limitations

#### 6.2 Proposed Method (Section III)
- [ ] Provide overview of your approach
- [ ] Explain the algorithm/method step-by-step
- [ ] Include pseudocode or flowcharts if helpful
- [ ] Derive mathematical formulations
- [ ] Explain the intuition behind your method

**Best Practices:**
- Define variables **before** using them
- Distinguish between problem (System Model) and solution (Proposed Method)
- Use consistent notation throughout
- Explain **why** your method works, not just **how**

---

## Part 2: Revising Your Paper

### Step 1: Set Up Revision Document

**Action:** Copy the "Template for Reply to Reviewers' Comments" and create your own version.

**Setup:**
- [ ] Create a separate document for responses
- [ ] Use clear formatting to distinguish comments from responses
- [ ] Number each comment for easy reference
- [ ] Prepare to track all changes in the paper

---

### Step 2: Extract Reviewer Comments

**Action:** Copy all comments from the decision letter.

**Organization:**
- [ ] Separate comments by reviewer (Reviewer 1, Reviewer 2, etc.)
- [ ] Number each comment sequentially
- [ ] Identify major vs. minor comments
- [ ] Prioritize critical issues

---

### Step 3: Respond to Each Comment

**Action:** Reply to comments one-by-one systematically.

**For Each Comment:**

#### 3.1 Answer Precisely
- [ ] Address the specific question or concern
- [ ] Provide clear, factual responses
- [ ] Include data or references if needed
- [ ] Be respectful and professional

#### 3.2 List Modifications
- [ ] Specify exact changes made to the paper
- [ ] Reference section, page, and line numbers
- [ ] Quote the revised text if substantial
- [ ] Explain why the change addresses the comment

**Response Template:**
```
Comment [N]: [Reviewer's comment]

Response: [Your answer to the question/concern]

Modifications:
- Section [X], Page [Y], Line [Z]: [Description of change]
- Added/Modified/Deleted: "[Quoted text if applicable]"
- Rationale: [Why this addresses the comment]
```

**Best Practices:**
- Never argue with reviewers; explain politely
- If you disagree, provide evidence and reasoning
- Thank reviewers for helpful suggestions
- Be thorough but concise
- Highlight changes in the revised manuscript (use color or track changes)

---

## Complete Workflow Summary

### Initial Writing Phase
1. ✅ Set up document from template
2. ✅ Define contributions (Introduction)
3. ✅ Plan result scenarios (Results section)
4. ✅ Create system diagram (System Model)
5. ✅ Review and summarize related work (Introduction)
6. ✅ Write System Model and Proposed Method

### Results and Validation Phase
7. ✅ Run experiments for each scenario
8. ✅ Generate figures with proper labels
9. ✅ Write results interpretation
10. ✅ Verify all contributions are validated

### Finalization Phase
11. ✅ Write Abstract (last)
12. ✅ Write Conclusion
13. ✅ Proofread entire paper
14. ✅ Check all references
15. ✅ Submit

### Revision Phase (if needed)
16. ✅ Set up revision response document
17. ✅ Extract and organize reviewer comments
18. ✅ Respond to each comment systematically
19. ✅ Make all required modifications
20. ✅ Resubmit with response letter

---

## Reference Materials

When using this workflow, also consult:
- **Project Proposal Slide** - For initial planning and scope
- **Template for Reply to Reviewers' Comments** - For revision responses
- **Published papers in target venue** - For style and format examples
- **IEEE Referencing Style Sheet** - For citation formatting

---

## Tips for Success

### Writing Tips
- Write System Model and Results **before** Introduction
- Keep Introduction concise - only essential background
- Every claim must be supported by results
- Use consistent terminology throughout

### Common Pitfalls to Avoid
- ❌ Writing Introduction first (write it last)
- ❌ Undefined variables or acronyms
- ❌ Results without clear interpretation
- ❌ Contributions not validated by experiments
- ❌ Inconsistent notation or terminology
- ❌ Missing figure/table captions

### Time Management
- Allocate most time to: System Model, Proposed Method, Results
- Allocate least time to: Introduction, Abstract (write last)
- Leave time for multiple revision rounds
- Get feedback early and often

---

## Checklist Before Submission

- [ ] All contributions clearly stated
- [ ] All contributions validated in results
- [ ] All scenarios properly designed and executed
- [ ] System architecture diagram included
- [ ] All related works properly cited and discussed
- [ ] All variables defined before use
- [ ] All acronyms defined on first use
- [ ] All figures have descriptive captions
- [ ] All figures referenced in text
- [ ] Abstract within word limit
- [ ] References formatted correctly
- [ ] Paper proofread for grammar and clarity
- [ ] All co-authors reviewed and approved
