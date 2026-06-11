import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart';

void main() {
  group('V172-Q382R32 all-key latency closure and template fast paths', () {
    test('policy covers template, MORE, long-press, delete, and clear safely', () {
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.phase, 'V172-Q382R32');
      expect(
        AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.marker,
        'q382r32-all-key-latency-closure-template-fast-paths-active',
      );
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversMainKeyboard, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversMoreTemplates, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversLongPressChildren, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversStructureTemplates, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversFunctionTemplates, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.coversDeleteCadence, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.preservesClearPriorityPath, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.optimisticEchoScopeExpanded, isFalse);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.templateOptimisticEchoAllowed, isFalse);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.moreLongPressOptimisticEchoAllowed, isFalse);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.keyboardLayoutOrderLabelsUntouched, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.longPressListsUntouched, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.moreTemplateTrayInventoryUntouched, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.mathLiveNativeCaretAuthorityPreserved, isTrue);
      expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.panDragScrollReintroduced, isFalse);
    });

    test('protected template labels remain out of optimistic echo and tap-down dispatch', () {
      for (final label in <String>['□/□', '√□', '|□|', 'sin', 'cos', 'tan', 'lim', 'Σ', '∫□dx', 'Taylor']) {
        expect(AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.isProtectedTemplateLabel(label), isTrue);
        expect(KeyboardCategoryFastPathsQ382R29Policy.mayUseOptimisticEcho(label), isFalse);
        expect(
          KeyboardCategoryFastPathsQ382R29Policy.dispatchOnTapDown(
            label: label,
            activeTab: 'Temel',
            hasLongPress: false,
          ),
          isFalse,
        );
      }
      expect(KeyboardCategoryFastPathsQ382R29Policy.mayUseOptimisticEcho('1'), isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.mayUseOptimisticEcho('x'), isTrue);
    });

    test('category debounce is tightened for non-linear families without making clear queued', () {
      expect(KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel('□/□').inMilliseconds, 88);
      expect(KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel('sin').inMilliseconds, 88);
      expect(KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel('⌫').inMilliseconds, 48);
      expect(KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel('C').inMilliseconds, 0);
      expect(KeyboardCategoryFastPathsQ382R29Policy.usesJsSideQueue(label: '□/□', action: 'insertLatex'), isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.usesJsSideQueue(label: '⌫', action: 'deleteBackward'), isTrue);
      expect(KeyboardCategoryFastPathsQ382R29Policy.usesJsSideQueue(label: 'C', action: 'clear'), isFalse);
    });

    test('JS bridge owns cached template payload conversion but keeps Q382R28 queue intact', () {
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      expect(bridge, contains("const ALL_KEY_LATENCY_CLOSURE_PHASE = 'V172-Q382R32'"));
      expect(bridge, contains('const q382r32TemplatePayloadCache = new Map()'));
      expect(bridge, contains('function q382r32CachedDocumentLatex(input)'));
      expect(bridge, contains('q382r32-template-payload-cache-hit'));
      expect(bridge, contains('q382r32-template-payload-cache-miss-store'));
      expect(bridge, contains('const latex = q382r32CachedDocumentLatex(sourceLatex);'));
      expect(bridge, contains('function enqueueKeyboardCommand(payload)'));
      expect(bridge, contains('q382r28-js-side-command-processing-sequence-safe'));
      expect(bridge, isNot(contains('document.addEventListener(\'touchmove\'')));
      expect(bridge, isNot(contains('direct-pan')));
      expect(bridge, isNot(contains('host-scrollport-force')));
    });

    test('latency court reports Q382R32 closure coverage without requiring manual phone sweep', () {
      final court = File('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart').readAsStringSync();
      final policy = File('lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart').readAsStringSync();
      expect(court, contains('q382r32TemplateFastPathCandidate'));
      expect(court, contains('q382r32OptimisticEchoProtected'));
      expect(court, contains('[Q382R32_CLOSURE] ALL_KEY_TEMPLATE_MORE_LONGPRESS'));
      expect(policy, contains('q382r32AllKeyLatencyClosureSummaryEnabled = true'));
      expect(policy, contains('q382r32TemplateMoreLongPressCoverageExpected = true'));
    });
  });
}
