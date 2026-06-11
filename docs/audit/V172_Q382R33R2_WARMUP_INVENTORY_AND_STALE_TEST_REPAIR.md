# V172-Q382R33R2 — Warmup Inventory and Stale Test Repair

This repair closes two user-side `flutter test` failures reported after Q382R33R1:

1. `v172_q153_mathlive_flutter_test_contract_repair_test.dart` still expected the old AppShell bridge marker `MathLiveKeyboardBridgePolicy.commandForMainEditorLabel`. The production AppShell now routes through `sendKeyFast`, while command mapping remains in the MathLive warmup/bridge policies. The test was updated without reviving the legacy simple-key fallback.
2. `v172_q382r33_full_keyboard_warmup_fast_path_closure_test.dart` expected primary calculus/template labels such as `∫□dx` in the warmup inventory. Q382R33 originally deduplicated by `origin::tab::label`, allowing duplicate per-tab entries and long-press options to consume the 256-entry cap before later primary tabs. Q382R33R2 deduplicates warmup by dispatch label so every unique primary key can be warmed once.

Production behavior is not expanded. Keyboard layout/order/labels, long-press inventories, MORE inventory, optimistic echo scope, MathLive slot/caret semantics, Graph, History, Solution, OCR, AndroidManifest, Gradle, MainActivity, splash/icon, and pan/drag-scroll remain untouched.

No Flutter/Dart PASS is claimed by the assistant without user-side evidence.
