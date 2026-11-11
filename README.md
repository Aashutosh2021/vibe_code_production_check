# 🛡️ 107-Point Production Readiness & Security Audit Skill

Turn any AI coding agent (**Gemini Antigravity**, **Claude Code**, **OpenAI Codex**, **Cursor**, or **Windsurf**) into a Principal Security Architect and Site Reliability Engineer. Built specifically for **Vibe Coders** and fast-moving builders who want to inspect, audit, and auto-patch their apps across **107 mandatory industry standards** before shipping to production.

## 📂 Repository Folder Structure

```text
107-production-audit-skill/
├── README.md                                    # Full documentation, domain guide & setup instructions
├── SKILL.md                                     # Core 107-point skill definition (universal agent format)
├── install.sh                                   # One-command installer for all supported coding agents
├── .gitignore                                   # Standard Git ignore rules
├── .agent/
│   └── skills/
│       └── production-audit/
│           └── SKILL.md                         # Pre-configured workspace skill for Gemini Antigravity
├── .claude/
│   └── commands/
│       └── audit.md                             # Slash command (/audit) for Claude Code
├── .codex/
│   └── skills/
│       └── production-audit/
│           └── SKILL.md                         # Pre-configured skill for OpenAI Codex CLI
├── skills/
│   └── production-audit/
│       └── SKILL.md                             # Canonical skill package directory (npx skills compatible)
├── checklists/
│   └── 107-checklist.md                         # Standalone markdown tracker for all 107 points
└── rules/
    ├── .cursorrules                             # Drop-in rules file for Cursor IDE
    └── .windsurfrules                           # Drop-in rules file for Windsurf IDE
```

## 🎯 Why Vibe Coders Need This Skill

When building fast with AI, apps often work on `localhost` but miss critical production defenses like rate limiting, IDOR ownership checks, SQL injection parameterization, webhook HMAC verification, or cookie security flags (`HttpOnly`, `Secure`, `SameSite`).

With a single `/audit` command, this skill instructs your coding agent to:

1. **Scan the Entire Repository**: Detect your stack, routes, database queries, auth flows, and deployment configs.
2. **Audit All 107 Industry Points**: Verify which controls are properly implemented (`PASS`), weakly configured (`WARN`), missing (`FAIL`), or not applicable (`N/A`).
3. **Score Your Production Readiness**: Generate a `0-100%` readiness score and a prioritized vulnerability table with exact file paths and line numbers.
4. **Auto-Patch Security Gaps**: Write and apply framework-idiomatic code fixes directly into your project without breaking existing features.

## 🧭 The 9 Audit Domains (All 107 Points Covered)

| Domain | Points Covered | Key Security & Engineering Controls |
| :--- | :--- | :--- |
| **1. Traffic, Network & Edge** | `1, 2, 8, 15, 18, 19, 21, 22, 23, 27` | Load Balancing, Rate Limiting, HTTP Status Codes, CDNs, Timeouts, Exponential Backoff, Circuit Breakers, Reverse Proxies, API Gateways, HTTPS/TLS |
| **2. AuthN, AuthZ & Sessions** | `5, 6, 28, 29, 34, 89-100` | Authentication, Authorization, Session Management, 2FA, Least Privilege, IDOR, Brute Force Protection, Account Lockout, Password Resets, Magic Links, Passkeys, SSO, RBAC, Row-Level Security, API Keys, Token Refresh, Cookie Flags |
| **3. Input & Web Attack Defense** | `7, 30-33, 39, 40, 81-88` | Input Validation, SQL Injection, XSS, CSRF, Dependency CVEs, Server Validation, File Upload Security, CSP, Security Headers, Clickjacking, SSRF, Open Redirects, Path Traversal, Command Injection, Mass Assignment |
| **4. Secrets, Crypto & Privacy** | `3, 4, 74, 101, 103-106` | Environment Variables, Secrets Management, GDPR Data Privacy, Secret Rotation, Encryption at Rest, Encryption in Transit, Hashing vs Encryption, Salting |
| **5. Database & Data Integrity** | `11-13, 20, 35-38, 45` | Database Indexing, Migrations, Backups, Idempotency, Race Conditions, Connection Pooling, Normalization, Soft Deletes, Read Replicas |
| **6. Caching, Async & Scaling** | `14, 26, 41-44, 46, 47` | Caching, Message Queues, Webhooks, Background Jobs, Cron Jobs, Cache Invalidation, Horizontal vs Vertical Scaling, Stateless Services |
| **7. Observability & Resilience** | `9, 16, 17, 48-54, 102` | Error Handling, Logging, Monitoring, Health Checks, Graceful Shutdown, Alerting, Distributed Tracing, Structured Logging, Error Tracking, Uptime Monitoring, Audit Logs |
| **8. QA, Containers & CI/CD** | `10, 24, 25, 55-66, 78-80, 107` | Automated Testing, Docker, CI/CD, Feature Flags, Staging Environments, IaC, Code Review, Branching Strategies, SemVer, API Versioning, API Docs, Unit/Integration/E2E Tests, Load Testing, Debugging, Profiling, Technical Debt, Docs, Error Messages, Penetration Readiness |
| **9. Runtime & Client Standards** | `67-73, 75-77` | Time Zones (UTC), Character Encoding (UTF-8), Concurrency, Async/Await, Memory Leaks, Cost Monitoring, Disaster Recovery, Accessibility, Mobile Responsiveness, Performance Budgets |

## 📦 Installation

### Option 1: One-Command Automatic Installer

Clone this repository and run `install.sh` to install across all your coding agents at once:

```bash
git clone https://github.com/your-username/107-production-audit-skill.git
cd 107-production-audit-skill
./install.sh all
```

Or install for a specific coding agent:

```bash
./install.sh antigravity   # Gemini Antigravity
./install.sh claude        # Claude Code
./install.sh codex         # OpenAI Codex
./install.sh cursor        # Cursor & Windsurf
```

### Option 2: Manual Installation by Agent

- **Gemini Antigravity**: Copy `SKILL.md` to `.agent/skills/production-audit/SKILL.md` in your workspace, or globally to `~/.gemini/antigravity/skills/production-audit/SKILL.md`.
- **Claude Code**: Copy `.claude/commands/audit.md` to `.claude/commands/audit.md` in your project, or globally to `~/.claude/commands/audit.md`.
- **OpenAI Codex**: Copy `SKILL.md` to `.codex/skills/production-audit/SKILL.md` in your project, or globally to `~/.codex/skills/production-audit/SKILL.md`.
- **Cursor / Windsurf**: Copy `rules/.cursorrules` or `rules/.windsurfrules` into the root folder of your project.

## 🚀 How to Use in Your Coding Agent

### 1. Full 107-Point Audit Report

```text
/audit
```

Or ask in natural language:

```text
Run the 107-point production-audit skill on this repository and show me all security and reliability gaps.
```

### 2. Audit + Auto-Patch Critical & High Issues

```text
/audit Fix all critical and high severity security vulnerabilities in this project
```

### 3. Domain-Specific Security Patching

```text
/audit Check Domain 2 (Authentication & Sessions) and Domain 3 (Injections & Headers) and patch any missing protections
```

## 📊 Sample Output Produced by the Agent

When triggered, the coding agent outputs a structured report and applies patches:

| Point ID | Control Name | Severity | Location | Issue Detected | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `#30` | SQL Injection | CRITICAL | `src/db/users.ts:28` | Raw string interpolation in query | Patched with parameterized query |
| `#89` | IDOR | CRITICAL | `src/routes/orders.ts:54` | Order fetched by `id` without checking `user_id` | Added ownership filter |
| `#2` | Rate Limiting | HIGH | `src/routes/auth.ts:12` | No throttling on `/api/login` | Added IP + account rate limiter |
| `#100` | Cookie Flags | HIGH | `src/auth/session.ts:19` | Session cookie missing `HttpOnly` and `SameSite` | Hardened cookie flags |

## 📄 License

Distributed under the MIT License.
