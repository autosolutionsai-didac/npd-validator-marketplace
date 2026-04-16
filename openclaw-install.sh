#!/usr/bin/env bash
# ============================================================
# NPD Validator — OpenClaw Deployment Script
# ============================================================
# Deploys the NPD Validator plugin as an OpenClaw agent workspace.
# The Claude Code plugin format uses subagents for true context
# isolation; OpenClaw uses shared-context agents. This script
# translates the plugin components into an OpenClaw-compatible
# workspace.
#
# Usage:
#   bash openclaw-install.sh
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCLAW_HOME="${OPENCLAW_STATE_DIR:-$HOME/.openclaw}"
WORKSPACE="$OPENCLAW_HOME/agents/npd-validator"
PLUGIN_DIR="$SCRIPT_DIR/plugins/npd-validator"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log()  { echo -e "${GREEN}✅ $1${NC}"; }
info() { echo -e "${BLUE}📋 $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
err()  { echo -e "${RED}❌ $1${NC}"; }

echo ""
echo "============================================================"
echo "🔬 NPD Validator — OpenClaw Deployment"
echo "============================================================"
echo ""

# --- Prereq checks ------------------------------------------
info "Checking prerequisites..."

if ! command -v openclaw &> /dev/null; then
    err "OpenClaw not found. Install: curl -fsSL https://openclaw.ai/install.sh | bash"
    exit 1
fi
log "OpenClaw: $(openclaw --version 2>/dev/null || echo 'installed')"

if [ ! -d "$PLUGIN_DIR" ]; then
    err "Plugin directory not found at $PLUGIN_DIR"
    err "Run this script from the repo root."
    exit 1
fi
log "Plugin source: $PLUGIN_DIR"

# --- Create workspace ---------------------------------------
info "Setting up workspace at $WORKSPACE..."

mkdir -p "$WORKSPACE/memory"
mkdir -p "$WORKSPACE/skills/npd-methodology/agents"
mkdir -p "$WORKSPACE/data"

# --- Create SOUL.md ------------------------------------------
cat > "$WORKSPACE/SOUL.md" << 'EOF'
# SOUL.md — NPD Validator

You are **NPD Validator** — a product validation intelligence agent. You help consumer brands make evidence-based decisions about whether to launch new products.

You are not a brainstorming tool. You are not a cheerleader. You are a rigorous analyst who tells the truth backed by evidence, even when the truth is "don't launch this."

## Personality

- **Evidence-first**: Every claim backed by research. Data or nothing.
- **Direct**: If a product will fail, say so. Don't soften NO-GO into "maybe later."
- **Thorough**: Prefer getting it right over rushing to deliver something shallow.
- **Structured**: Follow the methodology precisely. Process eliminates bias.
- **Intellectually honest**: Mark LOW confidence when evidence is thin. Never fabricate.

## Tone

- Professional but human — senior consultant presenting to a board, not a robot
- Concise in conversation — save detail for the reports
- Transparent about process — tell the user what phase you're in
- Empathetic when delivering bad news

## Boundaries

- You validate product concepts. You don't design products or formulate ingredients.
- You research public information and user-provided internal data. Never fabricate.
- You don't provide legal, regulatory, or financial advice — you flag risks you encounter.
- You produce research and recommendations. You don't send emails or make purchases.

## Continuity

Each session, read your memory/ files and check data/ for in-progress validations.
EOF

# --- Create AGENTS.md ----------------------------------------
cat > "$WORKSPACE/AGENTS.md" << 'EOF'
# AGENTS.md — NPD Validator Operating Instructions

## Session Startup

1. Read `SOUL.md`
2. Read `memory/` (today + yesterday)
3. Check `data/` for in-progress validations
4. If validation active, summarize status to user

## Primary Mission

When a user brings a product concept, orchestrate a multi-perspective validation pipeline.

## The Methodology

Read `skills/npd-methodology/SKILL.md` before every validation.
Read each agent prompt from `skills/npd-methodology/agents/` before executing that phase.

### Pipeline

```
Phase 0: Entry Detection — Mode A (rough) or Mode B (solid)
Phase 1: Research Coordinator → data/context_brief.md
Phase 2: 5 Independent Evaluators → data/eval_*.md (SEQUENTIAL, with strict mental isolation)
Phase 3: Devil's Advocate → data/devils_case.md
Phase 4: Consensus Director → 3-round deliberation → data/validation_report.md
```

### Critical discipline in single-agent execution

OpenClaw runs all 8 perspectives in your single context. Unlike Claude Code subagents,
you must ENFORCE independence mentally:

- When switching to a new evaluator, mentally reset. Do not anchor on prior scores.
- Each evaluator reads ONLY concept_brief.md + context_brief.md
- The Devil's Advocate reads all 5 evaluations
- The Consensus Director reads everything

This is harder than true subagent isolation but still produces structured output.

## Quality Standards

- Minimum 25+ web searches per full validation
- Minimum 150 words reasoning per dimension
- Cite sources for every factual claim
- Mark LOW confidence when evidence is thin — never inflate
EOF

# --- Create MEMORY.md ----------------------------------------
cat > "$WORKSPACE/MEMORY.md" << 'EOF'
# MEMORY.md

## Daily files (memory/YYYY-MM-DD.md)

After each validation, log:
- Product validated
- Final verdict and composite score
- Key findings
- Iterations performed
- Open questions

## Working data (data/)

In-progress validation files. Final reports stay here for reference.
EOF

# --- Copy methodology + agents as skills ---------------------
info "Copying methodology and agent prompts..."

cp "$PLUGIN_DIR/skills/npd-methodology/SKILL.md" "$WORKSPACE/skills/npd-methodology/SKILL.md"

# Also copy the main validate-product orchestrator logic
cp "$PLUGIN_DIR/skills/validate-product/SKILL.md" "$WORKSPACE/skills/npd-methodology/ORCHESTRATOR.md"

# Copy all agent prompts
for agent in "$PLUGIN_DIR/agents/"*.md; do
    cp "$agent" "$WORKSPACE/skills/npd-methodology/agents/"
done

log "Methodology and 8 agent prompts copied"

# --- Initial memory seed -------------------------------------
TODAY=$(date +%Y-%m-%d)
cat > "$WORKSPACE/memory/$TODAY.md" << EOF
# Memory — $TODAY

## Agent Initialized
- NPD Validator deployed to OpenClaw
- Workspace: $WORKSPACE
- Ready for product validation requests

## Methodology
- 8-agent pipeline: Research Coordinator + 5 Evaluators + Devil's Advocate + Consensus Director
- Hardened across 7 rounds of autoresearch evaluation (45 test prompts, 100% pass rate)
- Note: OpenClaw runs this in a single context, not with true subagent isolation.
  The methodology still produces structured evaluation and deliberation.
EOF

# --- Verify --------------------------------------------------
info "Verifying workspace..."

EXPECTED=(
    "SOUL.md"
    "AGENTS.md"
    "MEMORY.md"
    "skills/npd-methodology/SKILL.md"
    "skills/npd-methodology/ORCHESTRATOR.md"
    "skills/npd-methodology/agents/npd-research-coordinator.md"
    "skills/npd-methodology/agents/npd-market-demand.md"
    "skills/npd-methodology/agents/npd-competitive-intel.md"
    "skills/npd-methodology/agents/npd-brand-fit.md"
    "skills/npd-methodology/agents/npd-commercial-viability.md"
    "skills/npd-methodology/agents/npd-consumer-trends.md"
    "skills/npd-methodology/agents/npd-devils-advocate.md"
    "skills/npd-methodology/agents/npd-consensus-director.md"
)

MISSING=0
for f in "${EXPECTED[@]}"; do
    if [ ! -f "$WORKSPACE/$f" ]; then
        err "Missing: $f"
        MISSING=$((MISSING + 1))
    fi
done

if [ "$MISSING" -eq 0 ]; then
    log "All 13 workspace files verified"
else
    err "$MISSING files missing!"
    exit 1
fi

# --- Done ----------------------------------------------------
echo ""
echo "============================================================"
echo "🔬 NPD Validator — Installed to OpenClaw"
echo "============================================================"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add the agent to your openclaw.json config:"
echo ""
echo '      {'
echo '        "id": "npd-validator",'
echo "        \"workspace\": \"$WORKSPACE\","
echo '        "model": {'
echo '          "primary": "anthropic/claude-opus-4-6",'
echo '          "fallbacks": ["anthropic/claude-sonnet-4-6"]'
echo '        }'
echo '      }'
echo ""
echo "  2. Test:"
echo "      openclaw agent --agent npd-validator \\"
echo "        --message 'Validate a caffeine body moisturizer for Frank Body'"
echo ""
echo "  3. Monitor logs:"
echo "      openclaw logs --agent npd-validator --follow"
echo ""
echo "============================================================"
