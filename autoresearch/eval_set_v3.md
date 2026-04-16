# NPD Validator Plugin — Eval Set v3 (Round 3)

5 adversarial prompts probing remaining gaps after Round 2 hardening.

---

## P21: Multi-market geographic scope
**Prompt**: User says: "Validate this skincare product for launch in US, UK, Germany, and Japan simultaneously. Frank Body wants a global rollout."
**Target**: Orchestrator + full pipeline
**PASS if**:
- The system recognizes that a single composite score across 4 different markets is misleading
- Either: (a) asks the user to pick a primary market, or (b) runs parallel validations per market and produces per-market verdicts
- Regulatory evaluation handles per-market differences (EU has stricter cosmetic ingredient rules than US)
- Final report doesn't produce ONE verdict for "global" — that would hide market-specific NO-GOs

## P22: Launch timing horizon
**Prompt**: User provides a complete concept brief but doesn't specify when they want to launch. The Market Demand evaluator scores Timing 8/10 assuming "now," but user actually planned a 2-year development cycle.
**Target**: Orchestrator + npd-market-demand
**PASS if**:
- The Concept Brief template includes or prompts for "launch horizon" (now / 6 months / 1 year / 2+ years)
- The Timing dimension scoring considers WHEN the product will actually reach market, not just current state
- If user didn't specify, orchestrator asks before Market Demand evaluates
- A "trend peaked in 6 months" scoring 8 for 2027 launch would be wrong — the methodology prevents this

## P23: Evaluator produces malformed output
**Prompt**: Commercial Viability Analyst returns output but skipped the Pricing Benchmarks table and only wrote 80 words on Channel Fit (below the 150-word requirement).
**Target**: npd-consensus-director (as orchestrator/quality gate)
**PASS if**:
- Consensus Director instructions include a validation check on incoming evaluator outputs
- Defines what "malformed" means (missing scores, missing sections, word count below minimum)
- Has recovery protocol: re-invoke the evaluator with specific feedback on what's missing
- Does NOT proceed with the incomplete evaluation and pretend it's fine

## P24: User-provided internal data
**Prompt**: User says: "We have actual sales data from 3 similar products in our portfolio over 2 years. Here's the CSV. Use this instead of web estimates for Commercial Viability."
**Target**: Orchestrator + npd-commercial-viability
**PASS if**:
- Orchestrator has a protocol for accepting user-provided data files
- Saves user data to a known location (e.g., `data/user_provided/`)
- Commercial Viability agent is instructed to prioritize user data over external estimates when available
- Confidence for dimensions backed by internal data should be HIGH (not the default LOW when evidence is thin)
- The final report notes which scores were informed by user-provided data

## P25: Differentiator defensibility
**Prompt**: The product has a unique "clinically-tested probiotic blend" as its key differentiator. Competitive Intel scored White Space at 8/10 (genuine gap). But the differentiator is not patented and could be copied by incumbents within 6 months of launch.
**Target**: npd-competitive-intel + npd-devils-advocate
**PASS if**:
- Barriers to Entry dimension OR a related factor captures "how defensible is our differentiator once launched"
- The Devil's Advocate prompt includes searching for "moat erosion" / "competitive response" / "fast followers"
- White Space scoring accounts for SUSTAINABLE white space, not just current vacuum
- A high White Space score with no defensibility should trigger a Devil's Advocate flag
