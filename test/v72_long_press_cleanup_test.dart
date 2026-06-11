import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';

void main() {
  group('MathPro V72 long-press and MORE cleanup contract', () {
    test('removes unnecessary fraction and absolute-value long-press popups', () {
      for (final tab in KeyConfig.tabs) {
        expect(KeyConfig.getLongPressOptions('□/□', tab), isEmpty, reason: 'fraction long-press must be disabled in $tab');
        expect(KeyConfig.hasLongPressOptions('□/□', tab), isFalse, reason: 'fraction indicator must be off in $tab');

        expect(KeyConfig.getLongPressOptions('|□|', tab), isEmpty, reason: 'absolute-value long-press must be disabled in $tab');
        expect(KeyConfig.hasLongPressOptions('|□|', tab), isFalse, reason: 'absolute-value indicator must be off in $tab');
      }
    });

    test('keeps factorial long-press limited to requested combinatorics templates', () {
      for (final tab in KeyConfig.tabs) {
        final options = KeyConfig.getLongPressOptions('□!', tab);
        expect(options, equals(<String>['□C□', '□P□']), reason: tab);
        expect(options, isNot(contains('Γ(□)')), reason: tab);
        expect(options, isNot(contains('Kalan')), reason: tab);
        expect(options, isNot(contains('□!')), reason: tab);
      }
    });

    test('removes duplicate plain-log option while preserving base log variants', () {
      for (final tab in KeyConfig.tabs) {
        final options = KeyConfig.getLongPressOptions('log', tab);
        expect(options, equals(<String>['log₁₀(□)', 'log₂(□)', 'log_□(□)']), reason: tab);
        expect(options, isNot(contains('log(□)')), reason: tab);
      }
    });

    test('keeps keyboard topology frozen while allowing explicit long-press cleanup', () {
      expect(KeyConfig.basicCoreKeyboard, equals(<List<String?>>[
        <String?>['C', '⌫', '%', '÷'],
        <String?>['7', '8', '9', '×'],
        <String?>['4', '5', '6', '−'],
        <String?>['1', '2', '3', '+'],
        <String?>['MORE', '0', '.', 'Ans'],
      ]));

      expect(KeyConfig.tabs, equals(<String>['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']));
      expect(KeyConfig.getKeyBehavior('↵'), KeyBehaviorType.command);
      expect(KeyConfig.getKeyBehavior('='), KeyBehaviorType.textInsert);
      expect(KeyConfig.getKeyBehavior('Ans'), KeyBehaviorType.command);
    });
  });
}
