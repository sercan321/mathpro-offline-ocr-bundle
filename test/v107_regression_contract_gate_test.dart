import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_expression_render_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_regression_gate.dart';

void main() {
  group('V107 regression contract gate lock', () {
    test('sacred keyboard tab and basic-core contracts stay frozen', () {
      expect(MathProRegressionGate.version, 'mathpro-v107-regression-contract-gate');
      expect(KeyConfig.tabs, orderedEquals(MathProRegressionGate.expectedTabs));
      expect(KeyConfig.basicCoreKeyboard, equals(MathProRegressionGate.expectedBasicCoreKeyboard));
      expect(MathProRegressionGate.sacredCoreDriftFindings(), isEmpty);
    });

    test('renderer and preview versions are regression-gated', () {
      expect(MathExpressionRenderBridge.version, 'mathpro-v107-renderer-bridge-regression-gated');
      expect(UnifiedMathPreviewPolicy.version, 'mathpro-v107-unified-math-preview-policy');
    });

    test('known public labels do not leak visible programmer tokens after preview canonicalization', () {
      final rawLabels = MathProRegressionGate.knownVisibleLabels();
      final visibleLabels = rawLabels.map(UnifiedMathPreviewPolicy.canonicalPreviewLabel).toSet();
      final leaks = MathProRegressionGate.visibleTokenLeaks(visibleLabels);
      expect(leaks, isEmpty);
    });

    test('legacy expression leaks are forced into user-facing math display forms', () {
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('asin(□)'), 'sin⁻¹(□)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('acos(□)'), 'cos⁻¹(□)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('atan(□)'), 'tan⁻¹(□)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('log_10(□)'), 'log₁₀(□)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('log(2)(5)'), 'log₍2₎(5)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('lim_y → 8(8)'), 'lim₍y→8₎(8)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('x_n'), 'x_□');
    });

    test('release gate has no findings for currently registered surfaces', () {
      final visibleLabels = MathProRegressionGate.knownVisibleLabels().map(UnifiedMathPreviewPolicy.canonicalPreviewLabel);
      expect(MathProRegressionGate.releaseGateFindings(visibleLabels: visibleLabels), isEmpty);
    });
  });
}
