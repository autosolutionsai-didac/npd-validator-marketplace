# NPD Validator — Claude Code Plugin

Multi-agent product validation pipeline that orchestrates 8 specialized subagents to evaluate
new product concepts and produce evidence-based launch recommendations.

## What It Does

When you run `/npd-validator:validate-product`, the plugin:

1. **Research Coordinator** gathers market data, competitor profiles, and category facts
2. **5 Independent Evaluators** each run in their own context window — no anchoring bias:
   - Market Demand Analyst (category size, demand signals, timing)
   - Competitive Intelligence Analyst (white space, competitor weakness, barriers)
   - Brand Fit Strategist (brand alignment, portfolio coherence, audience fit)
   - Commercial Viability Analyst (pricing power, unit economics, channels)
   - Consumer & Trend Analyst (social sentiment, trend momentum, cultural fit)
3. **Devil's Advocate** reads all 5 evaluations and builds the strongest case NOT to launch
4. **Consensus Director** identifies conflicts, challenges evaluators, and produces the final report

Each evaluator is a **real subagent with its own context window** — not one model pretending to
be multiple perspectives. This ensures genuine analytical independence.

## Install

```bash
claude --plugin-dir /path/to/npd-validator-plugin
```

Or from a marketplace:
```
/plugin install npd-validator
```

## Usage

```
/npd-validator:validate-product A caffeine-infused body moisturizer targeting 25-35 year old
women, priced at $28-35, positioned as clean beauty with an energy boost angle, for Frank Body
```

Or start with a rough idea:
```
/npd-validator:validate-product I think there's a gap in men's skincare for something simple
```

## Output

A comprehensive validation report with:
- **Verdict**: GO / CONDITIONAL GO / REVISIT / NO-GO
- **Composite Score**: weighted average of 15 scored dimensions
- **Master Scorecard**: all 15 dimensions with scores and confidence
- **Competitor Map**: top competitors with positioning analysis
- **Pricing Benchmarks**: category pricing tiers
- **Trend Evidence**: social signals and cultural alignment
- **Devil's Advocate Case**: strongest counter-arguments with kill shot rating
- **Deliberation Log**: how conflicts were identified and resolved
- **Recommended Next Steps**: specific actions

## Iteration

After the report, you can:
- **Pivot**: "What if we repositioned as premium?" → re-runs pipeline
- **Deepen**: "Dig deeper on competitive landscape" → re-runs that evaluator
- **Challenge**: "I disagree with the brand fit score because..." → evaluator re-assesses
- **Reweight**: "Brand fit matters more for us" → recalculates composite

## Architecture

```
npd-validator-plugin/
├── .claude-plugin/
│   └── plugin.json               ← Plugin manifest
├── skills/
│   ├── validate-product/
│   │   └── SKILL.md              ← Main /validate-product command (orchestrator)
│   └── npd-methodology/
│       └── SKILL.md              ← Scoring rubrics and templates (reference)
├── agents/
│   ├── npd-research-coordinator.md
│   ├── npd-market-demand.md
│   ├── npd-competitive-intel.md
│   ├── npd-brand-fit.md
│   ├── npd-commercial-viability.md
│   ├── npd-consumer-trends.md
│   ├── npd-devils-advocate.md
│   └── npd-consensus-director.md
└── README.md
```

## Requirements

- Claude Code with subagent support
- Web search enabled (essential for market research)
- Recommended: Opus for Consensus Director, Sonnet for evaluators

## Credits

Built by [AutoSolutions.ai](https://autosolutions.ai).
Methodology inspired by [Karpathy's autoresearch](https://github.com/karpathy/autoresearch).
