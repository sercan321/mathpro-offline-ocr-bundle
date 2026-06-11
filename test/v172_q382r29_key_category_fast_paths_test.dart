import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/keyboard_latency_closure_q382r24_policy.dart';

void main() {
  group('V172-Q382R29 key category fast paths', () {
    test('policy categorizes key families without expanding optimistic echo', () {
      expect(KeyboardCategoryFastPathsQ382R29Policy.phase, 'V172-Q382R29');
      expect(KeyboardCategoryFastPathsQ382R29Policy.optimisticEchoScopeExpanded, isFalse);
      expect(KeyboardCategoryFastPathsQ382R29Policy.keyboardLayoutOrderLabelsUntouched, isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.longPressListsUntouched, isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.moreTemplateTrayInventoryUntouched, isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.panDragScrollReintroduced, isFalse);

      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '1'),
        KeyCategoryFastPathQ382R29.linearSafe,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '×'),
        KeyCategoryFastPathQ382R29.operatorText,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '□/□'),
        KeyCategoryFastPathQ382R29.structureTemplate,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '|□|'),
        KeyCategoryFastPathQ382R29.wrapperTemplate,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '□!'),
        KeyCategoryFastPathQ382R29.longPressParent,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: 'sin'),
        KeyCategoryFastPathQ382R29.functionTemplate,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: 'sin⁻¹(□)', origin: 'longPressOption'),
        KeyCategoryFastPathQ382R29.longPressChild,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: 'Taylor', origin: 'moreTemplate'),
        KeyCategoryFastPathQ382R29.moreTemplate,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: 'C'),
        KeyCategoryFastPathQ382R29.clearPriority,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '⌫'),
        KeyCategoryFastPathQ382R29.deleteRepeat,
      );
      expect(
        KeyboardCategoryFastPathsQ382R29Policy.categoryFor(label: '↵'),
        KeyCategoryFastPathQ382R29.evaluateAction,
      );
    });

    test('tap-down dispatch is fast for safe text but closed for templates and commands', () {
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: '1', activeTab: 'Temel', hasLongPress: false),
        isTrue,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: '(' , activeTab: 'Temel', hasLongPress: false),
        isTrue,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: '□/□', activeTab: 'Temel', hasLongPress: false),
        isFalse,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: '|□|', activeTab: 'Temel', hasLongPress: false),
        isFalse,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: 'sin', activeTab: 'Temel', hasLongPress: true),
        isFalse,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: 'C', activeTab: 'Temel', hasLongPress: false),
        isFalse,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: '⌫', activeTab: 'Temel', hasLongPress: false),
        isFalse,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown(label: 'MORE', activeTab: 'Temel', hasLongPress: false),
        isFalse,
      );
    });

    test('downstream sync debounce is category-aware', () {
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('1'), isTrue);
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('□/□'), isTrue);
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('⌫'), isTrue);
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('C'), isFalse);
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('↵'), isFalse);
      expect(KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel('MORE'), isFalse);

      expect(
        KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounceForLabel('1'),
        KeyboardCategoryFastPathsQ382R29Policy.linearDownstreamSyncDebounce,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounceForLabel('□/□'),
        KeyboardCategoryFastPathsQ382R29Policy.templateDownstreamSyncDebounce,
      );
      expect(
        KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounceForLabel('⌫'),
        KeyboardCategoryFastPathsQ382R29Policy.deleteDownstreamSyncDebounce,
      );
    });

    test('source wires Q382R29 into premium key, AppShell and Q382R25 court categories', () {
      final q24 = File('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final court = File('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart').readAsStringSync();
      expect(q24, contains("import 'keyboard_category_fast_paths_q382r29_policy.dart';"));
      expect(q24, contains('KeyboardCategoryFastPathsQ382R29Policy.dispatchOnTapDown'));
      expect(q24, contains('KeyboardCategoryFastPathsQ382R29Policy.deferDownstreamSyncForLabel'));
      expect(q24, contains('KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel'));
      expect(appShell, contains('controllerSyncDebounceForLabel(snapshot.lastCommandLabel)'));
      expect(court, contains("import '../../features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart';"));
      expect(court, contains('KeyboardCategoryFastPathsQ382R29Policy.categoryFor'));
    });
  });
}
