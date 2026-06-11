import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_normalization_hardening_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q102 MathLive State Normalization Hardening', () {
    test('Q102 records a package-side normalizer without activation or protected UI mutation', () {
      expect(MathLiveStateNormalizationHardeningPolicy.phase, 'V172-Q102');
      expect(MathLiveStateNormalizationHardeningPolicy.packageSideNormalizerImplemented, isTrue);
      expect(MathLiveStateNormalizationHardeningPolicy.q101LabSmokeEvidenceClosureRequiredForActivation, isTrue);
      expect(MathLiveStateNormalizationHardeningPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.mathLiveEnabledByDefault, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.cursorPassClaimAllowed, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.writesCanonicalSmokeEvidence, isFalse);
      expect(MathLiveStateNormalizationHardeningPolicy.installsRuntimeFiles, isFalse);
      expect(MathProPackageContract.q102MathLiveStateNormalizationHardeningRule, contains('MathLive State Normalization Hardening'));
    });

    test('normalizes deterministic MathLive LaTeX samples into MathPro candidate expressions', () {
      final samples = <String, String>{
        '3+5': '3+5',
        r'x^{2}': 'x^2',
        r'\sin\left(x\right)': 'sin(x)',
        r'\log_{2}\left(8\right)': 'log_2(8)',
        r'\frac{1}{2}+\frac{3}{4}': '(1)/(2)+(3)/(4)',
        r'\sqrt{x}': 'sqrt(x)',
        r'y=x^{2}': 'y=x^2',
        r'x^{2}+y^{2}=1': 'x^2+y^2=1',
      };

      for (final entry in samples.entries) {
        final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(entry.key);
        expect(normalized.phase, 'V172-Q102');
        expect(normalized.normalizedExpression, entry.value, reason: entry.key);
        expect(normalized.historyPayloadExpression, entry.value);
        expect(normalized.solutionCandidateExpression, entry.value);
        expect(normalized.evaluatorCandidateExpression, entry.value);
      }
    });

    test('classifies Graph / evaluator candidate intent without mutating Graph UI', () {
      final graphable = MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(r'\sqrt{x}');
      expect(graphable.graphIntent, 'graphableExplicit');
      expect(graphable.isGraphCandidate, isTrue);
      expect(graphable.containsVariableX, isTrue);
      expect(graphable.containsVariableY, isFalse);

      final numeric = MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(r'\log_{2}\left(8\right)');
      expect(numeric.graphIntent, 'constantSuggestion');
      expect(numeric.evaluatorIntent, 'numericCandidate');

      final implicit = MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro(r'x^{2}+y^{2}=1');
      expect(implicit.graphIntent, 'implicitPending');
      expect(implicit.evaluatorIntent, 'symbolicCandidate');
    });

    test('normalizes Q86 bridge snapshot while preserving lab safety flags and JSON payload shape', () {
      final snapshot = MathLiveStateAdapter.parseBridgeMessage(jsonEncode(<String, Object?>{
        'latex': r'\frac{1}{2}+\frac{3}{4}',
        'normalizedLatex': r'\frac{1}{2}+\frac{3}{4}',
        'plainText': '1/2 + 3/4',
        'mathJson': <String, Object?>{'fn': 'Add'},
        'evaluateRequested': true,
        'hasFocus': true,
        'virtualKeyboardEnabled': false,
        'remoteScriptLoadingAllowed': false,
        'mainEditorSwitchAllowed': false,
      }));

      final normalized = MathLiveStateNormalizationHardeningPolicy.normalizeSnapshot(snapshot);
      expect(normalized.normalizedExpression, '(1)/(2)+(3)/(4)');
      expect(normalized.plainText, '1/2 + 3/4');
      expect(normalized.evaluateRequested, isTrue);
      expect(normalized.hasFocus, isTrue);
      expect(normalized.mathJson, isNotNull);
      expect(normalized.isSafePackageSideCandidate, isTrue);
      expect(normalized.toJson()['phase'], 'V172-Q102');
    });

    test('Q92 adapter delegates to the Q102 normalizer for envelope preparation', () {
      expect(MathLiveLatexNormalizer.toMathProExpression(r'\sin\left(x\right)'), 'sin(x)');
      expect(MathLiveLatexNormalizer.toMathProExpression(r'\frac{1}{2}+\frac{3}{4}'), '(1)/(2)+(3)/(4)');
    });

    test('Q102 readiness can pass package side while still blocking activation until Q101 evidence closes', () {
      final verdict = MathLiveStateNormalizationHardeningPolicy.evaluateReadiness(
        normalizerPolicyPresent: true,
        deterministicSampleSuitePasses: true,
        q101LabSmokeEvidenceClosed: false,
        protectedSurfacesUnchanged: true,
        graphHistorySolutionUiUntouched: true,
        mainEditorStillLegacy: true,
        noRuntimeEvidenceFaked: true,
        noCanonicalSmokeEvidenceWritten: true,
      );

      expect(verdict.status, 'MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(verdict.packageSideNormalizationReady, isTrue);
      expect(verdict.mayProceedToQ103Binding, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayMountMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q102 may not activate runtime flow'));
    });

    test('Q102 metadata and verifier are wired without stale protected-surface permissions', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_state_normalization.mjs').readAsStringSync();
      expect(manifest, contains('"q102MathLiveStateNormalizationPhase": "V172-Q102"'));
      expect(manifest, contains('"q102MaySwitchMainEditor": false'));
      expect(manifest, contains('"q102MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q102 MathLive State Normalization Hardening'));
      expect(verifier, contains('MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(verifier, isNot(contains('maySwitchMainEditor: true')));
      expect(verifier, isNot(contains('mayDeleteLegacyCursor: true')));
    });
  });
}
