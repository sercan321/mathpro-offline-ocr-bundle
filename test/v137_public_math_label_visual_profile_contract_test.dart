import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_visual_contract.dart';
import 'package:mathpro_flutter_phase17/logic/math_template_contract_registry.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V137 public math label visual profile contract', () {
    test('package metadata advances through the single current release contract', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(10).join('\n');

      expect(MathProPackageContract.phase, startsWith('V'));
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));

      for (final stale in MathProPackageContract.staleVersionMarkers) {
        expect(pubspec, isNot(contains(stale)), reason: stale);
      }
    });

    test('every public keyboard, MORE and long-press label has a visual profile family', () {
      expect(MathKeyInventory.publicUiLabels, isNotEmpty);
      expect(MathKeyVisualContract.unprofiledPublicLabels(MathKeyInventory.publicUiLabels), isEmpty);
      expect(MathKeyVisualContract.heavyCompactPublicLabels(MathKeyInventory.publicUiLabels), isEmpty);
    });

    test('high-risk math families use compact non-heavy keycap profiles', () {
      final expectations = <String, String>{
        'lim': 'limit',
        'lim x→∞': 'limit',
        '∫□dx': 'integral',
        '∫ₐᵇ': 'integral',
        'Σ': 'big-operator',
        'Π': 'big-operator',
        'Taylor': 'series',
        'Maclaurin': 'series',
        '□!': 'postfix',
        '□ᵀ': 'postfix',
        '□C□': 'binary-slot-operator',
        'f(□,□)': 'function',
        'f∘g': 'function',
        'log_□(□)': 'log',
        'sin⁻¹(□)': 'function',
      };

      for (final entry in expectations.entries) {
        final profile = MathKeyVisualContract.profileFor(entry.key);
        expect(profile.family, entry.value, reason: entry.key);
        expect(profile.weightClass, isNot('semibold'), reason: '${entry.key} must not render as a heavy/bold math key');
        expect(profile.compactFontSize, lessThanOrEqualTo(13.2), reason: '${entry.key} should stay compact on keycaps/chips');
      }
    });

    test('MathLabel consumes the central visual profile instead of local stale font buckets', () {
      final source = File('lib/features/workspace/math_label.dart').readAsStringSync();
      expect(source, contains("import '../../logic/math_key_visual_contract.dart';"));
      expect(source, contains('MathKeyVisualContract.profileFor(value)'));
      expect(source, isNot(contains("final bigOps =")));
      expect(source, isNot(contains("final boundedOps =")));
      expect(source, isNot(contains("final functions =")));
    });

    test('registry visual families still cover the important public structural contracts', () {
      for (final label in <String>['lim', '∫□dx', 'Σ', 'Taylor', '□!', '□C□', 'f∘g', 'sin⁻¹(□)']) {
        final contract = MathTemplateContractRegistry.contractFor(label);
        expect(contract, isNotNull, reason: label);
        expect(contract!.visualFamily, isNotEmpty, reason: label);
        expect(MathKeyVisualContract.profileFor(label).family, MathKeyVisualContract.visualFamilyFor(label));
      }
    });
  });
}
