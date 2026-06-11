/// V172-Q277R2 — Camera/OCR Runtime Premium Regression Analyzer Hygiene.
///
/// This phase is a tiny real-log repair after Q277R1: the user-side Flutter
/// test run passed, but `flutter analyze` still reported one informational
/// `unnecessary_const` item in the deferred model readiness result.
///
/// Scope is intentionally narrow: clean the analyzer hygiene item, keep the
/// Q277/Q277R1 Camera/OCR regression court intact, and do not add runtime,
/// model, inference, download, workspace import, solve, graph, solution, or
/// history behavior.
class GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy {
  const GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy._();

  static const String phase =
      'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE';
  static const String sourcePhase =
      'V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR';

  static const bool userFlutterTestPassed = true;
  static const int userFlutterTestPassingCount = 1120;
  static const int userFlutterAnalyzeRemainingInfoCount = 1;

  static const bool analyzerUnnecessaryConstCleaned = true;
  static const bool protectedRuntimeSurfacesUnchanged = true;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> repairedIssues = <String>[
    'gaussDeferredModelDownloadRuntimeUnnecessaryConstInfoCleaned',
  ];

  static const List<String> preservedRedLines = <String>[
    'keyboard-layout',
    'more-template-tray',
    'long-press-lists',
    'mathlive-production-route',
    'graph-solution-history-surfaces',
    'workspace-runtime',
    'camera-shell-runtime',
    'solver-evaluator',
    'splash-icon',
  ];

  static const List<String> requiredUserSideRetest = <String>[
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
