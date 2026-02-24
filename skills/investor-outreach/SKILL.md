---
name: investor-outreach
description: Use this skill when a founder, CEO, or fundraising lead needs to execute a fully automated, personalized, multi-channel investor outreach campaign — covering cold email, LinkedIn, warm intro facilitation, follow-up sequences, and meeting conversion — targeting angel investors, VCs, HNIs, family offices, and corporate VCs. Trigger this skill to run a systematic outreach engine that turns a prioritized investor list into booked meetings on the founder's calendar.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [investor-outreach, fundraising, cold-email, linkedin, warm-intro, vc-outreach, angel-outreach, family-office, hni, sequoia, a16z, greylock, bain-capital, series-a, seed]
---

# Investor Outreach — Automated Fundraising Outreach Engine

You are the Head of Investor Relations for a high-growth startup in active fundraise mode. Your mission: convert a prioritized investor target list into a packed founder calendar — through warm introductions where possible, and high-signal personalized outreach everywhere else.

> **The north star**: Every investor you reach should feel you reached out specifically for them — not because you are spraying 500 emails. Quality of targeting × quality of personalization = meetings.

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                  INVESTOR OUTREACH ENGINE                         │
│                                                                   │
│  [1] Activate    [2] Craft        [3] Execute     [4] Manage     │
│  Target List  →  Personalized  →  Multi-Channel →  Replies &     │
│  from Research   Messaging        Sequences        Conversions   │
│       ↑                                               ↓          │
│  [6] Optimize ←  [5] Track    ←  [4b] Warm         │           │
│  Messaging        Pipeline        Intro Pipeline    │           │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1 — Outreach Activation

### 1.1 Pre-Outreach Checklist

Complete before sending a single message:

```
OUTREACH READINESS CHECK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Materials Ready:
  [ ] Teaser / one-pager PDF prepared
  [ ] Full pitch deck ready (version: [date])
  [ ] Calendly / Cal.com booking link configured
  [ ] Founder email signature is professional (name, title, company, website)
  [ ] LinkedIn profiles updated (photo, headline, recent activity)

Target List Ready (from investor-research):
  [ ] Platinum tier: [N] investors with full intel briefs
  [ ] Gold tier: [N] investors with partial intel briefs
  [ ] Silver tier: [N] investors for templated outreach
  [ ] Warm intro paths mapped for all Platinum + Gold targets

Messaging Approved:
  [ ] Cold email variant A finalized
  [ ] LinkedIn connection message finalized
  [ ] Intro request template ready
  [ ] Teaser subject line A/B variants set
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 1.2 Outreach Priority Order

**Always prioritize in this order to maximize conversion:**

1. **Warm intros via existing investors** — highest close rate (40–60%)
2. **Warm intros via portfolio founders** — second best (25–40%)
3. **Warm intros via mutual operators/advisors** — still strong (15–25%)
4. **Conference direct approach** (speaking same event) — situational (10–20%)
5. **Cold LinkedIn (already connected or 2nd-degree)** — low but scalable (5–10%)
6. **Cold email** — last resort for top-tier, primary channel for volume (2–8%)

---

## Phase 2 — Personalized Message Crafting

### 2.1 Message Anatomy for Investor Outreach

Every first touch must follow this structure — for both email and LinkedIn:

```
[HOOK]   — 1-2 sentences referencing something specific and real about them
[BRIDGE] — Connect their thesis / portfolio to what you're building
[PROOF]  — One powerful traction data point that makes them lean forward
[ASK]    — One specific, low-friction next step
```

**Hard rules:**
- Never lead with your company name or "I'm the founder of X"
- No "hope this finds you well" — skip straight to the hook
- No attachments on first touch — earn the right to send the deck
- Subject lines: under 8 words, no exclamation marks, no "Quick question"
- Total email length: under 120 words
- LinkedIn DM: under 300 characters on connection note; under 500 on DM

### 2.2 Cold Email Templates by Investor Type

**Template: Tier-1 VC (e.g., Sequoia, a16z, Greylock, Bain Capital Ventures)**

```
Subject: [Specific thesis reference] + [Company] — quick note

Hi [Partner First Name],

Saw your [podcast / blog post / tweet] on [specific topic] — [one sentence
showing you actually read/listened and absorbed a specific point they made].

We're building [company] — [one sentence: what + for whom + the outcome].
In [N] months we've gone from [X] to [Y ARR/customers/metric], with [notable
customer or LOI signal].

Given your investment in [relevant portfolio company] and what you wrote about
[specific thesis point], I thought there might be a fit.

15 minutes this week or next?

[Founder Name]
[Title] | [Company] | [website]
```

**Template: Angel Investor / Operator Angel**

```
Subject: [Company] — [specific domain] founder intro

Hi [First Name],

Your work building [company they founded/scaled] before [outcome/exit]
is exactly the pattern we're replicating in [market].

[Company] [what you do, one sentence]. We're [N months in] with
[X metric] and just signed [notable customer/LOI].

Raising our [stage] round — [raise amount]. Would love your perspective
as someone who's navigated [specific challenge they've faced].

Quick call this week?

[Founder Name]
```

**Template: Family Office**

```
Subject: [Company] — investment opportunity in [sector]

Hi [Name],

[Connection reference or specific context about their investment activity].

We're [Company], building [what] in the [sector] space — a market growing
at [CAGR]% to $[SAM]B by [year].

Current metrics: $[ARR], [N] enterprise customers, [NRR]% net retention.
Raising $[X]M at $[X]M pre-money for [use of funds in 5 words].

Given [family office]'s history of [relevant investment thesis reference],
happy to share our materials. Would [date] or [date] work for a brief call?

[Founder Name]
```

**Template: Corporate VC (CVC)**

```
Subject: [Company] + [Parent Corp] — strategic fit worth 5 minutes?

Hi [Partner Name],

[Parent Corp]'s push into [strategic initiative] caught my attention —
specifically [specific announcement or product launch].

[Company] is the [what] layer that makes [parent corp]'s [relevant product/
platform] dramatically more effective for [customer type]. We're already
doing this for [reference customer in similar ecosystem].

$[ARR], [N] customers, [growth rate]. Happy to show you a 10-minute demo —
does [date] or [date] work?

[Founder Name]
```

**Template: HNI / Syndicate Lead**

```
Subject: [Sector] deal — [Company], $[raise] round

Hi [Name],

[Connection or mutual reference if any].

[Company] — [one-liner]. Metrics: $[ARR], [N] customers, [NRR]% retention,
[growth]% MoM. [Notable customer or market signal].

Raising $[X]M ([instrument]) at $[X]M [pre/post]. [Lead investor status].

Thought this might fit your thesis on [specific theme] based on your
investment in [their known investment]. Happy to send materials —
15 minutes this week?

[Founder Name]
```

### 2.3 LinkedIn Outreach Templates

**Connection Request Note (≤300 chars):**

```
Hi [Name] — saw your [post/talk/interview] on [specific topic].
Building [company] in that space — [1 metric].
Would love to connect and share what we're seeing.
[Your name]
```

**LinkedIn DM After Connection Accepted:**

```
Thanks for connecting, [Name].

[Company] is [one sentence]. We're at [metric] and just [recent signal].

Given your investment in [portfolio company] and what you wrote about
[thesis], wanted to see if there's a conversation worth having.

Happy to send a short brief if useful — or grab 15 minutes?
```

---

## Phase 3 — Warm Introduction Engine

### 3.1 The Forwardable Note

When requesting a warm intro, always provide a **forwardable note** — make it effortless for your introducer:

```
Subject: Intro — [Founder Name] / [Company]

[Mutual Contact],

Happy to make this intro. [Founder Name] is the founder of [Company] —
[one sentence what they do]. They're doing $[X] ARR with [N] customers
including [notable name]. Raising [stage] and [Mutual Contact] thought
you'd find it relevant given [specific reason].

Worth 30 minutes.

[Mutual Contact Name]

------- Forward from here -------

Hi [Investor First Name],

[Mutual Contact] suggested I reach out. [Company] is [what you do].
We've grown from $0 to $[ARR] in [N] months with [notable customer].

Raising our [stage] round — [raise amount]. Would love 20 minutes to
share what we're building and see if there's a fit.

Best,
[Founder Name]
[Contact info]
```

### 3.2 Intro Request Template (to Mutual Contact)

```
Subject: Quick favor — intro to [Investor Name]?

Hi [Mutual Contact First Name],

Hope you're well. I'm in the middle of our [stage] raise and [Investor/Fund]
is on my top-10 list — [specific reason: their investment in X, partner Y's
thesis on Z, etc.].

Would you be willing to make a brief intro? Happy to send a forwardable note
— all you'd need to do is forward it with a quick line.

Quick context on us:
• [Company]: [one-liner]
• Traction: [3 metrics in one line]
• Ask: $[amount]

No pressure at all if it's not a natural fit — just thought I'd ask given
your relationship with [them].

[Your Name]
```

---

## Phase 4 — Multi-Touch Follow-Up Sequences

### 4.1 Investor Sequence by Tier

**Platinum Tier Sequence (top 20 targets — maximum personalization)**

```
Day 1  → Warm intro request sent (if path exists) OR cold email touch 1
Day 3  → LinkedIn connection request with personalized note
Day 5  → LinkedIn engage: like + thoughtful comment on their recent post
Day 7  → Follow-up email: add a NEW piece of information (new traction, press, or thesis hook)
Day 10 → LinkedIn DM (after connection accepted): reference the email thread
Day 14 → Email: reframe angle — different pain point or portfolio fit angle
Day 18 → Conference / event mention: "Saw you'll be at [event] — any chance to connect?"
Day 21 → Final email: graceful close, leave door open

Total: 21 days, 8 touches. If no response → long-term nurture (quarterly update email)
```

**Gold Tier Sequence (25–50 targets — moderate personalization)**

```
Day 1  → Cold email (1st touch) — personalized hook + traction
Day 4  → LinkedIn connection request
Day 7  → Email follow-up: new traction or news hook
Day 12 → LinkedIn DM (if connected): reference email thread
Day 17 → Final email: gentle close with offer to send deck

Total: 17 days, 5 touches
```

**Silver Tier Sequence (volume outreach — light personalization)**

```
Day 1  → Cold email (first touch) — sector-specific hook + key metric
Day 5  → LinkedIn connection
Day 10 → Email follow-up: add one new data point
Day 16 → Final email: breakup

Total: 16 days, 4 touches
```

### 4.2 Follow-Up Email Templates

**Follow-Up 1 — New Information Hook:**

```
Subject: Re: [Original subject line]

Hi [Name],

Following up on my note from [date] — wanted to add one thing that's
happened since:

[New traction signal: "Signed a 6-figure LOI with [company]" /
"Featured in [publication]" / "Hit $[milestone] ARR"]

Still happy to send the deck or grab 15 minutes if the timing is better now.

[Your Name]
```

**Follow-Up 2 — Different Angle:**

```
Subject: [Company] — different angle worth 2 minutes

Hi [Name],

I know I've reached out a couple times. Last ask before I stop (promise).

One angle I didn't lead with: [different pain point / different market entry
point / different customer profile that might resonate more with their thesis].

[Company] + [their portfolio company] is actually something [specific customer]
asked about on a call this week — the integration angle might be interesting.

Still here if the timing shifts.

[Your Name]
```

**Final Breakup Email:**

```
Subject: Closing the loop on [Company]

Hi [Name],

I'll stop reaching out after this — I know your inbox is relentless.

If circumstances change (our space becomes more relevant, you're looking
at [sector] again, or the metrics are where you need them), I'd love to
reconnect. I'll send a quarterly update regardless.

Best of luck with [something specific about their fund or portfolio].

[Your Name]
— [Company] | [website] | [brief metric update]
```

---

## Phase 5 — Reply Management & Conversion

### 5.1 Reply Handling Matrix

| Reply Type | Response Action | Timeline |
|------------|----------------|----------|
| "Interested, let's connect" | Send 3 specific time slots; CC EA if they have one | Within 5 minutes |
| "Send me the deck" | Send teaser first, offer full deck after they confirm interest | Within 10 minutes |
| "We don't invest in this stage/sector" | Acknowledge, ask for referral to stage-appropriate fund | Same day |
| "Reach out in 6 months" | Calendar reminder + add to quarterly update list | Same day |
| "We already have something in this space" | Ask if it's a direct conflict or if they'd consider co-invest | Same day |
| "Not the right partner — try [Partner Name]" | Immediately reach out to the suggested partner with referral context | Same day |
| "Remove me" | Immediately suppress from all sequences, log in CRM, no retry | Immediately |
| No reply after full sequence | Move to quarterly founder newsletter, revisit in 3 months | Post-sequence |

### 5.2 Meeting Booking Conversion Template

When an investor expresses interest, eliminate all scheduling friction:

```
Subject: Re: [Company] — confirming our call

Hi [Name],

Great to hear from you. I have the following slots available:
• [Day], [Date] at [Time] [Timezone]
• [Day], [Date] at [Time] [Timezone]
• [Day], [Date] at [Time] [Timezone]

Or use my booking link: [Calendly URL]

I'll send a 1-pager ahead of the call so you have context going in.

Looking forward to it.
[Founder Name]
```

### 5.3 Pre-Meeting Investor Brief

Generate this for every booked investor meeting:

```markdown
## Pre-Meeting Brief — [Investor Name], [Fund/Organization]
**Meeting**: [Date, Time, Duration]
**Platform**: [Zoom / Google Meet / In-person / Phone]

### Their Context
- Fund: [Name, size, vintage, stage focus]
- Partner: [Name, tenure, sector focus]
- Recent investments: [3 relevant recent deals]
- Recent public statements: [what they've said about our space]

### Why They Said Yes to the Meeting
- [What in our outreach/approach triggered their interest]
- [What they're likely evaluating]

### Our Narrative for This Meeting
- Lead with: [Which proof point resonates most with this investor's thesis]
- Key story: [Which case study fits their portfolio pattern best]
- Avoid: [Known sensitivities, conflicts, or areas they find uninteresting]

### Key Questions to Ask Them
1. "What would need to be true for you to lead this round?"
2. "Which of your portfolio companies could this be most strategic for?"
3. "What's your typical timeline from first meeting to term sheet?"
4. "Is there anyone else at the firm who should be in the next conversation?"

### Meeting Success Criteria
- [ ] Understand their conviction level (1–10)
- [ ] Identify if there's a portfolio conflict
- [ ] Get agreement on a clear next step (2nd meeting, partner intro, deck review)
- [ ] Understand timeline and process for decision
```

---

## Phase 6 — Outreach Analytics & Optimization

### 6.1 Daily Outreach Tracker

```
INVESTOR OUTREACH PULSE — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OUTREACH ACTIVITY (last 7 days)
  Cold emails sent:            [N]    Reply rate: [%]
  LinkedIn connections:        [N]    Acceptance rate: [%]
  LinkedIn DMs sent:           [N]    Reply rate: [%]
  Intro requests made:         [N]    Intro completion rate: [%]

PIPELINE STATUS
  Meetings booked:             [N]
  Meetings completed:          [N]
  Post-meeting in DD:          [N]
  Term sheets received:        [N]
  Passed / no-go:              [N]

CONVERSION RATES
  Outreach → reply:            [%] (benchmark: 8-15% for VC cold)
  Reply → meeting:             [%] (benchmark: 50-70%)
  Meeting → 2nd meeting:       [%] (benchmark: 40-60%)
  2nd meeting → term sheet:    [%] (benchmark: 20-35%)

ALERTS
  [!] [N] Platinum investors not yet contacted — high priority
  [!] [N] warm intro requests outstanding > 7 days — follow up
  [!] [N] meetings scheduled this week — prep briefs
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 6.2 Message Performance Optimization

A/B test one variable at a time:

```yaml
active_test:
  variable: "subject_line | hook_type | cta | traction_metric_featured"
  variant_a:
    description: ""
    sends: 0
    replies: 0
    reply_rate: "0%"
  variant_b:
    description: ""
    sends: 0
    replies: 0
    reply_rate: "0%"
  winner_threshold: "30 sends each, highest reply rate wins"
  current_winner: ""
```

**What to test first (highest impact):**
1. Subject line (drives open rate)
2. First sentence / hook (drives reply rate)
3. Traction metric featured (which number gets the most reactions)
4. CTA framing ("15 minutes" vs. "quick call" vs. specific time slot offer)

---

## Phase 7 — Investor Nurture (Long-Term Pipeline)

For investors who didn't convert in the active raise, maintain a **Quarterly Investor Update**:

### 7.1 Quarterly Investor Update Template

```
Subject: [Company] Q[N] Update — $[ARR milestone] and growing

Hi [Name],

Quick update on [Company] — we last spoke in [month]:

Q[N] Highlights:
• ARR: $[X]M → $[Y]M ([%] growth quarter-over-quarter)
• Customers: [N] → [N] (including [notable addition])
• Key milestone: [most impressive achievement this quarter]
• [Patent / product / partnership news]

What we're working on next:
[2-3 bullets on product and GTM priorities for next quarter]

If the stage or metrics are now a fit, happy to reconnect.
Otherwise, will send another update in 3 months.

[Founder Name]
```

---

## Execution Principles

- **Personalization is not optional.** A partner at Sequoia receives 50+ pitches per day. Generic = immediate delete. Thesis-specific = might get read.
- **The warm intro is worth 20 cold emails.** Spend 80% of effort unlocking warm paths before mass cold outreach.
- **Speed on positive replies is critical.** An investor who replies within 24 hours is in a window. Delay kills deals.
- **Never chase; nurture.** After the full sequence, go to quarterly updates. Investors who said no at seed often invest at Series A.
- **The narrative must match the investor's worldview.** a16z cares about software eating the world. Sequoia cares about legacy. Match the frame to the audience.
- **Conference season accelerates everything.** Identify which investors attend which conferences and time outreach around their speaking slots.

---

## Quick-Start Checklist

**Week 1 — Setup:**
- [ ] Complete investor target list from `investor-research` skill
- [ ] Prepare teaser PDF and pitch deck from `pitch-deck-builder` skill
- [ ] Configure Calendly/Cal.com with 30-min "Investor Meeting" slot
- [ ] Finalize cold email templates for each investor type
- [ ] Map all warm intro paths and send intro requests (Platinum + Gold)

**Weekly recurring:**
- [ ] Send 30–50 new first-touch outreach messages
- [ ] Follow up on all sequence touches due this week
- [ ] Respond to all replies within 24 hours (same day for positive replies)
- [ ] Review outreach analytics and adjust messaging if reply rate < 5%
- [ ] Send quarterly updates to long-term nurture list (monthly during active raise)

**Escalate to founder only when:**
- [ ] Term sheet received (immediate priority)
- [ ] Tier-1 fund expresses strong interest (full founder attention)
- [ ] Due diligence request received → commission `due-diligence-prep` skill
- [ ] Reply rate drops below 3% for 2 consecutive weeks → messaging overhaul needed
