---
name: Vocabulary Level Guide
description: Maintains a list of difficult English vocabulary to avoid when writing, suggesting "Junior High School" level simple direct synonyms to align with the advisor's requirement for correctness and simplicity.
---

# Vocabulary Level Guide

This skill enforces the writing style rule from the advisor's guidelines:
> **Language Style**: Use "Junior High School" level English (Simple Direct Sentences). **Correctness** is the most important factor. Avoid complex sentence structures.

When drafting or revising text for the thesis or paper, the Agent MUST consult this guide to ensure that the vocabulary used is simple, direct, and easy to understand.

## 🚫 Words to Avoid & ✅ Suggested Replacements

Below is a running list of words that have been identified as "too difficult" or "unnecessarily complex", along with their simpler, more direct synonyms.

Whenever you encounter or consider using a word from the "Avoid" list, **automatically replace it** with a word from the "Use Instead" column or rephrase the sentence to be simpler.

| 🚫 Avoid (Too Difficult) | Part of Speech | Meaning (in context) | ✅ Use Instead (Simpler Synonyms) | Example Context / Reason |
| :--- | :--- | :--- | :--- | :--- |
| **Prohibitive** | adj. | 高昂得令人望而卻步的 | **Very high, Too high, Expensive** | e.g., "The cost of hardware synchronization in traditional TSN is *too high*." |
| **Proactively** | adv. | 主動地、先發制人地 | **Actively, Early, In advance** | e.g., "The proposed method *actively* adjusts the slots ahead." |
| **Orchestration** | n. | 編排、協同運作 | **Management, Control, Coordination** | e.g., "O-RAN Service *Management* and *Control* framework." (If part of a proper noun like SMO, keep SMO but explain simply) |
| **Catastrophic** | adj. | 災難性的 | **Huge, Massive, Very bad, Severe** | e.g., "Static configuration causes a *severe* drop in system throughput." |
| **Pragmatic** | adj. | 務實的、實用主義的 | **Practical, Realistic, Useful** | e.g., "Small Cell Forum provides a more *practical* explanation." |
| **Camaraderie** | n. | 同袍情誼、深厚友誼 | **Friendship, Support, Teamwork** | e.g., Acknowledgements: "Thanks for the *support* and *friendship* of my classmates." |
| **Mitigate** | v. | 減輕、緩和 | **Reduce, Solve, Decrease** | e.g., "This approach dynamically tracks and *reduces* network jitter..." |
| **Resilient** | adj. | 有彈性的、具韌性的 | **Strong, Stable** | e.g., "...and ensures *stable* system throughput." |
| **Proprietary** | adj. | 專有的、專利的 | **Special, Private** | e.g., "...without relying on high-end *special* hardware..." |
| **Endogenous** | adj. | 內生的、內在產生的 | **Internal** | e.g., "...introduces *internal* processing latency..." |
| **Consequently** | adv. | 結果、因此 | **So, Therefore, As a result** | e.g., "*Therefore*, the system can maintain stable throughput." |
| **Fluctuations** | n. | 波動、起伏 | **Changes, Variations** | e.g., "...and does not require special handling for latency *variations*..." |
| **Robustness** | n. | 魯棒性、強健性 | **Stability** | e.g., "To test the system's *stability*..." |
| **Deficit** | n. | 延遲赤字、不足量 | **Delay** | e.g., "...tracks the *accumulated delay*..." |

## 📝 Rules for Updating this Guide
When the user indicates that a specific word is too difficult, update this skill by adding the word to the table above, providing its part of speech, meaning, and simpler alternatives.

## 🔍 Verification & Feedback Protocol (驗證與回饋機制)
Whenever this skill is applied to write or edit text:
1. **List the Replaced Words**: In the final output, clearly list all the target difficult words that were replaced in this turn, along with their new simpler equivalents.
2. **Scan for Remaining Difficult Words**: Analyze the final output for any remaining words that are relatively high-level (e.g., GRE, TOEFL, or advanced academic vocabulary).
3. **User Feedback Query**: Present a list of these remaining relatively difficult words in a distinct bulleted list or table, and explicitly ask the user: *"Are any of these words too difficult? If yes, please let me know and I will add them to the avoid list and suggest simpler alternatives."*

## ✍️ Writing Heuristics
1. **Rule of Thumb**: If you have to think twice about what a word means, it's probably too difficult.
2. **Action Words**: Use basic verbs (make, do, use, show, find) instead of fancy ones (fabricate, utilize, exhibit, discover) when the meaning is the same.
3. **Clarity over Elegance**: It is better to write a slightly repetitive but perfectly clear sentence than an elegant but complex one.
