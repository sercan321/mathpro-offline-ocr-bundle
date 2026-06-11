import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart';

void main() {
  group('V172-Q382R33 full keyboard warmup and fast path closure', () {
    test('policy builds a full dispatchable keyboard/MORE/long-press warmup inventory', () {
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.phase, 'V172-Q382R33');
      expect(
        MathLiveFullKeyboardWarmupQ382R33Policy.marker,
        'q382r33-full-keyboard-warmup-fast-path-closure-active',
      );
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.webViewOnPageFinishedWarmupEnabled, isTrue);
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.warmupDoesNotInsertIntoVisibleMathField, isTrue);
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.optimisticEchoScopeExpanded, isFalse);
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.keyboardLayoutOrderLabelsUntouched, isTrue);
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.longPressListsUntouched, isTrue);
      expect(MathLiveFullKeyboardWarmupQ382R33Policy.moreInventoryUntouched, isTrue);

      final inventory = MathLiveFullKeyboardWarmupQ382R33Policy.fullKeyInventory();
      final labels = inventory.map((entry) => entry['label']).toSet();
      for (final label in <String>['0', '9', '.', '+', 'x', 'y', 'sin', 'cos', 'tan', '□/□', '√□', '∫□dx', 'Σ', 'Taylor', '2×2', 'det(□)']) {
        expect(labels, contains(label));
      }
      expect(inventory.length, lessThanOrEqualTo(MathLiveFullKeyboardWarmupQ382R33Policy.maxWarmupEntries));
      expect(inventory.where((entry) => entry['action'] == 'insertLatex'), isNotEmpty);
    });

    test('JS bridge warms template payload cache without visible editor mutation', () {
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      expect(bridge, contains("const FULL_KEYBOARD_WARMUP_PHASE = 'V172-Q382R33'"));
      expect(bridge, contains('function q382r33WarmupAllKeys(input)'));
      expect(bridge, contains('mathproWarmupAllKeys: q382r33WarmupAllKeys'));
      expect(bridge, contains('q382r33-full-keyboard-warmup-complete'));
      expect(bridge, contains('q382r32CachedDocumentLatex(latex);'));
      expect(bridge, contains('never calls'));
    });

    test('Dart production surface runs warmup once after WebView page finish', () {
      final surface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      final mainSurface = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      expect(mainSurface, contains("import 'mathlive_full_keyboard_warmup_q382r33_policy.dart';"));
      expect(surface, contains('await _warmupProductionMathLiveQ382R33();'));
      expect(surface, contains('MathLiveFullKeyboardWarmupQ382R33Policy.fullKeyInventory'));
      expect(surface, contains('window.MathProProductionMathLiveBridge.mathproWarmupAllKeys'));
      expect(surface, isNot(contains("final scheme = Uri.tryParse(request.url)?.scheme.toLowerCase() ?? '';\n            final scheme")));
    });

    test('MORE and long-press first-open cache hooks exist without inventory mutation', () {
      final tray = File('lib/features/workspace/template_tray.dart').readAsStringSync();
      final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
      final dock = File('lib/features/keyboard/bottom_dock.dart').readAsStringSync();
      expect(tray, contains('_q382r33MoreChipWarmupCache'));
      expect(tray, contains('AutomaticKeepAliveClientMixin<TemplateTray>'));
      expect(popup, contains('warmupLongPressPopupLayoutCacheQ382R33'));
      expect(popup, contains('_q382r33LongPressPanelWidthCache'));
      expect(dock, contains('MathLiveFullKeyboardWarmupQ382R33Policy.longPressOptionGroups()'));
      expect(File('lib/features/keyboard/key_config.dart').readAsStringSync(), isNot(contains('V172-Q382R33')));
      expect(File('lib/logic/action_utils.dart').readAsStringSync(), isNot(contains('V172-Q382R33')));
    });
  });
}
