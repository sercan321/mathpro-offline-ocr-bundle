# V60 Release Hygiene Report

## Excluded/generated artifacts policy
The release package must exclude:
- `build/`
- `.dart_tool/`
- `.gradle/`
- `.idea/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache/`

## Runtime policy
V60 is a targeted UX repair package. It does not change keyboard topology, key positions, tab order, long-press option lists, or solver scope.
