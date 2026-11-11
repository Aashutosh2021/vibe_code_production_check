---
name: production-audit
description: Comprehensive 107-point security, resilience, architecture, and production readiness auditor and auto-patcher for Vibe Coders and engineering teams. Use when users ask to audit, inspect, review, or patch their codebase for production readiness across Antigravity, Claude Code, Codex, Cursor, or Windsurf, or when triggered via /audit or /security-check.
---
# Production Readiness & Security Auditor (107 Points)

Act as a Principal Security Architect and Site Reliability Engineer (SRE). Perform an automated, end-to-end inspection of the project repository against all 107 industry standards for security, scalability, data integrity, and operational readiness, then generate production-grade code patches for any missing or vulnerable controls.

## When to Use

- The user invokes `/audit` or `/security-check` in their coding agent
- A Vibe Coder or developer finishes building a prototype or feature and wants to make it production-ready
- The user asks to check if the 107 security, reliability, and architecture points are properly implemented
- The user asks to find vulnerabilities (SQLi, XSS, CSRF, SSRF, IDOR, broken auth, exposed secrets) and patch them automatically

## Steps

### Phase 1: Repository Reconnaissance & Stack Discovery

1. Inspect package manifests (`package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`) and environment templates (`.env.example`).
2. Identify the web framework, authentication strategy, ORM/database client, caching layer, and deployment configuration (`Dockerfile`, CI/CD workflows, infrastructure configs).
3. Map all entry points: public API routes, authenticated endpoints, webhook receivers, file upload handlers, and background workers.

### Phase 2: 107-Point Codebase Inspection

Audit the repository across all 9 domains and verify whether each of the 107 controls is **Implemented Properly (PASS)**, **Partially/Weakly Implemented (WARN)**, **Missing/Vulnerable (FAIL)**, or **Not Applicable (N/A)** for the project's stack:

#### Domain 1: Traffic, Network & Edge Gateway (10 Points)

- **1. Load Balancing**: Stateless application design behind load balancers with health check routing.
- **2. Rate Limiting**: Per-IP and per-user throttling on login, registration, OTP, and public API routes.
- **8. HTTP Status Codes**: Proper semantic status codes (`200`, `201`, `400`, `401`, `403`, `404`, `422`, `429`, `500`).
- **15. CDNs**: Static asset delivery with `Cache-Control` headers and Subresource Integrity (SRI) on external scripts.
- **18. Timeouts**: Explicit connection and read timeouts on all outbound HTTP, database, and cache calls.
- **19. Exponential Backoff**: Retry logic with exponential backoff and jitter for external API calls.
- **21. Circuit Breakers**: Graceful degradation and circuit breaking on flaky third-party dependencies.
- **22. Reverse Proxies**: Safe `trust proxy` configuration so `X-Forwarded-For` cannot be spoofed.
- **23. API Gateways**: Centralized request routing, payload size limits, and edge auth validation.
- **27. HTTPS / TLS**: Enforced HTTPS redirects and strict `Strict-Transport-Security` (HSTS) headers.

#### Domain 2: Identity, Authentication & Access Control (17 Points)

- **5. Authentication**: Timing-safe credential verification and hardened auth flows.
- **6. Authorization**: Server-side authorization checks enforced on every route/controller action.
- **28. Session Management**: Session ID rotation on login and strict server-side invalidation on logout.
- **29. Two-Factor Authentication (2FA)**: TOTP or WebAuthn verification with rate-limited OTP checks and hashed backup codes.
- **34. Principle of Least Privilege**: Scoped database credentials, IAM roles, and service permissions.
- **89. IDOR (Insecure Direct Object References)**: Ownership and tenant verification (`WHERE id = ? AND user_id = ?`) on every resource fetch or mutation.
- **90. Brute Force Protection**: IP + account throttling and progressive delays on credential endpoints.
- **91. Account Lockout**: Temporary lockout or challenge escalation after repeated failed login attempts.
- **92. Password Reset Flows**: High-entropy reset tokens stored hashed, expiring within 15-30 minutes, invalidated after single use.
- **93. Magic Links**: Cryptographically random single-use tokens with short TTL and non-replayable state.
- **94. Passkeys**: Standards-compliant WebAuthn/FIDO2 challenge verification.
- **95. Single Sign-On (SSO)**: OAuth2/OIDC `state` and `PKCE` verification to block login CSRF.
- **96. Role-Based Access Control (RBAC)**: Explicit role/permission middleware with default-deny policy.
- **97. Row-Level Security (RLS)**: Tenant/user isolation enforced in database policies or query scopes.
- **98. API Keys**: Scoped API keys hashed at rest using SHA-256/HMAC and compared in constant time.
- **99. Token Expiration and Refresh**: Short-lived access tokens (5-15 mins) paired with rotated, revocable refresh tokens.
- **100. Cookie Flags**: Auth and session cookies set with `HttpOnly`, `Secure`, and `SameSite=Lax` or `Strict`.

#### Domain 3: Input Safety, Injection & Web Attack Defense (15 Points)

- **7. Input Validation**: Schema validation (Zod, Joi, Pydantic, Validator) on body, query, and URL params.
- **30. SQL Injection**: 100% parameterized queries or prepared statements; zero raw string concatenation in SQL.
- **31. XSS (Cross-Site Scripting)**: Contextual output escaping, HTML sanitization (DOMPurify), and avoidance of unsafe raw HTML injection.
- **32. CSRF**: CSRF tokens or strict `SameSite` cookies + custom header validation on state-changing requests.
- **33. Dependency Vulnerabilities**: Zero critical/high CVEs in lockfiles (`npm audit`, `pip-audit`, `govulncheck`, `cargo audit`).
- **39. Data Validation on the Server**: Mandatory server-side validation independent of frontend form checks.
- **40. File Upload Security**: Magic-byte MIME verification, file size caps, randomized storage filenames, and non-executable storage buckets.
- **81. Content Security Policy (CSP)**: Strict CSP headers restricting `default-src`, `script-src`, `object-src`, and `frame-ancestors`.
- **82. Security Headers**: Helmet/middleware setting `X-Content-Type-Options: nosniff`, `Referrer-Policy`, and `Permissions-Policy`.
- **83. Clickjacking**: `X-Frame-Options: DENY` (or `SAMEORIGIN`) and CSP `frame-ancestors`.
- **84. SSRF (Server-Side Request Forgery)**: URL allowlisting and private IP range blocking (`127.0.0.0/8`, `10.0.0.0/8`, `169.254.169.254`) on server-side fetches.
- **85. Open Redirects**: Redirect target validation against relative paths or an explicit domain allowlist.
- **86. Path Traversal**: Path normalization (`path.resolve`) and base-directory prefix checks before file reads/writes.
- **87. Command Injection**: Usage of `execFile`/`spawn` with argument arrays; zero shell interpolation of user input.
- **88. Mass Assignment**: Explicit DTO field picking so users cannot inject `role`, `isAdmin`, or `balance` fields.

#### Domain 4: Secrets, Cryptography & Privacy (8 Points)

- **3. Environment Variables**: `.env` excluded in `.gitignore`, validated at startup, with zero hardcoded fallback secrets in code.
- **4. Secrets Management**: Production secrets loaded from secret managers or encrypted environment stores.
- **74. Data Privacy (GDPR)**: PII minimization, consent tracking, and account data export/erasure routines.
- **101. Secret Rotation**: Support for dual-key verification (current + previous key) during secret/key rotation.
- **103. Encryption at Rest**: Sensitive PII, tokens, and backups encrypted at rest (AES-256).
- **104. Encryption in Transit**: TLS 1.2/1.3 enforced for HTTPS, database connections, and Redis/queue links.
- **105. Hashing vs Encryption**: Passwords hashed with Argon2id/bcrypt/scrypt; reversible secrets encrypted with AES-256-GCM.
- **106. Salting**: Unique per-record cryptographic salts managed automatically by the password hasher.

#### Domain 5: Database Architecture & Data Integrity (9 Points)

- **11. Database Indexing**: Indexes defined on foreign keys, unique lookups, and frequent filter/sort columns.
- **12. Database Migrations**: Deterministic, version-controlled schema migration files committed to the repo.
- **13. Backups**: Automated backup configuration and documented restore verification scripts.
- **20. Idempotency**: Idempotency key handling on payments, orders, and state-mutating POST endpoints.
- **35. Race Conditions**: Atomic database transactions, `SELECT ... FOR UPDATE` row locks, or optimistic version checks on concurrent state updates.
- **36. Connection Pooling**: Bounded connection pool sizes and timeouts configured on the database client.
- **37. Database Normalization**: Clean relational schema design free of anomalous update/delete duplication.
- **38. Soft Deletes**: `deleted_at` timestamp handling with filtered indexes where data recovery/audit is needed.
- **45. Read Replicas**: Read/write connection separation support for read-heavy queries.

#### Domain 6: Caching, Async Jobs & Scaling (8 Points)

- **14. Caching**: Explicit TTLs, cache keys namespaced by tenant/version, and memory limits.
- **26. Message Queues**: Durable queues with retry policies, visibility timeouts, and Dead-Letter Queues (DLQ).
- **41. Webhooks**: Raw-body HMAC signature verification (`crypto.timingSafeEqual`), timestamp replay protection, and idempotent event IDs.
- **42. Background Jobs**: Heavy processing (emails, PDFs, media, AI calls) offloaded from the request thread.
- **43. Cron Jobs**: Distributed lock/mutex protection so scheduled jobs do not double-run across instances.
- **44. Cache Invalidation**: Deterministic cache busting or write-through updates on data mutation.
- **46. Horizontal vs Vertical Scaling**: Process architecture ready to run multiple concurrent replicas without local file/state lock-in.
- **47. Stateless Services**: Zero in-process memory reliance for user sessions or uploaded files across requests.

#### Domain 7: Observability, Logging & Resilience (11 Points)

- **9. Error Handling**: Centralized error-handling middleware that logs internals and returns sanitized error payloads without stack traces.
- **16. Logging**: Redaction of passwords, API keys, JWTs, and PII from all log statements.
- **17. Monitoring**: Request latency, error rate, CPU, and memory instrumentation hooks.
- **48. Health Checks**: Liveness (`/healthz`) and readiness (`/readyz` checking DB/cache connectivity) endpoints.
- **49. Graceful Shutdown**: `SIGTERM`/`SIGINT` handlers that stop accepting new traffic, drain active requests, and close DB pools cleanly.
- **50. Alerting**: Error spike and SLA breach alert rules or webhook hooks.
- **51. Distributed Tracing**: Request/correlation ID generation (`X-Request-ID` / OpenTelemetry) propagated across logs and calls.
- **52. Structured Logging**: JSON-formatted logs with `timestamp`, `level`, `requestId`, and `context`.
- **53. Error Tracking**: Sentry/OpenTelemetry exception capture integrated into the global error handler.
- **54. Uptime Monitoring**: Synthetic health check endpoints ready for external uptime monitors.
- **102. Audit Logs**: Immutable audit trail recording actor, action, target resource, IP, and timestamp for sensitive actions.

#### Domain 8: Testing, Containers & Release Engineering (20 Points)

- **10. Automated Testing**: Runnable test suite configured in the project.
- **24. Docker**: Multi-stage `Dockerfile`, `.dockerignore`, pinned base image tags, and non-root `USER`.
- **25. CI/CD**: Automated pipeline running lint, typecheck, test suite, and security audit on every PR.
- **55. Feature Flags**: Config or flag evaluation wrapper for safe progressive rollouts.
- **56. Staging Environments**: Environment-agnostic config separation supporting `development`, `staging`, and `production`.
- **57. Infrastructure as Code (IaC)**: Reproducible deployment manifests (Docker Compose, Terraform, Kubernetes, or PaaS config).
- **58. Code Review**: PR template or `CODEOWNERS` enforcing security and quality checks.
- **59. Branching Strategies**: Protected main branch workflow documented and configured in CI triggers.
- **60. Semantic Versioning**: `MAJOR.MINOR.PATCH` versioning in package manifests and changelogs.
- **61. API Versioning**: Explicit `/api/v1/` route prefixing or header versioning.
- **62. API Documentation**: OpenAPI/Swagger spec or up-to-date endpoint documentation.
- **63. Unit vs Integration vs End-to-End Tests**: Separation of fast unit tests, DB/API integration tests, and critical E2E flows.
- **64. Load Testing**: k6, Artillery, or Locust script for stress-testing critical endpoints.
- **65. Debugging**: Debug modes, stack dumps, and dev-only routes strictly disabled when `NODE_ENV=production`.
- **66. Profiling**: Safe performance timing and query execution time logging for slow queries.
- **78. Technical Debt**: Tracking and cleanup of unsafe `TODO`/`FIXME` security shortcuts and deprecated packages.
- **79. Reading Documentation**: Clear project `README.md` with setup, environment variable table, and run commands.
- **80. Reading Error Messages**: Actionable, descriptive internal error messages with error codes.
- **107. Penetration Testing Readiness**: Threat-modeled surface free of exposed debug ports, default credentials, or unauthenticated admin routes.

#### Domain 9: Runtime Correctness & Client Experience (9 Points)

- **67. Time Zones**: All server and database timestamps stored in UTC (`TIMESTAMPTZ` / ISO-8601).
- **68. Character Encoding**: Explicit `UTF-8` encoding across HTTP responses, file reads, and database tables.
- **69. Concurrency**: Safe shared-state handling using locks, queues, or atomic operations.
- **70. Async / Await**: Proper `try/catch` or `.catch()` handling on all promises; zero floating unhandled promises.
- **71. Memory Leaks**: Bounded in-memory caches, cleaned-up event listeners/intervals, and streamed large file processing.
- **72. Cost Monitoring**: Token limits, pagination caps (`limit <= 100`), and budget guards on paid external APIs/LLMs.
- **73. Disaster Recovery**: Documented RTO/RPO recovery steps and backup restoration procedure.
- **75. Accessibility (a11y)**: Semantic HTML elements, `alt` attributes, form `<label>` bindings, keyboard focus, and ARIA roles.
- **76. Mobile Responsiveness**: Responsive viewport meta tag and fluid mobile-friendly layouts.
- **77. Performance Budgets**: Pagination, asset compression (gzip/brotli), lazy loading, and bundle size awareness.

### Phase 3: Generate the Audit Report

Present a structured report containing:

1. **Production Readiness Score**: Overall percentage (`Passed / Applicable Points * 100`) and breakdown by severity (`Critical`, `High`, `Medium`, `Low`).
2. **Domain Scorecard**: Status summary across all 9 domains.
3. **Critical & High Findings Table**: Point number, category, exact file path and line number, vulnerability explanation, and exploit scenario.

### Phase 4: Auto-Patch & Verify

When the user asks to fix or patch the project (or runs `/audit fix`):

1. Prioritize **Critical** and **High** severity issues first (secrets, SQLi/XSS/CSRF, broken auth/IDOR, missing validation, security headers, rate limiting, error handling).
2. Apply clean, minimal, framework-idiomatic code changes directly to the project files.
3. Run existing tests, typechecks, or linters to verify that the security patches do not break application functionality.

## Gotchas

- **Do not break existing app flows while hardening**: When adding CSP, CORS, or cookie flags, match the project's actual frontend/backend origin architecture and local development mode (`Secure` cookie flag conditional on production HTTPS).
- **Check applicability before penalizing**: A CLI tool or static site may not have a SQL database or SSO; mark those points `N/A` rather than `FAIL` and explain why.
- **Never commit real secrets**: When fixing Point 3/4, create `.env.example` with safe placeholder values and ensure `.env` is added to `.gitignore`.
