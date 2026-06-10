---
name: Vocabulary Level Guide
description: Maintains a list of difficult English vocabulary to avoid when writing, suggesting "Junior High School" level simple direct synonyms to align with the advisor's requirement for correctness and simplicity.
---

# Vocabulary Level Guide

This skill enforces the writing style rule from the advisor's guidelines:
> **Language Style**: Use "Junior High School" level English (Simple Direct Sentences). **Correctness** is the most important factor. Avoid complex sentence structures.

When drafting or revising text for the thesis or paper, the Agent MUST consult this guide to ensure that the vocabulary used is simple, direct, and easy to understand.

## Words to Avoid and Suggested Replacements

This is a running list of words identified as "too difficult" or "unnecessarily complex" for the advisor's requirement of "junior high school" level English. Whenever you encounter these words, **automatically replace them** with simpler synonyms or rephrase for clarity.

| Avoid (Too Difficult) | Part of Speech | Simpler Alternatives | Explanation / Example |
| :--- | :--- | :--- | :--- |
| **Prohibitive** | adj. | very high, too high, expensive | The cost is "prohibitive" sounds academic but unclear. Better: "The cost is *too high* for most deployments." |
| **Proactively** | adv. | actively, early, in advance | "The method proactively adjusts timing" is awkward. Simpler: "*The method adjusts timing early* based on network conditions." |
| **Orchestration** | n. | management, control, coordination | "O-RAN orchestration" is vague. Clearer: "O-RAN *management* and *control* systems." (Exception: keep "SMO" as it's an acronym, but explain what it means.) |
| **Catastrophic** | adj. | huge, massive, very bad, severe | "Catastrophic failure" is dramatic. Better: "a *severe* failure in throughput." |
| **Pragmatic** | adj. | practical, realistic, useful | "A pragmatic approach" lacks clarity. Say: "a *practical* method that works in real networks." |
| **Camaraderie** | n. | friendship, support, teamwork | Seldom used in technical papers. In acknowledgments: "Thank you for the *support* and *friendship* of my classmates." |
| **Mitigate** | v. | reduce, solve, decrease | "Mitigate network jitter" is formal. Simpler: "*reduce* network jitter." |
| **Resilient** | adj. | strong, stable, reliable | "A resilient system" is vague. Better: "a *stable* system that handles changes well." |
| **Proprietary** | adj. | special, private, unique | "Proprietary hardware" is unclear. Clearer: "*special* hardware" or "hardware from one company only." |
| **Endogenous** | adj. | internal, from inside | "Endogenous delay" is too academic. Say: "*internal* processing delay." |
| **Consequently** | adv. | so, therefore, as a result | Not wrong, but "consequently" is formal. Simpler: "Therefore, ..." or "*As a result*, ..." |
| **Fluctuations** | n. | changes, variations | "Network fluctuations" is abstract. Better: "network *variations* and unexpected changes." |
| **Robustness** | n. | stability, strength, reliability | "The robustness of the system" is too formal. Say: "how *stable* the system is" or "the system's *reliability*." |
| **Deficit** | n. | delay, shortage, gap | "Timing deficit" is unclear. Better: "*accumulated delay*" or "missing time." |
| **Hypothesis** | n. | idea, design, assumption, guess | "Our hypothesis" in technical papers should be: "our *design*" or "our *idea*." |
| **Rigorous** | adj. | thorough, strict, detailed, careful | "A rigorous evaluation" can be: "a *thorough* evaluation" or "a *detailed* test." |
| **Fluctuates drastically** | v. + adv. | changes a lot, varies quickly | "The parameter fluctuates drastically" is awkward. Say: "*changes a lot*" or "*varies quickly*." |
| **Underwent** | v. (past) | went through, experienced, had | "The system underwent testing" is stiff. Better: "the system *went through* testing" or "*was tested*." |
| **Conservatively** | adv. | safely, carefully, with caution | "The algorithm conservatively adjusts values" is formal. Simpler: "*The algorithm adjusts values carefully*." |
| **Inflation** | n. | increase, growth | "To avoid RTT inflation" is jargon. Better: "to avoid *increasing* the RTT" or "to keep RTT *low*." |


## Rules for Maintaining This Guide

When feedback indicates a word is too difficult:
1. Add it to the table above with part of speech, simple explanation, and alternatives
2. Provide at least one example showing the problem and the fix
3. Include context about why the simpler version is better

## Application Protocol

Whenever applying this skill to writing or editing:

1. **Word Replacement**: Automatically replace identified difficult words with simpler alternatives
2. **Word List**: In your output, clearly list all words that were changed and what they became
3. **Remaining Difficult Words**: Scan the final text for any remaining high-level vocabulary (GRE, TOEFL, advanced academic terms) and flag them for user review
4. **User Feedback**: Ask explicitly: *"Are any of these remaining words too difficult? If yes, please let me know and I will add them to the avoid list."*

Example format:
```
Words replaced in this turn:
- "mitigate" → "reduce"
- "pragmatic" → "practical"
- "inherent" → "built-in"

Remaining words to review:
- "synchronization" (technical term, acceptable in networking context)
- "latency" (essential domain vocabulary, keep)
- "architecture" (standard in system design, keep)
```

## Simple Writing Heuristics

Follow these practical rules for maintaining clarity:

1. **The Clarity Test**: If you hesitate while reading a word, your reader will too. Replace it with something simpler.
2. **Verb Choice**: Use basic action verbs:
   - **Use:** make, do, use, show, find, test, create, set, change, improve
   - **Avoid:** fabricate, utilize, exhibit, discover, implement, facilitate, leverage
3. **Sentence Structure**: A clear, slightly repetitive sentence beats an elegant, confusing one
4. **Domain Vocabulary**: Keep essential technical terms (latency, throughput, RTT) because they are specific to the field. But explain them clearly on first use.
5. **The "Tell a Friend" Test**: Could you explain this concept to a friend using simple words? If not, simplify your writing.
