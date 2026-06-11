import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('V172-Q382R25 All Key Latency Court and Inventory', () {
    test('debug-only court files and audit artifacts are present', () {
      for (final path in <String>[
        'lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart',
        'lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart',
        'tool/verify_all_key_latency_court_v172_q382r25.mjs',
        'docs/audit/V172_Q382R25_ALL_KEY_LATENCY_COURT_AND_INVENTORY.md',
        'docs/audit/V172_Q382R25_CHANGED_FILES.md',
      ]) {
        expect(File(path).existsSync(), isTrue, reason: path);
      }
    });

    test('court is gated by dart-define and stays measurement-only', () {
      final policy = File('lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart').readAsStringSync();
      expect(policy, contains("static const String phase = 'V172-Q382R25'"));
      expect(policy, contains('q382r25-all-key-latency-court-and-inventory-active'));
      expect(policy, contains("'MATHPRO_LATENCY_COURT'"));
      expect(policy, contains('defaultValue: false'));
      expect(policy, contains('performanceOptimizationAllowed = false'));
      expect(policy, contains('keyboardBehaviorChangeAllowed = false'));
      expect(policy, contains('mathLiveCommandSemanticsChangeAllowed = false'));
      expect(policy, contains('graphSolutionHistoryOcrAndroidChangeAllowed = false'));
      expect(policy, contains('dispatchDestructiveOrUiCommands = false'));
    });

    test('inventory is sourced from real keyboard, long-press, and MORE definitions', () {
      final court = File('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart').readAsStringSync();
      expect(court, contains('KeyConfig.tabs'));
      expect(court, contains('KeyConfig.buildKeyboardSections(tab)'));
      expect(court, contains('KeyConfig.longPressMap.entries'));
      expect(court, contains('KeyConfig.getLongPressOptions(entry.key, tab)'));
      expect(court, contains('ActionUtils.morePanelCategories'));
      expect(court, contains("origin: 'mainKeyboard'"));
      expect(court, contains("origin: 'longPressOption'"));
      expect(court, contains("origin: 'moreTemplate'"));
      expect(court, contains("origin: 'moreCategory'"));
      expect(court, contains('[Q382R25_COURT] INVENTORY'));
      expect(court, contains('[Q382R25_COURT] DIRECT_BRIDGE_ENTRY'));
    });

    test('Q382R25 did not revive pan/drag or optimistic echo behavior', () {
      final combined = <String>[
        'lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart',
        'lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart',
        'lib/app/app_shell.dart',
        'assets/mathlive/mathlive_prod_bridge.js',
      ].map((path) => File(path).readAsStringSync()).join('\n');

      for (final forbidden in <String>[
        'direct-pan',
        'drag-pan',
        'host-scrollport-force',
        'document-capture',
        "document.addEventListener('touchmove'",
        'preventDefault()',
        'stopPropagation()',
        'optimisticExpressionEcho = true',
        'Q383',
      ]) {
        expect(combined, isNot(contains(forbidden)), reason: forbidden);
      }
    });
  });
}
