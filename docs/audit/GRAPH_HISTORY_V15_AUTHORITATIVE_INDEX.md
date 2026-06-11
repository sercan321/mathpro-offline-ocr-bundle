# GRAPH_HISTORY_V15 — Superseded Historical Index

Current authoritative surface: `docs/audit/GRAPH_HISTORY_V17_AUTHORITATIVE_INDEX.md` and README V17.

V15 was superseded by V16 after a third deep re-audit found no runtime source issue but found historical audit-note ambiguity around the retired `mathpro-history-handle` references. V15 remains a historical reference only.

---

# GRAPH_HISTORY_V15 — Authoritative Audit Index

This file is superseded/historical. V17 is the current authoritative audit surface for the Graph + Premium History branch after the user-side analyze/test log repair.

## Current authoritative files

- `README.md`
- `docs/audit/GRAPH_HISTORY_V15_DEEP_REAUDIT_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V15_CHANGED_FILES_MANIFEST.md`
- `docs/audit/GRAPH_HISTORY_V15_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/GRAPH_HISTORY_V15_STATIC_CHECK.txt`
- `docs/audit/GRAPH_HISTORY_V15_AUTHORITATIVE_INDEX.md`
- `docs/audit/GRAPH_HISTORY_V15_CONTENTS.txt`

## Current runtime truth

- Graph + Premium History are active.
- History is not removed.
- The old crude `mathpro-history-handle` surface is not authoritative and is not present in runtime `lib/`.
- The keyboard, tabs, key positions, `MORE`, `Ans`, `↵`, `=`, and long-press contracts remain frozen.
- V15 did not change runtime Dart source. It repaired audit-governance documentation drift found during the second deep re-audit.

Older audit files remain historical references only. They must not override this file or the README.


Superseded by: `docs/audit/GRAPH_HISTORY_V17_AUTHORITATIVE_INDEX.md`.
