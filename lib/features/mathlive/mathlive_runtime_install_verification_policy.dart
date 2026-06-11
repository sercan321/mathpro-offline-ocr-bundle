/// V172-Q90R4 — MathLive Runtime Install Verification Gate.
///
/// This is still a lab-only proof gate. It does not mount MathLive in the main
/// editor, does not delete the legacy cursor stack, and does not claim cursor
/// quality. It only verifies that the developer-side runtime installer produced
/// a credible local/offline MathLive vendor bundle before Q90R2 runtime smoke is
/// allowed to run.
class MathLiveRuntimeInstallVerificationPolicy {
  const MathLiveRuntimeInstallVerificationPolicy._();

  static const String phase = 'V172-Q90R4';
  static const String verifierScript = 'tool/verify_mathlive_runtime.mjs';
  static const String vendorRoot = 'assets/mathlive/vendor/mathlive/';
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEngineRemainsDefault = true;
  static const bool legacyEngineRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;
  static const bool cursorPassClaimAllowedFromInstallVerification = false;

  static const List<String> requiredLocalRuntimeFiles = <String>[
    'mathlive.min.js',
    'mathlive-fonts.css',
    'mathlive-static.css',
    'LICENSE.txt',
    'package.json',
    'runtime_manifest.json',
  ];

  static MathLiveRuntimeInstallVerificationVerdict evaluate({
    required bool mathliveMinJsPresent,
    required int mathliveMinJsBytes,
    required bool fontsCssPresent,
    required bool staticCssPresent,
    required bool licensePresent,
    required bool packageJsonPresent,
    required bool packageJsonNameIsMathlive,
    required bool packageJsonVersionPresent,
    required bool runtimeManifestPresent,
    required bool runtimeManifestDeclaresNpmSource,
    required bool runtimeManifestDeclaresRuntimeBundled,
    required bool runtimeManifestDisablesRemoteScripts,
    required bool runtimeManifestDisablesVirtualKeyboard,
    required bool projectManifestForbidsRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    final issues = <String>[];
    if (!mathliveMinJsPresent) issues.add('mathlive.min.js is missing');
    if (mathliveMinJsPresent && mathliveMinJsBytes < 1024) {
      issues.add('mathlive.min.js is too small to be treated as an official runtime bundle');
    }
    if (!fontsCssPresent) issues.add('mathlive-fonts.css is missing');
    if (!staticCssPresent) issues.add('mathlive-static.css is missing');
    if (!licensePresent) issues.add('LICENSE.txt is missing');
    if (!packageJsonPresent) issues.add('package.json is missing');
    if (!packageJsonNameIsMathlive) issues.add('package.json does not identify the mathlive package');
    if (!packageJsonVersionPresent) issues.add('package.json version is missing');
    if (!runtimeManifestPresent) issues.add('runtime_manifest.json is missing');
    if (!runtimeManifestDeclaresNpmSource) issues.add('runtime_manifest.json does not declare npm source');
    if (!runtimeManifestDeclaresRuntimeBundled) issues.add('runtime_manifest.json does not declare runtimeBundled=true');
    if (!runtimeManifestDisablesRemoteScripts) issues.add('runtime_manifest.json does not forbid remote scripts');
    if (!runtimeManifestDisablesVirtualKeyboard) issues.add('runtime_manifest.json does not keep MathLive virtual keyboard disabled');
    if (!projectManifestForbidsRemoteScripts) issues.add('assets/mathlive/manifest.json does not forbid remote scripts');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');

    final ready = issues.isEmpty;
    return MathLiveRuntimeInstallVerificationVerdict(
      status: ready ? 'MATHLIVE_RUNTIME_INSTALL_VERIFIED_FOR_LAB_SMOKE' : 'BLOCKED_MATHLIVE_RUNTIME_INSTALL_VERIFICATION',
      installVerified: ready,
      q90r2SmokeMayRun: ready,
      q87CursorCourtMayRun: false,
      mainEditorSwitchAllowed: false,
      issues: List<String>.unmodifiable(issues),
      diagnostic: ready
          ? 'q90r4-runtime-install-verified-lab-smoke-may-run-no-main-editor-switch'
          : 'q90r4-runtime-install-blocked-no-fake-runtime-claim',
    );
  }
}

class MathLiveRuntimeInstallVerificationVerdict {
  const MathLiveRuntimeInstallVerificationVerdict({
    required this.status,
    required this.installVerified,
    required this.q90r2SmokeMayRun,
    required this.q87CursorCourtMayRun,
    required this.mainEditorSwitchAllowed,
    required this.issues,
    required this.diagnostic,
  });

  final String status;
  final bool installVerified;
  final bool q90r2SmokeMayRun;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final List<String> issues;
  final String diagnostic;

  bool get isBlocked => !installVerified;
}
