import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_expression_render_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/features/workspace/math_label.dart';

void main() {
  group('V106 unified math preview polish lock', () {
    test('preview policy canonicalizes programmer and legacy preview labels', () {
      expect(UnifiedMathPreviewPolicy.version, 'mathpro-v107-unified-math-preview-policy');
      expect(MathExpressionRenderBridge.version, 'mathpro-v107-renderer-bridge-regression-gated');

      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('asin(□)'), 'sin⁻¹(□)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('log(2)(5)'), 'log₍2₎(5)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('lim_y → 8(8)'), 'lim₍y→8₎(8)');
      expect(UnifiedMathPreviewPolicy.shouldUseMathPreview('log(2)(5)'), isTrue);
      expect(UnifiedMathPreviewPolicy.shouldUseMathPreview('lim_y → 8(8)'), isTrue);
    });

    test('long-press and MORE preview widths reserve enough room for dense math labels', () {
      expect(UnifiedMathPreviewPolicy.longPressChipWidth('∫_{□}^{□}(□)d□'), greaterThanOrEqualTo(150));
      expect(UnifiedMathPreviewPolicy.longPressChipWidth('Taylor'), greaterThanOrEqualTo(164));
      expect(UnifiedMathPreviewPolicy.moreChipMinWidth('lim sin(x)/x', compact: true), greaterThanOrEqualTo(84));
      expect(UnifiedMathPreviewPolicy.moreChipMaxWidth('Taylor', compact: false), greaterThanOrEqualTo(170));
      expect(UnifiedMathPreviewPolicy.needsViewportProtection('log(2)(5)'), isTrue);
    });

    testWidgets('compact MathLabel accepts filled log and limit display forms', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MathLabel(label: 'log₍2₎(5)', variant: MathLabelVariant.chip),
              MathLabel(label: 'lim₍y→8₎(8)', variant: MathLabelVariant.chip),
              MathLabel(label: 'Π', variant: MathLabelVariant.chip),
            ],
          ),
        ),
      );

      expect(find.text('log₍2₎(5)'), findsOneWidget);
      expect(find.text('lim₍y→8₎(8)'), findsOneWidget);
      expect(find.text('Π'), findsWidgets);
    });
  });
}
