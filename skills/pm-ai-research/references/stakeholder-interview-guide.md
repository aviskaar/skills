# Stakeholder Interview Guide

Question banks and interview structures for gathering intelligence from each stakeholder group. Used by the `stakeholder-intel` skill and `pm-lead` orchestrator. Adapt questions to context — these are starting points, not rigid scripts.

**Universal interview rules**:
- Ask about behavior and history, not opinions and preferences ("walk me through the last time..." beats "what do you want?").
- Probe for root cause, not surface symptoms ("why did that matter to you?").
- Silence is a tool — let the interviewee fill it.
- Take verbatim notes on the most vivid quotes — they will power proposals and PRDs.
- Never lead with solutions ("would you use a feature that...") — this contaminates data.
- Allow 45–60 minutes. Never rush.

---

## Customers

**Goal**: Understand the real job they're trying to do, the pain of the current state, and what success looks like for them.

**Opening**:
"I'm not here to sell anything today — I want to understand how you work and where things are painful. The more honest you are, the more useful it is for us."

**Core questions**:
1. Walk me through how your team accomplishes [relevant workflow] today, from start to finish.
2. Where does that process break down or slow down?
3. What workarounds are you using? (Workarounds are gold — they reveal real need.)
4. What does a good outcome look like for your team on this? How do you measure it?
5. What have you tried that didn't work?
6. Who else is affected when this process goes wrong?
7. If you had a magic wand and could change one thing about [product/process], what would it be?
8. What would need to be true for you to expand your use of [product] / increase your team's investment?
9. What would trigger you to look at alternatives?
10. Who else in your organization should I talk to about this?

**Churn / at-risk customers** (additional questions):
- What was the moment you realized [product] wasn't working for you?
- What did you switch to and why?
- What would have had to be different for you to stay?

---

## Sales

**Goal**: Understand win/loss patterns, objection themes, competitive dynamics, and deal blockers.

**Core questions**:
1. Walk me through the last 3 deals you won. What was the deciding factor?
2. Walk me through the last 3 deals you lost. What was the deciding factor?
3. What objections do you hear most frequently in the sales cycle?
4. Which competitors come up most often? What do they say about us vs. them?
5. What's the first thing prospects ask about that we can't answer well?
6. What demo moments make customers lean in vs. disengage?
7. What do you wish the product could do that you could show in a demo?
8. What's the #1 reason deals stall after a great first meeting?
9. Which customer segment is easiest to close right now and why?
10. Which segment should we be targeting that we're not? Why?
11. What do customers ask for in the contract that we can't currently offer (SLAs, features, integrations)?
12. If you could change one thing about the product to close 20% more deals, what would it be?

---

## Sales Engineers (SEs / Solutions Consultants)

**Goal**: Understand technical objections, integration friction, demo gaps, and workaround hacks that reveal real product gaps.

**Core questions**:
1. What are the most common technical objections you encounter during a proof of concept?
2. Walk me through the last PoC you lost. What broke down technically?
3. What integrations do customers ask for most that we don't have?
4. What are you hacking or workaround-ing during demos that you shouldn't have to?
5. Where does the product behave unexpectedly in customer environments?
6. What part of a PoC always takes longer than it should?
7. What do competitors' SEs demo that you can't match?
8. What do enterprise customers ask about on security, compliance, or architecture that we handle poorly?
9. What's the most common thing you have to explain multiple times before customers understand?
10. If you were the PM, what's the first thing you'd fix?

---

## Marketing

**Goal**: Understand positioning gaps, ICP clarity, messaging confusion, and campaign signal.

**Core questions**:
1. What positioning or messaging is working best right now with prospects?
2. What messaging consistently falls flat or creates confusion?
3. Who is responding best to our campaigns right now? Who isn't?
4. What does the market think we do? How does that differ from what we actually do?
5. What categories do analysts put us in? Are we comfortable with that framing?
6. What do competitor brands stand for that we don't? What do we stand for that they don't?
7. What content resonates most — what are prospects actually reading or engaging with?
8. What events, communities, or channels are driving the best pipeline? What's underperforming?
9. What product capabilities are hardest to market because they're hard to explain?
10. If we could make one change to the product that would make marketing 10x easier, what would it be?

---

## Developers / Engineering

**Goal**: Understand tech debt signals, API friction, feasibility concerns, internal tooling needs, and build priorities.

**Core questions**:
1. What parts of the codebase slow you down most when building new features?
2. What external APIs or integrations do you wish we had but don't?
3. What do we build repeatedly that should be abstracted or automated?
4. What customer requests do you frequently see as technically infeasible with our current architecture? What would need to change?
5. What technical debt is costing us the most in delivery speed?
6. What infrastructure investments would unlock 2–3 features we can't build today?
7. What tooling or platform improvements would make your team 20% faster?
8. Where do you see us falling behind technically vs. where the industry is moving?
9. What parts of the system are most brittle or prone to production incidents?
10. If the PM could give you one quarter to work on anything architecture-related, what would you tackle?

---

## C-Level (CEO, CPO, CTO, CMO, CRO)

**Goal**: Understand strategic priorities, OKR pressure, investor narrative, M&A signals, and company-level bets.

**Core questions**:
1. What does winning look like for us in 12 months? In 3 years?
2. What are the 2–3 things that, if we get right, will define our success this year?
3. Where are we most at risk of losing to competitors in the next 6–12 months?
4. What do you hear from investors / the board that's shaping our priorities?
5. Where do you see the most important untapped market opportunity?
6. Are there adjacent markets or new customer segments we should be entering?
7. What capabilities are table stakes to protect our current base? What's our offensive bet?
8. What would a competitor need to build to make us irrelevant?
9. What partnerships, acquisitions, or ecosystem moves are on your radar?
10. What should product management be spending more time on that we're currently under-indexing?

---

## Investors / Board Members

**Goal**: Understand portfolio thesis, growth expectations, competitive view, and what the board needs to see.

**Note**: These conversations happen less frequently and require clear purpose. Use for annual strategy reviews and funding-adjacent planning.

**Core questions**:
1. What's your current thesis on this market? Has it changed in the last 6–12 months?
2. What do you hear from other portfolio companies in adjacent spaces that's relevant to us?
3. What metrics do you use to assess whether we're on the right track?
4. What competitive move are you watching most closely?
5. Where do you see the biggest risk to our market position?
6. What do you think we're underestimating in our strategy?
7. What do the best companies in adjacent markets do that we should study or borrow?
8. What would make you most excited about our product roadmap?
9. What would cause you concern if you saw it in our roadmap?
10. Are there customers, partners, or market experts you'd recommend we talk to?

---

## Support Teams

**Goal**: Understand recurring pain patterns, usability failures, and documentation gaps that represent latent product debt.

**Core questions**:
1. What are the top 5 most common questions or issues you handle each week?
2. Which issues come back repeatedly even after we think they're resolved?
3. What do customers get frustrated about most — where do you hear the most frustration in their voice?
4. What workarounds are you teaching customers that shouldn't be necessary?
5. What's the longest-standing open issue that customers complain about?
6. Which features generate the most confusion or misuse?
7. What documentation do you wish existed that doesn't?
8. What do enterprise customers ask about that SMB customers don't?
9. Which issues, if fixed, would cut your support volume by 20%?
10. What do customers say when they're about to churn — what's the last straw?

---

## Interview Analysis Checklist

After each interview, before moving to the next:

- [ ] Captured verbatim quotes on the most vivid pain points.
- [ ] Identified the underlying job or outcome (not just the surface request).
- [ ] Noted any competitive mentions (what alternative was referenced?).
- [ ] Flagged any contradiction with previous interviews.
- [ ] Noted urgency signals (blocking a deal? triggering churn? a "nice to have"?).
- [ ] Identified any new stakeholders to interview ("you should also talk to...").
- [ ] Added findings to the Stakeholder Intelligence Brief in progress.
