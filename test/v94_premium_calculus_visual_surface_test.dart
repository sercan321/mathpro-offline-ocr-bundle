import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/workspace/math_label.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_surface_policy.dart';

void main() {
  group('MathPro V94 premium calculus visual surface', () {
    const newStructuralLabels = <String>[
      '∫(□)dx',
      '∫_{□}^{□}(□)d□',
      '∫₀¹(□)dx',
      '∫₀¹ f(x)',
      'Σ(□)',
      'Π(□)',
      'limₓ→□(□)',
      'limₓ→∞(□)',
      'limₓ→0(□)',
      'limₓ→0⁺(□)',
      'limₓ→0⁻(□)',
      'lim sin(x)/x',
    ];

    test('classifies all new calculus templates as premium math surfaces', () {
      for (final label in newStructuralLabels) {
        expect(PremiumMathSurfacePolicy.isMathSurface(label), isTrue, reason: label);
        expect(PremiumMathSurfacePolicy.longPressChipWidth(label), greaterThanOrEqualTo(112), reason: label);
      }
    });

    testWidgets('builds the new calculus glyphs in keycap and chip variants', (tester) async {
      for (final label in newStructuralLabels) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MathLabel(label: label, variant: MathLabelVariant.keycap),
                    MathLabel(label: label, variant: MathLabelVariant.chip),
                  ],
                ),
              ),
            ),
          ),
        );
        expect(find.byType(MathLabel), findsNWidgets(2), reason: label);
      }
    });
  });
}
