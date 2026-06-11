import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';

void main() {
  group('V172-Q382R27 Safe Optimistic Linear Echo', () {
    const trustedEndCaret = MathLiveCaretContextSnapshot(
      phase: 'V172-Q382R26',
      source: 'mathlive-public-position-lastOffset',
      confidence: 'trusted-linear-document-context',
      trusted: true,
      selectionCollapsed: true,
      caretAtDocumentEnd: true,
      insidePlaceholder: false,
      insideTemplate: false,
      caretOffset: 3,
      documentEndOffset: 3,
      selectionLength: 0,
      diagnostic: 'q382r26-caret-context-trusted-for-linear-append-gate',
    );

    test('policy enables only append-only trusted linear labels', () {
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.phase, 'V172-Q382R27');
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.optimisticEchoEnabled, isTrue);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.requiresCaretContextBridge, isTrue);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.requiresTrustedCaretContext, isTrue);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.templateOptimisticEchoAllowed, isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.moreLongPressOptimisticEchoAllowed, isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.deleteClearSolveGraphOptimisticEchoAllowed, isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.nativeMathLiveCaretAuthorityPreserved, isTrue);

      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
        label: '1',
        caretContext: trustedEndCaret,
        continuingOptimisticChain: false,
        workspaceSelectionActive: false,
      ), isTrue);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
        label: '□/□',
        caretContext: trustedEndCaret,
        continuingOptimisticChain: false,
        workspaceSelectionActive: false,
      ), isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
        label: 'MORE',
        caretContext: trustedEndCaret,
        continuingOptimisticChain: false,
        workspaceSelectionActive: false,
      ), isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
        label: '⌫',
        caretContext: trustedEndCaret,
        continuingOptimisticChain: false,
        workspaceSelectionActive: false,
      ), isFalse);
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
        label: 'x',
        caretContext: const MathLiveCaretContextSnapshot.unknown(),
        continuingOptimisticChain: false,
        workspaceSelectionActive: false,
      ), isFalse);
    });

    test('append map stays linear and deterministic', () {
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(expression: '12', label: '3'), '123');
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(expression: '12', label: '−'), '12-');
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(expression: 'x', label: '+'), 'x+');
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(expression: 'x+', label: 'y'), 'x+y');
      expect(MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(expression: 'x', label: 'sin'), 'x');
    });

    test('AppShell arms echo through caret context and suppresses external MathLive sync', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, contains('_tryApplyQ382R27OptimisticLinearEcho'));
      expect(appShell, contains('snapshot.mayAllowOptimisticLinearAppend'));
      expect(appShell, contains('suppressNextExternalExpressionSyncForOptimisticEcho'));
      expect(appShell, contains('MathLiveSafeOptimisticLinearEchoQ382R27Policy.optimisticSource'));

      final surface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      expect(surface, contains('_q382r27SuppressNextExternalExpressionSync'));
      expect(surface, contains('q382r27-optimistic-external-expression-sync-suppressed'));
      expect(surface, contains('_suppressNextExternalExpressionSyncForQ382R27OptimisticEcho'));
    });
  });
}
