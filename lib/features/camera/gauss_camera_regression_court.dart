import 'gauss_advanced_math_ocr_offline_mode_guard_policy.dart';
import 'gauss_camera_permission_capture_shell_policy.dart';
import 'gauss_camera_regression_court_policy.dart';
import 'gauss_camera_ux_premium_polish_policy.dart';
import 'gauss_deferred_math_ocr_model_manager_policy.dart';
import 'gauss_formula_crop_scan_frame_policy.dart';
import 'gauss_mathlive_ocr_review_surface_policy.dart';
import 'gauss_ocr_benchmark_dataset_lab_runner_policy.dart';
import 'gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'gauss_ocr_benchmark_external_lab_result_schema_policy.dart';
import 'gauss_ocr_engine_benchmark_court_policy.dart';
import 'gauss_winner_engine_adapter_policy.dart';
import 'gauss_workspace_camera_entry_policy.dart';

/// V172-Q244 static regression checkpoint severity.
enum GaussCameraRegressionCourtSeverity {
  info,
  blocking,
}

/// One static regression checkpoint in the Q244 camera court.
class GaussCameraRegressionCourtCheckpoint {
  const GaussCameraRegressionCourtCheckpoint({
    required this.code,
    required this.description,
    required this.passed,
    this.severity = GaussCameraRegressionCourtSeverity.blocking,
  });

  final String code;
  final String description;
  final bool passed;
  final GaussCameraRegressionCourtSeverity severity;

  bool get isBlockingFailure => !passed && severity == GaussCameraRegressionCourtSeverity.blocking;
}

/// Package-side verdict for the Q244 camera regression court.
class GaussCameraRegressionCourtVerdict {
  const GaussCameraRegressionCourtVerdict({
    required this.phase,
    required this.checkpoints,
    required this.realFlutterAndAndroidRetestRequired,
    required this.realOcrEngineRuntimeBound,
    required this.directCameraMathActionAllowed,
  });

  final String phase;
  final List<GaussCameraRegressionCourtCheckpoint> checkpoints;
  final bool realFlutterAndAndroidRetestRequired;
  final bool realOcrEngineRuntimeBound;
  final bool directCameraMathActionAllowed;

  bool get staticCourtPassed => checkpoints.every((checkpoint) => checkpoint.passed);

  bool get hasBlockingFailure => checkpoints.any((checkpoint) => checkpoint.isBlockingFailure);

  List<String> get blockingFailureCodes => checkpoints
      .where((checkpoint) => checkpoint.isBlockingFailure)
      .map((checkpoint) => checkpoint.code)
      .toList(growable: false);
}

/// V172-Q244 static regression court for the camera/OCR foundation.
class GaussCameraRegressionCourt {
  const GaussCameraRegressionCourt._();

  static const String phase = GaussCameraRegressionCourtPolicy.phase;
  static const String fullPhase = GaussCameraRegressionCourtPolicy.fullPhase;
  static const bool realOcrEngineRuntimeBound = false;
  static const bool directCameraMathActionAllowed = false;
  static const bool realFlutterAndAndroidRetestRequired = true;

  static const List<String> protectedRuntimeSurfaces =
      GaussCameraRegressionCourtPolicy.lockedRedLineSurfaces;

  static const List<String> forbiddenActions =
      GaussCameraRegressionCourtPolicy.forbiddenCameraRegressionActions;

  static GaussCameraRegressionCourtVerdict runStaticCourt() {
    final checkpoints = <GaussCameraRegressionCourtCheckpoint>[
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q239aWorkspaceCameraEntryPreserved',
        description: 'Workspace ellipsis replacement remains camera entry only.',
        passed: GaussWorkspaceCameraEntryButtonPolicy.replacesWorkspaceEllipsisAction &&
            GaussWorkspaceCameraEntryButtonPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q239bCameraCaptureShellPreserved',
        description: 'Camera permission/capture shell remains capture-only.',
        passed: GaussCameraPermissionCaptureShellPolicy.cameraPreviewImplemented &&
            GaussCameraPermissionCaptureShellPolicy.stillPhotoCaptureImplemented &&
            GaussCameraPermissionCaptureShellPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q239cCropScanFramePreserved',
        description: 'Formula crop/scan-frame review remains pre-OCR only.',
        passed: GaussFormulaCropScanFramePolicy.premiumFormulaCropReviewImplemented &&
            GaussFormulaCropScanFramePolicy.mathLiveImportImplemented == false &&
            GaussFormulaCropScanFramePolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q239dDeferredModelManagerPreserved',
        description: 'Deferred model manager does not bind a model URL or worker.',
        passed: GaussDeferredMathOcrModelManagerPolicy.modelManagerStateContractImplemented &&
            GaussDeferredMathOcrModelManagerPolicy.productionDownloadUrlBound == false &&
            GaussDeferredMathOcrModelManagerPolicy.backgroundDownloadWorkerImplemented == false &&
            GaussDeferredMathOcrModelManagerPolicy.modelBinaryBundledInBaseApp == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q239eMathLiveReviewSurfacePreserved',
        description: 'MathLive OCR review foundation remains review-only.',
        passed: GaussMathLiveOcrReviewSurfacePolicy.mathLiveOcrReviewSurfaceImplemented &&
            GaussMathLiveOcrReviewSurfacePolicy.productionMathLiveBridgeCalled == false &&
            GaussMathLiveOcrReviewSurfacePolicy.directWorkspaceImportImplemented == false &&
            GaussMathLiveOcrReviewSurfacePolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q240BenchmarkCourtPreserved',
        description: 'OCR benchmark court still has no production OCR runtime.',
        passed: GaussOcrEngineBenchmarkCourtPolicy.benchmarkCourtContractImplemented &&
            GaussOcrEngineBenchmarkCourtPolicy.realOcrEngineAdded == false &&
            GaussOcrEngineBenchmarkCourtPolicy.benchmarkWinnerSelected == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q240r1DatasetLabRunnerPreserved',
        description: 'Dataset lab runner remains dry-run metadata only.',
        passed: GaussOcrBenchmarkDatasetLabRunnerPolicy.datasetManifestImplemented &&
            GaussOcrBenchmarkDatasetLabRunnerPolicy.realOcrEngineAdded == false &&
            GaussOcrBenchmarkDatasetLabRunnerPolicy.realBenchmarkImageAssetsBundled == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q240r2ExternalLabSchemaPreserved',
        description: 'External lab schema still blocks unsafe direct actions.',
        passed: GaussOcrBenchmarkExternalLabResultSchemaPolicy.externalLabResultSchemaImplemented &&
            GaussOcrBenchmarkExternalLabResultSchemaPolicy.productionModelUrlBound == false &&
            GaussOcrBenchmarkExternalLabResultSchemaPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q240r3IntakeGatePreserved',
        description: 'External lab intake gate remains mandatory.',
        passed: GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.externalLabIntakeValidatorImplemented &&
            GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.directSolveFromCameraAllowed == false &&
            GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.benchmarkWinnerSelected == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q241WinnerAdapterPreserved',
        description: 'Winner adapter remains a review-only contract.',
        passed: GaussWinnerEngineAdapterPolicy.winnerEngineAdapterContractImplemented &&
            GaussWinnerEngineAdapterPolicy.mathLiveReviewOnlyRoutingImplemented &&
            GaussWinnerEngineAdapterPolicy.directWorkspaceImportImplemented == false &&
            GaussWinnerEngineAdapterPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q242OfflineModeGuardPreserved',
        description: 'Offline OCR mode still cannot execute a model in this phase.',
        passed: GaussAdvancedMathOcrOfflineModeGuardPolicy.advancedOfflineModeGuardImplemented &&
            GaussAdvancedMathOcrOfflineModeGuardPolicy.offlineOcrExecutionAllowedInThisPhase == false &&
            GaussAdvancedMathOcrOfflineModeGuardPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'q243PremiumUxPreserved',
        description: 'Camera UX polish remains visual-only and review-only.',
        passed: GaussCameraUxPremiumPolishPolicy.cameraUxPremiumPolishImplemented &&
            GaussCameraUxPremiumPolishPolicy.realOcrEngineAdded == false &&
            GaussCameraUxPremiumPolishPolicy.directSolveFromCameraAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'redLineSurfacesLocked',
        description: 'Q244 allows no keyboard/MORE/MathLive/Graph/Solution/History/splash/icon mutation.',
        passed: GaussCameraRegressionCourtPolicy.keyboardMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.longPressMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.moreMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.mathLiveProductionMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.graphRuntimeMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.solutionMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.historyMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.splashMutationAllowed == false &&
            GaussCameraRegressionCourtPolicy.launcherIconMutationAllowed == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'noRuntimeEngineOrModelAdded',
        description: 'Q244 adds no OCR runtime, no model binary, no model URL, and no downloader.',
        passed: GaussCameraRegressionCourtPolicy.realOcrEngineAdded == false &&
            GaussCameraRegressionCourtPolicy.textOcrFallbackAdded == false &&
            GaussCameraRegressionCourtPolicy.paddleRuntimeAdded == false &&
            GaussCameraRegressionCourtPolicy.pix2TextRuntimeAdded == false &&
            GaussCameraRegressionCourtPolicy.onnxRuntimeAdded == false &&
            GaussCameraRegressionCourtPolicy.modelBinaryBundledInBaseApp == false &&
            GaussCameraRegressionCourtPolicy.productionModelUrlBound == false &&
            GaussCameraRegressionCourtPolicy.backgroundDownloadWorkerImplemented == false,
      ),
      const GaussCameraRegressionCourtCheckpoint(
        code: 'realDeviceRetestRequired',
        description: 'Assistant does not claim Flutter/Android/camera/OCR PASS.',
        passed: GaussCameraRegressionCourtPolicy.flutterAnalyzePassClaimedByAssistant == false &&
            GaussCameraRegressionCourtPolicy.flutterTestPassClaimedByAssistant == false &&
            GaussCameraRegressionCourtPolicy.flutterRunPassClaimedByAssistant == false &&
            GaussCameraRegressionCourtPolicy.androidRealDeviceCameraRegressionPassClaimedByAssistant == false &&
            GaussCameraRegressionCourtPolicy.realEngineAccuracyPassClaimedByAssistant == false,
        severity: GaussCameraRegressionCourtSeverity.info,
      ),
    ];

    return GaussCameraRegressionCourtVerdict(
      phase: fullPhase,
      checkpoints: List<GaussCameraRegressionCourtCheckpoint>.unmodifiable(checkpoints),
      realFlutterAndAndroidRetestRequired: true,
      realOcrEngineRuntimeBound: false,
      directCameraMathActionAllowed: false,
    );
  }
}
