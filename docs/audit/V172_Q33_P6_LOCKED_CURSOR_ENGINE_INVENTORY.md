# V172-Q33 P6-Locked Existing Cursor Engine Inventory

## Verdict

MathPro already contains a cursor engine. Q33 does not create a cursor engine from zero. It inventories the existing engine and locks the next +95 cursor work to real geometry hardening while keeping P6 UI files unchanged.

## P6 Locked File Check

| File | P6 exists | Q33 exists | P6 SHA16 | Q33 SHA16 | SAME |
|---|---:|---:|---|---|---:|
| `lib/features/keyboard/key_config.dart` | True | True | `4ecd7270e29a27d7` | `4ecd7270e29a27d7` | PASS |
| `lib/features/keyboard/math_keyboard.dart` | True | True | `f4f2a9acdc226cdc` | `f4f2a9acdc226cdc` | PASS |
| `lib/features/keyboard/bottom_dock.dart` | True | True | `f75e70c490827bae` | `f75e70c490827bae` | PASS |
| `lib/features/keyboard/long_press_popup.dart` | True | True | `d6b2c030bd3e8281` | `d6b2c030bd3e8281` | PASS |
| `lib/features/keyboard/premium_key.dart` | True | True | `2d0941666300c4db` | `2d0941666300c4db` | PASS |
| `lib/features/workspace/math_label.dart` | True | True | `e7a185deabadfc05` | `e7a185deabadfc05` | PASS |
| `lib/features/workspace/template_tray.dart` | True | True | `9310d7ae9b61334e` | `9310d7ae9b61334e` | PASS |
| `lib/app/app_shell.dart` | True | True | `df584bf0af59a640` | `df584bf0af59a640` | PASS |
| `lib/features/solution/solution_steps_panel.dart` | True | True | `cefded355d74046a` | `cefded355d74046a` | PASS |
| `lib/features/graph/graph_card.dart` | True | True | `ea1010e17627c4f1` | `ea1010e17627c4f1` | PASS |
| `lib/features/history/history_controller.dart` | True | True | `331a6d84dbe4a940` | `331a6d84dbe4a940` | PASS |
| `lib/features/history/history_panel.dart` | True | True | `fad987605894ffaf` | `fad987605894ffaf` | PASS |

## Cursor Engine Files

| File | Classes | Version/Markers | Key flags |
|---|---|---|---|
| `lib/features/editor/cursor_anchor.dart` | CursorAnchor | - | - |
| `lib/features/editor/selection_controller.dart` | MathProSelectionState, MathProSelectionController, MathProCaretController, _LinearCaretMetrics | mathpro-core-editor-selection-controller-v3-render-mapped-caret-aware, mathpro-core-editor-caret-controller-v10-phase6-token-aware-v172e-log-root-nested-slots | - |
| `lib/features/editor/slot_registry.dart` | NormalizedSlotBounds, SlotEntry, SlotRegistry | - | - |
| `lib/features/editor/editor_commands.dart` | AtomicBackspaceEdit, StructuralSlotBackspaceEdit, LinkedSeriesSlotEdit, _AtomicRange, _SeriesLinkProfile, _SeriesTemplateMatch, EditorCommands | - | - |
| `lib/features/editor/render/editor_interaction_layer.dart` | EditorSlotSelection, EditorInteractionLayer, _SlotBox, _BlinkingSlotCaret, _BlinkingSlotCaretState | - | - |
| `lib/features/editor/render/mathjax_render_surface.dart` | MathJaxRenderSurface, _MathJaxRenderSurfaceState, _MathJaxRenderEvent, _MathJaxHtml, _MathJaxFirstFrameHold, _MathJaxUnavailableSurface, _MathJaxLoadingGhost, _Q30ReadableEditorMirror, _StaticMathJaxFallback | mathpro-v121-v172q30-p6-visual-baseline-cursor-only-visible-input-repair | - |
| `lib/features/workspace/editor_caret_overlay.dart` | EditorCaretOverlay, _PremiumBlinkingCaret, _PremiumBlinkingCaretState | - | - |
| `lib/features/workspace/editor_viewport.dart` | EditorViewport, _ExpressionPreview, _ExpressionPreviewState, _EmptyEditorHint, _ActiveSlotGhost, _ActiveSlotGhostState | - | - |
| `lib/features/formula_engine/math_layout_engine.dart` | MathLayoutBox, MathLayoutEngine | - | - |
| `lib/features/formula_engine/slot_hit_testing.dart` | SlotHitTarget, SlotHitTestResult, SlotHitTesting, _Candidate | - | - |
| `lib/features/formula_engine/layout_coordinate_hit_test.dart` | LayoutCoordinateHitTest | - | - |
| `lib/features/formula_engine/render_mapped_slot_hit_test.dart` | bridges, RenderMappedSlotHitTest | mathpro-v84-render-mapped-slot-hit-test-v172l-renderer-sync-calibrated | - |
| `lib/features/formula_engine/renderer_sync_geometry_policy.dart` | RendererSyncGeometryPolicy | mathpro-v172l-renderer-sync-geometry-calibration-v1 | rendererExtractedBoundsAvailable, deterministicCalibrationEnabled, editorLoupeEnabled, greenDebugOverlayEnabled |
| `lib/features/formula_engine/slot_interaction_calibration_policy.dart` | SlotInteractionCalibrationPolicy, SlotHitSlop | mathpro-v66-v105-premium-slot-interaction-calibration-matrix-system-cells | - |
| `lib/features/formula_engine/slot_priority_policy.dart` | SlotPriorityScore, SlotPriorityPolicy | mathpro-core-editor-v172i-priority-hit-test-calculus-matrix-system-v1 | - |
| `lib/features/formula_engine/template_slot_navigation_policy.dart` | TemplateSlotNavigationPolicy | mathpro-v172i-template-slot-navigation-policy-calculus-matrix-system | - |
| `lib/features/formula_engine/pixel_qa_cursor_matrix_policy.dart` | PixelQACursorMatrixPolicy, PixelQACursorCase | mathpro-v172m-pixel-qa-cursor-matrix-v1 | - |
| `lib/features/formula_engine/real_device_slot_test_protocol.dart` | RealDeviceSlotTestProtocol, ManualSlotScenario, ManualSlotScenarioResult, RealDeviceSlotTestReport, RealDeviceProtocolVerdict | mathpro-v65-real-device-interaction-lock-protocol | - |
| `lib/features/formula_engine/premium_cursor_visual_polish_policy.dart` | PremiumCursorVisualPolishPolicy | mathpro-v172n-v172q32-premium-cursor-visual-polish-role-scaled-v2 | editorLoupeEnabled, greenDebugOverlayEnabled, legacySlotBoxAllowed |

## High-Level Finding

- Structural slot registry exists.
- Slot hit testing exists.
- Render-mapped slot hit test exists.
- Caret overlay exists.
- Real-device slot QA protocol exists.
- Pixel QA cursor matrix exists.
- Current hard limit: renderer-derived bounds are not a complete per-slot/glyph identity system. `RendererSyncGeometryPolicy.rendererExtractedBoundsAvailable` remains false in the existing engine.
