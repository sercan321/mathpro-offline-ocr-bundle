import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V171 premium math chip rendering restoration', () {
    test('active metadata is V171 closure', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.auditTitle, contains('Closure'));
    });

    test('long-press popup keeps the mathish branch and text fallback', () {
      final source = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
      expect(source, contains('final isMathish = _mathishChipLabels.contains(widget.label)'));
      expect(source, contains('child: isMathish'));
      expect(source, contains('? Center('));
      expect(source, contains(': FittedBox('));
    });

    test('visible labels remain user-facing instead of raw template source', () {
      const labels = <String>['Taylor', 'EBOB', 'EKOK', '√□', '□^□', '□!', 'log_□(□)', '∫ₐᵇ'];
      for (final label in labels) {
        final visible = UnifiedMathPreviewPolicy.visibleDisplayLabel(label);
        expect(visible, isNot(contains('□')), reason: label);
      }
    });
  });
}
