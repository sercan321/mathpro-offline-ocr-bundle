# V129 — Real Device Template Routing Repair Audit

## Source of truth
The uploaded package that was re-opened for this repair still identified as the V121/V124 MathJax line in project metadata, not as the previously reported V126/V127/V128 repair line. This V129 package therefore reapplies the missing key/template routing repairs to the actual package contents instead of assuming prior reports were present.

## Real-device defects addressed
- `□!` / factorial and related postfix templates could collapse to bare postfix operators instead of keeping an editable target box.
- `□ᵀ`, `□⁻¹`, and `□ᴴ` could display as bare postfix symbols such as `T` rather than boxed structural templates.
- `□C□` and `□P□` were vulnerable to generic placeholder conversion that produced invalid MathJax such as `\BoxC\Box`.
- Dynamic limit strings such as `limₓ→6(□)` did not consistently serialize to true MathJax limit notation.
- MathJax WebView still committed the full MathJax container node in the uploaded package instead of committing the cloned SVG visual node only.
- Some compact key/MORE/long-press labels had oversized or inconsistent visual routing.

## Files changed
- `pubspec.yaml`
- `README.md`
- `assets/mathjax/tex-svg.js`
- `lib/logic/action_utils.dart`
- `lib/logic/premium_math_key_specs.dart`
- `lib/features/editor/node_factory.dart`
- `lib/features/editor/tex_serializer.dart`
- `lib/features/editor/editor_commands.dart`
- `lib/features/editor/render/math_tex_serializer.dart`
- `lib/features/editor/render/mathjax_render_surface.dart`
- `lib/features/workspace/math_label.dart`
- `test/v121_mathjax_only_editor_surface_test.dart`
- `test/v129_real_device_template_routing_static_test.dart`
- `docs/audit/V129_REAL_DEVICE_TEMPLATE_ROUTING_REPAIR_AUDIT.md`
- `docs/audit/V129_CHANGED_FILES_MANIFEST.md`

## Preserved contracts
- Keyboard key positions were not changed.
- Tab order was not changed.
- `MORE`, `Ans`, `=`, and `↵` contracts were not changed.
- Graph, History, and Solution panel UI files were not modified.
- Long-press option order and key map source files were not modified.

## Flutter execution status
Flutter/Dart SDK was not available in the assistant container. No `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed for this package.
