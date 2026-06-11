/// V172-Q311 — OCR Candidate → Editable MathLive Review UI Binding Gate.
///
/// This policy defines the package-side contract for a future UI binding that
/// can present a real PP-FormulaNet-S OCR candidate inside an editable MathLive
/// review surface. Q311 is intentionally static: it does not open a review UI,
/// bind a native runtime, call MethodChannel, import into the workspace, or run
/// OCR.
class GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy {
  const GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy._();

  static const String phase =
      'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE';
  static const String sourcePhase =
      'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String reviewUiBindingFeatureFlag =
      'gauss.ppFormulaNetS.ocrCandidateEditableMathLiveReviewUiBinding.defaultOff';
  static const String reviewUiBindingMode =
      'ocr-candidate-editable-mathlive-review-ui-binding-gate-default-off-no-ui-open';
  static const String readinessState =
      'BLOCKED_PENDING_Q310_REAL_INFERENCE_CANDIDATE_AND_REVIEW_UI_EVIDENCE';

  static const List<String> requiredBeforeReviewUiBinding = <String>[
    'q310-image-to-latex-inference-gate-present',
    'q310-real-image-to-latex-inference-evidence',
    'q310-native-latex-candidate-envelope-present',
    'candidate-latex-sanitized',
    'candidate-alternatives-preserved',
    'candidate-confidence-recorded',
    'crop-preprocess-metadata-preserved',
    'editable-mathlive-review-surface-present',
    'mathlive-review-draft-created-from-candidate',
    'user-edit-capability-required',
    'explicit-user-approval-required-before-workspace-import',
    'direct-workspace-import-blocked',
    'direct-solve-graph-solution-history-blocked',
    'real-android-device-review-ui-log-required',
    'review-ui-timeout-policy-present',
    'review-ui-rollback-policy-present',
  ];

  static const List<String> reviewDraftEnvelopeFields = <String>[
    'reviewRequestId',
    'inferenceEvidenceId',
    'candidateLatex',
    'editableDraftLatex',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'cropBox',
    'preprocessProfileId',
    'sourceImageSha256',
    'reviewState',
    'userEdited',
    'userApproved',
    'errorCode',
  ];

  static const List<String> reviewStates = <String>[
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingQ310InferenceEvidence',
    'blockedMissingCandidateLatex',
    'blockedMathLiveReviewSurfaceUnavailable',
    'reviewDraftPrepared',
    'reviewVisibleForEditing',
    'userEditedDraft',
    'userApprovedDraft',
    'userRejectedDraft',
    'reviewFailed',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'q310InferenceEvidenceMissing',
    'candidateLatexMissing',
    'candidateLatexUnsafe',
    'mathLiveReviewSurfaceUnavailable',
    'reviewDraftCreationFailed',
    'userApprovalMissing',
    'unexpectedReviewResult',
  ];

  static const List<String> protectedSurfaceMarkers = <String>[
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'camera-shell-runtime-preserved',
    'workspace-runtime-preserved',
    'android-manifest-mainactivity-preserved',
    'pubspec-preserved',
  ];

  static const List<String> forbiddenActions = <String>[
    'openReviewUiInsideQ311Package',
    'callMethodChannelInsideQ311Package',
    'invokeNativeRuntimeInsideQ311Package',
    'parseRuntimeLatexResponseInsideQ311Package',
    'importWorkspaceInsideQ311Package',
    'autoApproveOcrCandidateInsideQ311Package',
    'autoSolveGraphSolutionHistoryFromOcrInsideQ311Package',
    'addRuntimeDependencyInQ311',
    'modifyMainActivityForRuntimeInQ311',
    'modifyAndroidManifestForRuntimeInQ311',
    'claimReviewBindingPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'bypassExplicitUserApproval',
  ];
}
