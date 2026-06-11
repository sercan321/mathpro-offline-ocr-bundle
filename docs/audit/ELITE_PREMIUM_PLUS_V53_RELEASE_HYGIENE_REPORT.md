# V53 Release Hygiene Report

## Clean ZIP exclusions required
- build/
- .dart_tool/
- .gradle/
- .idea/
- __pycache__/
- *.pyc
- .pytest_cache/
- temporary worktree artifacts

## Integrity protocol
- Produce full package ZIP, not a patch-only package.
- Produce meta/audit ZIP.
- Include no generated build caches.
- Preserve keyboard/topology contracts.
- Do not claim Flutter PASS without running Flutter.
