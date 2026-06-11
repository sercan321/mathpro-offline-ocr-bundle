/// V172-Q306 — SHA Verification + Atomic Move Real Runtime Gate.
///
/// This policy defines the package-side contract for the future verified
/// PP-FormulaNet-S artifact promotion step. It is intentionally static: Q306
/// does not download a model, compute a real artifact SHA, move files, accept a
/// model for runtime, start native runtime, or run OCR.
class GaussShaVerificationAtomicMoveRealRuntimeGatePolicy {
  const GaussShaVerificationAtomicMoveRealRuntimeGatePolicy._();

  static const String phase =
      'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE';
  static const String sourcePhase =
      'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String verificationFeatureFlag =
      'gauss.ppFormulaNetS.shaVerificationAtomicMove.defaultOff';
  static const String readinessState =
      'BLOCKED_PENDING_Q302_EXPECTED_ACTUAL_SHA_AND_Q305_CONTROLLED_DOWNLOAD_EVIDENCE';
  static const String verificationMode =
      'sha-verification-atomic-move-gate-default-off-no-file-move';

  static const List<String> requiredBeforeArtifactReady = <String>[
    'q302-expected-sha256-locked',
    'q302-actual-sha256-computed-from-controlled-download',
    'q302-expected-actual-sha256-match',
    'q305-private-download-worker-evidence',
    'temporary-private-file-complete',
    'checksum-before-ready',
    'atomic-move-after-checksum-pass',
    'verified-private-artifact-path-recorded',
    'partial-corrupt-download-cleanup-evidence',
    'rollback-plan-present',
  ];

  static const List<String> verificationEnvelopeFields = <String>[
    'artifactLocator',
    'temporaryPrivatePath',
    'verifiedPrivatePath',
    'expectedSha256',
    'actualSha256',
    'byteLength',
    'computedAtUtc',
    'verificationState',
    'atomicMoveState',
    'errorCode',
  ];

  static const List<String> atomicMoveStates = <String>[
    'notStarted',
    'checksumComputing',
    'checksumMismatch',
    'checksumVerified',
    'atomicMovePending',
    'atomicMoveSucceeded',
    'atomicMoveFailed',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'expectedShaMissing',
    'temporaryFileMissing',
    'actualShaComputationFailed',
    'checksumMismatch',
    'atomicMoveAttemptedBeforeChecksumPass',
    'atomicMoveFailed',
    'verifiedArtifactPathUnsafe',
    'cleanupFailed',
  ];

  static const List<String> protectedSurfaceMarkers = <String>[
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'camera-shell-runtime-preserved',
    'android-manifest-mainactivity-preserved',
    'pubspec-preserved',
  ];

  static const List<String> forbiddenActions = <String>[
    'computeRealArtifactShaInsideQ306Package',
    'performAtomicMoveInsideQ306Package',
    'acceptArtifactForRuntimeInsideQ306Package',
    'enableProductionDownloadInQ306',
    'addRuntimeDependencyInQ306',
    'modifyMainActivityForRuntimeInQ306',
    'claimShaModelRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'directWorkspaceSolveGraphSolutionHistoryFromOcr',
  ];
}
