# NPD Validator Plugin — Eval Set v7 (Round 7)

5 adversarial prompts. Focus: specialized go-to-market scenarios that real NPD processes
encounter but that haven't been tested yet.

---

## P41: Retailer buying calendar sync
**Prompt**: Product is planned for a 12-month launch targeting Sephora shelves. Sephora's buying calendar has specific windows — submissions Q1–Q2 for the following year's fall floorset, with 6+ months of lead time before on-shelf. Missing the calendar window = 12-month delay.
**Target**: npd-commercial-viability (Channel Fit) + orchestrator
**PASS if**:
- Channel Fit considers not just whether a channel is accessible but WHEN it can realistically be accessed
- For major retailers with rigid calendars (Sephora, Ulta, Target, Whole Foods), buying cycle timing is factored into the launch feasibility
- If retailer listing is a key channel but the brand missed the buying window, Channel Fit reflects the real delay
- Not just "can we get into Sephora" but "can we get into Sephora IN the launch horizon"

## P42: SKU complexity / line launch mathematics
**Prompt**: Concept is "launch with 5 skincare SKUs simultaneously instead of 1 hero." Five SKUs = 5× inventory capital, 5× testing costs, 5× retailer listing fees, 5× marketing complexity. But also: larger retailer listing conversation, bigger launch moment, more PR hooks. Plugin currently validates as if it were a single SKU.
**Target**: Orchestrator + npd-commercial-viability
**PASS if**:
- Orchestrator distinguishes between single-SKU launches and line launches (which are NOT the same as bundles — distinct SKUs sold separately)
- Commercial Viability handles line launch economics: working capital multiplier, testing cost aggregation, listing fee negotiation leverage
- The validation outputs a recommendation on optimal launch size (hero first? full line? staggered?)
- A 5-SKU launch is not just "5× a single SKU validation" — there are complexity non-linearities

## P43: Forward-looking competitive intel (patent filings)
**Prompt**: Competitive Intel research focuses on launched products and known competitors. But patent filings and trademark registrations are public signals of what WILL launch in 12–24 months. A rival brand with 3 recent patent filings on similar technology is a forward signal Competitive Intel should catch.
**Target**: npd-competitive-intel
**PASS if**:
- The evaluator's research scope includes forward-looking competitive signals: patent filings (USPTO, EPO), trademark registrations, investor filings mentioning product categories, accelerator/incubator stealth-mode companies
- White Space scoring considers NOT JUST current vacuum but IMMINENT competitor arrival
- Research includes "[category] patent filing 2024 2025 2026" or similar forward-looking searches

## P44: International regulatory divergence (same product, different legal form per market)
**Prompt**: Product is a retinol serum planned for US + EU launch. Same formulation, but EU caps retinol at 0.3% while US has no cap. The "same product" is effectively two different products — with different formulation runs, different testing files, different labeling, different marketing claims. Geographic scope check (P21) handles "validate per market" but doesn't flag that formulation itself must differ.
**Target**: npd-research-coordinator + orchestrator
**PASS if**:
- Research Coordinator surfaces not just "EU has different regulations" but "the formulation must be different — this is effectively two products"
- Orchestrator's Geographic Scope check recognizes when markets require PRODUCT differences (not just marketing differences)
- Commercial Viability adjusts for the operational reality of producing and managing two variants
- The validation doesn't assume "one formulation fits all markets" for regulated categories

## P45: Test market / beachhead sequencing
**Prompt**: User says: "We're considering launching in the US market only first as a test, then expanding to EU/UK/Australia in year 2 based on US performance." This is a beachhead strategy — validate in one market, use performance data to de-risk expansion. Different validation framing than "global simultaneous launch."
**Target**: Orchestrator
**PASS if**:
- Orchestrator's Geographic Scope check (P21) recognizes "test market first" as a THIRD option beyond "single market" or "parallel per-market validations"
- The methodology supports validating a primary market with explicit "expansion readiness" considerations: what would US success look like before committing to EU?
- The validation produces success criteria for the beachhead market, not just a GO/NO-GO for US
- Does NOT just default to single-market validation and ignore the expansion intent
