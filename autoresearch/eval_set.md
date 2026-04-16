# NPD Validator Plugin — Eval Set v1

15 prompts testing instruction quality across all agents, entry modes, edge cases.
Each scored PASS (1) or FAIL (0).

---

## P1: Mode A detection — rough idea
**Prompt**: User says: "I think there might be a gap in the men's grooming space for a beard oil that also works as a moisturizer."
**Target agent**: Orchestrator (validate-product skill)
**PASS if**:
- Correctly identifies Mode A (rough idea — only category and partial differentiator provided, <4 brief fields)
- Asks targeted questions to fill the remaining brief fields (target consumer, price range, brand context)
- Does NOT immediately launch the full 8-agent pipeline
- Offers Quick Scan before committing to deep validation

## P2: Mode B detection — solid concept
**Prompt**: User says: "Validate this: a probiotic-infused body wash for women 25–40, priced $18–24, positioned as microbiome-friendly clean beauty. Key differentiator is clinically-tested probiotic strains. For Frank Body."
**Target agent**: Orchestrator
**PASS if**:
- Correctly identifies Mode B (≥5 of 6 brief fields present)
- Confirms understanding of the brief back to user
- Proceeds directly to Phase 1 (Research Coordinator) without unnecessary questions
- Does NOT ask "do you want me to validate this?" — user already said "validate"

## P3: Research Coordinator — factual neutrality
**Prompt**: Research Coordinator receives a concept brief for a "CBD-infused sleep gummy."
**Target agent**: npd-research-coordinator
**PASS if**:
- Produces fact-only output — NO scores, NO opinions, NO recommendations
- Includes regulatory landscape section (CBD is heavily regulated)
- Covers all 7 required sections from the prompt
- Cites sources with URLs
- Notes data conflicts when they exist rather than choosing one

## P4: Evaluator independence — no cross-contamination
**Prompt**: The orchestrator has just finished running the Market Demand evaluator. It's now launching the Competitive Intel evaluator.
**Target agent**: Orchestrator + npd-competitive-intel
**PASS if**:
- Orchestrator instruction clearly states evaluators must NOT receive other evaluators' output
- The competitive-intel subagent prompt does NOT reference any other evaluator's findings
- The subagent's allowed-tools do NOT include SubAgent (can't spawn its own sub-evaluators)
- Input is limited to concept_brief.md + context_brief.md only

## P5: Market Demand — thin evidence handling
**Prompt**: Market Demand Analyst researches a very niche product: "artisanal fermented cricket protein bars for ultramarathon runners."
**Target agent**: npd-market-demand
**PASS if**:
- Instructions guide the evaluator to mark LOW confidence when evidence is sparse
- Scoring rubric clearly defines what LOW confidence means
- Evaluator is told to search for adjacent category data when direct data is unavailable
- Does NOT say to fabricate or estimate without flagging uncertainty

## P6: Competitive Intel — barriers scoring inversion
**Prompt**: Competitive Intel Analyst evaluates a product in a heavily patented, highly regulated space (e.g., pharmaceutical skincare with novel active ingredient requiring FDA approval).
**Target agent**: npd-competitive-intel
**PASS if**:
- "Barriers to Entry" scoring rubric correctly inverts: HIGH barriers = LOW score (bad for new entrant)
- This inversion is explicitly stated in the prompt (not ambiguous)
- The evaluator would score barriers at 1–3 for this scenario, not 7–9

## P7: Brand Fit — no brand context
**Prompt**: User provides a concept with no brand context: "new brand, launching from scratch."
**Target agent**: npd-brand-fit
**PASS if**:
- Brand Fit prompt explicitly handles the "new brand" case
- Scoring rubric has a separate definition for new brands (credibility barriers, not brand alignment)
- Portfolio Coherence dimension adapts to "hero product strength" instead of cannibalization
- Does NOT score brand alignment as N/A or skip it

## P8: Commercial Viability — price point challenge
**Prompt**: User proposes a premium product at $85 in a category where the mass market is $12–$20 and premium is $30–$45.
**Target agent**: npd-commercial-viability
**PASS if**:
- Pricing Power dimension captures this gap (proposed price far above premium tier)
- Evaluator is instructed to produce a pricing benchmark TABLE that would make this gap visible
- The scoring rubric doesn't automatically penalize premium pricing — it asks whether differentiation justifies it
- Instructions require searching for examples of ultra-premium success in the category

## P9: Consumer Trends — backlash detection
**Prompt**: Consumer & Trend Analyst evaluates a product using a trendy ingredient that has recently faced social media backlash (e.g., "snail mucin" or "retinol" with a counter-trend of "no actives" skincare).
**Target agent**: npd-consumer-trends
**PASS if**:
- Instructions explicitly require searching for NEGATIVE sentiment, not just positive
- Cultural Fit dimension includes backlash risk assessment
- Trend Momentum rubric distinguishes between "trending" and "peaked/declining"
- Evaluator is told to search "[ingredient/trend] controversy" or "[trend] over"

## P10: Devil's Advocate — weak case honesty
**Prompt**: All 5 evaluators scored very high (7–9 across all dimensions). The product concept is strong. Devil's Advocate must still run.
**Target agent**: npd-devils-advocate
**PASS if**:
- Devil's Advocate prompt explicitly says a kill shot of 1–2 is VALID output
- Instructions say "If you can't build a strong case, say so honestly"
- Does NOT force the agent to manufacture problems that don't exist
- Includes the "Honest Assessment" section where the DA can say the product should proceed

## P11: Consensus Director — conflict resolution protocol
**Prompt**: Market Demand scored Timing at 9/10. Competitive Intel identified 4 major launches in last 6 months (implying saturation). These evaluators disagree but never directly reference each other.
**Target agent**: npd-consensus-director
**PASS if**:
- Round 1 instructions detect this as an IMPLICIT conflict (different agents, related dimensions)
- Round 2 instructions generate a specific challenge to Market Demand citing the competitive data
- The challenge format includes the counter-evidence explicitly
- Instructions allow the Consensus Director to adjust scores if the defense is weak

## P12: Consensus Director — override rules
**Prompt**: Final composite score is 5.8 (CONDITIONAL GO). But one dimension scored 2/10 (fatal flaw) and the Devil's Advocate kill shot is 8/10.
**Target agent**: npd-consensus-director
**PASS if**:
- Fatal Flaw Override applies: dimension ≤2 AND kill shot ≥7 → downgrade one level
- Devil's Advocate Override also applies: kill shot ≥8 AND composite in CONDITIONAL range → downgrade to REVISIT
- Both overrides are documented in the report
- Final verdict is REVISIT, not CONDITIONAL GO

## P13: Non-beauty vertical — SaaS product
**Prompt**: User says: "Validate this: an AI-powered meeting summarizer SaaS tool for remote teams, priced $15/user/month, competing with Otter.ai and Fireflies."
**Target agent**: Full pipeline
**PASS if**:
- The methodology skill doesn't contain beauty-specific assumptions that would break for SaaS
- Brand Fit handles "SaaS brand" without confusion
- Commercial Viability handles subscription pricing (not just unit/retail pricing)
- The concept brief template works for digital products (no "ingredients" or "packaging" assumptions)
- Scoring rubrics are phrased generically enough to apply

## P14: Iteration — weight adjustment
**Prompt**: After receiving the report, user says: "For Frank Body, brand fit matters way more than market size. Change weights to Brand Fit 30%, Market Demand 15%."
**Target agent**: Orchestrator
**PASS if**:
- Orchestrator instructions cover weight adjustment as an iteration option
- It explicitly states weight changes do NOT require re-running evaluators
- It re-invokes the Consensus Director to recalculate with new weights
- The methodology skill documents that custom weights should be noted in the report header

## P15: Challenge/rebuttal file protocol
**Prompt**: Consensus Director writes a challenge to the Brand Fit evaluator. The orchestrator needs to re-invoke the Brand Fit subagent to respond.
**Target agent**: Orchestrator + npd-brand-fit + npd-consensus-director
**PASS if**:
- Consensus Director writes challenge to a specific file path (`data/challenges/challenge_brand_fit.md`)
- Brand Fit subagent prompt includes a "Challenge Response Protocol" section
- The protocol tells the evaluator to CHECK for challenge files and respond
- The response format is specified (100–200 words, sources, defend or revise)
- The orchestrator skill instructs re-invocation of the evaluator with challenge context
