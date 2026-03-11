<!--
Sync Impact Report
- Version change: N/A → 0.1.0
- List of modified principles: Initial Initialization (I. Widget-Driven Architecture, II. Test-First Reliability, III. State & Logic Separation, IV. Lint & Style Compliance, V. Asset & Localization Discipline)
- Added sections: Core Principles, Storage & Data Standards, Quality Gates, Governance
- Removed sections: None
- Templates requiring updates: ✅ All templates verified for alignment
- Follow-up TODOs: None
-->
# first_app_ueg_20261 Constitution

## Core Principles

### I. Widget-Driven Architecture
Break down UI into small, reusable widgets. Follow atomic design principles where possible (atoms, molecules, organisms). Widgets MUST be stateless unless state is strictly local.

### II. Test-First Reliability (NON-NEGOTIABLE)
Every feature MUST have corresponding widget or unit tests. Integration tests are required for P1 user journeys. Tests must pass before merging.

### III. State & Logic Separation
Business logic MUST be separated from the UI layer. Use clear patterns like BLoC, Provider, or simple Controllers to manage shared state.

### IV. Lint & Style Compliance
Adhere strictly to 'flutter_lints'. No warnings allowed in production code. Use consistent naming conventions (camelCase for variables, PascalCase for classes).

### V. Asset & Localization Discipline
Avoid hardcoded strings and paths. Use centralized asset management and localization files to ensure maintainability and future internationalization.

## Storage & Data Standards

Use 'shared_preferences' for simple local state and SQL or local files for complex persistence. API calls should handle errors gracefully with retry/timeout logic.

## Quality Gates

Automatic linting, unit tests, and the 'speckit.analyze' consistency report must be reviewed for every pull request.

## Governance

Amendments require documented justification and a version bump in 'constitution.md'. This document supersedes ad-hoc development decisions.

**Version**: 0.1.0 | **Ratified**: 2026-02-20 | **Last Amended**: 2026-02-20
