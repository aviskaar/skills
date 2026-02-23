# Encryption Standards Reference

## Approved Algorithms & Key Lengths

### Symmetric Encryption (Data at Rest & Bulk Encryption)

| Algorithm | Key Size | Status | Use Case |
|---|---|---|---|
| AES-256-GCM | 256-bit | **REQUIRED** | All data at rest; preferred for all symmetric |
| AES-256-CBC | 256-bit | Acceptable | Legacy systems; prefer GCM where possible |
| AES-128-GCM | 128-bit | Acceptable | Performance-constrained environments only |
| ChaCha20-Poly1305 | 256-bit | Acceptable | Mobile/embedded; TLS 1.3 cipher suite |
| 3DES (TDEA) | 112-bit | **PROHIBITED** | Do not use in any new implementation |
| DES | 56-bit | **PROHIBITED** | Do not use; easily broken |
| RC4 | Variable | **PROHIBITED** | Do not use; completely broken |
| Blowfish | Variable | **PROHIBITED** | Do not use in new implementations |

### Asymmetric Encryption & Key Exchange

| Algorithm | Key Size | Status | Use Case |
|---|---|---|---|
| RSA | 4096-bit | **REQUIRED** (preferred) | Key exchange, signatures (legacy compat) |
| RSA | 2048-bit | Acceptable | Minimum acceptable for any new RSA use |
| ECDSA P-384 | 384-bit | **REQUIRED** (preferred) | Digital signatures (TLS, code signing) |
| ECDSA P-256 | 256-bit | Acceptable | Digital signatures (faster; acceptable security) |
| Ed25519 | 256-bit | **REQUIRED** (preferred) | SSH keys, API signing; modern preferred |
| ECDH P-384 | 384-bit | Required | Key agreement |
| X25519 | 256-bit | Required | Key agreement (TLS 1.3, modern) |
| RSA < 2048-bit | Any | **PROHIBITED** | Do not use; insufficient security |
| DSA | Any | **PROHIBITED** | Do not use; replaced by ECDSA |
| Diffie-Hellman (non-ECDH) | <2048 | **PROHIBITED** | Use ECDH instead |

### Hash Functions

| Algorithm | Digest Size | Status | Use Case |
|---|---|---|---|
| SHA-3-256 | 256-bit | **REQUIRED** (preferred) | Highest-security hashing |
| SHA-256 | 256-bit | Required | General purpose; HMAC; integrity |
| SHA-384 | 384-bit | Required | Higher-security applications |
| SHA-512 | 512-bit | Required | File integrity, HMAC |
| BLAKE3 | 256-bit | Acceptable | High-performance hashing |
| SHA-1 | 160-bit | **PROHIBITED** | Do not use in any new implementation |
| MD5 | 128-bit | **PROHIBITED** | Do not use for any security purpose |

### Password Hashing (not general-purpose hash)

| Algorithm | Status | Parameters |
|---|---|---|
| Argon2id | **REQUIRED** (preferred) | m=64MB, t=3, p=4 (minimum) |
| bcrypt | Required | Cost factor ≥ 12 |
| scrypt | Acceptable | N=32768, r=8, p=1 minimum |
| PBKDF2-SHA256 | Acceptable | ≥600,000 iterations (NIST 2023) |
| MD5 (passwords) | **PROHIBITED** | Never use for password storage |
| SHA-1 (passwords) | **PROHIBITED** | Never use for password storage |
| Unsalted hashes | **PROHIBITED** | Never store passwords without unique salt |
| Plaintext | **PROHIBITED** | Absolute prohibition |

---

## TLS Configuration Standards

### Minimum TLS Standard (all services)

```nginx
# Nginx TLS configuration — production standard
ssl_protocols TLSv1.2 TLSv1.3;

# TLS 1.3 cipher suites (defined by RFC 8446; cannot be configured):
# TLS_AES_256_GCM_SHA384
# TLS_CHACHA20_POLY1305_SHA256
# TLS_AES_128_GCM_SHA256

# TLS 1.2 cipher suites (explicitly configured):
ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256';
ssl_prefer_server_ciphers off;  # Let client choose (TLS 1.3 best practice)

# ECDH curve
ssl_ecdh_curve X25519:P-384:P-256;

# Session handling
ssl_session_timeout 1d;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;  # Disable for perfect forward secrecy

# OCSP Stapling
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;

# HSTS (include in HTTP response headers)
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
```

### Prohibited TLS Configurations

```
❌ SSLv2: Completely broken; never use
❌ SSLv3: POODLE attack; never use
❌ TLS 1.0: BEAST/POODLE; prohibited by PCI-DSS since June 2018
❌ TLS 1.1: Deprecated; disable
❌ NULL cipher suites: No encryption
❌ EXPORT cipher suites: Intentionally weak; FREAK/LOGJAM
❌ RC4 cipher suites: Stream cipher; statistically broken
❌ DES/3DES cipher suites: SWEET32; deprecated
❌ Anonymous DH (ADH): No authentication
❌ MD5 in cipher suites: Collision vulnerabilities
❌ SHA-1 in cipher suites: SHAttered; deprecated
```

---

## Key Management Standards

### Key Generation
```
Requirements:
- All keys generated using CSPRNG (Cryptographically Secure Pseudo-Random Number Generator)
- OS-level RNG: /dev/urandom (Linux/macOS) or BCryptGenRandom (Windows)
- Library: OpenSSL, libsodium, or NIST-validated library
- Never: Math.random(), rand(), or predictable seeds for cryptographic keys
- HSM: Use HSM for all CA keys, master encryption keys, and high-value signing keys
- FIPS 140-2/3: Level 3 HSM required for CA root keys and KMS master keys
```

### Key Storage
```
Tier          Key Type                         Storage
Critical      CA root keys, KMS master keys    Offline HSM (FIPS 140-3 L3); air-gapped
High          Intermediate CA, per-service keys HSM (FIPS 140-2 L2+) or cloud KMS (AWS/Azure/GCP)
Standard      Application encryption keys      Cloud KMS (AWS KMS, Azure Key Vault, GCP Cloud KMS)
Runtime       Session keys, ephemeral keys     In-memory only; never persisted
Prohibited    Any key                          Source code, config files, environment variables (plaintext)
```

### Key Rotation Schedule
```
Key Type                    Rotation Frequency    Method
AES data encryption keys    Annual minimum        Automated (KMS key rotation policy)
TLS certificate keys        Certificate lifecycle  Automated (ACME) or at cert renewal
SSH host keys               Annual               Manual; update known_hosts
SSH user keys               Annual or on personnel change  Manual; audit and replace
API signing keys            90 days              Automated via secrets manager
JWT signing keys            30 days              Automated; concurrent validity for transition
Service account credentials 30 days (vaulted)    PAM auto-rotation
CA root keys                10 years (offline)   Planned ceremony with multiple custodians
CA intermediate keys        2–5 years            Planned; retire old intermediate
Encryption master keys      Annual               KMS rotation (automatic); re-wrap DEKs
```

---

## Encryption Implementation Checklist

### Database Encryption:
```
□ TDE enabled (SQL Server/Oracle/PostgreSQL)
□ Column-level encryption for PII/PHI (SSN, DOB, medical record number)
□ Backup encryption: separate key from primary data encryption key
□ Encryption verified: attempt to read raw data files (should be unreadable)
□ Key stored in KMS/HSM (not in database itself)
□ Key rotation tested: confirm data accessible after key rotation
□ Connection encryption: TLS enforced for all database connections
□ Encrypted audit logs: cannot be tampered with by DB admin
```

### Object Storage Encryption (S3/Blob/GCS):
```
□ Default encryption enabled on all buckets (SSE-KMS preferred; SSE-S3 acceptable)
□ Customer-managed keys (CMKs) for regulated data (HIPAA, PII, PCI)
□ Bucket policy: deny s3:PutObject without server-side encryption
□ Bucket policy: deny unencrypted transport (aws:SecureTransport: false → deny)
□ Versioning enabled: allows recovery; encryption applies to all versions
□ Replication encryption: if cross-region replication, target also encrypted
```

### Secrets Management:
```
□ All secrets in vault (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault, GCP Secret Manager)
□ No plaintext secrets in: source code, config files, IaC, CI/CD env vars (use references)
□ Secrets injected at runtime: applications retrieve from vault on startup
□ Secret rotation: automated for all secrets with API support
□ Audit logging: every secret access logged (who, when, what)
□ Secret versioning: previous versions retained for rollback; old versions deactivated
□ Least-privilege vault access: applications can only read their own secrets
□ Pre-commit hook: secrets scanning in developer workflow (detect-secrets, gitleaks)
```
