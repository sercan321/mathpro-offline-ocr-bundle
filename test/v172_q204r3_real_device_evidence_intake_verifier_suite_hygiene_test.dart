import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_evidence_intake_verifier_suite_hygiene_policy.dart';

void main() {
  test('V172-Q204R3 verifier-suite hygiene does not revive retired runtime paths', () {
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.phase, 'V172-Q204R3');
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.activeVerifierSuiteDeclared, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.retiredVerifierSuiteDeclared, isTrue);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.obsoleteVerifiersMayProduceFakeFailures, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.productionRuntimeFilesMutated, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.returningResultApiRestored, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.retiredVisibleFallbackOverlayRestored, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.retiredDiagnosticOverlayRestored, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.retiredLegacyMainEditorStateRestored, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveRealDeviceEvidenceIntakeVerifierSuiteHygienePolicy.androidRealDevicePassClaimed, isFalse);
  });
}
