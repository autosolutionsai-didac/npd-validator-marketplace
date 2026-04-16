# NPD Validator Plugin — Eval Set v5 (Round 5)

5 adversarial prompts probing gaps after Round 4 hardening.
Focus: real NPD failure modes that show up in consulting engagements.

---

## P31: Sustainability / ESG dimension
**Prompt**: Validate this: a glass-bottled face serum with a "sustainable beauty" positioning. Sustainability is increasingly a purchase driver in beauty — competitors are making aggressive ESG claims (carbon neutral, refillable, ocean plastic packaging).
**Target**: Full pipeline (esp. Consumer & Trends + Commercial Viability)
**PASS if**:
- Sustainability is treated as a material consideration, not just a vague "cultural values" mention
- Consumer & Trends evaluator has explicit guidance on ESG-as-purchase-driver in the category
- Commercial Viability addresses cost implications of sustainable choices (glass vs plastic unit cost, recyclability infrastructure, offset costs)
- Risk of "greenwashing" backlash is flagged if claims are stronger than actual practices
- The report would clearly surface whether sustainability is table-stakes, premium differentiator, or inauthentic claim in this category

## P32: Regulatory runway vs launch horizon
**Prompt**: User wants to launch a novel OTC SPF innovation (new UV filter) with a 12-month launch horizon. Novel UV filters require FDA approval which typically takes 3–5 years in the US. EU approval is faster but still 18 months.
**Target**: npd-research-coordinator + npd-market-demand + orchestrator
**PASS if**:
- Research Coordinator surfaces the regulatory timeline as a Critical Alert
- Timing dimension explicitly considers "regulatory runway vs launch horizon gap"
- If regulatory approval exceeds launch horizon, this is flagged as potentially fatal — not buried
- The report would prevent a GO verdict for a product that literally cannot legally launch in the stated window
- Orchestrator or Methodology gives guidance to check regulatory feasibility against the Launch Horizon

## P33: Go-to-market investment capacity
**Prompt**: Brief includes "small indie brand with $500K annual revenue." The product scores GO across all dimensions but launching it successfully in a category dominated by brands spending $10M+ on marketing would require a capital raise the brand hasn't secured.
**Target**: npd-commercial-viability + npd-devils-advocate
**PASS if**:
- Commercial Viability considers realistic marketing/launch investment required vs brand capacity
- Or: Devil's Advocate is directed to assess "execution capability gap" — can this brand actually fund the launch?
- The product can score GO on dimensions but receive a conditions note: "Requires $X minimum launch budget — confirm brand has capacity"
- Does NOT just say "great product" when the brand financially can't launch it

## P34: Claims substantiation / marketing legal risk
**Prompt**: Product positioning includes "clinically proven 50% wrinkle reduction in 14 days." Such claims carry regulatory liability in the US (FDA), UK (ASA), EU (cosmetics regulation). If the brand doesn't have clinical studies backing the exact claim, this is a legal risk.
**Target**: npd-research-coordinator + npd-devils-advocate
**PASS if**:
- Research Coordinator flags claims substantiation requirements in the regulatory section
- Devil's Advocate includes "claim risk" as part of adversarial research — searches for precedents of ASA/FDA action against similar claims
- The methodology recognizes that unsubstantiated claims can result in regulatory action, retailer delisting, and PR damage
- Before a GO verdict, claims mentioned in positioning should be checked for substantiation feasibility

## P35: Supply chain / single-supplier risk
**Prompt**: Key differentiator is a proprietary ingredient sourced from a single supplier in one country. Commercial Viability scores Unit Economics 8/10 based on current supply, but doesn't consider what happens if that supplier has a disruption.
**Target**: npd-commercial-viability + npd-devils-advocate
**PASS if**:
- Commercial Viability includes supply chain resilience in its research scope (alternative suppliers, ingredient substitutability, geographic concentration)
- Or: Devil's Advocate explicitly probes single-supplier risk as a fragility
- A product reliant on a single unreplaceable source is flagged, not ignored
- Unit Economics scoring considers supply risk, not just current margins
