# V172-Q169R21 Court Overlay Compile Scope Repair Audit

Q169R20 user-side `flutter analyze` and `flutter test` failed because `lib/features/mathlive/mathlive_main_editor_surface.dart` referenced `mounted` inside `_consumeBridgeStateMessage()` before the local variable `final mounted = snapshot.runtime...` was declared later in the same function. Dart treated the later local declaration as the scope owner, so the earlier overlay guard was a `referenced_before_declaration` / `read_potentially_unassigned_final` compile error.

Q169R21 repairs this without changing the MathLive bridge semantics:

- the overlay lifecycle guard now uses `this.mounted`, the `State` property;
- the parsed runtime boolean is renamed to `runtimeMountedFromSnapshot`;
- the ambiguous `final mounted = snapshot.runtime...` local is removed;
- Q169R20 court result ownership / overlay lock logic remains intact;
- protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files remain untouched;
- no real-device MathLive paint or premium visual PASS is claimed.

Package-side verification added: `node tool/verify_mathlive_court_overlay_compile_scope_repair_v172_q169r21.mjs`.
