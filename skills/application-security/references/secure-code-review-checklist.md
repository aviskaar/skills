# Secure Code Review Checklist

## Usage

Use this checklist during code review for all changes touching:
- Authentication or authorization logic
- Cryptography or secrets handling
- External input processing (user input, API responses, file uploads)
- Data persistence (database queries, file operations)
- External service integrations
- Session management
- Logging or error handling

**Severity levels for findings:**
- **BLOCK:** Do not merge; must fix before approval
- **REQUIRE:** Must address before next release
- **RECOMMEND:** Best practice; fix in current or next sprint

---

## Section 1: Authentication & Authorization

| # | Check | Severity | Notes |
|---|---|---|---|
| 1.1 | All endpoints have explicit authorization checks (not relying on UI hiding) | BLOCK | |
| 1.2 | Authorization checked server-side, not client-side only | BLOCK | |
| 1.3 | Permissions verified at object/record level (not just function level) | BLOCK | |
| 1.4 | Session tokens are cryptographically random (≥128 bits entropy) | BLOCK | |
| 1.5 | Passwords stored using bcrypt/Argon2id (not MD5/SHA-1/SHA-256) | BLOCK | |
| 1.6 | Password comparison uses constant-time compare (prevent timing attacks) | BLOCK | |
| 1.7 | No hardcoded credentials in code, config, or comments | BLOCK | |
| 1.8 | Account lockout implemented (≥5 failed attempts → lockout + alert) | REQUIRE | |
| 1.9 | Password reset tokens: single-use, expire in 15 minutes, cryptographically random | REQUIRE | |
| 1.10 | JWT: algorithm verified (reject 'none' algorithm; RS256 not switchable to HS256) | BLOCK | |
| 1.11 | JWT: expiry (exp claim) validated; reject expired tokens | BLOCK | |
| 1.12 | Session invalidated on logout (server-side; not just cookie deletion) | REQUIRE | |
| 1.13 | Re-authentication required for sensitive operations (password change, MFA change) | REQUIRE | |
| 1.14 | OAuth state parameter present and validated (CSRF prevention) | BLOCK | |
| 1.15 | OAuth redirect_uri strictly validated against allowlist | BLOCK | |

---

## Section 2: Input Validation & Injection Prevention

| # | Check | Severity | Notes |
|---|---|---|---|
| 2.1 | All user inputs validated (type, format, length, range) | BLOCK | |
| 2.2 | Input validation on server-side (client-side validation alone is insufficient) | BLOCK | |
| 2.3 | SQL queries use parameterized statements or ORM (no string concatenation) | BLOCK | |
| 2.4 | NoSQL queries use driver's parameterization (no raw JSON injection) | BLOCK | |
| 2.5 | OS command execution: no user input in shell commands; use execv() family | BLOCK | |
| 2.6 | LDAP queries: special characters escaped; no user input in filter | BLOCK | |
| 2.7 | XML parsing: external entities disabled (XXE prevention) | BLOCK | |
| 2.8 | Template engines: user input not passed directly to template renderer | BLOCK | |
| 2.9 | URL parameters used in HTTP requests: SSRF controls (allowlist; block internal) | BLOCK | |
| 2.10 | File paths: user input not concatenated into file paths (path traversal) | BLOCK | |
| 2.11 | Deserialization of user-provided data: avoid or use safe alternatives | REQUIRE | |
| 2.12 | Regular expressions: protected against ReDoS (catastrophic backtracking) | RECOMMEND | |
| 2.13 | Integer overflow/underflow handled (especially in financial calculations) | REQUIRE | |

---

## Section 3: Output Encoding (XSS Prevention)

| # | Check | Severity | Notes |
|---|---|---|---|
| 3.1 | HTML output: user data HTML-encoded before rendering | BLOCK | |
| 3.2 | JavaScript output: user data JSON-encoded or JS-escaped | BLOCK | |
| 3.3 | URL output: user data URL-encoded | BLOCK | |
| 3.4 | CSS output: user data CSS-escaped (or avoided entirely) | BLOCK | |
| 3.5 | Content-Security-Policy header set (no unsafe-inline, no unsafe-eval) | REQUIRE | |
| 3.6 | X-Content-Type-Options: nosniff header set | REQUIRE | |
| 3.7 | X-Frame-Options or CSP frame-ancestors set (clickjacking prevention) | REQUIRE | |
| 3.8 | Referrer-Policy header set | RECOMMEND | |
| 3.9 | DOM-based XSS: no innerHTML, outerHTML, document.write with user data | BLOCK | |

---

## Section 4: Cryptography

| # | Check | Severity | Notes |
|---|---|---|---|
| 4.1 | No custom cryptography implementation (use standard libraries only) | BLOCK | |
| 4.2 | Symmetric encryption: AES-256-GCM or AES-256-CBC minimum | BLOCK | |
| 4.3 | Asymmetric: RSA-2048+ or ECDSA P-256+ | BLOCK | |
| 4.4 | Hash functions: SHA-256 minimum (no MD5, no SHA-1 for security) | BLOCK | |
| 4.5 | Random number generation: use CSPRNG (os.urandom(), secrets module, etc.) | BLOCK | |
| 4.6 | No Math.random() or rand() for security purposes | BLOCK | |
| 4.7 | Encryption keys stored in vault/KMS (not hardcoded, not in config file) | BLOCK | |
| 4.8 | HMAC used for message authentication (not bare hash) | REQUIRE | |
| 4.9 | IV/nonce: unique per encryption operation; not reused | BLOCK | |
| 4.10 | TLS: certificate validation not disabled (verify=True, ssl_verify not False) | BLOCK | |

---

## Section 5: Secrets & Credential Management

| # | Check | Severity | Notes |
|---|---|---|---|
| 5.1 | No API keys, passwords, tokens in source code | BLOCK | |
| 5.2 | No secrets in environment variable names that log to stdout | BLOCK | |
| 5.3 | No secrets in comments or documentation files | BLOCK | |
| 5.4 | Secrets loaded from vault/environment at runtime (not config file committed to git) | BLOCK | |
| 5.5 | .gitignore includes .env, *.key, *.pem, *.p12, credentials.json | REQUIRE | |
| 5.6 | Secret references in IaC use variable references (not literal values) | BLOCK | |
| 5.7 | Third-party SDK credentials: application-specific; scoped to minimum permissions | REQUIRE | |
| 5.8 | Access tokens with short TTL (≤1h for user-delegated; ≤24h for service-to-service) | REQUIRE | |

---

## Section 6: Error Handling & Logging

| # | Check | Severity | Notes |
|---|---|---|---|
| 6.1 | Error messages to users: generic (no stack traces, internal paths, db structure) | BLOCK | |
| 6.2 | Detailed errors logged internally (not shown to user) | REQUIRE | |
| 6.3 | Logging captures: auth events, access denied, data export, admin actions | REQUIRE | |
| 6.4 | No PII, PHI, or credentials in log statements | BLOCK | |
| 6.5 | No passwords or tokens logged (including in debug mode) | BLOCK | |
| 6.6 | All exceptions caught; no unhandled exception propagates to user | REQUIRE | |
| 6.7 | HTTP 500 errors: generic message; no exception detail to client | REQUIRE | |
| 6.8 | Structured logging format (JSON) for SIEM ingestion | RECOMMEND | |
| 6.9 | Sensitive operations logged with: user, timestamp, action, resource | REQUIRE | |

---

## Section 7: File Upload & Download

| # | Check | Severity | Notes |
|---|---|---|---|
| 7.1 | File type validation: allowlist of permitted MIME types (not just extension) | BLOCK | |
| 7.2 | File size limit enforced (prevent DoS via large file upload) | REQUIRE | |
| 7.3 | Uploaded files stored outside web root (not directly accessible) | BLOCK | |
| 7.4 | Uploaded file names sanitized (prevent path traversal) | BLOCK | |
| 7.5 | Uploaded files scanned for malware before processing | REQUIRE | |
| 7.6 | No execution of uploaded files (PHP, executable, scripts) | BLOCK | |
| 7.7 | File download: Content-Disposition: attachment (prevent inline execution) | REQUIRE | |
| 7.8 | Download path: user cannot traverse outside intended directory | BLOCK | |
| 7.9 | Zip files: check for zip bombs (max file count, max uncompressed size) | REQUIRE | |

---

## Section 8: Data Protection

| # | Check | Severity | Notes |
|---|---|---|---|
| 8.1 | PII/PHI: data minimization (collect only what is necessary) | REQUIRE | |
| 8.2 | PII in transit: always over TLS (no HTTP for any PII) | BLOCK | |
| 8.3 | PII in database: sensitive fields encrypted at column level if required | REQUIRE | |
| 8.4 | PII not present in: URLs, query strings, logs, or error messages | BLOCK | |
| 8.5 | Data retention: records older than retention period deleted or archived | REQUIRE | |
| 8.6 | Soft delete vs hard delete: confirm which is used; audit requirements met | RECOMMEND | |
| 8.7 | Multi-tenant systems: tenant isolation verified (user A cannot see tenant B data) | BLOCK | |
| 8.8 | Mass assignment: framework protections enabled (Rails strong params, Django exclude) | BLOCK | |

---

## Section 9: CSRF & Clickjacking

| # | Check | Severity | Notes |
|---|---|---|---|
| 9.1 | CSRF token on all state-changing forms and AJAX requests | BLOCK | |
| 9.2 | SameSite=Strict or SameSite=Lax on session cookies | REQUIRE | |
| 9.3 | Origin/Referer header validated for sensitive operations | REQUIRE | |
| 9.4 | X-Frame-Options: DENY or SAMEORIGIN (or CSP frame-ancestors) | REQUIRE | |
| 9.5 | Custom request header (e.g., X-Requested-With) for AJAX CSRF protection | RECOMMEND | |

---

## Section 10: Dependency Security

| # | Check | Severity | Notes |
|---|---|---|---|
| 10.1 | All dependencies pinned to specific versions (not ranges in production) | REQUIRE | |
| 10.2 | No known critical CVE in dependencies (SCA scan passed) | BLOCK | |
| 10.3 | Dependencies sourced from official registries (PyPI, npm, Maven Central) | REQUIRE | |
| 10.4 | Lockfile committed (package-lock.json, Pipfile.lock, etc.) | REQUIRE | |
| 10.5 | No dependency with copyleft license (GPL) in proprietary product | REQUIRE | |
| 10.6 | SBOM generated for this release | RECOMMEND | |

---

## AI-Generated Code (Additional Checks)

When reviewing AI-generated code (from LLMs/Copilot/etc.), apply all above checks PLUS:

| # | Check | Severity |
|---|---|---|
| AI.1 | Verify no training data leakage (proprietary patterns, credentials from training) | BLOCK |
| AI.2 | Confirm no placeholder functions with "TODO: add security check" | BLOCK |
| AI.3 | SAST scan mandatory on all AI-generated code before merge | BLOCK |
| AI.4 | Generated regex patterns tested against ReDoS and edge cases | REQUIRE |
| AI.5 | No generated crypto implementations (AI often generates flawed crypto) | BLOCK |
| AI.6 | Dependency hallucinations: verify every import/package actually exists | BLOCK |
| AI.7 | Business logic: thoroughly review; AI may not understand security requirements | REQUIRE |
