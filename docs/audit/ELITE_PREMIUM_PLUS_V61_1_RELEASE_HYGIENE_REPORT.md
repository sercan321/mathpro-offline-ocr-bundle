# V61.1 Release Hygiene Report

Package hygiene target:

- no `build/`
- no `.dart_tool/`
- no `.gradle/`
- no `.idea/`
- no `__pycache__/`
- no `.pyc`
- no `.pytest_cache/`

Fresh extraction and zip integrity are checked during packaging. Flutter/Dart runtime tests are not claimed from the assistant container because the toolchain is unavailable here.
