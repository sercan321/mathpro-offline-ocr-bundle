import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_key_ordering_regression_q382r33r3_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';

void main() {
  group('V172-Q382R33R3 key ordering regression repair', () {
    test('policy preserves scope while forcing ordered delivery into JS-side queue', () {
      expect(MathLiveKeyOrderingRegressionQ382R33R3Policy.phase, 'V172-Q382R33R3');
      expect(
        MathLiveKeyOrderingRegressionQ382R33R3Policy.contract,
        'q382r33r3-key-ordering-regression-repair-active',
      );
      expect(MathLiveKeyOrderingRegressionQ382R33R3Policy.serializeDartDispatchBeforeJsSideQueue, isTrue);
      expect(
        MathLiveKeyOrderingRegressionQ382R33R3Policy.mustSerializeJsSideQueueDispatch(commandUsesJsSideQueue: true),
        isTrue,
      );
      expect(
        MathLiveKeyOrderingRegressionQ382R33R3Policy.mustSerializeJsSideQueueDispatch(commandUsesJsSideQueue: false),
        isFalse,
      );
      expect(MathLiveKeyOrderingRegressionQ382R33R3Policy.preservesOptimisticEchoScope, isTrue);
      expect(MathLiveKeyOrderingRegressionQ382R33R3Policy.templateOptimisticEchoAllowed, isFalse);
      expect(MathLiveKeyOrderingRegressionQ382R33R3Policy.preservesQ384DownloadOnlyOcrContract, isTrue);
    });

    test('MathLive state adapter carries last command sequence for stale snapshot guard', () {
      final snapshot = MathLiveEditorStateSnapshot.fromJson(<String, dynamic>{
        'latex': '888887777',
        'normalizedLatex': '888887777',
        'lastCommandLabel': '7',
        'lastCommandAction': 'insertLatex',
        'lastCommandSequence': 9,
      });
      expect(snapshot.lastCommandSequence, 9);
      expect(snapshot.toJson()['lastCommandSequence'], 9);
    });

    test('production surface serializes enqueue delivery instead of fire-and-forget racing it', () {
      final mainSurface = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      final surface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      expect(mainSurface, contains("import 'mathlive_key_ordering_regression_q382r33r3_policy.dart';"));
      expect(surface, contains('final commandUsesJsSideQueue = MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction(command.action);'));
      expect(surface, contains('MathLiveKeyOrderingRegressionQ382R33R3Policy.mustSerializeJsSideQueueDispatch'));
      expect(surface, contains("'insertLatex' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetInsertDispatch && !mustSerializeJsSideQueueDispatch"));
      expect(surface, contains("'deleteBackward' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetDeleteDispatch && !mustSerializeJsSideQueueDispatch"));
      expect(surface, contains('window.MathProProductionMathLiveBridge.enqueueKeyboardCommand'));
    });

    test('AppShell discards older sequence snapshots without expanding optimistic echo', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, contains('_q382r33r3LastAppliedMathLiveCommandSequence'));
      expect(appShell, contains('_shouldDiscardQ382R33R3StaleMathLiveSnapshot'));
      expect(appShell, contains('sequence < _q382r33r3LastAppliedMathLiveCommandSequence'));
      expect(appShell, contains('snapshot.lastCommandSequence > _q382r33r3LastAppliedMathLiveCommandSequence'));
      final optimisticPolicy = File('lib/features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart').readAsStringSync();
      expect(optimisticPolicy, contains('templateOptimisticEchoAllowed = false'));
      expect(optimisticPolicy, contains('moreLongPressOptimisticEchoAllowed = false'));
    });
  });
}
