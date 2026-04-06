---
name: meridian-investor-research
description: >
  Run a full Meridian investor intelligence report for any startup URL. Use this skill whenever
  the user asks to find investors, build an outreach list, write cold emails to investors, or
  research who to pitch. Also trigger when the user says things like "find investors for [URL]",
  "run Meridian on [company]", "who should I pitch", "write investor emails for [startup]",
  or "build my investor outreach". The skill finds 6 matched investors through real web research,
  verifies facts from public sources, and writes hyper-personalized cold emails grounded in
  actual portfolio companies, public statements, LinkedIn posts, and press releases.
  Never fabricate investor facts. Always search before writing.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [investor, fundraising, outreach, cold-email, vc, research, meridian, startup, pitch, investor-intelligence]
---

# Meridian Investor Research Skill

Produces a **verified, hyper-personalized investor outreach report** for any startup. Every investor
fact is sourced from real web searches. Every email references something the investor actually said,
did, or invested in. No synthetic data. No made-up quotes.

---

## What This Skill Produces

For each of 6 matched investors:

1. **Investor profile** — name, role, firm, thesis, why they fit this startup specifically
2. **Verified match signals** — real portfolio companies, real public statements, real fund announcements
3. **Hyper-personalized cold email** — subject line and body referencing verified facts only
4. **Outreach email list** — all 6 in `Name <email>` format for direct paste into Gmail or CRM
5. **Email quality notes** — what was verified vs what to double-check before sending

---

## Inputs Required

| Input | Required | Notes |
|-------|----------|-------|
| `startup_url` | YES | e.g. www.aviskaar.com or www.nextlabs.com |
| `founder_name` | NO | Who signs off the emails. Default: "The Founder" |
| `founder_title` | NO | e.g. "CEO", "Co-founder". Default: "Founder" |
| `extra_context` | NO | Any facts about the startup the user wants included (traction, raise size, sector) |

If the user has not provided a URL, ask for it before starting.

---

## Step-by-Step Workflow

### Step 1 — Read the startup website

Use `web_fetch` to read the startup's homepage. Extract:
- What the company does (in plain English, not their marketing copy)
- Sector and sub-sector
- Stage signals (team size, customers mentioned, product maturity)
- Geography
- Any notable traction numbers, patents, customers, or partners mentioned

If web_fetch fails, infer from the domain name and any context the user has provided.

### Step 2 — Identify 6 matched investors

Based on what the startup does, identify 6 real named investors who would genuinely be excited
by this company. Think carefully about fit:

- For deep tech / research-to-product companies: look for investors who back platform plays and IP-heavy companies
- For cybersecurity: look for operator-investors who built and sold security companies
- For enterprise SaaS: look for investors with enterprise portfolio companies at similar stages
- For AI infrastructure: look for investors who have publicly written about the AI infrastructure opportunity
- Do NOT pick generic "top VC" names. Pick investors whose specific thesis matches this specific startup.

For each investor identify:
- Full name and current role
- Why they specifically fit this startup (not just "they invest in AI")
- 2 to 3 real things to search for (recent investments, public posts, fund announcements)

### Step 3 — Research each investor with real web searches

For EVERY investor, run at least 2 web searches before writing anything. Use these search patterns:

```
"[Investor Name]" "[Firm]" recent investment 2024 2025
"[Investor Name]" LinkedIn post OR thesis OR "we invest in"
"[Investor Name]" portfolio company announcement press release
"[Investor Name]" interview OR podcast OR quote cybersecurity (or relevant sector)
```

For each investor collect:
- At least one REAL portfolio company they backed that is relevant to this startup
- At least one REAL public statement, blog post, LinkedIn post, or interview quote
- Their actual firm email format if discoverable (e.g. first@firm.com or firstlast@firm.com)
- Any recent fund announcement or investment that is directly relevant

**CRITICAL: If you cannot find a verified fact for an investor, say so explicitly.**
Do not invent portfolio companies. Do not fabricate quotes. Do not guess at investments.
If research comes back thin, note "limited public information found" and write a more
general but still honest email.

### Step 4 — Write hyper-personalized emails

Write one cold email per investor. Follow all of these rules precisely:

**TONE:**
- Warm, direct, conversational. Two smart people talking over coffee.
- Simple English. Short sentences. No jargon, no buzzwords.
- No dashes anywhere. Not em dashes, not hyphens as pauses. Use commas or periods instead.
- No bullet points in the email body. Pure flowing prose.
- The investor should genuinely enjoy reading this.

**STRUCTURE (4 paragraphs, 130 to 160 words total):**

Paragraph 1: Open with a VERIFIED specific observation about this investor. Name a real portfolio
company they backed, quote something they actually wrote or said publicly, or reference a real
investment or fund announcement. Make it clear you have done your homework. Then connect
naturally to this startup in one sentence. Do not force the pivot.

Paragraph 2: Share 2 to 3 concrete proof points about the startup with real numbers or named
customers. Pull these from the website research in Step 1. Do not invent figures. If the startup
has limited public traction data, focus on the product, technology differentiation, or market size.

Paragraph 3: The bigger picture. This is not just about returns. Show how backing this company
shapes an industry, defines a category, or solves a problem that matters beyond revenue. Give
the investor a reason to feel proud of this bet, not just rich.

Paragraph 4: A warm, specific ask. "Would a short call next week work?" or "Happy to share more
if this resonates." Sign off with founder name and title only. Nothing else.

**SUBJECT LINE:**
- Conversational. Feels like a person wrote it.
- References a specific portfolio company or a real shared idea.
- Max 9 words. No punctuation gimmicks. No dashes.

### Step 5 — Format and present the report

Present the full report in the chat in this order:

1. One-line summary of the startup (what you learned from the website)
2. For each of the 6 investors:
   - Name, role, firm
   - Tags: [Sector focus] · [Stage] · [Geography]
   - Why they fit (2 sentences grounded in verified research)
   - Sources used (what you actually found and searched)
   - Email subject line
   - Full email body
3. Outreach email list (all 6 in `Name <email@firm.com>` format)
4. Email verification notes (what to double check before sending)

---

## Email Quality Standards

Every email must pass these checks before presenting:

- [ ] Opens with a VERIFIED fact about the investor, not a generic compliment
- [ ] Portfolio company named in the email is one they actually backed (confirmed via search)
- [ ] Any quote attributed to the investor is real and sourced
- [ ] No dashes anywhere in the email body or subject line
- [ ] No bullet points in the email body
- [ ] Startup facts match what was found on the website
- [ ] Word count is between 130 and 160 words
- [ ] Sign-off is founder name and title only
- [ ] Subject line is under 9 words with no dashes

---

## Investor Selection Criteria

Pick investors who match ALL THREE of these:

1. **Thesis fit** — their stated investment focus overlaps directly with this startup's sector
2. **Stage fit** — they invest at or near the startup's current stage
3. **Pattern fit** — they have backed at least one company with a similar business model, customer type, or technology approach

Avoid:
- Mega-funds who only do late stage if the startup is early
- Investors who have publicly said they are not investing in this sector
- Investors with obvious portfolio conflicts (a direct competitor in their portfolio)
- Generic "top 10 VC" lists that are not specific to this startup

---

## Verified Email Format Research

To find the most likely email format for each investor:

1. Search `"[first name] [last name]" "[firm domain]" email`
2. Check the firm's website for a standard format (e.g. first@firm.com)
3. Check Hunter.io format if the domain is known
4. Note confidence level: HIGH (confirmed format), MEDIUM (inferred from firm convention), LOW (guessed)

Always flag LOW confidence emails so the user knows to verify before sending.
Recommend Hunter.io or Apollo.io for verification.

---

## Common Mistakes to Avoid

**Research mistakes:**
- Do not write an email referencing a portfolio company without confirming via search that this investor actually backed it
- Do not quote an investor without a source URL or publication
- Do not assume fund size, check size, or stage without a public source
- Do not pick investors just because they are famous, pick them because they fit

**Email mistakes:**
- Do not open with "I" or "We" — open with the investor
- Do not use em dashes anywhere
- Do not list traction figures that are not verified from the website or user-provided context
- Do not use words like "revolutionary", "transformative", "cutting-edge", "game-changing"
- Do not end with "I would love to connect" — be specific about the ask

**Tone mistakes:**
- Write like a founder who has done their homework, not a PR agency
- The email should feel like it was written by a human who read the investor's blog last week
- Avoid any sentence that could appear in a template or be sent to 100 people unchanged

---

## Output Example Structure

```
MERIDIAN · Investor Report for [startup name]

[Startup summary: one sentence from website research]

---

1. [Investor Name] — [Role], [Firm]
   Tags: [Focus] · [Stage] · [Geography]
   Why they fit: [2 sentences grounded in verified research]
   Sources used: [What was searched and found]

   Subject: [Subject line]

   [Full email body]

---

[Repeat for all 6 investors]

---

OUTREACH EMAIL LIST
[Name] <[email]> — [confidence: HIGH/MEDIUM/LOW]
[Name] <[email]> — [confidence: HIGH/MEDIUM/LOW]
...

EMAIL VERIFICATION NOTES
- [Any facts that should be double-checked before sending]
- [Any investors where research was thin]
- Recommended: verify all emails at hunter.io before sending
```

---

## Notes on Meridian

This skill is the research and writing engine behind Meridian, an investor intelligence tool
built by Aviskaar. When this skill runs well, every email feels like it was written by someone
who has been following the investor for months, not generated in seconds. That is the bar.
The difference between a reply and a delete is whether the investor believes you actually
know them. Make them believe it, because you did the research to earn it.
