# NPD Validator Plugin — Eval Set v6 (Round 6)

5 adversarial prompts probing remaining gaps after 5 rounds of iteration.
Focus: genuine NPD failure modes that have caused real product launch failures.

---

## P36: Accessibility / inclusive design
**Prompt**: Validate this: a "universal" foundation launching with 12 shades. In 2026, after Fenty Beauty's 50-shade precedent set the bar, 12 shades is below industry minimum for credibility. The brand risks backlash for inadequate range, retailer pushback, and loss of credibility with BIPOC consumers.
**Target**: npd-brand-fit + npd-consumer-trends
**PASS if**:
- The plugin recognizes inclusive design as a credibility threshold in categories where it's expected
- Brand Fit evaluator considers whether the product meets inclusivity benchmarks for the category
- Consumer & Trends flags backlash risk for products that fall short of inclusivity expectations
- Does NOT require the user to explicitly mention inclusivity — it's a category consideration the evaluator should surface
- Applies to more than just shade range: accessibility features (pump grip, texture options, scent-free variants), inclusive marketing, etc.

## P37: Climate sourcing resilience
**Prompt**: Key differentiator is "sustainably sourced shea butter." Shea production faces documented climate risks — West African shea trees are affected by rising temperatures and shifting rainfall patterns. 3–5 year projections show potential supply constraints and price volatility.
**Target**: npd-research-coordinator + npd-commercial-viability
**PASS if**:
- Research Coordinator's research scope includes climate-related supply risks for key ingredients (not just current supply)
- Commercial Viability's supply chain check considers CLIMATE resilience, not just geopolitical/supplier risk
- The plugin distinguishes short-term supply stability (can we get it now?) from long-term climate resilience (will this crop exist in 5 years?)
- For Launch Horizons of 24+ months, climate risk becomes more material — the methodology should reflect that

## P38: Product safety testing requirements
**Prompt**: Brief describes a new face oil with 18 novel ingredients. Cosmetic launches require patch testing, stability testing, microbial testing, preservative efficacy (challenge testing), and PIF (Product Information File) in the EU. 18 novel ingredients = extensive testing timeline. User's Launch Horizon is 9 months.
**Target**: npd-research-coordinator + npd-market-demand (Timing)
**PASS if**:
- Research Coordinator's research includes typical safety testing timelines for the category
- The methodology distinguishes between REGULATORY APPROVAL (P32, novel ingredients/claims) and SAFETY TESTING (every cosmetic launch requires this)
- Safety testing timelines are factored into Timing alongside regulatory approval
- A product with 18 novel ingredients and 9-month horizon should trigger a timing concern even without formal regulatory approval pending

## P39: Seasonality and launch timing within year
**Prompt**: User's Launch Horizon is 12 months. Product is a body self-tanner. In beauty, self-tanners peak in demand May–August (summer). A January launch misses the prime sell-in window and faces dead inventory through Q1–Q2. Market Demand scoring should consider WHEN within the year, not just WHICH year.
**Target**: npd-market-demand + orchestrator
**PASS if**:
- Launch Horizon captures not just the duration but ideally the target month/season
- Market Demand's Timing dimension considers seasonal demand cycles for seasonal categories
- Categories with strong seasonality (self-tanners, sunscreen, winter lip care, holiday fragrance) get explicit seasonal considerations
- The orchestrator asks about seasonal launch timing when the category is seasonal

## P40: Existing product retirement / migration strategy
**Prompt**: Frank Body's new product would replace/obsolete their existing Hero SKU (which still generates $2M/year). Validation so far has covered cannibalization but not migration: how do existing customers move from old to new? What about customers with subscriptions to the old SKU? What about unsold inventory?
**Target**: npd-brand-fit + orchestrator (output recommendations)
**PASS if**:
- When Brand Fit identifies cannibalization of an existing revenue-generating SKU, the methodology triggers a migration strategy consideration
- The final report's Recommended Next Steps section includes migration/retirement planning when applicable
- Subscription customer migration, inventory run-down, and brand communication are called out as pre-launch requirements
- A GO verdict on a cannibalizing product includes explicit conditions on retirement planning
