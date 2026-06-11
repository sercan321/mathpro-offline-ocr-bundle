# MathPro Flutter Phase 12 — Release Hygiene Report

This package is a full ZIP, not a patch.

Excluded from ZIP:

- build/
- .dart_tool/
- .gradle/
- __pycache__/
- *.pyc
- .pytest_cache/
- temporary packaging folders

Included for Android bootstrap:

- android/gradlew
- android/gradlew.bat
- android/gradle/wrapper/gradle-wrapper.properties

The Gradle scripts delegate to a system Gradle when available or download Gradle 8.7 into android/.gradle on first Android build.
