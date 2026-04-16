# Baseline Evaluation — Iteration 0

## Results

| # | Prompt | Target | Result | Issue |
|---|---|---|---|---|
| P1 | Mode A detection — rough idea | Orchestrator | ✅ PASS | Mode A correctly defined, asks questions, offers Quick Scan |
| P2 | Mode B detection — solid concept | Orchestrator | ✅ PASS | ≥4 fields → confirm + proceed, no unnecessary questions |
| P3 | Research Coordinator neutrality | npd-research-coordinator | ✅ PASS | "librarian not analyst", 7 sections, cites sources, notes conflicts |
| P4 | Evaluator independence | Orchestrator + agents | ✅ PASS | "CRITICAL" isolation note, agents have no SubAgent tool, input limited |
| P5 | Market Demand thin evidence | npd-market-demand | ❌ FAIL | No explicit guidance for thin evidence: no "mark LOW confidence when sparse", no "search adjacent categories", no "never fabricate" |
| P6 | Barriers scoring inversion | npd-competitive-intel | ✅ PASS | Explicitly states "High barriers = LOW score" with correct rubric |
| P7 | Brand Fit no brand context | npd-brand-fit | ✅ PASS | Separate rubrics for new brands, Portfolio Coherence adapts to hero product |
| P8 | Commercial Viability price challenge | npd-commercial-viability | ✅ PASS | Pricing benchmark table, doesn't auto-penalize premium, "premium pricing precedents" in research |
| P9 | Consumer Trends backlash | npd-consumer-trends | ✅ PASS | Searches for controversy, Cultural Fit includes backlash, Trend Momentum covers decline |
| P10 | Devil's Advocate weak case | npd-devils-advocate | ✅ PASS | Kill shot 1–2 is valid, "say so honestly", Honest Assessment section |
| P11 | Consensus Director implicit conflicts | npd-consensus-director | ❌ FAIL | Conflict detection says "contradictory conclusions" but lacks guidance on IMPLICIT conflicts across different dimensions of different evaluators |
| P12 | Override stacking | npd-consensus-director | ❌ FAIL | Fatal Flaw and DA overrides listed separately — unclear if they stack/compound. Could a 5.8 CONDITIONAL be downgraded twice to NO-GO? |
| P13 | SaaS product vertical | Full pipeline | ❌ FAIL | Commercial Viability research cites "COGS breakdown, contract manufacturer pricing, MOQ" — physical product terms. No guidance for digital/SaaS economics (CAC, churn, server costs, LTV) |
| P14 | Weight adjustment iteration | Orchestrator + methodology | ❌ FAIL | Orchestrator says "re-invoke consensus-director" (good) but methodology and report template don't instruct documenting custom weights in the report |
| P15 | Challenge/rebuttal protocol | Orchestrator + agents + director | ✅ PASS | File paths match, challenge response protocol in all evaluators, orchestrator instructs re-invocation |

## Score: 10/15 = 66.7% → BASELINE
