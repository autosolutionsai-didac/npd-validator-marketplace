# AutoSolutions Plugins — Marketplace

Production AI plugins from [AutoSolutions.ai](https://autosolutions.ai). Evidence-based, tested, real-world tools for real business problems.

## Available Plugins

### `npd-validator` — New Product Development Validation

Multi-agent product validation pipeline. Orchestrates **8 specialized subagents** to evaluate new product concepts and produce evidence-based launch recommendations.

**What you get:**
- **GO / CONDITIONAL GO / REVISIT / NO-GO** verdict with composite score (0–10)
- **15 scored dimensions** across Market Demand, Competitive Landscape, Brand Fit, Commercial Viability, Consumer & Trends
- **Devil's Advocate case** — the strongest argument NOT to launch
- **Full source citations** — every claim backed by real research
- **Works for any consumer product vertical**: beauty, CPG, food, wellness, SaaS, B2B

**Validated across 45 test scenarios** spanning 7 rounds of adversarial evaluation. See the [autoresearch results](./autoresearch/results.tsv) for the full methodology and iteration history.

---

## Install in Claude Code

### Option A: Install from this marketplace (recommended)

```bash
# 1. Add the marketplace
/plugin marketplace add autosolutionsai-didac/npd-validator-marketplace

# 2. Install the plugin
/plugin install npd-validator@autosolutions-plugins
```

### Option B: Install from a local clone (for development/testing)

```bash
# 1. Clone the repo
git clone https://github.com/autosolutionsai-didac/npd-validator-marketplace.git
cd npd-validator-marketplace

# 2. Add as a local marketplace
claude /plugin marketplace add ./

# 3. Install
claude /plugin install npd-validator@autosolutions-plugins
```

### Using the plugin

Once installed, run:

```
/npd-validator:validate-product A caffeine-infused body moisturizer targeting 25-35 year old women, priced at $28-35, positioned as clean beauty with an energy boost angle, for Frank Body, launch horizon 9 months
```

Or start with a rough idea:

```
/npd-validator:validate-product I think there's a gap in men's skincare for something simple
```

The plugin will either (a) ask clarifying questions to complete the concept brief, or (b) launch the full 8-agent pipeline directly if you provided enough detail.

---

## Install in OpenClaw

OpenClaw doesn't natively use the Claude Code plugin format, but the plugin's components (agents, skills, orchestrator prompt) can be deployed into an OpenClaw agent workspace.

### Quick install

```bash
# 1. Clone this repo
git clone https://github.com/autosolutionsai-didac/npd-validator-marketplace.git
cd npd-validator-marketplace

# 2. Run the OpenClaw deployer
bash openclaw-install.sh
```

This creates an OpenClaw agent at `~/.openclaw/agents/npd-validator/` with:
- `SOUL.md` — agent identity
- `AGENTS.md` — orchestration protocol derived from the plugin's main skill
- `skills/npd-methodology/` — scoring rubrics and templates
- Per-agent prompts copied into the workspace as skills

After installation:

```bash
# Add to openclaw.json and start chatting with the agent
openclaw agent --agent npd-validator --message "Validate this concept: [your product]"
```

**Note**: OpenClaw runs all 8 agent perspectives within a single context (not true parallel subagents like Claude Code). You still get the methodology, scoring, and deliberation structure — but without process-level isolation between evaluators. For truly independent multi-agent execution, use the Claude Code install.

---

## Repo Structure

```
npd-validator-marketplace/
├── .claude-plugin/
│   └── marketplace.json                    ← marketplace catalog
├── plugins/
│   └── npd-validator/
│       ├── .claude-plugin/plugin.json
│       ├── skills/
│       │   ├── validate-product/SKILL.md   ← main command orchestrator
│       │   └── npd-methodology/SKILL.md    ← scoring rubrics reference
│       ├── agents/                         ← 8 subagents with true isolation
│       │   ├── npd-research-coordinator.md
│       │   ├── npd-market-demand.md
│       │   ├── npd-competitive-intel.md
│       │   ├── npd-brand-fit.md
│       │   ├── npd-commercial-viability.md
│       │   ├── npd-consumer-trends.md
│       │   ├── npd-devils-advocate.md
│       │   └── npd-consensus-director.md
│       └── README.md
├── openclaw-install.sh                     ← OpenClaw deployment script
├── autoresearch/                           ← test eval sets and results log
│   ├── eval_set.md
│   ├── eval_set_v2.md ... v7.md
│   └── results.tsv                         ← 35 experiments, 0 → 100% trajectory
└── README.md
```

---

## How It Works

### The 8-Agent Pipeline

```
Phase 1: Research Coordinator        → shared context brief (category, competitors, trends)
Phase 2: 5 Independent Evaluators    → each runs in its OWN context window:
          • Market Demand              (category size, demand signals, timing)
          • Competitive Intelligence   (white space, competitor weakness, barriers)
          • Brand Fit                  (brand alignment, portfolio, audience)
          • Commercial Viability       (pricing, unit economics, channels)
          • Consumer & Trends          (social sentiment, momentum, cultural fit)
Phase 3: Devil's Advocate            → reads all 5, builds strongest NO-GO case
Phase 4: Consensus Director          → 3-round deliberation:
          Round 0: output validation (catches malformed evaluations)
          Round 1: conflict detection (explicit, implicit, interpretive)
          Round 2: challenge evaluators on conflicts → collect rebuttals
          Round 3: final synthesis + verdict
```

### True Agent Independence

In Claude Code, each evaluator is a **separate subagent with its own context window**. When the Market Demand Analyst scores, it *cannot see* the Competitive Intel Analyst's output — they're different processes. This eliminates the anchoring bias of single-model "multi-perspective" prompting.

### What the methodology validates

- **Market fundamentals**: category size, growth, timing, demand signals
- **Competitive dynamics**: white space (including forward-looking patent signals), competitor weakness, sustainable defensibility
- **Brand alignment**: portfolio coherence, audience fit, cannibalization + migration strategy, inclusivity thresholds
- **Commercial reality**: pricing power, unit economics, channel fit, execution capability, retailer buying calendars, supply chain resilience, climate risk
- **Consumer signals**: social sentiment, trend momentum, cultural fit (with appropriation + ESG + inclusivity checks)
- **Regulatory and testing**: approval timelines, safety testing workflows, claims substantiation, per-market regulatory divergence
- **Launch context**: seasonality, horizon, bundle vs line launch vs single SKU, beachhead vs parallel market strategy, iteration scope creep

---

## Credits

Built by [AutoSolutions.ai](https://autosolutions.ai) — Didac Fernandez Girona.

Methodology inspired by [Andrej Karpathy's autoresearch](https://github.com/karpathy/autoresearch). The plugin was itself built and hardened using that methodology over 7 rounds of adversarial evaluation.

## License

MIT — see [LICENSE](./LICENSE)

## Issues / Contributions

Open an issue at [GitHub](https://github.com/autosolutionsai-didac/npd-validator-marketplace/issues).
