/// V172-Q300 — Release Candidate Freeze.
///
/// Contract-only release-candidate freeze for the MathPro/Gauss Camera/OCR
/// chain. It freezes Q288→Q299 evidence gates, store-audit blockers, protected
/// UI/runtime surfaces, and no-fake-PASS rules without submitting to Play Store,
/// creating a release build, adding OCR runtime, or claiming store/release PASS.
class GaussReleaseCandidateFreezePolicy {
  const GaussReleaseCandidateFreezePolicy._();

  static const String phase = 'V172-Q300-RELEASE-CANDIDATE-FREEZE';
  static const String sourcePhase = 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String freezeMode = 'release-candidate-freeze-contract-only-release-blocked';
  static const String freezeFeatureFlag = 'gauss.releaseCandidate.freeze.defaultOff';
  static const String freezeReadinessState = 'FROZEN_PENDING_REAL_FLUTTER_ANDROID_PLAY_CONSOLE_PRIVACY_DATA_SAFETY_AND_OCR_RUNTIME_EVIDENCE';
  static const String freezeDecision = 'freeze-contract-ready-but-release-store-ocr-pass-blocked-until-real-evidence';
  static const String rollbackMode = 'delete-q300-contract-files-without-runtime-binding-store-submit-release-build-model-download-or-workspace-mutation';

  static const int minimumFreezeGateCount = 34;
  static const int minimumRealEvidenceArtifactCount = 18;
  static const int maximumAllowedNewRuntimeMutationCount = 0;

  static const bool q299StoreReleaseCandidateAuditRequired = true;
  static const bool q298FullRealCameraOcrRegressionRequired = true;
  static const bool q297ApprovedWorkspaceImportRequired = true;
  static const bool q296EditableMathLiveReviewRequired = true;
  static const bool q295ImageToLatexInferenceEvidenceRequired = true;
  static const bool q294DummyInputRuntimeCallEvidenceRequired = true;
  static const bool q293RuntimeStartupEvidenceRequired = true;
  static const bool q292PrivateArtifactLoadEvidenceRequired = true;
  static const bool q291PrivateModelDownloadShaEvidenceRequired = true;
  static const bool q288ArtifactSourceIntakeRequired = true;

  static const bool privacyPolicyRequired = true;
  static const bool dataSafetyFormRequired = true;
  static const bool cameraPermissionDisclosureRequired = true;
  static const bool modelLicenseDisclosureRequired = true;
  static const bool truthfulOcrClaimsRequired = true;
  static const bool screenshotsRealDeviceEvidenceRequired = true;
  static const bool localizationReviewRequired = true;
  static const bool contentRatingEvidenceRequired = true;
  static const bool internalTestingEvidenceRequired = true;
  static const bool noMedicalFinancialOrExamGuaranteeClaims = true;
  static const bool editableMathLiveReviewStillRequired = true;
  static const bool explicitUserApprovalStillRequired = true;
  static const bool workspaceImportOnlyAfterApproval = true;
  static const bool manualSolveGraphAfterImportOnly = true;

  static const bool releaseCandidateFreezeContractReady = true;
  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool splashIconChanged = false;
  static const bool pubspecChanged = false;

  static const bool storeSubmissionPerformed = false;
  static const bool playConsoleConfigured = false;
  static const bool privacyPolicyPublished = false;
  static const bool dataSafetyFormCompleted = false;
  static const bool productionReleaseCreated = false;
  static const bool releaseAabCreated = false;
  static const bool releaseApkCreated = false;
  static const bool internalTestingTrackUploaded = false;
  static const bool realStoreListingAssetsAttached = false;
  static const bool realLocalizedListingsAttached = false;
  static const bool fullRealCameraOcrRegressionExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realWorkspaceImportRuntimeExecuted = false;
  static const bool nativeRuntimeStartupExecuted = false;
  static const bool realModelDownloadedAndShaVerified = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool jniBindingAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool solutionHistoryWriteEnabled = false;

  static const bool releaseCandidateFreezePassClaimed = false;
  static const bool storeReleaseCandidatePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;
  static const bool privacyPolicyPassClaimed = false;
  static const bool dataSafetyPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;

  static const List<String> requiredFreezeGates = <String>[
    'q299-store-release-candidate-audit-contract-present',
    'q298-full-real-camera-ocr-regression-contract-present',
    'q297-approved-workspace-import-contract-present',
    'q296-editable-mathlive-review-contract-present',
    'q295-image-to-latex-inference-contract-present',
    'q294-dummy-input-runtime-call-contract-present',
    'q293-runtime-startup-smoke-contract-present',
    'q292-private-artifact-load-contract-present',
    'q291-private-model-download-sha-contract-present',
    'q288-real-ocr-artifact-source-intake-contract-present',
    'privacy-policy-required',
    'data-safety-form-required',
    'camera-permission-disclosure-required',
    'model-license-source-disclosure-required',
    'truthful-ocr-claims-required',
    'real-device-screenshot-evidence-required',
    'localization-review-required',
    'content-rating-evidence-required',
    'internal-testing-evidence-required',
    'no-medical-financial-exam-guarantee-claims',
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'camera-shell-runtime-preserved',
    'workspace-runtime-preserved',
    'graph-solution-history-preserved',
    'android-manifest-mainactivity-preserved',
    'camera-dependencies-preserved',
    'android-toolchain-preserved',
    'editable-mathlive-review-required',
    'explicit-user-approval-required',
    'workspace-import-only-after-approval',
    'no-auto-evaluate-solve-graph-solution-history',
  ];

  static const List<String> releaseFreezeCourtCases = <String>[
    'q299-store-audit-contract-continuity-review',
    'play-console-evidence-still-missing-release-block-review',
    'privacy-policy-and-data-safety-still-blocking-review',
    'camera-permission-purpose-limitation-review',
    'model-license-source-size-sha-disclosure-review',
    'real-device-screenshots-and-run-log-evidence-review',
    'localization-and-content-rating-evidence-review',
    'app-bundle-hygiene-no-apk-aab-model-binary-review',
    'keyboard-more-longpress-mathlive-route-freeze-review',
    'graph-solution-history-no-auto-write-freeze-review',
    'camera-ocr-review-first-approval-first-freeze-review',
    'fake-pass-release-store-ocr-claim-guard',
  ];

  static const List<String> blockedUntilRealEvidence = <String>[
    'real-privacy-policy-url-and-in-app-access-evidence',
    'real-play-console-data-safety-form-screenshot-or-export',
    'real-camera-permission-disclosure-review-evidence',
    'real-store-listing-copy-final-review-evidence',
    'real-store-screenshots-from-supported-devices',
    'real-localized-listings-en-es-de-tr-review-evidence',
    'real-content-rating-questionnaire-evidence',
    'real-internal-test-track-upload-evidence',
    'real-model-license-source-and-size-disclosure-evidence',
    'real-official-artifact-url-and-expected-sha256',
    'real-private-download-actual-sha256-log',
    'real-private-artifact-load-device-log',
    'real-native-runtime-startup-device-log',
    'real-image-to-latex-inference-device-log',
    'real-editable-mathlive-review-opened-evidence',
    'real-explicit-user-approval-evidence',
    'real-approved-workspace-import-evidence',
    'real-flutter-analyze-log',
    'real-flutter-test-log',
    'real-flutter-run-device-log',
  ];

  static const List<String> forbiddenActions = <String>[
    'submitPlayStoreReleaseInQ300',
    'createProductionReleaseInQ300',
    'buildReleaseAabOrApkInQ300',
    'claimReleaseCandidateFreezePassWithoutRealEvidence',
    'claimStoreReadyPassWithoutPlayConsoleEvidence',
    'claimReleasePassWithoutRealDeviceAndStoreAuditEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimPrivacyPolicyPassWithoutPublishedPolicyEvidence',
    'claimDataSafetyPassWithoutPlayConsoleEvidence',
    'addPaddleRuntimeDependencyInQ300',
    'bindRuntimeMethodChannelInQ300',
    'implementNativeRuntimeHandlerInQ300',
    'bundlePPFormulaNetSModelInBaseApkInQ300',
    'enableProductionDownloadInQ300',
    'invokeNativeRuntimeInQ300',
    'sendCameraImageToNativeRuntimeInQ300',
    'mutateWorkspaceFromCameraWithoutApproval',
    'autoEvaluateCameraOutput',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCameraOutput',
  ];

  static const List<String> blockedDependencyFamilies = <String>[
    'paddleocr',
    'paddle_ocr',
    'paddle_flutter',
    'paddle_lite',
    'onnxruntime',
    'tesseract',
    'pix2text',
    'flutter_downloader',
    'background_downloader',
    'dio',
  ];

  static const List<String> requiresUserSideRetest = <String>[
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
