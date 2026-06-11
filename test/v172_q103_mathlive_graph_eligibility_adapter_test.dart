import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q103 Graph Eligibility Adapter Real Binding', () {
    test('records package-side GraphEligibility adapter without UI mutation or editor switch', () {
      expect(MathLiveGraphEligibilityAdapterPolicy.phase, 'V172-Q103');
      expect(MathLiveGraphEligibilityAdapterPolicy.packageSideGraphEligibilityAdapterImplemented, isTrue);
      expect(MathLiveGraphEligibilityAdapterPolicy.q102StateNormalizationRequired, isTrue);
      expect(MathLiveGraphEligibilityAdapterPolicy.q101LabSmokeEvidenceClosureRequiredForRuntimeActivation, isTrue);
      expect(MathLiveGraphEligibilityAdapterPolicy.graphCardMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.graphUiMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.historyUiMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.solutionUiMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveGraphEligibilityAdapterPolicy.fakeConstantGraphAllowed, isFalse);
      expect(MathProPackageContract.q103GraphEligibilityAdapterRule, contains('V172-Q103'));
    });

    test('classifies normalized MathLive expressions using the existing graph eligibility contract', () {
      final samples = <String, String>{
        r'x^{2}': 'graphableExplicit',
        r'\sin\left(x\right)': 'graphableExplicit',
        r'\sqrt{x}': 'graphableExplicit',
        r'y=x^{2}': 'graphableExplicit',
        r'x^{2}+y^{2}=1': 'implicitPending',
        '3+5': 'constantSuggestion',
        r'\frac{1}{2}+\frac{3}{4}': 'constantSuggestion',
      };

      for (final entry in samples.entries) {
        final envelope = MathLiveGraphEligibilityAdapterPolicy.classifyLatex(entry.key);
        expect(envelope.phase, 'V172-Q103');
        expect(envelope.eligibilityKind, entry.value, reason: entry.key);
        expect(envelope.graphCardMutationAllowed, isFalse);
        expect(envelope.mainEditorSwitchAllowed, isFalse);
        expect(envelope.legacyCursorDeletionAllowed, isFalse);
      }
    });

    test('does not fake constant graph suggestions when evaluator bridge cannot compute a result', () {
      final envelope = MathLiveGraphEligibilityAdapterPolicy.classifyLatex(r'\log_{2}\left(8\right)');

      expect(envelope.normalizedExpression, 'log_2(8)');
      expect(envelope.q102GraphIntent, 'constantSuggestion');
      expect(envelope.eligibilityKind, 'notGraphable');
      expect(envelope.asksForConstantSuggestion, isFalse);
      expect(envelope.fakeConstantSuggestionBlocked, isTrue);
      expect(envelope.hasDirectGraphExpression, isFalse);
    });

    test('builds direct graph expressions only for supported explicit or constant cases', () {
      final explicit = MathLiveGraphEligibilityAdapterPolicy.classifyLatex(r'y=x^{2}');
      expect(explicit.canOpenGraphDirectly, isTrue);
      expect(explicit.graphNormalizedExpression, 'x^2');
      expect(explicit.graphExpression, isNotNull);
      expect(explicit.graphExpression!.displayExpression, 'y = x^2');

      final constant = MathLiveGraphEligibilityAdapterPolicy.classifyLatex('3+5');
      expect(constant.asksForConstantSuggestion, isTrue);
      expect(constant.evaluatorDisplayValue, '8');
      expect(constant.graphNormalizedExpression, '8');
      expect(constant.graphExpression, isNotNull);
      expect(constant.graphExpression!.displayExpression, 'y = 8');

      final implicit = MathLiveGraphEligibilityAdapterPolicy.classifyLatex(r'x^{2}+y^{2}=1');
      expect(implicit.implicitPending, isTrue);
      expect(implicit.hasDirectGraphExpression, isFalse);
    });

    test('Q92 envelope delegates graph classification through Q103 adapter', () {
      final snapshot = MathLiveEditorStateSnapshot.fromLatex(r'\sqrt{x}');
      final envelope = MathLiveGraphHistorySolutionAdapterPolicy.buildEnvelope(snapshot);

      expect(envelope.normalizedExpression, 'sqrt(x)');
      expect(envelope.graphEligibilityKind, 'graphableExplicit');
      expect(envelope.graphNormalizedExpression, 'sqrt(x)');
      expect(envelope.diagnostic, contains('q103-graph-eligibility-adapter'));
    });

    test('readiness remains package-side until Q101 Lab smoke evidence closure is real', () {
      final readiness = MathLiveGraphEligibilityAdapterPolicy.evaluateReadiness(
        adapterPolicyPresent: true,
        deterministicGraphEligibilitySamplesPass: true,
        q102StateNormalizationReady: true,
        q101LabSmokeEvidenceClosed: false,
        protectedSurfacesUnchanged: true,
        graphCardUntouched: true,
        graphHistorySolutionUiUntouched: true,
        mainEditorStillLegacy: true,
        noFakeConstantGraph: true,
        noRuntimeEvidenceFaked: true,
      );

      expect(readiness.status, 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(readiness.packageSideGraphEligibilityReady, isTrue);
      expect(readiness.mayProceedToRuntimeGraphBinding, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayMountMainEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayMutateGraphCard, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q103 must remain package-side only'));
    });

    test('metadata and verifier contain Q103 guard markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_graph_eligibility_adapter.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q103_GRAPH_ELIGIBILITY_ADAPTER_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q103_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(manifest, contains('"q103GraphEligibilityAdapterPhase": "V172-Q103"'));
      expect(manifest, contains('"q103MayMutateGraphCard": false'));
      expect(manifest, contains('"q103MaySwitchMainEditor": false'));
      expect(manifest, contains('"q103MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q103 Graph Eligibility Adapter Real Binding'));
      expect(verifier, contains('MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q103 adds MathLive normalized expression to GraphEligibility adapter binding'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(verifier, isNot(contains('maySwitchMainEditor: true')));
      expect(verifier, isNot(contains('mayDeleteLegacyCursor: true')));
    });
  });
}
