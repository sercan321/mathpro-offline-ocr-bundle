/// V172-Q100 — Official MathLive Runtime Bundle Closure.
///
/// Q100 is a package-side closure gate for the official local MathLive runtime
/// bundle. It checks whether the vendor runtime is genuinely present, manifest
/// backed, hash-verifiable, and still isolated to the Lab path. It never creates
/// placeholder runtime files, never turns MathLive into the default editor,
/// never enables the MathLive virtual keyboard, never permits remote scripts,
/// and never deletes the legacy cursor engine.
class MathLiveOfficialRuntimeBundleClosurePolicy {
  const MathLiveOfficialRuntimeBundleClosurePolicy._();

  static const String phase = 'V172-Q100';
  static const bool officialRuntimeBundleClosureGateProvided = true;
  static const bool createsFakeRuntimeFiles = false;
  static const bool downloadsRuntimeDuringVerification = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mathLiveEnabledByDefault = false;
  static const bool legacyCursorDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool smokeEvidenceStillRequired = true;
  static const bool realDeviceCourtStillRequired = true;

  static const List<String> requiredRuntimeFiles = <String>[
    'mathlive.min.js',
    'mathlive-fonts.css',
    'mathlive-static.css',
    'LICENSE.txt',
    'package.json',
    'runtime_manifest.json',
  ];

  static MathLiveOfficialRuntimeBundleClosureVerdict evaluate({
    required bool allRequiredRuntimeFilesPresent,
    required bool runtimeManifestPresent,
    required bool runtimeManifestJsonValid,
    required bool runtimeManifestDeclaresNpmMathlive,
    required bool runtimeManifestDeclaresRuntimeBundled,
    required bool runtimeManifestDeclaresRemoteScriptsDisabled,
    required bool runtimeManifestDeclaresVirtualKeyboardDisabled,
    required bool runtimeManifestContainsSha256Evidence,
    required bool runtimeFileHashesMatchManifest,
    required bool packageJsonDeclaresMathlive,
    required bool packageJsonHasVersion,
    required bool q90r4RuntimeVerifierPassed,
    required bool protectedSurfacesUnchanged,
    required bool noMainEditorSwitchAttempted,
    required bool noLegacyDeletionAttempted,
    required bool packageHygieneClean,
  }) {
    final blockers = <String>[];
    if (!allRequiredRuntimeFilesPresent) blockers.add('official MathLive runtime file set is incomplete');
    if (!runtimeManifestPresent) blockers.add('runtime_manifest.json is missing');
    if (!runtimeManifestJsonValid) blockers.add('runtime_manifest.json is not valid JSON');
    if (!runtimeManifestDeclaresNpmMathlive) blockers.add('runtime_manifest.json does not declare npm/mathlive provenance');
    if (!runtimeManifestDeclaresRuntimeBundled) blockers.add('runtime_manifest.json does not declare runtimeBundled true');
    if (!runtimeManifestDeclaresRemoteScriptsDisabled) blockers.add('runtime_manifest.json does not keep remote scripts disabled');
    if (!runtimeManifestDeclaresVirtualKeyboardDisabled) blockers.add('runtime_manifest.json does not keep MathLive virtual keyboard disabled');
    if (!runtimeManifestContainsSha256Evidence) blockers.add('runtime_manifest.json is missing sha256 file evidence');
    if (!runtimeFileHashesMatchManifest) blockers.add('runtime file sha256 evidence does not match manifest');
    if (!packageJsonDeclaresMathlive) blockers.add('package.json does not declare package name mathlive');
    if (!packageJsonHasVersion) blockers.add('package.json version is missing');
    if (!q90r4RuntimeVerifierPassed) blockers.add('Q90R4 runtime verifier PASS is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!noMainEditorSwitchAttempted) blockers.add('main editor switch was attempted during Q100');
    if (!noLegacyDeletionAttempted) blockers.add('legacy cursor deletion was attempted during Q100');
    if (!packageHygieneClean) blockers.add('package hygiene is not clean');

    final ready = blockers.isEmpty;
    return MathLiveOfficialRuntimeBundleClosureVerdict(
      status: ready
          ? 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE'
          : 'BLOCKED_MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE',
      blockers: blockers,
      officialRuntimeBundleClosed: ready,
      mayRunLabSmokeEvidence: ready,
      mayClaimCursorPass: false,
      maySwitchMainEditor: false,
      mayEnableMathLiveByDefault: false,
      mayDeleteLegacyCursor: false,
    );
  }
}

class MathLiveOfficialRuntimeBundleClosureVerdict {
  const MathLiveOfficialRuntimeBundleClosureVerdict({
    required this.status,
    required this.blockers,
    required this.officialRuntimeBundleClosed,
    required this.mayRunLabSmokeEvidence,
    required this.mayClaimCursorPass,
    required this.maySwitchMainEditor,
    required this.mayEnableMathLiveByDefault,
    required this.mayDeleteLegacyCursor,
  });

  final String status;
  final List<String> blockers;
  final bool officialRuntimeBundleClosed;
  final bool mayRunLabSmokeEvidence;
  final bool mayClaimCursorPass;
  final bool maySwitchMainEditor;
  final bool mayEnableMathLiveByDefault;
  final bool mayDeleteLegacyCursor;

  bool get isBlocked => !officialRuntimeBundleClosed;
}
