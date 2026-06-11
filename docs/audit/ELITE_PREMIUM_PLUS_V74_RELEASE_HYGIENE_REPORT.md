# V74 Release Hygiene Report

Package hygiene target:
- no `build/`
- no `.dart_tool/`
- no `.gradle/`
- no `.idea/`
- no `__pycache__/`
- no `*.pyc`
- no `.pytest_cache/`

Static hygiene verification was performed before packaging. Flutter runtime verification must be performed on the user's machine.
