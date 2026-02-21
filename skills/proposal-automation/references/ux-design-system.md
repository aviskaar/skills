# UX Design System — Component Library Selection & Design Standards

Reference for Phase 4.4 (Frontend Build). Follow this guide to select the right design foundation and build a UI that looks and feels enterprise-grade from day one.

---

## 1. COMPONENT LIBRARY SELECTION GUIDE

### 1.1 Decision Matrix

Choose based on the customer's context and the POC requirements:

| Library | Best For | Style | Customization | Bundle Size | Accessibility |
|---|---|---|---|---|---|
| **shadcn/ui** | Modern SaaS, clean B2B, design-system-first | Tailwind CSS, minimal | Full (copy-paste) | Minimal | Excellent (Radix) |
| **Ant Design (antd)** | Data-heavy enterprise, large tables, forms | Opinionated, corporate | Moderate | Large | Good |
| **Material UI (MUI)** | Google ecosystem familiarity, rapid prototyping | Material Design | High (theme tokens) | Medium | Good |
| **Chakra UI** | Developer-friendly, accessible by default | Clean, flexible | High | Small–Medium | Excellent |
| **Radix UI Primitives** | Headless — maximum control, custom design | None (BYO) | Complete | Minimal | Excellent |

**Decision rules**:
- Customer is in **FinServ / Healthcare / Government** → Ant Design or shadcn/ui (professional, dense)
- Customer values **modern SaaS aesthetics** → shadcn/ui or Chakra UI
- POC needs **heavy data tables, dashboards** → Ant Design (Table, Charts) or MUI (DataGrid)
- Customer has **existing design brand** → Radix UI + Tailwind (full control over look)
- **Default recommendation** for most POCs: **shadcn/ui** (modern, accessible, zero style debt)

### 1.2 shadcn/ui Setup (Default Path)

```bash
npx create-next-app@latest [project-web] --typescript --tailwind --app
cd [project-web]
npx shadcn-ui@latest init
# Install commonly needed components:
npx shadcn-ui@latest add button card table form input select dialog
npx shadcn-ui@latest add badge skeleton alert toast dropdown-menu
npx shadcn-ui@latest add tabs sheet command popover calendar date-picker
```

Data visualization (add one):
```bash
# Recharts — lightweight, React-native
npm install recharts
# Or Tremor — shadcn-compatible dashboard components
npm install @tremor/react
```

### 1.3 Ant Design Setup (Data-Heavy Path)

```bash
npx create-react-app [project-web] --template typescript
npm install antd @ant-design/icons @ant-design/plots
```

Custom theme (override defaults to avoid the default blue Ant look):
```typescript
// theme/antd-theme.ts
import type { ThemeConfig } from 'antd';

export const antdTheme: ThemeConfig = {
  token: {
    colorPrimary: '#1a56db',   // customer brand color
    borderRadius: 6,
    fontFamily: "'Inter', -apple-system, sans-serif",
    fontSize: 14,
  },
  components: {
    Table: { headerBg: '#f8fafc', borderColor: '#e2e8f0' },
    Card: { borderRadius: 8 },
  },
};
```

---

## 2. DESIGN TOKENS (Establish Before Building Screens)

Define these in `src/styles/tokens.css` or `src/theme/tokens.ts` on day one. Never use raw hex values inline.

### 2.1 Color System

```css
/* tokens.css — Tailwind CSS custom properties */
:root {
  /* Brand */
  --color-primary-50:  #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;   /* primary action */
  --color-primary-600: #2563eb;   /* hover state */
  --color-primary-700: #1d4ed8;   /* pressed state */

  /* Semantic */
  --color-success:  #16a34a;
  --color-warning:  #d97706;
  --color-error:    #dc2626;
  --color-info:     #0284c7;

  /* Neutrals */
  --color-gray-50:  #f8fafc;
  --color-gray-100: #f1f5f9;
  --color-gray-200: #e2e8f0;
  --color-gray-500: #64748b;
  --color-gray-700: #334155;
  --color-gray-900: #0f172a;

  /* Surface */
  --color-bg:       #ffffff;
  --color-surface:  #f8fafc;
  --color-border:   #e2e8f0;
}
```

### 2.2 Typography Scale

```css
:root {
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-mono: 'JetBrains Mono', 'Fira Code', monospace;

  --text-xs:   0.75rem;    /* 12px — labels, captions */
  --text-sm:   0.875rem;   /* 14px — body small, table rows */
  --text-base: 1rem;       /* 16px — body default */
  --text-lg:   1.125rem;   /* 18px — section headers */
  --text-xl:   1.25rem;    /* 20px — page section titles */
  --text-2xl:  1.5rem;     /* 24px — page titles */
  --text-3xl:  1.875rem;   /* 30px — KPI numbers */

  --font-normal:   400;
  --font-medium:   500;
  --font-semibold: 600;
  --font-bold:     700;
}
```

### 2.3 Spacing & Layout

```css
:root {
  /* 4px base grid */
  --space-1: 0.25rem;   /* 4px */
  --space-2: 0.5rem;    /* 8px */
  --space-3: 0.75rem;   /* 12px */
  --space-4: 1rem;      /* 16px — base unit */
  --space-6: 1.5rem;    /* 24px */
  --space-8: 2rem;      /* 32px */
  --space-12: 3rem;     /* 48px */
  --space-16: 4rem;     /* 64px */

  /* Content widths */
  --max-width-sm:   640px;
  --max-width-md:   768px;
  --max-width-lg:   1024px;
  --max-width-xl:   1280px;
  --max-width-2xl:  1536px;

  /* Sidebar */
  --sidebar-width:  240px;
  --sidebar-collapsed: 64px;
}
```

---

## 3. LAYOUT PATTERNS

### 3.1 Application Shell (Standard Enterprise App)

```
┌─────────────────────────────────────────────────────────────────┐
│ Top Nav Bar (64px)                                               │
│ [Logo] [Nav Links]                    [Search] [Notifications] [Avatar]│
├──────────────────┬──────────────────────────────────────────────┤
│                  │  Page Header (48–64px)                        │
│  Sidebar         │  [Breadcrumbs]           [Page Title] [CTA]  │
│  (240px)         ├──────────────────────────────────────────────┤
│                  │                                               │
│  [Section]       │  Main Content Area                            │
│    [Nav Item]    │  (fluid width, max 1280px, centered)          │
│    [Nav Item]    │                                               │
│  [Section]       │                                               │
│    [Nav Item ●]  │                                               │
│                  │                                               │
└──────────────────┴──────────────────────────────────────────────┘
```

```tsx
// AppShell.tsx
export function AppShell({ children }: { children: ReactNode }) {
  return (
    <div className="min-h-screen bg-gray-50">
      <TopNav />
      <div className="flex">
        <Sidebar />
        <main className="flex-1 min-w-0">
          <div className="max-w-[1280px] mx-auto px-6 py-6">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
}
```

### 3.2 Dashboard Layout

```
┌──────────────────────────────────────────────────────────────┐
│ Page Title + Date Range Picker + Export Button               │
├──────────┬──────────┬──────────┬──────────────────────────────┤
│ KPI Card │ KPI Card │ KPI Card │ KPI Card                     │
│ (trend ↑)│ (trend ↑)│ (trend ↓)│ (trend ↑)                   │
├──────────┴──────────┴──────────┴──────────────────────────────┤
│ Chart (8 cols)                    │ Top Items List (4 cols)   │
│                                   │                           │
│                                   │                           │
├───────────────────────────────────┴───────────────────────────┤
│ Recent Activity Table (full width)                            │
└──────────────────────────────────────────────────────────────┘
```

### 3.3 KPI Card Component

```tsx
interface KpiCardProps {
  title: string;
  value: string | number;
  unit?: string;
  trend: { direction: 'up' | 'down' | 'flat'; percentage: number; label: string };
  target?: { value: number; label: string };
  status: 'good' | 'warning' | 'critical';
}

// Required data: baseline + current + target (wired from Phase 2.3 KPIs)
// Never show static numbers — always computed from real seed data
```

### 3.4 Data Table Pattern

Every data table must implement:

```tsx
<DataTable
  data={claims}
  columns={claimsColumns}
  // Sorting
  sortingState={sorting}
  onSortingChange={setSorting}
  // Filtering
  filterValue={globalFilter}
  onFilterChange={setGlobalFilter}
  columnFilters={columnFilters}
  // Pagination
  pageSize={pageSize}
  pageIndex={pageIndex}
  rowCount={totalCount}
  onPaginationChange={setPagination}
  // States
  isLoading={isLoading}
  loadingRows={10}   // skeleton rows
  emptyState={
    <EmptyState
      icon={<FileSearchIcon />}
      title="No claims found"
      description="Try adjusting your filters or date range"
      action={<Button onClick={clearFilters}>Clear Filters</Button>}
    />
  }
  // Row actions
  onRowClick={(row) => navigate(`/claims/${row.id}`)}
  rowActions={(row) => <ClaimRowActions claim={row} />}
/>
```

Use TanStack Table (formerly react-table) — it's the standard for complex tables.

---

## 4. SCREEN-BY-SCREEN UX STANDARDS

### 4.1 Dashboard Screen

**Purpose**: Immediate situational awareness — "what needs my attention right now?"

Required elements:
- KPI cards (4–6) — with trend vs. prior period, current vs. target
- Primary chart — trend over time for the most important metric
- Secondary chart — breakdown/distribution (donut, bar)
- Activity feed or urgent items list — what needs action today
- Quick-action buttons — top 2–3 actions a user would take from here

**Anti-patterns**:
- All-green dashboard (unrealistic — seed data should show some warning states)
- Charts without axis labels or units
- KPI cards without context (just a number with no trend or comparison)
- Date range defaulting to "All time" (should default to last 30 days)

### 4.2 List / Search Screen

**Purpose**: Find, filter, and act on a collection of records.

Required elements:
```
[Page Title]  [Record Count]              [Search input] [Filter button] [Export] [+ New]
─────────────────────────────────────────────────────────────────────────────────────────
[Active Filter Pills: Status = "Pending" ×] [Status = "Assigned" ×] [Clear All]

[Sortable Column Hdr] [Sortable] [Sortable] [Sortable] [Status Badge] [Actions ···]
─────────────────────────────────────────────────────────────────────────────────────────
[Row 1 data]                                             [Active]      [Approve] [···]
[Row 2 data]                                             [Pending]     [Review]  [···]
...15–20 rows...
─────────────────────────────────────────────────────────────────────────────────────────
  Showing 1–20 of 147 results                  [< Prev]  1  2  3  4  5 ...8  [Next >]
```

Standards:
- Column headers are sortable (click to sort, click again to reverse)
- Status always uses a color-coded badge (not plain text)
- Actions column uses icon buttons or a `···` dropdown menu
- Empty state is branded and helpful (not "No data found")
- Filter panel slides in from right (drawer) or drops down below search bar
- Bulk selection: checkboxes on rows + bulk action bar when rows are selected

### 4.3 Detail / Record View Screen

**Purpose**: Complete view of one record and all actions applicable to it.

Layout pattern:
```
[Breadcrumb: Home > Claims > CLM-2024-00847]

[Record Title]  [CLM-2024-00847]         [Status Badge: Under Review]  [Edit] [···]
─────────────────────────────────────────────────────────────────────────────────────
[Left Column 65%]                         [Right Column 35%]
  Section: Core Details                     Timeline / Activity Feed
    Field: Policy Holder    Margaret Chen     ● Submitted — Nov 3, 2024 9:42am
    Field: Claim Type       Property Damage   ● Assigned to K. Patel — Nov 4, 10:15am
    Field: Claimed Amount   $47,250.00        ● Documents requested — Nov 4, 2:30pm
    Field: Incident Date    Nov 3, 2024       ● Documents received — Nov 5, 11:20am
                                              ● Under review — Nov 5, 11:25am
  Section: Documents
    [Document list with download links]
                                            Action Panel
  Section: Assessment Notes                  [Approve Claim]  primary button
    [Text area — editable inline]            [Request More Info]
                                             [Escalate to Senior]
                                             [Reject Claim]  danger button
```

Standards:
- Status is always visible at the top
- Action buttons are in a sticky right panel (or top-right), not buried in the middle
- Timeline shows every state change — required from audit trail in the backend
- Related records are linked (policy number → policy detail)
- Inline editing where appropriate — don't force navigate to an edit page for small changes

### 4.4 Form / Workflow Screen

**Purpose**: Capture structured input to advance a business process.

Standards:
```tsx
// Form layout rules:
// 1. Single column for ≤ 5 fields; two-column grid for 6–12 fields
// 2. Related fields grouped into sections with headings
// 3. Required fields marked with asterisk (*) — legend at top: "* required"
// 4. Inline validation — show error on blur (not on submit only)
// 5. Submit button: shows loading spinner, disabled during submit
// 6. Cancel link: always present, confirms discard if changes made
// 7. Success: redirect with toast, not a blank page
// 8. Error: show field-level errors AND a summary at top if > 2 errors

// Form field pattern:
<FormField
  label="Claimed Amount"
  required
  hint="Enter the total value of damages claimed in USD"
  error={errors.claimedAmount?.message}
>
  <Input
    type="number"
    prefix="$"
    placeholder="0.00"
    {...register('claimedAmount', {
      required: 'Claimed amount is required',
      min: { value: 1, message: 'Amount must be greater than $0' },
      max: { value: 10_000_000, message: 'Exceeds maximum single-claim limit of $10M' },
    })}
  />
</FormField>
```

### 4.5 Configuration / Settings Screen

**Purpose**: Allow admin users to configure system behavior.

Structure:
```
Settings
  ├── General           (organization name, timezone, locale)
  ├── Users & Roles     (invite, manage permissions)
  ├── Workflow Rules    (approval thresholds, routing rules)
  ├── Integrations      (connected systems, API keys — masked)
  └── Notifications     (email/webhook triggers)
```

Standards:
- Use a left-nav sidebar within settings (not tabs for > 4 sections)
- Save changes immediately on toggle/select (no explicit Save needed) OR use explicit Save with unsaved indicator
- Destructive actions (delete, disable) require confirmation dialog
- API keys shown as `sk-••••••••••••4f2a` with "Reveal" button

---

## 5. RESPONSIVE DESIGN STANDARDS

### 5.1 Breakpoints

```css
/* Tailwind defaults — use these, don't invent new ones */
/* sm  */ @media (min-width: 640px)
/* md  */ @media (min-width: 768px)
/* lg  */ @media (min-width: 1024px)
/* xl  */ @media (min-width: 1280px)
/* 2xl */ @media (min-width: 1536px)
```

### 5.2 Mobile Behavior (375px — required for POC quality gate)

| Desktop Element | Mobile Behavior |
|---|---|
| Sidebar navigation | Collapses to bottom tab bar or hamburger drawer |
| Data table (many columns) | Horizontal scroll OR card view per row |
| Multi-column form | Single column stack |
| Dashboard KPI grid (4 cols) | 2 cols, then 1 col on small screens |
| Action buttons (multiple) | Primary action visible, secondary in `···` menu |
| Modal dialogs | Full-screen sheet on mobile |
| Date range pickers | Bottom sheet calendar on mobile |

### 5.3 Touch Targets

All interactive elements on mobile:
- Minimum 44×44px tap target (WCAG 2.5.5)
- 8px spacing between adjacent targets

---

## 6. ACCESSIBILITY STANDARDS (WCAG 2.1 AA — Minimum)

### 6.1 Required Checks

| Criterion | Standard | How to Verify |
|---|---|---|
| Color contrast (text) | ≥ 4.5:1 (normal), ≥ 3:1 (large) | WebAIM Contrast Checker |
| Color contrast (UI) | ≥ 3:1 | Lighthouse |
| Keyboard navigation | All interactive elements reachable via Tab | Manual test |
| Focus visible | Focus ring visible on all interactive elements | Manual test |
| Images | All `<img>` have `alt` text | Axe DevTools |
| Form labels | All inputs associated with `<label>` or `aria-label` | Axe |
| Error messages | Announced to screen readers (role="alert") | NVDA / VoiceOver |
| Page title | Each page has a unique, descriptive `<title>` | Manual |
| Heading hierarchy | H1 → H2 → H3, no skipping | HeadingsMap extension |

### 6.2 Component-Level Requirements

```tsx
// REQUIRED on every interactive element:

// Buttons with only icons must have accessible labels:
<Button aria-label="Delete claim CLM-2024-00847">
  <TrashIcon aria-hidden="true" />
</Button>

// Status badges must not rely on color alone:
<Badge variant="warning">
  <AlertTriangleIcon aria-hidden="true" className="mr-1" />
  Pending Review
</Badge>

// Modals must trap focus and return it on close:
<Dialog open={open} onOpenChange={setOpen}>
  <DialogContent>
    <DialogTitle>Confirm Claim Approval</DialogTitle>
    {/* DialogContent from Radix/shadcn handles focus trap automatically */}
  </DialogContent>
</Dialog>

// Tables must have scope on headers:
<th scope="col">Claim Reference</th>
<th scope="col">Policy Holder</th>
```

---

## 7. PERFORMANCE STANDARDS

### 7.1 Core Web Vitals Targets

| Metric | Target | Measured By |
|---|---|---|
| Largest Contentful Paint (LCP) | < 2.5s | Lighthouse / CrUX |
| First Input Delay (FID) | < 100ms | Chrome UX |
| Cumulative Layout Shift (CLS) | < 0.1 | Lighthouse |
| Time to Interactive (TTI) | < 3.5s | Lighthouse |

### 7.2 Code-Level Performance Practices

```tsx
// Lazy-load route-level components:
const ClaimsPage = lazy(() => import('./pages/claims/ClaimsPage'));
const DashboardPage = lazy(() => import('./pages/dashboard/DashboardPage'));

// Avoid layout shifts — always provide dimensions on images/iframes:
<img src={logoUrl} alt="Company logo" width={120} height={40} />

// Memoize expensive computations:
const processedData = useMemo(
  () => aggregateClaimsForChart(claims, dateRange),
  [claims, dateRange]  // Only recompute when these change
);

// Paginate data tables — never load all records:
const { data, isLoading } = useQuery({
  queryKey: ['claims', filters, { page, pageSize }],
  queryFn: () => claimsService.list({ ...filters, page, pageSize }),
  keepPreviousData: true,  // Smooth pagination without flash
});
```

### 7.3 API Response Time Targets

| Endpoint Type | Target p95 | Target p99 |
|---|---|---|
| List endpoints (paginated) | < 300ms | < 500ms |
| Detail endpoints (single record) | < 150ms | < 300ms |
| Write operations | < 500ms | < 1s |
| Analytics / aggregation queries | < 1s | < 2s |

Add an N+1 query check: every list endpoint must use JOINs or batch loading — never `SELECT` inside a loop.

---

## 8. DEMO UX STANDARDS

### 8.1 The "First Impression" Rule

The first screen a customer sees must:
1. Load in < 2 seconds
2. Show domain-realistic data (not empty or generic)
3. Have at least one "wow" visual element (a chart, a KPI improving, a live update)
4. Not require the customer to do any setup — data is pre-loaded

### 8.2 Color-Coded Status System

Use consistent status colors throughout the entire application:

| Status Type | Color | Tailwind Class | Use For |
|---|---|---|---|
| Active / Success | Green | `text-green-700 bg-green-50` | Approved, Completed, Healthy |
| Warning / Attention | Amber | `text-amber-700 bg-amber-50` | Pending, In Review, Degraded |
| Error / Critical | Red | `text-red-700 bg-red-50` | Rejected, Failed, Critical |
| Neutral / Inactive | Gray | `text-gray-600 bg-gray-100` | Draft, Closed, Archived |
| Information | Blue | `text-blue-700 bg-blue-50` | New, Submitted, Info |

Seed data must include records in at least 4 different status states to make the color system visible in the demo.

### 8.3 Loading Skeletons (Not Spinners)

```tsx
// Spinners are acceptable only for actions (button loading state)
// Page content must use skeleton screens — never blank white + spinner

function ClaimsTableSkeleton({ rows = 10 }: { rows?: number }) {
  return (
    <div className="space-y-2">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="flex gap-4 p-3 animate-pulse">
          <div className="h-4 bg-gray-200 rounded w-32" />
          <div className="h-4 bg-gray-200 rounded w-48" />
          <div className="h-4 bg-gray-200 rounded w-24" />
          <div className="h-5 bg-gray-200 rounded-full w-20" />
        </div>
      ))}
    </div>
  );
}
```
