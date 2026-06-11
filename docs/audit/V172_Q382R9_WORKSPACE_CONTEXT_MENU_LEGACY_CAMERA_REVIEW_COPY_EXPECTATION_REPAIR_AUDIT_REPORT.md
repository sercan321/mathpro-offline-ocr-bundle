# V172-Q382R9 Workspace Context Menu Legacy Camera Review Copy Expectation Repair Audit

Q382R9 repairs stale legacy Flutter tests after user-side `flutter test` evidence showed Q239/Q243/Q277R1 expectations still pinned to older camera/review copy and StatelessWidget review sheet shape.

## Scope

- Test expectation repair only.
- Runtime behavior unchanged.
- Q382 context menu behavior unchanged.
- Q381R1 OCR runtime/camera flow unchanged.
- No fake OCR/result/PASS claim.

## Repaired legacy expectations

- Q239B accepts current camera copy: `OCR review akışı başlar`.
- Q239C accepts current MathLive OCR review title and editable OCR candidate copy.
- Q239D accepts current pending/blocked OCR review copy.
- Q239E accepts `GaussMathLiveOcrReviewSheet extends StatefulWidget` and current review copy.
- Q243 accepts current camera guidance copy.
- Q277R1 accepts Stateful review sheet shape and current pending/blocked review copy.

## Red lines

No changes to keyboard, MORE/template tray, long-press popup/list/order, MathLive production HTML/JS bridge assets, Q381R1 OCR native bridge/runtime/camera flow, Graph, History, solver/evaluator, splash/icon, pubspec, Gradle, or AndroidManifest.

## Claims

No assistant-side Flutter analyze/test/run PASS is claimed. User reported analyze has no issue before this repair; this package targets the remaining `flutter test` legacy expectation failures.
