# Premium Keyboard V20 Release Hygiene Report

- Full package ZIP created from a fresh working directory.
- Excluded dirty build/cache/interpreter artifacts:
  - build/
  - .dart_tool/
  - .gradle/
  - .idea/
  - __pycache__/
  - .pyc
  - .pytest_cache/
- ZIP integrity check passed after packaging.
- Flutter/Dart execution unavailable in this container; real Flutter verification must be run on the user's machine.
