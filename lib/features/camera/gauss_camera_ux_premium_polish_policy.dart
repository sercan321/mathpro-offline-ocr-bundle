/// V172-Q243 — Camera UX Premium Polish policy.
///
/// This phase is intentionally visual/UX only. It improves the already-isolated
/// camera capture/crop/review shell with premium guidance, low-light/blur/focus
/// copy, scan-frame hierarchy, and safer button state language while preserving
/// every math, keyboard, MathLive, Graph, Solution, History, splash, and OCR
/// runtime boundary.
class GaussCameraUxPremiumPolishPolicy {
  static const phase = 'V172-Q243';
  static const fullPhase = 'V172-Q243-CAMERA-UX-PREMIUM-POLISH';

  static const q242OfflineModeGuardPreserved = true;
  static const q241WinnerEngineAdapterPreserved = true;
  static const q239eMathLiveReviewSurfacePreserved = true;
  static const q239dDeferredModelManagerPreserved = true;
  static const q239cCropScanFramePreserved = true;
  static const q239bCaptureShellPreserved = true;

  static const cameraUxPremiumPolishImplemented = true;
  static const premiumFocusQualityRailImplemented = true;
  static const lowLightGuidanceCopyImplemented = true;
  static const blurGuidanceCopyImplemented = true;
  static const alignmentGuidanceCopyImplemented = true;
  static const cropReviewConfidenceCopyImplemented = true;
  static const captureControlHierarchyPreserved = true;
  static const retakeRotateUseFrameControlsPreserved = true;
  static const mathLiveReviewOnlyCopyPreserved = true;
  static const noDirectCameraToMathActionPolicyPreserved = true;

  static const realOcrEngineAdded = false;
  static const textOcrFallbackAdded = false;
  static const paddleRuntimeAdded = false;
  static const pix2TextRuntimeAdded = false;
  static const texTellerRuntimeAdded = false;
  static const uniMerNetRuntimeAdded = false;
  static const onnxRuntimeAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const backgroundDownloadWorkerImplemented = false;
  static const productionMathLiveBridgeCalled = false;
  static const directWorkspaceImportImplemented = false;
  static const directSolveFromCameraAllowed = false;
  static const graphFromCameraAllowed = false;
  static const historyWriteFromCameraAllowed = false;
  static const solutionFromCameraAllowed = false;

  static const keyboardMutationAllowed = false;
  static const longPressMutationAllowed = false;
  static const moreMutationAllowed = false;
  static const mathLiveProductionMutationAllowed = false;
  static const graphRuntimeMutationAllowed = false;
  static const resultPanelMutationAllowed = false;
  static const solutionMutationAllowed = false;
  static const historyMutationAllowed = false;
  static const solverMutationAllowed = false;
  static const splashMutationAllowed = false;
  static const launcherIconMutationAllowed = false;

  static const flutterAnalyzePassClaimedByAssistant = false;
  static const flutterTestPassClaimedByAssistant = false;
  static const flutterRunPassClaimedByAssistant = false;
  static const androidRealDeviceCameraUxPassClaimedByAssistant = false;
  static const realEngineAccuracyPassClaimedByAssistant = false;

  static const qualityRailLabels = <String>[
    'Netlik',
    'Işık',
    'Hizalama',
  ];

  static const qualityRailHints = <String>[
    'Formülü net tut',
    'Gölgeyi azalt',
    'Çerçeveye paralel al',
  ];

  static const blockedCameraOutputActions = <String>[
    'workspaceImportWithoutReview',
    'evaluateWithoutReview',
    'graphWithoutReview',
    'historyWithoutReview',
    'solutionWithoutReview',
  ];
}
