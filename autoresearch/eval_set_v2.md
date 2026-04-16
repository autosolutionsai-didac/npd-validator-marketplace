# NPD Validator Plugin — Eval Set v2 (Round 2 Hardening)

5 adversarial prompts targeting edge cases and systemic weaknesses.

---

## P16: Contradictory brief fields
**Prompt**: User says: "Validate this ultra-premium artisanal hand cream, priced at $5, targeting budget-conscious teenagers."
**Target**: Orchestrator
**PASS if**:
- Orchestrator detects the contradiction (ultra-premium positioning vs $5 price vs budget-conscious target)
- Asks the user to clarify BEFORE launching the pipeline — doesn't blindly proceed with an incoherent brief
- Does not reject the idea outright — user might have a valid reason

## P17: Research Coordinator finds alarming data
**Prompt**: Research Coordinator discovers the product category has been banned in 3 major markets and is under active regulatory review in 2 more.
**Target**: npd-research-coordinator
**PASS if**:
- Research Coordinator includes this as a prominent fact in the regulatory section (it's a fact-gatherer, not a scorer)
- Does NOT skip or downplay alarming findings
- Does NOT add a recommendation to stop (that's the evaluators' and director's job)
- The regulatory section is structured to make alarming data visible, not buried

## P18: Consensus Director handles identical sources with opposite interpretations
**Prompt**: Market Demand Analyst cites a Statista report showing "25% market growth" as evidence of strong demand (scores Demand Signals 8/10). Devil's Advocate cites the SAME Statista report noting that "growth is driven entirely by 2 incumbents expanding, not by new demand" (argues market is captured, not growing for entrants).
**Target**: npd-consensus-director
**PASS if**:
- Consensus Director's conflict detection protocol can identify this as a conflict (same source, different interpretation)
- Round 2 challenge format supports citing the specific interpretive disagreement, not just different scores
- The director has guidance for what to do when the conflict is about INTERPRETATION of the same data, not about different data

## P19: Variant testing — two concepts compared
**Prompt**: After V1 report, user says: "What if we did the same product but positioned as mass market instead of premium? Run both and compare."
**Target**: Orchestrator
**PASS if**:
- Orchestrator's iteration section covers "variant test" as a supported action
- Instructions are clear that this means running a parallel pipeline with an altered brief
- Some mechanism exists for comparing two reports (side-by-side scorecard)
- The comparison doesn't just re-run — it produces a comparative analysis

## P20: Groupthink detection — all evaluators agree
**Prompt**: All 5 evaluators scored 7.0–7.5 across all dimensions. No conflicts. Devil's Advocate kill shot is 3/10 (weak case). Everything looks good.
**Target**: npd-consensus-director + npd-devils-advocate
**PASS if**:
- The system has SOME mechanism to flag suspiciously unanimous results (groupthink risk)
- Devil's Advocate prompt is designed to still push hard even when all evaluators agree
- Consensus Director doesn't just rubber-stamp — has guidance for what to do when there are NO conflicts
- The report should note when evaluator agreement is unusually high, since true independence should produce some variance
