# V172-Q306 — SHA Verification + Atomic Move Real Runtime Gate Audit

## Purpose

Q306 defines the future PP-FormulaNet-S private artifact promotion contract: temporary private artifact → expected/actual SHA256 verification → checksum pass → atomic move → verified private artifact path.

## Status

Static/package-side gate only. Q306 is intentionally blocked until Q302 has a controlled expected/actual SHA pair and Q305 has real controlled download worker evidence.

## What Q306 Adds

- Default-off feature flag: `gauss.ppFormulaNetS.shaVerificationAtomicMove.defaultOff`.
- Verification envelope fields for `expectedSha256`, `actualSha256`, temporary private path, verified private path, verification state, and atomic move state.
- Atomic move state model: checksum computing, mismatch, verified, pending move, succeeded, failed, cleanup required.
- Error taxonomy for missing SHA, SHA computation failure, checksum mismatch, pre-checksum move, unsafe verified path, atomic move failure, and cleanup failure.
- Explicit block against marking an artifact ready before checksum match.
- Explicit block against OCR direct workspace/solve/Graph/Solution/History.

## What Q306 Does Not Do

Q306 does **not** compute a real artifact SHA. It does **not** perform atomic move. It does **not** accept an artifact for runtime. It does **not** load a private artifact. It does **not** modify `pubspec.yaml`, `AndroidManifest.xml`, `MainActivity.kt`, MathLive production route, camera shell, workspace, Graph, Solution, History, keyboard, MORE, or long-press surfaces.

Q306 adds no Paddle/PaddleOCR dependency, JNI/native handler, MethodChannel binding, model binary, production download, runtime startup, dummy runtime call, image-to-LaTeX inference, editable MathLive review launch, workspace import, OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS.

## Evidence Boundary

A later real implementation may only promote an artifact after all of these exist:

- Q302 expected SHA256 locked from a controlled source.
- Q302 actual SHA256 computed from the controlled downloaded artifact.
- Expected/actual SHA match.
- Q305 controlled download worker evidence.
- Temporary private file evidence.
- Atomic move after checksum pass.
- Verified private artifact path evidence.
- Cleanup/rollback evidence.
- Editable MathLive review and explicit user approval remain mandatory before any workspace import.
