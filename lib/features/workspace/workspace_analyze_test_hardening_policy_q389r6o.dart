/// Q389R6O is a narrow user-log hotfix after Q389R6N: analyzer is already
/// clean on the user machine, while flutter test still reports one Graph
/// settings test hit-test issue and two stale OCR runtime false-positive
/// guards. This policy records only those test-harness/contract corrections.
class WorkspaceAnalyzeTestHardeningPolicyQ389R6O {
  const WorkspaceAnalyzeTestHardeningPolicyQ389R6O._();

  static const String phase = 'Q389R6O-FLUTTER-TEST-REMAINING-HOTFIX';
  static const bool userSideFlutterAnalyzeNoIssuesObserved = true;
  static const bool graphSettingsApplyTestTargetsElevatedButton = true;
  static const bool pubspecWideOnnxMarkerRemoved = true;
  static const bool q276Q277ForbiddenRuntimeFalsePositiveTargeted = true;
  static const bool keyboardLayoutTouched = false;
  static const bool mathLiveDispatchTouched = false;
  static const bool cursorDragRuntimeTouched = false;
  static const bool graphRuntimeTouched = false;
  static const bool ocrRuntimeTouched = false;
  static const bool androidNativeTouched = false;
  static const bool solverTouched = false;
  static const bool flutterTestPassClaimedByPackage = false;
}
