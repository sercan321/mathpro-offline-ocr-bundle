import 'gauss_android_toolchain_modernization_policy.dart';

enum GaussAndroidToolchainModernizationDecision {
  blockedMissingQ252Foundation,
  blockedAgpTargetMismatch,
  blockedGradleOrJavaTargetMismatch,
  blockedCameraOcrRegression,
  blockedProtectedSurfaceRegression,
  blockedForbiddenRuntimeBinding,
  androidToolchainModernizationStaticReady,
}

class GaussAndroidToolchainModernizationInput {
  const GaussAndroidToolchainModernizationInput({
    required this.q252PremiumFinalRegressionVerified,
    required this.settingsGradleUsesTargetAgp,
    required this.kotlinPluginPreservedAt21,
    required this.gradleWrapperAt87,
    required this.javaCompileOptionsAt17,
    required this.kotlinJvmTargetAt17,
    required this.cameraDependencyLinePreserved,
    required this.cameraOcrRuntimeUnchanged,
    required this.protectedSurfaceHashesUnchanged,
    required this.noPaddleRuntimeDependency,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrl,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectCameraSolveGraphSolutionHistory,
    required this.evidenceLabel,
  });

  final bool q252PremiumFinalRegressionVerified;
  final bool settingsGradleUsesTargetAgp;
  final bool kotlinPluginPreservedAt21;
  final bool gradleWrapperAt87;
  final bool javaCompileOptionsAt17;
  final bool kotlinJvmTargetAt17;
  final bool cameraDependencyLinePreserved;
  final bool cameraOcrRuntimeUnchanged;
  final bool protectedSurfaceHashesUnchanged;
  final bool noPaddleRuntimeDependency;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrl;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectCameraSolveGraphSolutionHistory;
  final String evidenceLabel;

  bool get hasEvidenceLabel => evidenceLabel.trim().isNotEmpty;
}

class GaussAndroidToolchainModernizationResult {
  const GaussAndroidToolchainModernizationResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.previousAgpVersion,
    required this.targetAgpVersion,
    required this.kotlinGradlePluginVersion,
    required this.gradleWrapperVersion,
    required this.javaTargetCompatibility,
    required this.realOcrRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
  });

  final String phase;
  final String sourcePhase;
  final GaussAndroidToolchainModernizationDecision decision;
  final GaussAndroidToolchainModernizationInput input;
  final List<String> issues;
  final String previousAgpVersion;
  final String targetAgpVersion;
  final String kotlinGradlePluginVersion;
  final String gradleWrapperVersion;
  final String javaTargetCompatibility;
  final bool realOcrRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get androidToolchainModernizationStaticReady =>
      decision == GaussAndroidToolchainModernizationDecision.androidToolchainModernizationStaticReady &&
      !hasBlockingIssues &&
      targetAgpVersion == GaussAndroidToolchainModernizationPolicy.targetAgpVersion &&
      kotlinGradlePluginVersion == GaussAndroidToolchainModernizationPolicy.kotlinGradlePluginVersion &&
      gradleWrapperVersion == GaussAndroidToolchainModernizationPolicy.gradleWrapperVersion &&
      javaTargetCompatibility == GaussAndroidToolchainModernizationPolicy.javaTargetCompatibility &&
      realOcrRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false;

  bool get canClaimFlutterPassWithoutLogs => false;
  bool get canClaimAndroidRunPassWithoutDeviceLog => false;
  bool get canClaimOcrPass => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
  bool get canSolveCameraOutputBeforeReviewApproval => false;
}

/// Q253 Android Toolchain Modernization.
///
/// This phase addresses the Android build-toolchain warning surface after Q252.
/// It moves AGP from 8.3.2 to 8.6.1 because Android's Kotlin 2.1 D8/R8 table
/// requires AGP 8.6+, while preserving Kotlin 2.1.0, Gradle wrapper 8.7,
/// Java/Kotlin 17 targets, and the entire camera/OCR review-only chain.
class GaussAndroidToolchainModernization {
  const GaussAndroidToolchainModernization._();

  static const phase = GaussAndroidToolchainModernizationPolicy.phase;
  static const sourcePhase = GaussAndroidToolchainModernizationPolicy.sourcePhase;
  static const previousAgpVersion = GaussAndroidToolchainModernizationPolicy.previousAgpVersion;
  static const targetAgpVersion = GaussAndroidToolchainModernizationPolicy.targetAgpVersion;
  static const kotlinGradlePluginVersion = GaussAndroidToolchainModernizationPolicy.kotlinGradlePluginVersion;
  static const gradleWrapperVersion = GaussAndroidToolchainModernizationPolicy.gradleWrapperVersion;
  static const javaTargetCompatibility = GaussAndroidToolchainModernizationPolicy.javaTargetCompatibility;

  static const requiresQ252PremiumFinalRegression = true;
  static const upgradesAgpTo861 = true;
  static const preservesKotlinPlugin210 = true;
  static const requiresGradleWrapper87 = true;
  static const requiresJava17CompileOptions = true;
  static const requiresKotlinJvmTarget17 = true;
  static const preservesCameraDependencies = true;
  static const preservesMathLiveReviewOnlyOcr = true;
  static const realInferenceEnabledInQ253 = false;
  static const callsProductionMathLiveBridge = false;

  static const forbiddenModernizationActions = <String>[
    'changeKeyboardLayout',
    'changeMoreInventory',
    'changeLongPressInventory',
    'replaceMathLiveProductionRoute',
    'modifyCameraCaptureShellRuntime',
    'addPaddleRuntime',
    'addPaddleOcrDependency',
    'bundlePpFormulaNetSModelInBaseApk',
    'setProductionModelUrl',
    'runPpFormulaNetSInference',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeSolutionFromCamera',
    'writeHistoryFromCamera',
  ];

  static GaussAndroidToolchainModernizationResult evaluate(
    GaussAndroidToolchainModernizationInput input,
  ) {
    final issues = <String>[];

    if (!input.q252PremiumFinalRegressionVerified) {
      issues.add('Q253 requires the Q252 camera/OCR premium final regression closure as its source baseline.');
    }
    if (!input.settingsGradleUsesTargetAgp) {
      issues.add('android/settings.gradle must use Android Gradle Plugin 8.6.1 for Q253.');
    }
    if (!input.kotlinPluginPreservedAt21) {
      issues.add('Kotlin Gradle Plugin must remain 2.1.0; Q253 is not a Kotlin-version experiment.');
    }
    if (!input.gradleWrapperAt87) {
      issues.add('Gradle wrapper must remain 8.7, the required Gradle line for AGP 8.6.');
    }
    if (!input.javaCompileOptionsAt17 || !input.kotlinJvmTargetAt17) {
      issues.add('Java compile options and Kotlin jvmTarget must remain 17 for Q253.');
    }
    if (!input.cameraDependencyLinePreserved || !input.cameraOcrRuntimeUnchanged) {
      issues.add('Camera/OCR dependency and runtime behavior must remain unchanged during Q253.');
    }
    if (!input.protectedSurfaceHashesUnchanged) {
      issues.add('Protected keyboard/MORE/long-press/MathLive/Graph/Solution/History surfaces must remain unchanged.');
    }
    if (!input.noPaddleRuntimeDependency || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrl) {
      issues.add('Q253 must not add Paddle runtime, model binaries, or production model URLs.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectCameraSolveGraphSolutionHistory) {
      issues.add('Camera/OCR output must remain review-only and cannot solve/graph/write records directly.');
    }
    if (!input.hasEvidenceLabel) {
      issues.add('Q253 requires a static evidence label.');
    }

    final decision = _decisionFor(input, issues);

    return GaussAndroidToolchainModernizationResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: decision,
      input: input,
      issues: List<String>.unmodifiable(issues),
      previousAgpVersion: previousAgpVersion,
      targetAgpVersion: targetAgpVersion,
      kotlinGradlePluginVersion: kotlinGradlePluginVersion,
      gradleWrapperVersion: gradleWrapperVersion,
      javaTargetCompatibility: javaTargetCompatibility,
      realOcrRuntimeAdded: false,
      modelBinaryBundledInBaseApp: false,
    );
  }

  static GaussAndroidToolchainModernizationDecision _decisionFor(
    GaussAndroidToolchainModernizationInput input,
    List<String> issues,
  ) {
    if (!input.q252PremiumFinalRegressionVerified) {
      return GaussAndroidToolchainModernizationDecision.blockedMissingQ252Foundation;
    }
    if (!input.settingsGradleUsesTargetAgp || !input.kotlinPluginPreservedAt21) {
      return GaussAndroidToolchainModernizationDecision.blockedAgpTargetMismatch;
    }
    if (!input.gradleWrapperAt87 || !input.javaCompileOptionsAt17 || !input.kotlinJvmTargetAt17) {
      return GaussAndroidToolchainModernizationDecision.blockedGradleOrJavaTargetMismatch;
    }
    if (!input.cameraDependencyLinePreserved || !input.cameraOcrRuntimeUnchanged) {
      return GaussAndroidToolchainModernizationDecision.blockedCameraOcrRegression;
    }
    if (!input.protectedSurfaceHashesUnchanged) {
      return GaussAndroidToolchainModernizationDecision.blockedProtectedSurfaceRegression;
    }
    if (!input.noPaddleRuntimeDependency || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrl || !input.mathLiveReviewAndUserApprovalRequired || !input.noDirectCameraSolveGraphSolutionHistory || !input.hasEvidenceLabel) {
      return GaussAndroidToolchainModernizationDecision.blockedForbiddenRuntimeBinding;
    }
    return issues.isEmpty
        ? GaussAndroidToolchainModernizationDecision.androidToolchainModernizationStaticReady
        : GaussAndroidToolchainModernizationDecision.blockedForbiddenRuntimeBinding;
  }
}
