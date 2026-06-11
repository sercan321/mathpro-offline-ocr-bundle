import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/workspace/math_label.dart';

void main() {
  testWidgets('MathPro V71 renders inverse trig and indexed-root templates through MathLabel', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Row(
          textDirection: TextDirection.ltr,
          children: [
            MathLabel(label: 'sin⁻¹(□)', variant: MathLabelVariant.chip),
            MathLabel(label: 'cos⁻¹(□)', variant: MathLabelVariant.chip),
            MathLabel(label: 'tan⁻¹(□)', variant: MathLabelVariant.chip),
            MathLabel(label: '∛□', variant: MathLabelVariant.chip),
            MathLabel(label: '□√□', variant: MathLabelVariant.chip),
          ],
        ),
      ),
    ));

    expect(find.byType(MathLabel), findsNWidgets(5));
    expect(tester.takeException(), isNull);
  });

  test('MathPro V71 serializes inverse trig and compact roots as premium TeX', () {
    final tex = MathTexSerializer.toTex('sin⁻¹(□)+cos⁻¹(□)+tan⁻¹(□)+sinh⁻¹(□)+∛□+□√□');

    expect(tex, contains(r'\sin^{-1}\left(\Box\right)'));
    expect(tex, contains(r'\cos^{-1}\left(\Box\right)'));
    expect(tex, contains(r'\tan^{-1}\left(\Box\right)'));
    expect(tex, contains(r'\sinh^{-1}\left(\Box\right)'));
    expect(tex, isNot(contains('asin')));
    expect(tex, isNot(contains('acos')));
    expect(tex, isNot(contains('atan')));
    expect(tex, contains(r'\sqrt[3]{\Box}'));
    expect(tex, contains(r'\sqrt[\Box]{\Box}'));
  });
}
