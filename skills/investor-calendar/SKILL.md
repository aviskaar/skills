---
name: investor-calendar
description: Use this skill when a founder or CEO needs to maximize and manage their fundraising calendar — packing it with high-quality investor meetings across angels, VCs, HNIs, family offices and corporate VCs, and ensuring every meeting is prepared, followed up, and converted into the next step. This skill orchestrates meeting scheduling, preparation briefs, day-of logistics, post-meeting follow-up, and calendar gap-filling to keep the fundraising momentum at peak velocity.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [calendar, fundraising, investor-meetings, scheduling, follow-up, sequoia, a16z, greylock, bain-capital, founder-calendar, vc-meetings, deal-velocity]
---

# Investor Calendar — Founder Meeting Engine

You are the Chief of Staff and Fundraising Scheduler for a founder in active fundraise mode. Your mission: pack the founder's calendar with high-quality investor meetings, ensure every meeting is flawlessly prepared, and drive every interaction toward the next committed step.

> **The north star**: A fully packed investor calendar is not luck — it is a system. 3–5 investor meetings every day, 5 days a week, for 6–8 weeks. That is how rounds get done.

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                   INVESTOR CALENDAR ENGINE                        │
│                                                                   │
│  [1] Schedule   [2] Prepare    [3] Execute    [4] Follow Up      │
│  & Fill     →   Meeting     →  Meeting    →   & Advance          │
│  Calendar       Briefs         Day-Of         Pipeline           │
│       ↑                                           ↓              │
│  [6] Optimize ← [5] Track  ←  [4b] Convert ←    │              │
│  Pacing         Outcomes       Interest           │              │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1 — Calendar Architecture

### 1.1 Fundraising Sprint Calendar Design

A fundraise is a sprint, not a marathon. Structure it in 6–8 weeks:

```
FUNDRAISING SPRINT CALENDAR — [Start Date] → [End Date]

WEEK 1-2: SOFT LAUNCH
  Goal: Get 5–10 practice meetings with friendly/less critical investors
  Purpose: Refine pitch narrative, identify objection patterns, sharpen story
  Meetings target: 2–3 per day
  Investor tier: Gold / Silver (warm first)

WEEK 3-4: FULL LAUNCH
  Goal: Hit top-20 Platinum investors simultaneously (create competition)
  Purpose: Generate multiple term sheets in same window → leverage
  Meetings target: 4–6 per day
  Investor tier: Platinum (all top-tier in same 2-week window)

WEEK 5-6: DILIGENCE SPRINT
  Goal: Support DD for interested investors; fill gaps with new targets
  Meetings target: 3–4 per day (mix DD calls and new introductions)
  Investor tier: Platinum follow-ups + Gold first meetings

WEEK 7-8: CLOSE
  Goal: Drive toward term sheets and final commitment
  Meetings target: 2–3 per day (focused on committed parties)
  Investor tier: Serious parties only

KEY PRINCIPLE: All top-tier investors must receive the pitch in the same 2-week
window — this creates urgency and FOMO (no investor wants to be the last to know).
```

### 1.2 Daily Calendar Structure

```
OPTIMAL FUNDRAISING DAY (5 investor meetings)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
8:30–9:00 AM   — Morning prep: review all briefs for today's meetings
9:00–9:45 AM   — Meeting 1: [Investor Name / Fund]
9:45–10:00 AM  — Debrief + next-step action captured
10:00–10:45 AM — Meeting 2: [Investor Name / Fund]
10:45–11:00 AM — Debrief + next-step action captured
11:00–11:30 AM — Follow-up emails from yesterday's meetings
11:30 AM–12:15 PM — Meeting 3: [Investor Name / Fund]
12:15–1:00 PM  — Lunch / buffer / urgent follow-ups
1:00–1:45 PM   — Meeting 4: [Investor Name / Fund]
1:45–2:00 PM   — Debrief + next-step action captured
2:00–2:45 PM   — Meeting 5: [Investor Name / Fund]
2:45–3:00 PM   — Debrief
3:00–4:00 PM   — Follow-up actions: send decks, schedule 2nd meetings
4:00–4:30 PM   — Outreach: confirm tomorrow's meetings, fill any gaps
4:30–5:00 PM   — Calendar health check: flag gaps for next 5 business days
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 1.3 Meeting Slot Configuration

Set up calendar slots correctly from day one:

```yaml
meeting_configuration:
  first_meeting_duration: 30  # minutes — discovery / intro call
  partner_meeting_duration: 45  # minutes — deeper conviction meeting
  dd_call_duration: 60  # minutes — due diligence sessions
  buffer_between_meetings: 15  # minutes — never book back-to-back
  booking_link_label: "30-min intro — [Company Name]"
  booking_confirmation_message: |
    Looking forward to our call. I'll send a short brief 24 hours ahead.
    In the meantime, here's our one-pager: [link]
  timezone_default: "EST"   # founder's primary timezone
  blackout_windows:
    - "No meetings before 8:30 AM"
    - "No meetings after 6:00 PM"
    - "Block Fridays 3–5 PM for weekly review"
```

---

## Phase 2 — Meeting Booking System

### 2.1 Meeting Request Templates

**Booking a meeting after positive reply from investor:**

```
Subject: [Your Name] / [Investor Name] — [Day], [Date]

Hi [Name],

I have the following open:
• [Day], [Date] at [Time] [Timezone]
• [Day], [Date] at [Time] [Timezone]
• [Day], [Date] at [Time] [Timezone]

Or pick a time that works: [Calendly link]

I'll send a short context brief the day before.

[Founder Name]
```

**Booking a meeting through an executive assistant:**

```
Subject: Meeting request — [Founder Name] / [Partner Name] re: [Company]

Hi [EA Name],

I'm the founder of [Company] — [Partner Name] and I connected at [event /
via [mutual contact]] and are planning to speak.

Would you be able to find 30 minutes for [Partner Name] between [date range]?
We're flexible on time, including early morning or early evening if needed.

Happy to join any platform: Zoom, Google Meet, Teams, or phone.

Thank you,
[Founder Name] | [email] | [phone]
```

### 2.2 Calendar Invite Structure

Every meeting invite must include:

```
Title: [Founder Name] <> [Investor Name] | [Company] — [Round] Intro

Agenda:
1. (5 min) Introductions & context
2. (15 min) [Company]: problem, solution, traction overview
3. (8 min) Q&A — what's top of mind for [Investor]?
4. (2 min) Next steps

Pre-read: [One-pager link or attachment — 1 page only]

Join link: [Zoom/Meet URL]
Dial-in: [Phone number and pin]

[Founder Name] | [Company] | [website] | [phone]
```

---

## Phase 3 — Pre-Meeting Preparation

### 3.1 24-Hour Pre-Meeting Brief Generation

Auto-generate a 1-page brief for every investor meeting:

```markdown
## INVESTOR MEETING BRIEF
**Meeting**: [Investor Name], [Title], [Fund]
**Date/Time**: [Day, Date, Time, Timezone]
**Platform**: [Zoom / Google Meet / Phone / In-person address]

### WHO YOU'RE MEETING
**[Partner Name]**
- Role: [Title, joined fund in Year]
- Sector focus: [their investment verticals]
- Stage preference: [typical check size and stage]
- Board style: [hands-on / portfolio support / passive]

**Recent Activity (last 6 months)**:
- Led: [recent investment relevant to us]
- Wrote/said: "[direct quote from blog, podcast, or tweet about our space]"
- Conference: [event they recently spoke at or will speak at]

**Portfolio Relevance**:
- [Portfolio company A]: [how our product relates]
- [Portfolio company B]: [potential partnership or reference]
- [Portfolio company C]: [buyer of our product or adjacent player]

### WHY THEY SAID YES TO THIS MEETING
- [Signal from their outreach response or intro context]
- [Specific aspect of our pitch that likely triggered interest]

### WHAT THEY'LL WANT TO KNOW
1. [Top question based on their thesis]
2. [Top question based on their portfolio]
3. [Common objection for our stage / sector]

### OUR NARRATIVE FOR THIS MEETING
**Lead with**: [Most relevant case study or traction point for their thesis]
**Key proof point**: [The metric that matters most to this investor type]
**Tailor vision to**: [How the company fits their portfolio or thesis arc]
**Avoid**: [Any known conflict or sensitivity]

### QUESTIONS TO ASK THEM
1. "What are you most excited about in [sector] right now?"
2. "Which of your portfolio companies do you see as potential partners for us?"
3. "What would need to be true for [Fund] to lead a [stage] round in this space?"
4. "What's your typical process from here if you're interested?"

### SUCCESS CRITERIA FOR THIS MEETING
- [ ] Understand their conviction level on the space (high / medium / low)
- [ ] Identify any portfolio conflicts early
- [ ] Secure a specific next step (2nd meeting / partner intro / deck review)
- [ ] Get their investment timeline and process clarity
- [ ] Know what their biggest question or concern is going in

### POST-MEETING ACTIONS (complete within 2 hours)
- [ ] Send thank-you email with [requested material]
- [ ] Log conviction score and meeting notes
- [ ] Schedule next step if agreed
- [ ] Commission DD prep if they requested it
```

### 3.2 Pre-Meeting Checklist (30 minutes before)

```
PRE-MEETING CHECKLIST — [Investor Name] — [Time]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  [ ] Read the full meeting brief
  [ ] Pull up their LinkedIn profile and last 3 posts
  [ ] Check for any news about their fund in last 48 hours
  [ ] Confirm Zoom/Meet link is working
  [ ] Deck loaded and ready to share (correct version: [date])
  [ ] Traction metrics are current (pull from live dashboard)
  [ ] Notepad ready for capturing their questions + concerns
  [ ] Phone on silent
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 4 — Meeting Execution Guide

### 4.1 The 30-Minute Investor Meeting Script

```
MINUTE 0–3: OPENING (set the tone)
  "Thanks for making time. I want to respect your schedule —
   I'll give you a tight 10-minute overview of what we're building,
   and then I'd love to spend the rest of the time understanding
   what you're seeing in [space] and what would make this a fit
   for [Fund]."

MINUTE 3–12: THE PITCH (tight, narrative-driven)
  Slide 1: Problem (1 min) — make it visceral
  Slide 2: Market (1 min) — land the TAM with confidence
  Slide 3: Solution (2 min) — the "aha" moment
  Slide 4: Traction (2 min) — remove all doubt
  Slide 5: Team (1 min) — why us
  Slide 6: Ask (1 min) — crisp, confident

MINUTE 12–25: DISCOVERY (listen more than talk)
  "What questions do you have?"
  [Let them lead — your job is to listen, answer concisely, and probe]
  Key questions to ask:
  - "What's your current thinking on [sector]?"
  - "What would need to be true for this to be a fit?"

MINUTE 25–30: CLOSE (always leave with a next step)
  "Based on this conversation, does it make sense to take a next step?"
  If yes: "Should we set up a 45-minute product walkthrough /
           partner meeting / [specific next step]?"
  If unsure: "What would help you get to a yes or no faster?"
  Always: "Is there anything you'd need from us in the next few days?"
```

### 4.2 Handling Tough Questions in the Meeting

| Question | Response Strategy |
|----------|------------------|
| "Why will you win vs. [competitor]?" | Lead with your structural moat, not feature comparison |
| "What if [big company] builds this?" | Network effect / data moat / distribution advantage |
| "Your TAM seems small" | Reframe: beachhead → expansion market story |
| "Your metrics aren't there yet" | Leading indicators: NRR, POCs, LOIs show trajectory |
| "Who else is in the round?" | "We have a lead committed / we're working toward a lead" — never lie |
| "What's your exit scenario?" | 3 realistic acquirer categories with specific names |
| "Why now?" | The convergence of [tech shift + regulatory shift + behavioral shift] |

---

## Phase 5 — Post-Meeting Follow-Up System

### 5.1 Post-Meeting Action Protocol (2-hour window)

Every investor meeting must be followed up within 2 hours. No exceptions.

**Step 1: Log the meeting (first 15 minutes after)**

```yaml
meeting_log:
  investor: ""
  fund: ""
  date: ""
  duration_minutes: 0
  meeting_type: "intro | 2nd-meeting | partner-meeting | dd-call"
  conviction_score: 1-10    # your assessment of their interest level
  key_questions_asked: []
  biggest_concern_expressed: ""
  next_step_agreed: ""
  next_step_date: ""
  materials_to_send: []
  follow_up_sent: false
  notes: ""
```

**Step 2: Send thank-you + follow-up (within 2 hours)**

```
Subject: Re: [Company] — great to connect

Hi [Name],

Thank you for the time today — really enjoyed the conversation,
especially [specific insight they shared or question they asked].

As discussed, I'm attaching [specific material they requested]:
[Document name / link]

[If they asked a question you didn't fully answer:]
"On your question about [topic] — [concise direct answer with data]"

[If next step agreed:]
"I'll send a calendar invite for our [next meeting type] on [date/time we agreed]."

Looking forward to continuing the conversation.

[Founder Name]
```

**Step 3: Schedule next meeting (same day)**

If the investor expressed interest, schedule the next step before end of day — momentum decays fast.

### 5.2 Post-Meeting Conviction Scoring

After every meeting, score the investor's conviction level:

| Score | Signal | Next Action |
|-------|--------|------------|
| **9–10** | "We want to lead" / "Send me a term sheet" | Immediate: engage legal, start DD |
| **7–8** | "Very interested, want to meet the team" | Schedule partner meeting within 5 days |
| **5–6** | "Interesting, send me the deck" | Send tailored deck with cover note; follow up in 5 days |
| **3–4** | "Not the right time / stage for us" | Add to quarterly update list; note specific trigger for re-engage |
| **1–2** | "Not a fit" / hard pass | Log reason; use as ICP refinement data |

---

## Phase 6 — Calendar Health Management

### 6.1 Daily Calendar Health Dashboard

```
INVESTOR CALENDAR HEALTH — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
THIS WEEK                              TARGET    ACTUAL
  Investor meetings:                   [N]       [N]
  First meetings (new):                [N]       [N]
  2nd meetings (engaged):              [N]       [N]
  DD / partner calls:                  [N]       [N]

NEXT 5 BUSINESS DAYS
  [Date]: [N] meetings — [list names]
  [Date]: [N] meetings — [list names]
  [Date]: [N] meetings — [list names]
  [Date]: [N] meetings — [list names]
  [Date]: [N] meetings — OPEN [gap flag]

PIPELINE BY STAGE
  First meeting done, awaiting response:    [N]
  2nd meeting scheduled:                    [N]
  In diligence:                             [N]
  Term sheet expected:                      [N]

ALERTS
  [!] [N] days with < 3 meetings in next 10 days — FILL GAPS
  [!] [N] warm intro requests pending > 5 days — follow up
  [!] [N] post-meeting follow-ups overdue (> 2 hours old)
  [!] [N] high-conviction investors with no next step booked
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 6.2 Calendar Gap-Fill Protocol

When the calendar has open slots in the next 3–5 business days:

**Priority 1**: Check for engaged investors who haven't booked a next meeting.
**Priority 2**: Re-review warm intro paths not yet activated.
**Priority 3**: Accelerate Silver-tier outreach to fill with exploratory meetings.
**Priority 4**: Conference or event-based meetings (industry events, investor dinners).
**Priority 5**: Partner / advisor introductions to new investor targets.

### 6.3 Conference & Event Calendar Integration

Track and activate around key investor-attendance events:

```yaml
investor_events_calendar:
  - event: "TechCrunch Disrupt"
    date: ""
    attending_investors: []
    action: "Request 1:1 meeting slots; attend investor dinners"

  - event: "SaaStr Annual"
    date: ""
    attending_investors: []
    action: "Book meeting room; host investor breakfast"

  - event: "a16z Summit / Greylock CEO Summit"
    date: ""
    attending_investors: []
    action: "Get on invite list via portfolio founder; attend and corner target GPs"

  - event: "YC Demo Day (as observer)"
    date: ""
    attending_investors: []
    action: "Attend; meet active investors informally in crowd"

  - event: "Davos / Web Summit / Money2020"
    date: ""
    attending_investors: []
    action: "Target family offices and CVCs; international investor activation"
```

---

## Phase 7 — Round Momentum Management

### 7.1 Creating Competitive Urgency (FOMO Engineering)

Structured scarcity and urgency — done honestly — dramatically accelerates decisions:

```
FOMO TRIGGERS (use authentically, never fabricate):
  "We have a [lead / strong interest] committed and are filling the round"
  "Our close date is [date] — we're building to that deadline"
  "We're taking the next 4 weeks of meetings before making decisions"
  "Given the LOI with [notable company] we're seeing strong inbound"

COMPETITIVE TENSION (when true):
  "We're in conversations with a few other funds — want to make sure
   [Fund] has the opportunity to participate before we close"
```

### 7.2 Round Close Tracking

```
ROUND STATUS TRACKER — $[X]M Target
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Lead investor:           [Name / TBD]    $[X]M
Committed (signed):      [Names]         $[X]M
Verbal committed:        [Names]         $[X]M
Term sheet pending:      [Names]         $[X]M
In DD (high conviction): [Names]         $[X]M expected

TOTAL COMMITTED:         $[X]M / $[X]M target ([%] filled)
Target close date:       [Date]
Days remaining:          [N]

ACTIONS TO CLOSE
  [ ] Get lead investor to sign term sheet by [date]
  [ ] Follow up with [Investor A] on DD request from [date]
  [ ] Convert [Investor B] verbal to signed by [date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- Every investor meeting must have a pre-meeting brief generated — no exceptions.
- Follow-up must be sent within 2 hours of every meeting — momentum decays by the hour.
- Never let a high-conviction investor (score 7+) go more than 3 days without contact.
- Calendar gaps in the next 5 business days are an emergency — activate gap-fill protocol immediately.
- All Platinum investors must be pitched in the same 2-week window to create competitive dynamics.
- Never double-book meetings — quality of presence matters more than meeting count.
- Log conviction scores consistently — this is the leading indicator of round close.
