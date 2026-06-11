import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_history_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q104 History Adapter Real Binding', () {
    test('records package-side History adapter without controller/UI mutation or editor switch', () {
      expect(MathLiveHistoryAdapterPolicy.phase, 'V172-Q104');
      expect(MathLiveHistoryAdapterPolicy.packageSideHistoryAdapterImplemented, isTrue);
      expect(MathLiveHistoryAdapterPolicy.q102StateNormalizationRequired, isTrue);
      expect(MathLiveHistoryAdapterPolicy.q103GraphEligibilityAdapterRequired, isTrue);
      expect(MathLiveHistoryAdapterPolicy.q101LabSmokeEvidenceClosureRequiredForRuntimeActivation, isTrue);
      expect(MathLiveHistoryAdapterPolicy.historyControllerMutationAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.historyPanelMutationAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.historyUiMutationAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveHistoryAdapterPolicy.fakeHistoryWriteAllowed, isFalse);
      expect(MathProPackageContract.q104HistoryAdapterRule, contains('V172-Q104'));
    });

    test('builds deterministic History entry envelopes from MathLive snapshots', () {
      final snapshot = MathLiveEditorStateSnapshot.fromJson(<String, dynamic>{
        'latex': r'\frac{1}{2}+\frac{3}{4}',
        'plainText': '1/2+3/4',
        'evaluateRequested': true,
      });
      final envelope = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(
        snapshot,
        createdAtUtc: DateTime.utc(2026, 5, 24, 20, 0),
        entryIdSeed: 'unit-test',
      );

      expect(envelope.phase, 'V172-Q104');
      expect(envelope.id, 'mathlive-history-unit-test');
      expect(envelope.inputEngine, 'mathlive');
      expect(envelope.inputExpression, '(1)/(2)+(3)/(4)');
      expect(envelope.displayExpression, '(1)/(2)+(3)/(4)');
      expect(envelope.evaluateRequested, isTrue);
      expect(envelope.graphEligibilityKind, 'constantSuggestion');
      expect(envelope.graphNormalizedExpression, '1.25');
      expect(envelope.graphCandidateAvailable, isTrue);
      expect(envelope.solutionCandidateExpression, '(1)/(2)+(3)/(4)');
      expect(envelope.evaluatorDisplayValue, '1.25');
      expect(envelope.createdAtIso8601, '2026-05-24T20:00:00.000Z');
      expect(envelope.runtimeWriteAllowed, isFalse);
      expect(envelope.historyControllerMutationAllowed, isFalse);
      expect(envelope.historyPanelMutationAllowed, isFalse);
      expect(envelope.mainEditorSwitchAllowed, isFalse);
      expect(envelope.legacyCursorDeletionAllowed, isFalse);
    });

    test('preserves unsupported and implicit cases without fake History runtime writes', () {
      final logEnvelope = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(
        MathLiveEditorStateSnapshot.fromLatex(r'\log_{2}\left(8\right)'),
      );
      expect(logEnvelope.inputExpression, 'log_2(8)');
      expect(logEnvelope.graphEligibilityKind, 'notGraphable');
      expect(logEnvelope.evaluatorDisplayValue, isEmpty);
      expect(logEnvelope.runtimeWriteAllowed, isFalse);
      expect(logEnvelope.hasInputExpression, isTrue);

      final implicit = MathLiveHistoryAdapterPolicy.buildEntryEnvelope(
        MathLiveEditorStateSnapshot.fromLatex(r'x^{2}+y^{2}=1'),
      );
      expect(implicit.inputExpression, 'x^2+y^2=1');
      expect(implicit.graphEligibilityKind, 'implicitPending');
      expect(implicit.graphCandidateAvailable, isTrue);
      expect(implicit.runtimeWriteAllowed, isFalse);
    });

    test('Q92 envelope delegates History payload through Q104 adapter', () {
      final snapshot = MathLiveEditorStateSnapshot.fromLatex(r'\sqrt{x}');
      final envelope = MathLiveGraphHistorySolutionAdapterPolicy.buildEnvelope(snapshot);

      expect(envelope.historyInputExpression, 'sqrt(x)');
      expect(envelope.historyInputMethod, 'mathlive');
      expect(envelope.graphEligibilityKind, 'graphableExplicit');
      expect(envelope.diagnostic, contains('q104-history-adapters'));
    });

    test('readiness remains package-side until Q101 Lab smoke evidence closure is real', () {
      final readiness = MathLiveHistoryAdapterPolicy.evaluateReadiness(
        adapterPolicyPresent: true,
        deterministicHistorySamplesPass: true,
        q102StateNormalizationReady: true,
        q103GraphEligibilityReady: true,
        q101LabSmokeEvidenceClosed: false,
        protectedSurfacesUnchanged: true,
        historyControllerUntouched: true,
        historyPanelUntouched: true,
        graphHistorySolutionUiUntouched: true,
        mainEditorStillLegacy: true,
        noFakeHistoryWrite: true,
        noRuntimeEvidenceFaked: true,
      );

      expect(readiness.status, 'MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(readiness.packageSideHistoryReady, isTrue);
      expect(readiness.mayProceedToRuntimeHistoryBinding, isFalse);
      expect(readiness.mayWriteHistoryAtRuntime, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayMountMainEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayMutateHistoryController, isFalse);
      expect(readiness.mayMutateHistoryPanel, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q104 must remain package-side only'));
    });

    test('metadata and verifier contain Q104 guard markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_history_adapter.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q104_HISTORY_ADAPTER_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q104_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final historyController = File('lib/features/history/history_controller.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();

      expect(manifest, contains('"q104HistoryAdapterPhase": "V172-Q104"'));
      expect(manifest, contains('"q104MayMutateHistoryController": false'));
      expect(manifest, contains('"q104MayMutateHistoryPanel": false'));
      expect(manifest, contains('"q104MayWriteHistoryAtRuntime": false'));
      expect(readme, contains('V172-Q104 History Adapter Real Binding'));
      expect(verifier, contains('MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q104 adds MathLive normalized expression to History entry envelope binding'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(historyController, isNot(contains('V172-Q104')));
      expect(historyPanel, isNot(contains('V172-Q104')));
      expect(verifier, isNot(contains('maySwitchMainEditor: true')));
      expect(verifier, isNot(contains('mayDeleteLegacyCursor: true')));
    });
  });
}
