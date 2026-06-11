import 'dart:ui';

import 'math_layout_engine.dart';
import 'slot_hit_testing.dart';
import 'structural_renderer_bridge.dart';

class SlotEngineSelfCheckResult {
  const SlotEngineSelfCheckResult({required this.ok, required this.checkedExpressions, required this.failures});

  final bool ok;
  final int checkedExpressions;
  final List<String> failures;
}

class SlotEngineSelfCheck {
  const SlotEngineSelfCheck._();

  static const String version = 'mathpro-v65-editor-interaction-lock-self-check';

  static const List<String> structuralSmokeExpressions = <String>[
    '□⁄□',
    '√(□)',
    '³√(□)',
    '□^(□)',
    'x^(□)',
    '∫(□)dx',
    '∫ₐᵇ(□)dx',
    '∫_{□}^{□}(□)d□',
    '√(√(□))',
    'x⁄□',
    '□⁄y',
    'Σ(□)',
    'Π(□)',
    'lim(□)',
    '[□ □; □ □]',
    '[□ □ □; □ □ □; □ □ □]',
    'sin(□)',
    '9□ = □; □ = □',
    'd/dx(88□)',
  ];

  static SlotEngineSelfCheckResult run({Size canvasSize = const Size(360, 118)}) {
    final failures = <String>[];

    for (final expression in structuralSmokeExpressions) {
      final snapshot = StructuralRendererBridge.snapshotForExpression(expression);
      if (!snapshot.registry.hasSlots) {
        failures.add('$expression: slot registry is empty');
        continue;
      }

      final ids = <String>{};
      final nodeSlotKeys = <String>{};
      for (final entry in snapshot.registry.entries) {
        if (!ids.add(entry.id)) {
          failures.add('$expression: duplicate slot id ${entry.id}');
        }
        final nodeSlotKey = '${entry.nodeId}.${entry.slotKey}.${entry.role}';
        if (!nodeSlotKeys.add(nodeSlotKey)) {
          failures.add('$expression: duplicate slot target $nodeSlotKey');
        }
      }

      final layout = MathLayoutEngine.deriveSlotRects(canvasSize: canvasSize, registry: snapshot.registry);
      if (layout.slotRects.length != snapshot.registry.entries.length) {
        failures.add('$expression: slot rect count ${layout.slotRects.length} != registry count ${snapshot.registry.entries.length}');
      }

      for (final item in layout.slotRects.entries) {
        final rect = item.value;
        if (rect.isEmpty) {
          failures.add('$expression: ${item.key.role} rect is empty');
        }
        if (rect.left < -0.01 || rect.top < -0.01 || rect.right > canvasSize.width + 0.01 || rect.bottom > canvasSize.height + 0.01) {
          failures.add('$expression: ${item.key.role} rect out of canvas $rect');
        }

        final hitTarget = SlotHitTesting.targetFor(item.key, rect);
        if (hitTarget.hitRect.width < SlotHitTesting.minimumFingerTarget || hitTarget.hitRect.height < SlotHitTesting.minimumFingerTarget) {
          failures.add('$expression: ${item.key.role} hit rect below 44x44 ${hitTarget.hitRect}');
        }
        if (!hitTarget.hitRect.contains(rect.center)) {
          failures.add('$expression: ${item.key.role} hit rect does not contain visual center');
        }
      }
    }

    return SlotEngineSelfCheckResult(
      ok: failures.isEmpty,
      checkedExpressions: structuralSmokeExpressions.length,
      failures: List<String>.unmodifiable(failures),
    );
  }
}
