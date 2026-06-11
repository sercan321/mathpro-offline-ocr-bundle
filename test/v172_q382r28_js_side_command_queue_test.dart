import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart';

void main() {
  group('V172-Q382R28 JS-side command queue', () {
    test('policy keeps queue scoped to insert/delete and protects priority clear', () {
      expect(MathLiveJsSideCommandQueueQ382R28Policy.phase, 'V172-Q382R28');
      expect(MathLiveJsSideCommandQueueQ382R28Policy.enabled, isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction('insertLatex'), isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction('deleteBackward'), isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction('clear'), isFalse);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.optimisticEchoScopeExpanded, isFalse);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.mathLiveNativeCaretAuthorityPreserved, isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.keyboardLayoutOrderLabelsUntouched, isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.moreTemplateTrayUntouched, isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.longPressListsUntouched, isTrue);
      expect(MathLiveJsSideCommandQueueQ382R28Policy.panDragScrollReintroduced, isFalse);
    });

    test('Dart hot insert/delete path sends payload to bridge enqueueKeyboardCommand', () {
      final controller = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      final surface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      expect(controller, contains("import 'mathlive_js_side_command_queue_q382r28_policy.dart';"));
      expect(surface, contains('MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction(command.action)'));
      expect(surface, contains('window.MathProProductionMathLiveBridge.enqueueKeyboardCommand(\$payload)'));
      expect(surface, contains('q382r28-dart-to-js-side-queue-dispatch-\$label-\$sequence'));
      expect(surface, contains('_productionCommandTail'));
      expect(surface, contains("'clear' => 'window.MathProProductionMathLiveBridge.clear(\$payload)'"));
    });

    test('production JS bridge owns a sequence-safe bounded drain queue', () {
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      expect(bridge, contains("const JS_SIDE_COMMAND_QUEUE_PHASE = 'V172-Q382R28'"));
      expect(bridge, contains('const Q382R28_MAX_JS_SIDE_QUEUE = 96'));
      expect(bridge, contains('const Q382R28_MAX_DRAIN_PER_TICK = 8'));
      expect(bridge, contains('function enqueueKeyboardCommand(payload)'));
      expect(bridge, contains('function q382r28DrainKeyboardCommandQueue()'));
      expect(bridge, contains('q382r28-js-side-command-queued-sequence-safe'));
      expect(bridge, contains('q382r28-js-side-command-processing-sequence-safe'));
      expect(bridge, contains('q382r28-js-side-command-drain-complete'));
      expect(bridge, contains('enqueueKeyboardCommand,'));
      expect(bridge, contains("if (action === 'insertLatex') insertLatex(payload);"));
      expect(bridge, contains("else if (action === 'deleteBackward') deleteBackward(payload);"));
      expect(bridge, isNot(contains('document.addEventListener(\'touchmove\'')));
      expect(bridge, isNot(contains('direct-pan')));
      expect(bridge, isNot(contains('host-scrollport-force')));
    });
  });
}
