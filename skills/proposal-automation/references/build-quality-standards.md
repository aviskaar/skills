# Build Quality Standards — Anti-Slop Ruleset & Enterprise Code Standards

This document governs Phase 4 (Autonomous POC/MVP Build). Every rule here is a hard requirement, not a suggestion. Violations fail the quality gate.

---

## 1. THE ANTI-SLOP MANIFESTO

"AI slop" is output that looks complete but is functionally hollow — placeholder code, generic data, stub implementations, and copy-paste boilerplate masquerading as a real product. It fails immediately when shown to a technical audience and destroys credibility with enterprise customers.

A POC passes quality standards when:
- A senior engineer reviews the code and finds no `// TODO` on any critical path
- A product manager opens the app and can complete a full workflow without hitting a dead end
- The customer's CTO sees domain-specific business logic, not generic CRUD
- A security engineer finds no credentials, keys, or sensitive data in the repository
- The app runs on a fresh laptop in under 5 minutes via `docker-compose up`

---

## 2. FORBIDDEN PATTERNS (Instant Quality Gate Fail)

### 2.1 Code Stubs & Placeholders

```
// FORBIDDEN — any of these patterns fail immediately:

// TODO: implement this
// FIXME: add real logic here
throw new Error("Not implemented")
raise NotImplementedError("coming soon")
pass  # (Python stub body)
return null  # on a real business operation
return {}    # on a real business operation
console.log("TODO")

// FORBIDDEN — placeholder function bodies:
function processClaimApproval(claim) {
  return true;  // stub
}

// REQUIRED — real implementation:
async function processClaimApproval(claim: Claim): Promise<ApprovalResult> {
  if (claim.amount > APPROVAL_LIMITS[claim.type]) {
    return requireSeniorReview(claim);
  }
  const validation = await validateClaimDocuments(claim.documents);
  if (!validation.passed) {
    return rejectClaim(claim, validation.failureReasons);
  }
  return approveAndSchedulePayment(claim);
}
```

### 2.2 Generic Test Data

```
// FORBIDDEN:
{ name: "John Doe", email: "test@test.com", amount: 12345 }
{ id: 1, title: "Test Item", description: "Lorem ipsum dolor sit amet" }
{ company: "ACME Corp", phone: "555-1234" }

// REQUIRED (Insurance domain example):
{
  claimReferenceNumber: "CLM-2024-00847",
  policyHolderName: "Margaret Chen",
  email: "m.chen@brightwood-consulting.com",
  claimType: "property_damage",
  incidentDate: "2024-11-03",
  claimedAmount: 47250.00,
  currency: "USD",
  status: "pending_assessment",
  adjusterId: "ADJ-00123"
}
```

Generate seed data that:
- Uses real-looking names from the demographic context (not "Test User 1")
- Uses plausible amounts for the industry (not round numbers unless they're actually round)
- Uses realistic dates and sequences
- Has at least 15–20 records per primary entity
- Has status/state variety — not all records in the same state

### 2.3 Hardcoded Secrets

```
// FORBIDDEN — any of these in source files:
const API_KEY = "sk-1234567890abcdef"
DATABASE_URL = "postgresql://admin:password123@localhost:5432/mydb"
JWT_SECRET = "mysecretkey"
AWS_ACCESS_KEY_ID = "AKIA..."

// REQUIRED:
const API_KEY = process.env.EXTERNAL_SERVICE_API_KEY
// .env.example documents every variable:
// EXTERNAL_SERVICE_API_KEY=your_key_here
```

### 2.4 Copy-Paste Boilerplate Without Domain Adaptation

```
// FORBIDDEN:
// Routes named after HTTP verbs:
router.get('/getUsers', ...)
router.post('/createUser', ...)

// Generic CRUD with no business logic:
app.post('/items', (req, res) => {
  db.insert('items', req.body);
  res.json({ success: true });
});

// REQUIRED:
// Routes named after business operations:
router.post('/claims/:id/approve', requireRole('CLAIMS_ADJUSTER'), approveClaimHandler)
router.post('/claims/:id/escalate', requireRole('SENIOR_ADJUSTER'), escalateClaimHandler)

// Business logic that reflects actual rules:
async function approveClaim(claimId: string, adjusterId: string): Promise<ClaimApproval> {
  const claim = await claimRepository.findWithDocuments(claimId);
  assertClaimIsInReviewState(claim);
  assertAdjusterHasAuthority(adjusterId, claim.amount);
  await documentVerificationService.verifyAll(claim.documents);
  const approval = await paymentService.schedulePayment(claim);
  await auditLog.record({ action: 'CLAIM_APPROVED', claimId, adjusterId, amount: claim.amount });
  await notificationService.notifyPolicyHolder(claim.policyHolder, approval);
  return approval;
}
```

---

## 3. BACKEND CODE STANDARDS

### 3.1 Project Structure — Domain-Driven

Organize by business domain, not by technical layer:

```
// FORBIDDEN — technical layers at top level:
src/
  controllers/
  models/
  repositories/
  services/

// REQUIRED — domain modules:
src/
  modules/
    claims/
      claims.controller.ts
      claims.service.ts
      claims.repository.ts
      claims.schema.ts       # Zod/Pydantic validation schemas
      claims.types.ts        # TypeScript interfaces
      claims.test.ts
    policies/
      ...
    adjusters/
      ...
  middleware/
    auth.middleware.ts       # Real JWT verification, not a stub
    validation.middleware.ts
    audit.middleware.ts      # Logs every state-changing operation
  config/
    database.ts              # Connection pooling, retry logic
    environment.ts           # Typed env var parsing with validation
```

### 3.2 API Design (Contract-First)

**Write openapi.yaml FIRST, generate code from it, never the reverse.**

Every endpoint must specify:
```yaml
# openapi.yaml — example endpoint
paths:
  /claims/{claimId}/approve:
    post:
      operationId: approveClaim
      summary: Approve a claim after adjuster review
      tags: [Claims]
      security:
        - bearerAuth: []
      parameters:
        - name: claimId
          in: path
          required: true
          schema:
            type: string
            pattern: '^CLM-\d{4}-\d{5}$'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ClaimApprovalRequest'
      responses:
        '200':
          description: Claim approved and payment scheduled
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ClaimApprovalResponse'
        '409':
          description: Claim is not in a state that allows approval
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '422':
          description: Validation error
```

### 3.3 Authentication & Authorization

POC must implement real auth — not a placeholder `if (user) { return true }`:

```typescript
// REQUIRED — Real JWT verification:
export function requireRole(...roles: UserRole[]) {
  return async (req: Request, res: Response, next: NextFunction) => {
    const token = extractBearerToken(req.headers.authorization);
    if (!token) return res.status(401).json({ error: { code: 'MISSING_TOKEN' } });

    const payload = await verifyJwt(token, process.env.JWT_PUBLIC_KEY!);
    if (!roles.includes(payload.role)) {
      return res.status(403).json({ error: { code: 'INSUFFICIENT_PERMISSIONS',
        message: `Role '${payload.role}' cannot perform this action. Required: ${roles.join(' or ')}` }});
    }
    req.user = payload;
    next();
  };
}
```

Seed the database with at least 3 users in different roles so the demo can show RBAC working.

### 3.4 Database Schema Standards

```sql
-- FORBIDDEN:
CREATE TABLE items (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  data TEXT,
  value FLOAT,
  created_at TIMESTAMP
);

-- REQUIRED (domain-specific, properly constrained):
CREATE TABLE insurance_claims (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  claim_reference_number VARCHAR(20) NOT NULL UNIQUE
                        CHECK (claim_reference_number ~ '^CLM-\d{4}-\d{5}$'),
  policy_id             UUID NOT NULL REFERENCES policies(id),
  policy_holder_id      UUID NOT NULL REFERENCES policy_holders(id),
  claim_type            VARCHAR(50) NOT NULL
                        CHECK (claim_type IN ('property_damage','liability','theft','medical')),
  incident_date         DATE NOT NULL CHECK (incident_date <= CURRENT_DATE),
  claimed_amount        NUMERIC(12, 2) NOT NULL CHECK (claimed_amount > 0),
  currency              CHAR(3) NOT NULL DEFAULT 'USD',
  status                VARCHAR(30) NOT NULL DEFAULT 'submitted'
                        CHECK (status IN ('submitted','under_review','pending_documents',
                                          'approved','rejected','paid','closed')),
  assigned_adjuster_id  UUID REFERENCES adjusters(id),
  created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by            UUID NOT NULL REFERENCES users(id)
);

CREATE INDEX idx_claims_status ON insurance_claims(status);
CREATE INDEX idx_claims_policy_holder ON insurance_claims(policy_holder_id);
CREATE INDEX idx_claims_adjuster ON insurance_claims(assigned_adjuster_id)
  WHERE assigned_adjuster_id IS NOT NULL;
```

### 3.5 Error Handling

```typescript
// REQUIRED — Structured domain error responses:
class ClaimNotFoundError extends DomainError {
  constructor(claimId: string) {
    super('CLAIM_NOT_FOUND', `Claim ${claimId} does not exist`, 404);
  }
}

class ClaimStateViolationError extends DomainError {
  constructor(claimId: string, currentStatus: string, requiredStatus: string) {
    super('CLAIM_STATE_VIOLATION',
      `Claim ${claimId} is in '${currentStatus}' status. This operation requires '${requiredStatus}'.`,
      409,
      { claimId, currentStatus, requiredStatus }
    );
  }
}

// Global error handler returns consistent shape:
// { "error": { "code": "CLAIM_STATE_VIOLATION", "message": "...", "details": { ... } } }
```

### 3.6 Testing Standards

Test structure mirrors domain structure:

```
tests/
  unit/
    modules/
      claims/
        claims.service.test.ts     # Business logic — mock repository
        claims.validation.test.ts  # Schema validation rules
  integration/
    claims.api.test.ts             # Full HTTP → DB roundtrip
    auth.middleware.test.ts
  fixtures/
    claims.fixtures.ts             # Typed, domain-realistic test data
```

**Coverage target**: 80% on service layer (business logic). Controllers and repositories can be lower.

**Test naming**:
```typescript
// FORBIDDEN:
test('should work', () => { ... })
test('test claim', () => { ... })

// REQUIRED:
describe('ClaimsService.approveClaim', () => {
  it('returns ApprovalResult with scheduled payment date when claim passes validation', ...)
  it('throws ClaimStateViolationError when claim is already in approved status', ...)
  it('throws InsufficientAuthorityError when adjuster limit is below claimed amount', ...)
})
```

---

## 4. FRONTEND CODE STANDARDS

### 4.1 Component Architecture

```typescript
// FORBIDDEN — one giant component:
function ClaimsPage() {
  const [claims, setClaims] = useState([])
  // 300 lines of mixed data fetching, business logic, and JSX
}

// REQUIRED — separation of concerns:
// hooks/useClaims.ts — data fetching & state
export function useClaims(filters: ClaimFilters) {
  return useQuery({
    queryKey: ['claims', filters],
    queryFn: () => claimsService.list(filters),
    staleTime: 30_000,
  });
}

// components/ClaimsTable/ClaimsTable.tsx — pure presentation
export function ClaimsTable({ claims, onApprove, onEscalate, isLoading }: ClaimsTableProps) {
  if (isLoading) return <ClaimsTableSkeleton rows={10} />;
  if (claims.length === 0) return <EmptyState message="No claims match your filters" action={<ClearFiltersButton />} />;
  // table JSX
}

// pages/claims/ClaimsPage.tsx — orchestration only
export function ClaimsPage() {
  const [filters, setFilters] = useClaimFilters();
  const { data: claims, isLoading } = useClaims(filters);
  return (
    <PageLayout title="Claims Management">
      <ClaimsFilters value={filters} onChange={setFilters} />
      <ClaimsTable claims={claims ?? []} isLoading={isLoading} ... />
    </PageLayout>
  );
}
```

### 4.2 API Client (Generated, Typed)

Generate the API client from `openapi.yaml`. Never hand-write raw `fetch()` calls:

```typescript
// Use openapi-typescript + openapi-fetch (or similar):
// services/api/claims.ts — generated or hand-typed from openapi.yaml

export async function approveClaim(
  claimId: string,
  request: ClaimApprovalRequest
): Promise<ClaimApprovalResponse> {
  const response = await apiClient.POST('/claims/{claimId}/approve', {
    params: { path: { claimId } },
    body: request,
  });
  if (response.error) throw new ApiError(response.error);
  return response.data;
}
```

### 4.3 State Management

```typescript
// For server state: React Query / TanStack Query (preferred) or SWR
// For UI state: Zustand or React Context (no Redux unless truly needed)
// Never: global mutable variables, localStorage abuse, prop drilling > 2 levels
```

### 4.4 Form Handling

```typescript
// REQUIRED — react-hook-form + Zod (or equivalent):
const claimSubmissionSchema = z.object({
  claimType: z.enum(['property_damage', 'liability', 'theft', 'medical']),
  incidentDate: z.date().max(new Date(), { message: 'Incident date cannot be in the future' }),
  claimedAmount: z.number().positive().max(10_000_000, { message: 'Exceeds maximum single-claim limit' }),
  description: z.string().min(20, { message: 'Please provide at least 20 characters describing the incident' }),
});

// Every field shows: label, helper text, error message (field-level), required indicator
// Form shows: loading state on submit, success toast, error summary
```

### 4.5 Loading & Error States

```typescript
// Every async-dependent UI block must handle all three states:

function ClaimDetail({ claimId }: { claimId: string }) {
  const { data: claim, isLoading, error } = useClaim(claimId);

  if (isLoading) return <ClaimDetailSkeleton />;       // skeleton, not spinner alone
  if (error) return (
    <ErrorState
      title="Unable to load claim"
      message={error.message}
      action={<Button onClick={refetch}>Try Again</Button>}  // always a recovery path
    />
  );
  return <ClaimDetailView claim={claim} />;
}
```

---

## 5. INFRASTRUCTURE STANDARDS

### 5.1 Docker & Local Dev

```yaml
# docker-compose.yml — full stack, no manual steps required
version: '3.9'
services:
  api:
    build: ./apps/api
    ports: ["3001:3001"]
    environment:
      DATABASE_URL: postgresql://app:app@db:5432/appdb
      JWT_SECRET_KEY: dev-secret-change-in-production
      NODE_ENV: development
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./apps/api/src:/app/src  # hot reload

  web:
    build: ./apps/web
    ports: ["3000:3000"]
    environment:
      VITE_API_URL: http://localhost:3001
    depends_on: [api]

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: app
      POSTGRES_DB: appdb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app"]
      interval: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    # for sessions / caching / job queues

volumes:
  postgres_data:
```

`README.md` setup block:
```bash
git clone [repo]
cd [project]
cp .env.example .env
docker-compose up -d
# App available at http://localhost:3000
# API docs at http://localhost:3001/api-docs
# Default login: admin@demo.com / Demo1234!
```

### 5.2 CI Pipeline (GitHub Actions)

```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Lint
        run: npm run lint
      - name: Type Check
        run: npm run typecheck
      - name: Test
        run: npm run test:coverage
      - name: Coverage Gate
        run: npm run test:coverage -- --coverageThreshold='{"global":{"lines":80}}'
      - name: Build
        run: npm run build
      - name: Docker Build
        run: docker-compose build
```

### 5.3 Environment Configuration

Every environment variable must be:
1. Documented in `.env.example` with a comment explaining what it does
2. Validated at startup (fail-fast — crash on missing required vars, don't silently use undefined)
3. Typed (use a config module, never raw `process.env.MY_VAR` scattered through code)

```typescript
// config/environment.ts
import { z } from 'zod';

const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  JWT_SECRET_KEY: z.string().min(32),
  EXTERNAL_API_KEY: z.string().min(10),
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.coerce.number().default(3001),
});

export const env = envSchema.parse(process.env);
// If validation fails, throws at startup with a clear message about which vars are missing
```

---

## 6. DEMO DATA STANDARDS

### 6.1 Seed Data Requirements

For each primary entity, seed:
- **Minimum 15 records** (enough to fill a paginated table and show realistic filtering)
- **Status variety**: seed records in every valid state — not all in the default/initial state
- **Date spread**: records created over the last 30–90 days — not all today
- **Amount/quantity spread**: low, medium, and high values — not all identical
- **Realistic relationships**: linked foreign keys that reflect real business relationships

### 6.2 Domain-Specific Seed Files

Organize seed files by domain. Name them after what they create:

```
db/seeds/
  001_users.sql           # 3+ users in different roles
  002_organizations.sql   # 2+ organizations / tenants
  003_[primary_entity].sql  # 15+ records in various states
  004_[secondary_entity].sql
  005_[relationships].sql
```

### 6.3 Realistic Name/Data Generation

Use a seeding library (Faker.js, faker-python, gofakeit) configured with:
- Locale-appropriate names for the customer's market
- Industry-specific identifiers (`INV-2024-00123`, `CLM-2024-00847`, `ORD-20241103-5521`)
- Plausible business metrics (transaction amounts in the realistic range for the domain)
- Geographic data consistent with the customer's region

---

## 7. QUALITY GATE CHECKLIST

Run this checklist in sequence before any customer demo. A single `[ ]` = demo is cancelled.

### Code Quality
- [ ] `npm run lint` (or equivalent) exits with code 0
- [ ] `npm run typecheck` (TypeScript) exits with code 0
- [ ] `npm test` exits with code 0, all tests green
- [ ] Business logic test coverage ≥ 80% (verified by coverage report)
- [ ] `git grep -r "TODO\|FIXME\|NotImplementedError\|throw new Error.*not impl"` returns zero results on critical paths
- [ ] `git grep -rE "(password|secret|api_key)\s*=\s*['\"][^$]"` returns zero results

### Functional
- [ ] All P1 use case acceptance criteria verified via manual walkthrough in running app
- [ ] Browser console clean during full demo flow (no errors, no warnings about missing keys)
- [ ] Network tab shows no 4xx/5xx during demo flow
- [ ] Every form: submits with valid data, shows errors with invalid data
- [ ] Every table: shows data, loads correctly, handles empty state

### UX
- [ ] App renders at 1440px without horizontal scroll
- [ ] App renders at 375px mobile — all content accessible
- [ ] Interactive elements reachable via keyboard Tab
- [ ] Lighthouse accessibility score ≥ 85 (run in Chrome DevTools)

### Infrastructure
- [ ] `docker-compose down -v && docker-compose up -d` → app running in < 60 seconds
- [ ] README setup instructions work on a clean machine (verified by someone other than the author)
- [ ] GitHub Actions CI pipeline green on the demo branch
- [ ] `.env.example` contains every required variable

### Demo Readiness
- [ ] Demo script written and rehearsed at least once
- [ ] Seed data loaded and verified in the demo environment
- [ ] Demo account credentials documented and tested
- [ ] Backup demo environment available (local + cloud hosted)
