# V172-Q111 Legacy Cursor Physical Cleanup Planning Audit Report

Q111 adds a physical-cleanup planning and inventory gate for the legacy cursor stack. It is planning-only.

## Scope

- Classify legacy cursor/editor files before any later Q112 cleanup execution.
- Preserve rollback, shared editor/data-path, and protected UI files.
- Block every physical deletion in this package.
- Keep MathLive main-editor switching, default activation, cursor PASS claims, and legacy cursor deletion blocked without real Q109/Q110/Q108/Flutter evidence and explicit cleanup approval.

## Guardrails

- No legacy cursor file was physically deleted.
- No main editor path was retired.
- No MathLive main workspace mount was implemented.
- No default editor switch was implemented.
- No protected keyboard/MORE/long-press/AppShell/Graph/History/Solution/MathLabel/template tray file was edited.
- No fake runtime, smoke, device, Flutter, cursor, or cleanup PASS evidence was generated.

## New verifier

```powershell
node tool/verify_legacy_cursor_physical_cleanup_planning.mjs
```

Expected package-side status before real evidence and manual approval:

```text
LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED
```

## Inventory

The cleanup inventory is stored at:

```text
docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json
```

It separates files into protected surfaces, shared editor/data-path files, rollback files, cleanup candidates for later Q112 review, and manual-review-required files.
