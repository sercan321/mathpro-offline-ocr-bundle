import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  group('Premium Keyboard V22 contract lock', () {
    test('keeps all visible tab keyboards in the fixed 8x5 grid', () {
      for (final tab in KeyConfig.tabs) {
        final sections = KeyConfig.buildKeyboardSections(tab);
        expect(sections.isBasic, isFalse, reason: tab);

        final rows = sections.expandedGridRows!;
        expect(rows.length, 8, reason: tab);
        for (final row in rows) {
          expect(row.length, 5, reason: tab);
        }

        final labels = _labelsFor(tab);
        expect(labels, containsAll(<String>['C', '⌫', '%', '÷', 'MORE', '0', '.', '↵']), reason: tab);
        expect(labels, contains(tab == 'Temel' ? 'Ans' : '='), reason: tab);
      }
    });

    test('keeps symbolic/Turkish keyboard surface instead of raw English words', () {
      const forbiddenVisibleLabels = <String>{
        'system',
        'matrix',
        'vector',
        'inv',
        'trans',
        'norm',
        'dot',
        'cross',
        'scalar',
        'exp',
        'conj',
        'mod',
        'gcd',
        'lcm',
        'prime?',
      };

      final visibleLabels = <String>{
        for (final tab in KeyConfig.tabs) ..._labelsFor(tab),
      };

      for (final forbidden in forbiddenVisibleLabels) {
        expect(visibleLabels.contains(forbidden), isFalse, reason: forbidden);
      }

      expect(_labelsFor('Cebir'), contains('{□=□'));
      expect(_labelsFor('Lineer Cebir'), contains('[□ □]'));
      expect(_labelsFor('Lineer Cebir'), contains('[□]'));
      expect(_labelsFor('Lineer Cebir'), contains('□⁻¹'));
      expect(_labelsFor('Lineer Cebir'), contains('□ᵀ'));
      expect(_labelsFor('Lineer Cebir'), contains('‖□‖'));
    });

    test('keeps essential template keys mapped to structural behaviors', () {
      const structuralLabels = <String>{
        '□/□',
        '√□',
        '□^□',
        '|□|',
        '{□=□',
        'f(□)',
        '□!',
        'd/dx',
        '∫□dx',
        'lim',
        'Σ',
        'Re(□)',
        'Im(□)',
        'arg(□)',
        '[□ □]',
        '[□]',
        'det(□)',
        '□⁻¹',
        '□ᵀ',
        '□·□',
        '□×□',
        '‖□‖',
      };

      for (final label in structuralLabels) {
        final behavior = KeyConfig.getKeyBehavior(label);
        expect(
          behavior == KeyBehaviorType.structureInsert || behavior == KeyBehaviorType.wrapper || behavior == KeyBehaviorType.postfix,
          isTrue,
          reason: '$label should stay structural/template-like',
        );
      }
    });

    test('keeps MORE panel Turkish where Turkish wording is expected', () {
      final moreLabels = <String>{
        for (final category in ActionUtils.morePanelCategories) ...category.labels,
      };

      expect(moreLabels, containsAll(<String>['Kalan', 'EBOB', 'EKOK', 'Asal mı?', 'Yuvarla', 'İşaret', 'Özdeğer', 'Çöz']));
      expect(moreLabels.contains('mod'), isFalse);
      expect(moreLabels.contains('gcd'), isFalse);
      expect(moreLabels.contains('lcm'), isFalse);
      expect(moreLabels.contains('prime?'), isFalse);
    });

    test('keeps key families behind long press instead of duplicating variants on visible surfaces', () {
      for (final tab in KeyConfig.tabs) {
        final labels = _labelsFor(tab);
        expect(labels.contains('x²'), isFalse, reason: tab);
        expect(labels.contains('x³'), isFalse, reason: tab);
        expect(labels.contains('≤'), isFalse, reason: tab);
        expect(labels.contains('≥'), isFalse, reason: tab);
        expect(labels.contains('y′'), isFalse, reason: tab);
        expect(labels.contains('y″'), isFalse, reason: tab);
        expect(labels.contains('∫ₐᵇ'), isFalse, reason: tab);
        expect(labels.contains('∬'), isFalse, reason: tab);
        expect(labels.contains('□P□'), isFalse, reason: tab);
        expect(labels.contains('□C□'), isFalse, reason: tab);
        expect(labels.contains('Γ(□)'), isFalse, reason: tab);
      }

      expect(KeyConfig.getLongPressOptions('□^□', 'Cebir'), containsAll(<String>['□²', '□³', '□ⁿ', '□⁻¹']));
      expect(KeyConfig.getLongPressOptions('=', 'Cebir'), containsAll(<String>['<', '>', '≤', '≥']));
      expect(KeyConfig.getLongPressOptions('y', 'Kalkülüs'), containsAll(<String>['y′', 'y″', 'y‴']));
      expect(KeyConfig.getLongPressOptions('∫□dx', 'Kalkülüs'), containsAll(<String>['∫ₐᵇ', '∬', '∭', '∮']));
    });

    test('keeps visible and long-press labels free of avoidable raw English wording', () {
      final allVisibleLabels = <String>{for (final tab in KeyConfig.tabs) ..._labelsFor(tab)};
      expect(allVisibleLabels.contains('□P□'), isFalse);
      expect(allVisibleLabels.contains('□C□'), isFalse);
      expect(allVisibleLabels.contains('Γ(□)'), isFalse);

      final longPressLabels = <String>{
        for (final tab in KeyConfig.tabs)
          for (final visible in _labelsFor(tab)) ...KeyConfig.getLongPressOptions(visible, tab),
      };
      expect(longPressLabels.contains('pseudo-inverse'), isFalse);
      expect(longPressLabels.contains('triple product'), isFalse);
      expect(longPressLabels.contains('real(□)'), isFalse);
      expect(longPressLabels.contains('imag(□)'), isFalse);
      expect(longPressLabels, containsAll(<String>['Eşlenik', 'Moore-Penrose', 'karma çarpım']));
    });
  });
}

Set<String> _labelsFor(String tab) {
  final rows = KeyConfig.buildKeyboardSections(tab).expandedGridRows!;
  return <String>{
    for (final row in rows)
      for (final cell in row)
        if (!cell.isEmpty) cell.label!,
  };
}
