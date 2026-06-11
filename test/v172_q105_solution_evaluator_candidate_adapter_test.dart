import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q105 Solution/Evaluator Candidate Adapter', () {
    test('records package-side Solution/Evaluator adapter without Solution UI mutation or editor switch', () {
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.phase, 'V172-Q105');
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.packageSideSolutionEvaluatorAdapterImplemented, isTrue);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.q102StateNormalizationRequired, isTrue);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.q103GraphEligibilityAdapterRequired, isTrue);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.q104HistoryAdapterRequired, isTrue);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.q101LabSmokeEvidenceClosureRequiredForRuntimeActivation, isTrue);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.solutionStepsPanelMutationAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.solutionUiMutationAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.fakeSolutionAllowed, isFalse);
      expect(MathLiveSolutionEvaluatorCandidateAdapterPolicy.runtimeSolutionWriteAllowed, isFalse);
      expect(MathProPackageContract.q105SolutionEvaluatorCandidateAdapterRule, contains('V172-Q105'));
    });

    test('builds deterministic numeric Solution/Evaluator candidate envelopes from MathLive snapshots', () {
      final snapshot = MathLiveEditorStateSnapshot.fromJson(<String, dynamic>{
        'latex': r'\frac{1}{2}+\frac{3}{4}',
        'plainText': '1/2+3/4',
        'evaluateRequested': true,
      });
      final envelope = MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope(
        snapshot,
        createdAtUtc: DateTime.utc(2026, 5, 25, 20, 0),
        candidateIdSeed: 'unit-test',
      );

      expect(envelope.phase, 'V172-Q105');
      expect(envelope.id, 'mathlive-solution-unit-test');
      expect(envelope.inputEngine, 'mathlive');
      expect(envelope.solutionCandidateExpression, '(1)/(2)+(3)/(4)');
      expect(envelope.evaluatorCandidateExpression, '(1)/(2)+(3)/(4)');
      expect(envelope.evaluateRequested, isTrue);
      expect(envelope.semanticKind, 'numeric');
      expect(envelope.evaluatorDisplayValue, '1.25');
      expect(envelope.hasEvaluatorResult, isTrue);
      expect(envelope.hasNumericResult, isTrue);
      expect(envelope.requiresAdvancedSolver, isFalse);
      expect(envelope.graphEligibilityKind, 'constantSuggestion');
      expect(envelope.historyEntryId, 'mathlive-history-q105-history-unit-test');
      expect(envelope.createdAtIso8601, '2026-05-25T20:00:00.000Z');
      expect(envelope.fakeSolutionGenerated, isFalse);
      expect(envelope.runtimeSolutionWriteAllowed, isFalse);
      expect(envelope.solutionStepsPanelMutationAllowed, isFalse);
      expect(envelope.mainEditorSwitchAllowed, isFalse);
      expect(envelope.legacyCursorDeletionAllowed, isFalse);
    });

    test('preserves unsupported and implicit cases without fake solution output', () {
      final logEnvelope = MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope(
        MathLiveEditorStateSnapshot.fromLatex(r'\log_{2}\left(8\right)'),
      );
      expect(logEnvelope.solutionCandidateExpression, 'log_2(8)');
      expect(logEnvelope.evaluatorDisplayValue, isEmpty);
      expect(logEnvelope.hasEvaluatorResult, isFalse);
      expect(logEnvelope.requiresAdvancedSolver, isTrue);
      expect(logEnvelope.fakeSolutionGenerated, isFalse);
      expect(logEnvelope.runtimeSolutionWriteAllowed, isFalse);
      expect(logEnvelope.hasHonestUnsupportedReason, isTrue);

      final implicit = MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope(
        MathLiveEditorStateSnapshot.fromLatex(r'x^{2}+y^{2}=1'),
      );
      expect(implicit.solutionCandidateExpression, 'x^2+y^2=1');
      expect(implicit.semanticKind, 'implicitEquation');
      expect(implicit.graphEligibilityKind, 'implicitPending');
      expect(implicit.hasEvaluatorResult, isFalse);
      expect(implicit.requiresAdvancedSolver, isTrue);
      expect(implicit.fakeSolutionGenerated, isFalse);
    });

    test('Q92 envelope delegates Solution payload through Q105 adapter', () {
      final snapshot = MathLiveEditorStateSnapshot.fromLatex(r'3+5');
      final envelope = MathLiveGraphHistorySolutionAdapterPolicy.buildEnvelope(snapshot);

      expect(envelope.solutionInputExpression, '3+5');
      expect(envelope.evaluatorDisplayValue, '8');
      expect(envelope.semanticType, 'numeric');
      expect(envelope.diagnostic, contains('q105-solution-adapters'));
    });

    test('readiness remains package-side until Q101 Lab smoke evidence closure is real', () {
      final readiness = MathLiveSolutionEvaluatorCandidateAdapterPolicy.evaluateReadiness(
        adapterPolicyPresent: true,
        deterministicSolutionSamplesPass: true,
        q102StateNormalizationReady: true,
        q103GraphEligibilityReady: true,
        q104HistoryAdapterReady: true,
        q101LabSmokeEvidenceClosed: false,
        protectedSurfacesUnchanged: true,
        solutionStepsPanelUntouched: true,
        graphHistorySolutionUiUntouched: true,
        mainEditorStillLegacy: true,
        noFakeSolutionGenerated: true,
        noRuntimeEvidenceFaked: true,
      );

      expect(readiness.status, 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(readiness.packageSideSolutionEvaluatorReady, isTrue);
      expect(readiness.mayProceedToRuntimeSolutionBinding, isFalse);
      expect(readiness.mayWriteSolutionAtRuntime, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayMountMainEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayMutateSolutionStepsPanel, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q105 must remain package-side only'));
    });

    test('metadata and verifier contain Q105 guard markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q105_SOLUTION_EVALUATOR_CANDIDATE_ADAPTER_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q105_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q105SolutionEvaluatorCandidateAdapterPhase": "V172-Q105"'));
      expect(manifest, contains('"q105MayMutateSolutionStepsPanel": false'));
      expect(manifest, contains('"q105MayWriteSolutionAtRuntime": false'));
      expect(manifest, contains('"q105MayGenerateFakeSolution": false'));
      expect(readme, contains('V172-Q105 Solution/Evaluator Candidate Adapter'));
      expect(verifier, contains('MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q105 adds MathLive normalized expression to Solution/Evaluator candidate envelope binding'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(solutionPanel, isNot(contains('V172-Q105')));
      expect(verifier, isNot(contains('maySwitchMainEditor: true')));
      expect(verifier, isNot(contains('mayDeleteLegacyCursor: true')));
    });
  });
}
