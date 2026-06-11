import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';

void main() {
  group('MathPro V76 long-press visual consistency hardening', () {
    test('routes every symbolic long-press option through the math chip renderer', () {
      final source = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
      final setMatch = RegExp(
        r"const Set<String> _mathishChipLabels = \{([\s\S]*?)\n\};",
      ).firstMatch(source);
      expect(setMatch, isNotNull);

      final mathishLabels = RegExp(r"'([^']*)'")
          .allMatches(setMatch!.group(1)!)
          .map((match) => match.group(1)!)
          .toSet();

      final missing = <String>[];
      for (final options in KeyConfig.longPressMap.values) {
        for (final label in options) {
          if (_requiresMathChipRenderer(label) && !mathishLabels.contains(label)) {
            missing.add(label);
          }
        }
      }

      expect(missing, isEmpty, reason: 'Every symbolic long-press label must use the MathLabel chip renderer: $missing');
    });

    test('uses Center for math chips and reserves FittedBox only for non-math text fallback', () {
      final source = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
      expect(source, contains('child: isMathish'));
      expect(source, contains('? Center('));
      expect(source, contains(': FittedBox('), reason: 'Only the non-math branch may use FittedBox scaleDown.');
      expect(source, contains('fit: BoxFit.scaleDown'));
    });
  });
}

bool _requiresMathChipRenderer(String label) {
  const symbolicRunes = '□∫∬∭∮ΣΠ√ⁿ²³₁₂ₙ₀∞→≤≥≠≈≡′″‴⁽⁾⁻ᵀᴴ·×‖';
  if (label.runes.any((rune) => symbolicRunes.runes.contains(rune))) return true;

  const functionTemplates = <String>{
    'sin(□)',
    'cos(□)',
    'tan(□)',
    'sin⁻¹(□)',
    'cos⁻¹(□)',
    'tan⁻¹(□)',
    'sinh(□)',
    'cosh(□)',
    'tanh(□)',
    'sinh⁻¹(□)',
    'cosh⁻¹(□)',
    'tanh⁻¹(□)',
    'ln(□)',
    'log₁₀(□)',
    'log₂(□)',
    'log_□(□)',
    'Arg(□)',
    'cis(□)',
  };
  return functionTemplates.contains(label);
}
