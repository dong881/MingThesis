---
name: Terminology Consistency
description: Provides a reference table and validation rules to ensure consistent usage of key technical terms across all manuscript drafts. Includes recommended replacements for vague resource allocation wording.
---

# Terminology Consistency Rule

This skill defines a **Terminology Consistency Table** that must be consulted and adhered to whenever drafting or editing LaTeX sections of the IEEE paper or NTUST thesis.

## Table of Preferred Terms

| Term (Preferred) | Disallowed Variants | Case | Hyphenation | Connector (+) | Example Usage |
|-------------------|----------------------|------|--------------|----------------|---------------|
| **slots ahead** | slots-ahead, slotsahead, slot ahead, slot-ahead | lower‑case (unless at sentence start) | none | none | `The scheduler projects **slots ahead** to compensate for jitter.` |
| **Timing Info** | timing‑info, Timing‑info, timing info | Title Case for headings, otherwise lower‑case (`timing info`) | none | none | `We compute the **Timing Info** using an EWMA filter.` |
| **Delay management** | delay‑management, delay management mechanism, delay‑management controller | lower‑case | none | none | `Effective **delay management** is crucial for synchronization.` |
| **Node sync** | node‑sync, Node sync, Node‑sync | lower‑case | none | none | `Periodic **node sync** aligns state across devices.` |
| **Timing Info Delay management Node sync** | any mixed‑case or hyphenated forms, quoted variants | lower‑case for each word | none | none | `The **timing info delay management node sync** process ensures coherent scheduling.` |

| **arrival margin** | arrival‑margin, arrival margin | lower‑case | none | none | `The scheduler accounts for **arrival margin** to handle network delays.` |
| **jitter** | jitter, jitter‑value | lower‑case | none | none | `We compute **jitter** using an EWMA filter to capture timing variability.` |
| **EWMA** | EWMA filter, exponential weighted moving average | upper‑case (acronym) | none | none | `The **EWMA** filter smooths the **Timing Info** and **jitter** measurements.` |
| **slot.indication** | slot‑indication, slot indication, Slot Indication | lower‑case (often formatted as `\texttt{slot.indication}`) | period | none | `The VNF receives a **slot.indication** to trigger scheduling.` |

## Recommended Replacements for Resource Allocation Phrases

| Original Phrase | Suggested Replacement | Rationale |
|-----------------|-----------------------|-----------|
| over‑provisions | **excess resource allocation** | Clearly indicates allocating more resources than needed. |
| under‑provisions | **insufficient resource allocation** | Directly conveys a shortage of allocated resources. |

## Enforcement Guidance

1. **Pre‑commit Check**: Before committing any `.tex` changes, run a grep search for each term to verify the preferred spelling, e.g.:
   ```bash
   grep -i "slots ahead" *.tex
   ```
2. **Automated Lint**: Add a simple script (e.g., `check_terms.sh`) that scans the repository for disallowed variants and fails the Git commit if any are found.
3. **Editor Integration**: Configure your LaTeX editor (VS Code, TeXstudio) with a custom spell‑check dictionary containing the preferred terms.
4. **Review Checklist**: Include a step in the review process to confirm that the terminology table has been consulted.

## Usage Example
When drafting a new section, reference this skill to ensure consistent terminology:
```latex
The scheduler projects **slots ahead** based on the latest **Timing Info**. This enables robust **delay management** and seamless **node sync** across the network.
```

> **Note**: If you encounter a term not listed here, add it to the table with the same format to keep the rule comprehensive.
