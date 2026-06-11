import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/mathpro_app.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/editor_controller.dart';
import 'package:mathpro_flutter_phase17/features/editor/selection_controller.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_layout_engine.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_engine_self_check.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_hit_testing.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_renderer_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/viewport_coordinate_transform.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_popup.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_step_models.dart';
import 'package:mathpro_flutter_phase17/features/solution/solution_steps_panel.dart';
import 'package:mathpro_flutter_phase17/features/workspace/math_label.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  testWidgets('MathPro phase 17 preserves frozen keyboard markers', (tester) async {
    await tester.pumpWidget(const MathProApp());

    expect(find.text('Temel'), findsWidgets);
    expect(find.text('MORE'), findsOneWidget);
    expect(find.text('Ans'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('0'), findsWidgets);
    expect(find.byKey(const ValueKey('mathpro-history-handle')), findsNothing);

    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.text('↵'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('□⁄□'), findsWidgets);
  });

  testWidgets('MathPro phase 17 opens long press popup without changing layout source', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.longPress(
      find.byWidgetPredicate((widget) => widget is MathLabel && widget.label == '√□').first,
      warnIfMissed: false,
    );
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byWidgetPredicate((widget) => widget is MathLabel && widget.label == '³√'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is MathLabel && widget.label == '□√□'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is MathLabel && widget.label == '√□'), findsWidgets);
    expect(find.text('×'), findsWidgets);
  });


  testWidgets('MathPro phase 4 bounded integral long-press chip has full no-clip envelope', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 360,
          height: 160,
          child: LongPressPopup(
            options: const <String>['∫ₐᵇ', '∮'],
            activeTab: 'Kalkülüs',
            onSelected: (_) {},
            onDismissed: () {},
          ),
        ),
      ),
    ));
    await tester.pump();

    final boundedIntegral = find.byWidgetPredicate(
      (widget) => widget is MathLabel && widget.label == '∫ₐᵇ' && widget.variant == MathLabelVariant.chip,
    );
    expect(boundedIntegral, findsOneWidget);
    final boundedIntegralChip = find.byKey(const ValueKey('mathpro-long-press-option-222b-2090-1d47'));
    expect(boundedIntegralChip, findsOneWidget);
    expect(tester.getSize(boundedIntegralChip).width, greaterThanOrEqualTo(84));
    expect(tester.getSize(boundedIntegralChip).height, greaterThanOrEqualTo(44));
    expect(find.text('×'), findsNothing);
  });

  testWidgets('MathPro phase 17 MORE tray exposes reference premium templates', (tester) async {
    await tester.pumpWidget(const MathProApp());

    await tester.tap(find.text('MORE'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-more-chip-Kuadratik')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-more-chip-(x+y)²')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-more-chip-∫₀¹ f(x)')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-more-chip-□·□')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-more-chip-‖□‖')), findsOneWidget);
  });

  testWidgets('MathPro phase 17 premium template insertion focuses an open slot', (tester) async {
    await tester.pumpWidget(const MathProApp());

    await tester.tap(find.text('MORE'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.tap(find.byKey(const ValueKey('mathpro-more-chip-∫₀¹ f(x)')));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.textContaining('Aktif slot:'), findsNothing);
    expect(find.text('Seçim'), findsNothing);
    expect(find.text('Aktif alan'), findsNothing);
  });

  testWidgets('MathPro phase 17 hidden selection toolbar preserves expression', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.tap(find.text('□⁄□').first, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.text('Seçim'), findsNothing);
    expect(find.text('Aktif alan'), findsNothing);
    expect(find.text('Temizle'), findsNothing);
  });

  testWidgets('MathPro phase 17 basic input is shown through math render surface', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.text('Seçim'), findsNothing);

    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
  });

  testWidgets('MathPro phase 17 equals remains literal and C clears expression', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();
    await tester.tap(find.text('1'));
    await tester.pump();

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);

    await tester.tap(find.text('C'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.text('Cebir'), findsWidgets);
  });

  testWidgets('MathPro final repair has no removed drawer surface in the widget tree', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-history-handle')), findsNothing);
    expect(find.text('BUGÜN'), findsNothing);
    expect(find.text('DÜN'), findsNothing);
  });

  testWidgets('MathPro phase 17 exposes structural slot layer for fraction template', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.tap(find.text('□⁄□').first, warnIfMissed: false);
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.textContaining('Aktif slot:'), findsNothing);
    expect(find.text('Aktif alan'), findsNothing);

    await tester.tap(find.text('7'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
  });


  testWidgets('MathPro phase 17 template expression keeps selection toolbar removed', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('MORE'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.tap(find.byKey(const ValueKey('mathpro-more-chip-2×2 Matris')));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-editor-math-render-surface')), findsOneWidget);
    expect(find.text('Seçim'), findsNothing);
    expect(find.text('Aktif alan'), findsNothing);
    expect(find.text('Temizle'), findsNothing);
  });

  testWidgets('MathPro phase 17 basic evaluator accepts pi as a numeric constant', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));

    await tester.tap(find.text('π'));
    await tester.pump();
    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
  });


  test('MathPro phase A uses structural TeX for core templates without debug labels', () {
    final sqrtSnapshot = StructuralRendererBridge.snapshotForExpression('√(□)');
    expect(sqrtSnapshot.registry.hasSlots, isTrue);
    expect(sqrtSnapshot.tex, r'\sqrt{\Box}');
    expect(sqrtSnapshot.registry.entries.any((entry) => entry.role == 'sqrtValue'), isTrue);

    final fractionSnapshot = StructuralRendererBridge.snapshotForExpression('□⁄□');
    expect(fractionSnapshot.tex, r'\frac{\Box}{\Box}');
    expect(fractionSnapshot.registry.entries.any((entry) => entry.role == 'fractionNumerator'), isTrue);
    expect(fractionSnapshot.registry.entries.any((entry) => entry.role == 'fractionDenominator'), isTrue);

    final integralSnapshot = StructuralRendererBridge.snapshotForExpression('∫₀¹(□)dx');
    expect(integralSnapshot.tex, r'\int_{0}^{1}{\Box}\,dx');
    expect(integralSnapshot.registry.entries.any((entry) => entry.role == 'integralBody'), isTrue);

    expect(MathTexSerializer.toTex('√(□)'), r'\sqrt{\Box}');
  });

  test('MathPro phase 17 structural slot engine self-check catalog is internally consistent', () {
    final result = SlotEngineSelfCheck.run();
    expect(result.ok, isTrue, reason: result.failures.join('\n'));
    expect(result.checkedExpressions, greaterThanOrEqualTo(10));
  });

  test('MathPro phase B keeps structural slot ownership after partial fills', () {
    final powerExpression = ActionUtils.templateForStructure('^');
    expect(powerExpression, '□^(□)');
    final powerSnapshot = StructuralRendererBridge.snapshotForExpression(powerExpression);
    final powerBase = powerSnapshot.registry.entries.singleWhere((entry) => entry.role == 'powerBase');
    final powerExponent = powerSnapshot.registry.entries.singleWhere((entry) => entry.role == 'powerExponent');
    expect(EditorCommands.replaceFirstOpenSlot(powerExpression, 'x', activeSlotId: powerBase.id), 'x^(□)');
    expect(EditorCommands.replaceFirstOpenSlot(powerExpression, '2', activeSlotId: powerExponent.id), '□^(2)');
    expect(StructuralRendererBridge.snapshotForExpression('x^(□)').registry.entries.single.role, 'powerExponent');

    const fractionExpression = '□⁄□';
    final fractionSnapshot = StructuralRendererBridge.snapshotForExpression(fractionExpression);
    final numerator = fractionSnapshot.registry.entries.singleWhere((entry) => entry.role == 'fractionNumerator');
    final denominator = fractionSnapshot.registry.entries.singleWhere((entry) => entry.role == 'fractionDenominator');
    expect(EditorCommands.replaceFirstOpenSlot(fractionExpression, 'x', activeSlotId: numerator.id), 'x⁄□');
    expect(EditorCommands.replaceFirstOpenSlot(fractionExpression, 'y', activeSlotId: denominator.id), '□⁄y');
    expect(StructuralRendererBridge.snapshotForExpression('x⁄□').registry.entries.single.role, 'fractionDenominator');
    expect(StructuralRendererBridge.snapshotForExpression('□⁄y').registry.entries.single.role, 'fractionNumerator');

    const sqrtExpression = '√(□)';
    final sqrtSlot = StructuralRendererBridge.snapshotForExpression(sqrtExpression).registry.entries.singleWhere((entry) => entry.role == 'sqrtValue');
    expect(EditorCommands.replaceFirstOpenSlot(sqrtExpression, 'x', activeSlotId: sqrtSlot.id), '√(x)');
    expect(StructuralRendererBridge.snapshotForExpression('√(x)').tex, r'\sqrt{x}');
    expect(StructuralRendererBridge.snapshotForExpression('√(√(□))').registry.entries.where((entry) => entry.role == 'sqrtValue').length, 2);
  });

  test('MathPro phase B exposes true editable definite-integral slots without false fixed-limit hit targets', () {
    final editableIntegral = ActionUtils.templateForStructure('∫ₐᵇ');
    expect(editableIntegral, '∫_{□}^{□}(□)d□');
    final integralSnapshot = StructuralRendererBridge.snapshotForExpression(editableIntegral);
    expect(integralSnapshot.tex, r'\int_{\Box}^{\Box}{\Box}\,d\Box');
    expect(integralSnapshot.registry.entries.map((entry) => entry.role), containsAll(<String>[
      'integralLowerLimit',
      'integralUpperLimit',
      'integralBody',
      'integralDifferential',
    ]));

    final lower = integralSnapshot.registry.entries.singleWhere((entry) => entry.role == 'integralLowerLimit');
    final upper = integralSnapshot.registry.entries.singleWhere((entry) => entry.role == 'integralUpperLimit');
    final body = integralSnapshot.registry.entries.singleWhere((entry) => entry.role == 'integralBody');
    final differential = integralSnapshot.registry.entries.singleWhere((entry) => entry.role == 'integralDifferential');
    expect(EditorCommands.replaceFirstOpenSlot(editableIntegral, '0', activeSlotId: lower.id), '∫_{0}^{□}(□)d□');
    expect(EditorCommands.replaceFirstOpenSlot(editableIntegral, '1', activeSlotId: upper.id), '∫_{□}^{1}(□)d□');
    expect(EditorCommands.replaceFirstOpenSlot(editableIntegral, 'x', activeSlotId: body.id), '∫_{□}^{□}(x)d□');
    expect(EditorCommands.replaceFirstOpenSlot(editableIntegral, 't', activeSlotId: differential.id), '∫_{□}^{□}(□)dt');

    final fixedIntegral = StructuralRendererBridge.snapshotForExpression('∫₀¹(□)dx');
    expect(fixedIntegral.registry.entries.any((entry) => entry.role == 'integralUpperLimit'), isFalse);
    expect(fixedIntegral.registry.entries.any((entry) => entry.role == 'integralLowerLimit'), isFalse);
    expect(fixedIntegral.registry.entries.single.role, 'integralBody');
  });


  test('MathPro phase C separates visual slot rects from invisible 44x44 hit targets', () {
    final snapshot = StructuralRendererBridge.snapshotForExpression('∫_{□}^{□}(□)d□');
    final layout = MathLayoutEngine.deriveSlotRects(canvasSize: const Size(360, 118), registry: snapshot.registry);
    expect(layout.slotRects.length, snapshot.registry.entries.length);

    for (final item in layout.slotRects.entries) {
      final target = SlotHitTesting.targetFor(item.key, item.value);
      expect(target.hitRect.width, greaterThanOrEqualTo(SlotHitTesting.minimumFingerTarget), reason: item.key.role);
      expect(target.hitRect.height, greaterThanOrEqualTo(SlotHitTesting.minimumFingerTarget), reason: item.key.role);
      expect(target.hitRect.contains(target.visualRect.center), isTrue, reason: item.key.role);
    }

    final upper = layout.slotRects.entries.singleWhere((item) => item.key.role == 'integralUpperLimit');
    final upperTarget = SlotHitTesting.targetFor(upper.key, upper.value);
    expect(upperTarget.hasInvisibleExpansion, isTrue);

    final outsideVisualInsideHit = Offset(upperTarget.hitRect.left + 1, upperTarget.hitRect.center.dy);
    expect(upperTarget.visualRect.contains(outsideVisualInsideHit), isFalse);
    final hit = SlotHitTesting.hitTest(outsideVisualInsideHit, layout.slotRects);
    expect(hit?.entry.role, 'integralUpperLimit');
    expect(hit?.source, 'slot-hit-invisible-target');
  });

  test('MathPro phase C keeps sqrt/fraction/power slots reachable through expanded hit targets', () {
    for (final expression in const <String>['√(□)', '□⁄□', '□^(□)', '√(√(□))']) {
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      final layout = MathLayoutEngine.deriveSlotRects(canvasSize: const Size(360, 118), registry: snapshot.registry);
      expect(layout.slotRects, isNotEmpty, reason: expression);

      for (final item in layout.slotRects.entries) {
        final target = SlotHitTesting.targetFor(item.key, item.value);
        final hit = SlotHitTesting.hitTest(target.visualRect.center, layout.slotRects);
        expect(hit, isNotNull, reason: '$expression ${item.key.role}');
        expect(target.hitRect.contains(target.visualRect.center), isTrue, reason: '$expression ${item.key.role}');
      }
    }
  });


  test('MathPro phase D ranks overlapping hit targets by visual intent plus priority, not priority alone', () {
    const upper = SlotEntry(
      id: 'integral_1.upper',
      nodeId: 'integral_1',
      nodeKind: MathNodeKind.integral,
      slotKey: 'upper',
      role: 'integralUpperLimit',
      priority: 110,
      minTouchSize: 52,
      normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
      depth: 1,
    );
    const body = SlotEntry(
      id: 'integral_1.body',
      nodeId: 'integral_1',
      nodeKind: MathNodeKind.integral,
      slotKey: 'body',
      role: 'integralBody',
      priority: 80,
      minTouchSize: 48,
      normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
      depth: 1,
    );

    final visualRects = <SlotEntry, Rect>{
      upper: const Rect.fromLTWH(90, 0, 28, 18),
      body: const Rect.fromLTWH(94, 24, 40, 22),
    };

    final hit = SlotHitTesting.hitTest(const Offset(110, 34), visualRects);
    expect(hit?.entry.role, 'integralBody');
    expect(hit?.source, 'slot-hit-invisible-target');
  });

  test('MathPro phase D prefers deeper nested structural slots when candidates are otherwise equal', () {
    const outer = SlotEntry(
      id: 'sqrt_outer.value',
      nodeId: 'sqrt_outer',
      nodeKind: MathNodeKind.sqrt,
      slotKey: 'value',
      role: 'sqrtValue',
      priority: 100,
      minTouchSize: 52,
      normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
      depth: 1,
    );
    const inner = SlotEntry(
      id: 'sqrt_inner.value',
      nodeId: 'sqrt_inner',
      nodeKind: MathNodeKind.sqrt,
      slotKey: 'value',
      role: 'sqrtValue',
      priority: 100,
      minTouchSize: 52,
      normalizedBounds: NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
      depth: 3,
    );

    const sharedVisual = Rect.fromLTWH(120, 34, 28, 22);
    final hit = SlotHitTesting.hitTest(const Offset(134, 45), <SlotEntry, Rect>{
      outer: sharedVisual,
      inner: sharedVisual,
    });

    expect(hit?.entry.id, 'sqrt_inner.value');
  });

  test('MathPro phase E exposes only user-safe selection labels and normalizes stale slots', () {
    final snapshot = StructuralRendererBridge.snapshotForExpression('√(□)');
    final sqrtEntry = snapshot.registry.entries.singleWhere((entry) => entry.role == 'sqrtValue');
    final selection = MathProSelectionController.select(entry: sqrtEntry, caretIndex: 99, source: 'unit');

    expect(selection.isActive, isTrue);
    expect(selection.userLabel, 'Aktif alan');
    expect(selection.userLabel.contains('sqrtValue'), isFalse);
    expect(selection.userLabel.contains(sqrtEntry.id), isFalse);
    expect(selection.caretIndex, 1);

    final normalized = MathProSelectionController.normalize(selection, snapshot.registry);
    expect(normalized.activeSlotId, sqrtEntry.id);
    expect(normalized.activeSlotRole, 'sqrtValue');
    expect(normalized.userLabel, 'Aktif alan');

    final stale = MathProSelectionController.normalize(
      const MathProSelectionState(activeSlotId: 'deleted.slot', activeSlotRole: 'integralBody', lastHitSource: 'stale'),
      snapshot.registry,
    );
    expect(stale.isActive, isFalse);
    expect(stale.userLabel, isEmpty);
  });

  test('MathPro phase E caret rect stays inside the active visual slot', () {
    const slotRect = Rect.fromLTWH(10, 20, 36, 28);
    final startCaret = MathProCaretController.caretRectForSlot(slotRect, caretIndex: -4, childCount: 1);
    final endCaret = MathProCaretController.caretRectForSlot(slotRect, caretIndex: 8, childCount: 1);

    expect(startCaret.left, greaterThanOrEqualTo(slotRect.left - 1));
    expect(startCaret.top, greaterThan(slotRect.top));
    expect(startCaret.height, greaterThanOrEqualTo(18));
    expect(endCaret.right, lessThanOrEqualTo(slotRect.right + 1));
  });

  test('MathPro phase E editor snapshot clears stale active slot instead of leaking debug role labels', () {
    final snapshot = MathEditorController.buildSnapshot(
      expression: '√(□)',
      activeSlotId: 'missing.slot',
      activeSlotRole: 'integralBody',
      lastHitSource: 'stale',
    );

    expect(snapshot.interaction.hasActiveSlot, isFalse);
    expect(snapshot.interaction.userSelectionLabel, isEmpty);
    expect(snapshot.interaction.userSelectionLabel.contains('integralBody'), isFalse);
  });

  test('MathPro phase F maps viewport taps back to canvas coordinates after pan and zoom', () {
    final snapshot = StructuralRendererBridge.snapshotForExpression('∫_{□}^{□}(□)d□');
    final layout = MathLayoutEngine.deriveSlotRects(canvasSize: const Size(360, 118), registry: snapshot.registry);
    final upper = layout.slotRects.entries.singleWhere((item) => item.key.role == 'integralUpperLimit');

    final transform = Matrix4.identity()
      ..translateByDouble(42.0, -13.0, 0.0, 1.0)
      ..scaleByDouble(1.45, 1.45, 1.45, 1.0);
    final viewportTap = MathViewportCoordinateTransform.canvasToViewport(
      canvasPoint: upper.value.center,
      transform: transform,
    );

    final canvasTap = MathViewportCoordinateTransform.viewportToCanvas(
      viewportPoint: viewportTap,
      transform: transform,
    );
    expect((canvasTap.dx - upper.value.center.dx).abs(), lessThan(0.001));
    expect((canvasTap.dy - upper.value.center.dy).abs(), lessThan(0.001));

    final hit = MathViewportSlotHitTesting.hitTestViewportPoint(
      viewportPoint: viewportTap,
      canvasToViewportTransform: transform,
      visualRects: layout.slotRects,
    );
    expect(hit?.entry.role, 'integralUpperLimit');
  });

  test('MathPro phase F keeps visual and hit rectangles transformable as one renderer-sync surface', () {
    final snapshot = StructuralRendererBridge.snapshotForExpression('□⁄□');
    final layout = MathLayoutEngine.deriveSlotRects(canvasSize: const Size(360, 118), registry: snapshot.registry);
    final numerator = layout.slotRects.entries.singleWhere((item) => item.key.role == 'fractionNumerator');
    final target = SlotHitTesting.targetFor(numerator.key, numerator.value);

    final transform = Matrix4.identity()
      ..translateByDouble(-24.0, 18.0, 0.0, 1.0)
      ..scaleByDouble(1.6, 1.6, 1.6, 1.0);
    final transformedVisual = MathViewportCoordinateTransform.canvasRectToViewport(
      canvasRect: target.visualRect,
      transform: transform,
    );
    final roundTripVisual = MathViewportCoordinateTransform.viewportRectToCanvas(
      viewportRect: transformedVisual,
      transform: transform,
    );

    expect(transformedVisual.width, greaterThan(target.visualRect.width));
    expect((roundTripVisual.center.dx - target.visualRect.center.dx).abs(), lessThan(0.001));
    expect((roundTripVisual.center.dy - target.visualRect.center.dy).abs(), lessThan(0.001));
    expect(MathViewportCoordinateTransform.approximateScale(transform), closeTo(1.6, 0.001));
  });


  testWidgets('MathPro premium history stays hidden by default and opens from the card icon', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const ValueKey('mathpro-history-handle')), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-premium-history-button')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('mathpro-premium-history-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsOneWidget);
    expect(find.text('Geçmiş'), findsOneWidget);
    expect(find.text('MORE'), findsNothing, reason: 'keyboard should be hidden while the premium history panel is open');
  });

  testWidgets('MathPro graph icon opens explicit graph preview without mutating keyboard layout', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.tap(find.text('x'));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('mathpro-graph-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-graph-surface')), findsNothing, reason: 'Q205 blocks fake graph surfaces without a MathLive production snapshot');
    expect(find.text('MORE'), findsOneWidget);
    expect(find.text('='), findsOneWidget);
    expect(find.text('↵'), findsOneWidget);
  });


  testWidgets('MathPro phase 7 keeps mounted app shell overflow-free on locked device profiles', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final profiles = <Size>[
      const Size(360, 740),
      const Size(393, 873),
      const Size(412, 915),
      const Size(768, 1024),
    ];

    for (final size in profiles) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(const MathProApp());
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull, reason: 'layout should not overflow at $size');
    }
  });


  testWidgets('MathPro V68 keeps workspace, solution panel and keyboard on one outer width rail', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 280));

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-steps-button')));
    await tester.pump(const Duration(milliseconds: 360));

    final workspaceWidth = tester.getSize(find.byKey(const ValueKey('mathpro-question-answer-card'))).width;
    final solutionWidth = tester.getSize(find.byKey(const ValueKey('mathpro-solution-steps-panel'))).width;
    final keyboardWidth = tester.getSize(find.byKey(const ValueKey('mathpro-keyboard-shell'))).width;

    expect(workspaceWidth, closeTo(solutionWidth, 0.5));
    expect(keyboardWidth, closeTo(solutionWidth, 0.5));
    expect(find.text('MORE'), findsOneWidget, reason: 'width lock must not hide or rebuild the frozen keyboard');
    expect(find.text('Ans'), findsOneWidget);
    expect(find.text('↵'), findsOneWidget);
  });

  test('MathPro Q205 retires legacy EditorViewport widget-level cursor coverage', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    expect(workspace, isNot(contains('EditorViewport(')));
    expect(workspace, contains('MathLiveProductionEditorSurface('));
  });

  testWidgets('MathPro solution steps panel opens in-workspace without mutating keyboard or history', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 280));

    expect(find.byKey(const ValueKey('mathpro-solution-steps-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-workspace-camera-entry-button')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-steps-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-steps-scroll')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-question-answer-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
    expect(find.text('MORE'), findsOneWidget, reason: 'solution steps must not hide or rebuild the frozen keyboard');
    expect(find.text('↵'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsNothing);

    expect(find.byKey(const ValueKey('mathpro-workspace-camera-entry-button')), findsOneWidget, reason: 'Q239A replaced the inert three-dot placeholder with the camera entry without mutating the solution panel.');
    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsOneWidget, reason: 'camera entry presence must not alter the solution panel unless tapped intentionally.');

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-panel-close-button')));
    await tester.pump(const Duration(milliseconds: 420));
    await tester.pump();

    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsNothing);
    expect(find.text('MORE'), findsOneWidget);
  });

  testWidgets('MathPro solution steps panel supports medium to expanded motion without losing card context', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('×'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 280));

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-steps-button')));
    await tester.pump(const Duration(milliseconds: 360));
    final mediumHeight = tester.getSize(find.byKey(const ValueKey('mathpro-solution-steps-panel'))).height;

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-panel-expand-button')));
    await tester.pump(const Duration(milliseconds: 360));
    final expandedHeight = tester.getSize(find.byKey(const ValueKey('mathpro-solution-steps-panel'))).height;

    expect(expandedHeight, greaterThanOrEqualTo(mediumHeight));
    expect(find.byKey(const ValueKey('mathpro-question-answer-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
    expect(find.text('MORE'), findsOneWidget);
  });


  testWidgets('MathPro Q227 solution steps render single-surface list items and inline math lanes', (tester) async {
    const snapshot = SolutionStepsSnapshot(
      expression: '1+2',
      result: '3',
      steps: <SolutionStep>[
        SolutionStep(
          index: 1,
          title: 'İfade alındı',
          description: '',
          mathLine: '1+2',
        ),
        SolutionStep(
          index: 2,
          title: 'Sınır bildirimi',
          description: 'Sahte adım gösterilmiyor.',
          isLimitation: true,
        ),
        SolutionStep(
          index: 3,
          title: 'Sonuç',
          description: '',
          mathLine: '3',
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: 390,
          height: 360,
          child: SolutionStepsPanel(
            snapshot: snapshot,
            panelState: SolutionStepsPanelState.medium,
            onClose: () {},
            onToggleExpanded: () {},
          ),
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 260));

    expect(find.byKey(const ValueKey('mathpro-solution-step-item-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-badge-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-math-line-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-math-scroll-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-tone-chip-2')), findsNothing);
    expect(find.text('Sınır'), findsNothing);
    expect(find.text('Matematik satırı'), findsNothing);
  });


  testWidgets('MathPro Q227 solution panel keeps premium motion surfaces without new routes', (tester) async {
    const snapshot = SolutionStepsSnapshot(
      expression: '2×3',
      result: '6',
      steps: <SolutionStep>[
        SolutionStep(
          index: 1,
          title: 'İfade alındı',
          description: 'Hareket korundu.',
          mathLine: '2×3',
        ),
        SolutionStep(
          index: 2,
          title: 'Sonuç',
          description: 'Ana bağlam korundu.',
          mathLine: '6',
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: 390,
          height: 360,
          child: SolutionStepsPanel(
            snapshot: snapshot,
            panelState: SolutionStepsPanelState.expanded,
            onClose: () {},
            onToggleExpanded: () {},
          ),
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const ValueKey('mathpro-solution-panel-content-motion-expanded')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-motion-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-steps-handle')), findsOneWidget);
    expect(tester.getSize(find.byKey(const ValueKey('mathpro-solution-steps-handle'))).width, greaterThanOrEqualTo(52));
    expect(find.byKey(const ValueKey('mathpro-solution-step-item-1')), findsOneWidget);
  });


  testWidgets('MathPro phase 6 expanded state supports premium drag toggling without route changes', (tester) async {
    const snapshot = SolutionStepsSnapshot(
      expression: 'x^2+2x+1',
      result: '(x+1)^2',
      steps: <SolutionStep>[
        SolutionStep(
          index: 1,
          title: 'İfade alındı',
          description: 'Geniş mod korundu.',
          mathLine: 'x^2+2x+1',
        ),
        SolutionStep(
          index: 2,
          title: 'Sonuç',
          description: 'Yeni route açılmaz.',
          mathLine: '(x+1)^2',
        ),
      ],
    );
    var panelState = SolutionStepsPanelState.medium;
    var toggleCount = 0;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: 390,
              height: 420,
              child: SolutionStepsPanel(
                snapshot: snapshot,
                panelState: panelState,
                onClose: () {},
                onToggleExpanded: () {
                  setState(() {
                    toggleCount += 1;
                    panelState = panelState.isExpanded
                        ? SolutionStepsPanelState.medium
                        : SolutionStepsPanelState.expanded;
                  });
                },
              ),
            );
          },
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const ValueKey('mathpro-solution-panel-state-pill')), findsOneWidget);
    expect(find.text('Orta'), findsOneWidget);
    expect(find.text('Geniş'), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-solution-panel-drag-surface')), findsOneWidget);

    await tester.drag(find.byKey(const ValueKey('mathpro-solution-steps-handle')), const Offset(0, -170));
    await tester.pump(const Duration(milliseconds: 340));

    expect(toggleCount, 1);
    expect(find.text('Geniş'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-panel-content-motion-expanded')), findsOneWidget);

    await tester.drag(find.byKey(const ValueKey('mathpro-solution-steps-handle')), const Offset(0, 170));
    await tester.pump(const Duration(milliseconds: 340));

    expect(toggleCount, 2);
    expect(find.text('Orta'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-panel-content-motion-medium')), findsOneWidget);
  });



  testWidgets('MathPro phase 7 regression keeps solution panel scrollable and close restores workspace', (tester) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Temel'), findsWidgets);
    expect(find.text('Cebir'), findsWidgets);
    expect(find.text('Kalkülüs'), findsWidgets);
    expect(find.text('Kompleks'), findsWidgets);
    // Lineer Cebir is intentionally reachable through the horizontal tab rail;
    // the compact 390px regression viewport should not require every tab chip to be mounted at once.
    expect(find.text('MORE'), findsOneWidget);
    expect(find.text('Ans'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsNothing);

    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('↵'));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-steps-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-steps-scroll')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-question-answer-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
    expect(find.text('MORE'), findsOneWidget, reason: 'solution panel must not hide the frozen keyboard');
    expect(find.text('Ans'), findsOneWidget);
    expect(find.text('↵'), findsOneWidget);

    await tester.drag(find.byKey(const ValueKey('mathpro-solution-steps-scroll')), const Offset(0, -120));
    await tester.pump(const Duration(milliseconds: 240));
    expect(tester.takeException(), isNull, reason: 'solution panel internal scroll should not overflow');

    expect(find.byKey(const ValueKey('mathpro-workspace-camera-entry-button')), findsOneWidget, reason: 'Q239A replaced the inert three-dot placeholder with the camera entry.');
    expect(find.byType(PopupMenuButton), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-panel-close-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-question-answer-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsWidgets, reason: 'Q205 keeps non-editor result/solution display surfaces available while the workspace editor remains MathLive-only.');
    expect(find.text('MORE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('MathPro phase 7 regression keeps graph and history surfaces independent from solution panel', (tester) async {
    await tester.pumpWidget(const MathProApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Cebir'));
    await tester.pump(const Duration(milliseconds: 260));
    await tester.tap(find.text('x'));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('mathpro-graph-button')));
    await tester.pump(const Duration(milliseconds: 360));

    expect(find.byKey(const ValueKey('mathpro-graph-surface')), findsNothing, reason: 'Q205 blocks fake graph surfaces without a MathLive production snapshot');
    expect(find.text('MORE'), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-steps-button')));
    await tester.pump(const Duration(milliseconds: 360));
    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-graph-button')), findsOneWidget, reason: 'graph action must remain mounted on the main card');

    await tester.tap(find.byKey(const ValueKey('mathpro-solution-panel-close-button')));
    await tester.pump(const Duration(milliseconds: 420));
    await tester.pump();
    expect(find.byKey(const ValueKey('mathpro-solution-steps-panel')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('mathpro-premium-history-button')));
    await tester.pump(const Duration(milliseconds: 360));
    expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsOneWidget);
    expect(find.text('MORE'), findsNothing, reason: 'existing history behavior should remain unchanged after solution panel work');
  });

  testWidgets('MathPro Q227 regression keeps long single-surface solution content inside panel scroll surface', (tester) async {
    final steps = List<SolutionStep>.generate(
      18,
      (index) => SolutionStep(
        index: index + 1,
        title: 'Regresyon adımı ${index + 1}',
        description: 'Uzun çözüm açıklamaları ana ekranı değil yalnızca çözüm panelinin kendi scroll alanını hareket ettirmelidir.',
        mathLine: index.isEven ? 'x^{${index + 2}} + 2x + 1 = ${(index + 1) * 3}' : null,
      ),
    );
    final snapshot = SolutionStepsSnapshot(
      expression: 'long-regression-expression',
      result: 'regression-result',
      steps: steps,
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: 390,
          height: 360,
          child: SolutionStepsPanel(
            snapshot: snapshot,
            panelState: SolutionStepsPanelState.medium,
            onClose: () {},
            onToggleExpanded: () {},
          ),
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const ValueKey('mathpro-solution-steps-scroll')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-item-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('mathpro-solution-step-item-18')), findsNothing);

    await tester.dragUntilVisible(
      find.byKey(const ValueKey('mathpro-solution-step-item-18')),
      find.byKey(const ValueKey('mathpro-solution-steps-scroll')),
      const Offset(0, -160),
      maxIteration: 20,
      duration: const Duration(milliseconds: 80),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byKey(const ValueKey('mathpro-solution-step-item-18')), findsOneWidget);
    expect(tester.takeException(), isNull, reason: 'long solution content should remain bounded by the panel scroll view');
  });

  test('MathPro solution step composer stays honest about unsupported symbolic steps', () {
    final unsupported = SolutionStepsComposer.compose(
      expression: '∫_{□}^{□}(□)d□',
      result: '0',
      unsupportedReason: 'Bu ifade henüz desteklenmiyor.',
    );

    expect(unsupported.steps.where((step) => step.isLimitation), isNotEmpty);
    expect(unsupported.steps.map((step) => step.description).join(' '), contains('Sahte adım gösterilmiyor'));

    final numeric = SolutionStepsComposer.compose(expression: '1+2', result: '3');
    expect(numeric.steps.length, 3);
    expect(numeric.steps.last.mathLine, '3');
  });

}
