# Terminology Consistency Table

This table defines the preferred spelling, capitalization, hyphenation, and connective style for recurring technical terms in your papers. Use it as a checklist before finalizing any manuscript section.

| Term (Preferred) | Disallowed Variants | Case | Hyphenation | Connector (+) | Example Usage |
|-------------------|----------------------|------|--------------|----------------|---------------|
| **slots ahead** | slots-ahead, slotsahead, slot ahead, slot-ahead | lower‑case (unless at sentence start) | none | none | "The scheduler projects **slots ahead** to compensate for jitter." |
| **Timing Info** | timing‑info, Timing‑info, timing info | Title Case for headings, otherwise lower‑case (`timing info`) | none | none | "We compute the **Timing Info** using an EWMA filter." |
| **Delay management** | delay‑management, delay management mechanism, delay‑management controller | lower‑case | none | none | "Effective **delay management** is crucial for synchronization." |
| **Node sync** | node‑sync, Node sync, Node‑sync | lower‑case | none | none | "Periodic **node sync** aligns state across devices." |
| **Timing Info Delay management Node sync** | any mixed‑case or hyphenated forms, quoted variants | lower‑case for each word | none | none | "The **timing info delay management node sync** process ensures coherent scheduling." |

## Recommended Replacements for Resource Allocation Phrases

| Original Phrase | Suggested Replacement | Rationale |
|-----------------|-----------------------|-----------|
| over‑provisions | **excess allocation** | Clearly indicates allocating more resources than needed. |
| under‑provisions | **insufficient allocation** | Directly conveys a shortage of allocated resources. |

**How to use:**
1. Keep this file in the project root.
2. Before committing any LaTeX changes, run a quick search (e.g., `grep -i "slots ahead" *.tex`) to verify the term matches the preferred form.
3. Update the table when new terminology is introduced.
