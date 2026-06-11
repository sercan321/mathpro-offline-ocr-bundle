# V172-Q279 — Selected Runtime Dependency Trial Behind Default-Off Flag Audit

## Scope

Q279 adds a selected runtime dependency trial gate for the future PP-FormulaNet-S runtime path. It is intentionally default-off and gate-only. It records the dependency-coordinate, pinned-version, license, transitive dependency, Gradle/AGP/Kotlin, ABI packaging, APK-size, rollback, MathLive review, and explicit-user-approval conditions that must be satisfied before any real dependency trial can advance.

## Explicit Non-Goals

- no Paddle runtime
- no PaddleOCR dependency
- no JNI/native bridge implementation
- no MethodChannel runtime binding
- no PP-FormulaNet-S model binary
- no production model URL
- no production download worker
- no image-to-LaTeX inference
- no direct OCR-to-workspace/Solve/Graph/Solution/History path
- no OCR/runtime/release PASS claim

## Red-Line Preservation

Keyboard layout, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, splash/icon, AndroidManifest, MainActivity, camera dependencies, and Android toolchain are preserved. The phase adds only camera/OCR contract files, verifier metadata, and audit records.
