# NPD Validator Plugin — Eval Set v4 (Round 4)

5 adversarial prompts probing gaps after Round 3. Focus: real-world NPD scenarios
that consulting clients bring but that previous rounds didn't test.

---

## P26: Bundled product / collection launch
**Prompt**: Frank Body wants to launch "The Morning Routine" — a 3-product collection (body scrub, body oil, body moisturizer) designed to be used together, priced as a bundle at $65 vs $75 separate. Validate this as a collection, not 3 separate products.
**Target**: Orchestrator + full pipeline
**PASS if**:
- The system recognizes this is NOT a single SKU validation
- Either: (a) validates the BUNDLE as a unit with collection-specific considerations, or (b) validates each component AND the bundled offering with explicit guidance
- Brand Fit evaluates whether a collection makes sense for the brand's current portfolio (vs 3 standalone products)
- Commercial Viability addresses bundle economics: attachment rate, bundle discount margins, inventory SKU complexity
- Market Demand considers whether consumers buy collections in this category or single products
- Does NOT just average 3 separate validations — collections have their own dynamics

## P27: B2B product validation
**Prompt**: Validate this: a novel encapsulated probiotic ingredient ("BioShield-7") sold B2B to cosmetic manufacturers. Target customers are indie beauty brands, $2,500/kg, differentiator is 18-month stability vs industry 6-month standard.
**Target**: Full pipeline
**PASS if**:
- The Target Consumer field handles B2B (cosmetic brand procurement teams, not end consumers)
- Consumer & Trends evaluator adapts — B2B "social sentiment" isn't TikTok/Reddit, it's trade publications, Cosmoprof signals, formulator communities
- Commercial Viability handles B2B pricing (per-kg/per-MT, not retail)
- Brand Fit considers B2B reputation channels (industry awards, certifications, partnerships) not consumer brand alignment
- Does NOT force-fit B2B into a B2C template with nonsensical outputs

## P28: Iteration scope creep
**Prompt**: User has iterated 6 times. V1 was "caffeine body moisturizer for women 25–35." Current V6 is "vegan adaptogenic mist for teens." The concept has drifted so far it's effectively a different product, but the iteration log shows it as "V6 of the same validation."
**Target**: Orchestrator
**PASS if**:
- The orchestrator has a mechanism to detect scope creep across iterations
- Defines what "scope creep" means (core category change, target demographic shift of >1 generation, differentiator completely replaced)
- When detected, asks the user: "This iteration has drifted substantially from V1. Should we close this validation and start a fresh one, or continue as V6?" — gives the user the choice
- Prevents a V7 verdict from being confused with the original concept's validation

## P29: Cultural sensitivity / appropriation risk
**Prompt**: Consumer & Trend Analyst evaluates a product using terms like "shamanic ritual," "tribal formula," or "ancient Ayurvedic secret" in its positioning. The category is trendy but these framings carry appropriation risk.
**Target**: npd-consumer-trends
**PASS if**:
- The Cultural Fit dimension explicitly includes appropriation risk (not just general backlash)
- Instructions direct the evaluator to check the origin of ingredients/concepts used in positioning
- Flags when brand lacks authentic connection to the culture being referenced
- Distinguishes between "inspiration" (acceptable) and "appropriation" (risk)
- Would score Cultural Fit lower for "tribal formula" if the brand has no indigenous community partnerships

## P30: Confidence calibration check
**Prompt**: Market Demand Analyst scores Category Size & Growth 9/10 with HIGH confidence, but the supporting reasoning cites only 1 source (a single Statista report from 2023). HIGH confidence requires ≥2 independent sources per evidence standards.
**Target**: npd-consensus-director (as quality gate)
**PASS if**:
- Round 0 output validation includes a check: "HIGH confidence must be backed by 2+ independent sources cited in the reasoning"
- Flags confidence/evidence mismatches (HIGH confidence with thin sourcing)
- Either downgrades the confidence to MEDIUM, or re-invokes the evaluator to either add sources or lower confidence
- Prevents confidence inflation from propagating into the final report
