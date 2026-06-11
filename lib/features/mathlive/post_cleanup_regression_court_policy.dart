/// V172-Q97 — Post-Cleanup Regression Court.
///
/// The final court validates that package cleanup did not break the premium
/// baseline. It requires real Flutter and real-device evidence; static package
/// checks alone are not enough.
class PostCleanupRegressionCourtPolicy {
  const PostCleanupRegressionCourtPolicy._();

  static const String phase = 'V172-Q97';
  static const bool realFlutterRequired = true;
  static const bool realDeviceRequired = true;
  static const bool staticPackageMayClaimFinalPass = false;
  static const bool protectedUiSurfaceMutationAllowed = false;

  static PostCleanupRegressionCourtVerdict evaluate({
    required bool flutterPubGetPassed,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool mainAppRealDeviceRunPassed,
    required bool mathLiveLabRealDeviceRunPassed,
    required bool keyboardContractPreserved,
    required bool moreLongPressAnsEnterEqualsPreserved,
    required bool graphWorks,
    required bool historyWorks,
    required bool solutionInputWorks,
    required bool noLegacyCursorOverlayVisibleOnMathLivePath,
    required bool rollbackFlagWorks,
    required bool packageHygieneClean,
  }) {
    final issues = <String>[];
    if (!flutterPubGetPassed) issues.add('flutter pub get PASS log is missing');
    if (!flutterAnalyzePassed) issues.add('flutter analyze PASS log is missing');
    if (!flutterTestPassed) issues.add('flutter test PASS log is missing');
    if (!mainAppRealDeviceRunPassed) issues.add('main app real-device run PASS is missing');
    if (!mathLiveLabRealDeviceRunPassed) issues.add('MathLive Lab real-device run PASS is missing');
    if (!keyboardContractPreserved) issues.add('keyboard contract is not preserved');
    if (!moreLongPressAnsEnterEqualsPreserved) issues.add('MORE/long-press/Ans/↵/= behavior is not preserved');
    if (!graphWorks) issues.add('Graph runtime behavior not verified');
    if (!historyWorks) issues.add('History runtime behavior not verified');
    if (!solutionInputWorks) issues.add('Solution input runtime behavior not verified');
    if (!noLegacyCursorOverlayVisibleOnMathLivePath) issues.add('legacy cursor overlay is still visible on MathLive path');
    if (!rollbackFlagWorks) issues.add('rollback flag behavior not verified');
    if (!packageHygieneClean) issues.add('package hygiene is not clean');

    final passed = issues.isEmpty;
    return PostCleanupRegressionCourtVerdict(
      status: passed ? 'POST_CLEANUP_REGRESSION_COURT_PASS' : 'BLOCKED_POST_CLEANUP_REGRESSION_COURT',
      issues: issues,
      finalReleaseCandidate: passed,
      mayClaimPostCleanupPass: passed,
    );
  }
}

class PostCleanupRegressionCourtVerdict {
  const PostCleanupRegressionCourtVerdict({
    required this.status,
    required this.issues,
    required this.finalReleaseCandidate,
    required this.mayClaimPostCleanupPass,
  });

  final String status;
  final List<String> issues;
  final bool finalReleaseCandidate;
  final bool mayClaimPostCleanupPass;

  bool get isBlocked => !finalReleaseCandidate;
}
