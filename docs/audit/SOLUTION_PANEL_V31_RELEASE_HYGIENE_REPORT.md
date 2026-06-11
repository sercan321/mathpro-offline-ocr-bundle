# MathPro Solution Panel V31 — Release Hygiene Report

## Package hygiene checks
The release package must exclude generated/runtime debris:
- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

## Expected delivery
- Full project ZIP, not a patch package.
- Same root directory: `MathProFlutterPhase17/`.
- Audit docs included under `docs/audit/`.

## Verification limitation
Flutter/Dart execution was unavailable in the assistant container. Static checks and source comparisons were performed; runtime analyzer/test/device evidence must be generated on the user's machine.
