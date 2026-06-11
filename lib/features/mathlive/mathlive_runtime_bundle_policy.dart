/// V172-Q90R1 — Official MathLive Runtime Bundle Intake Guard.
///
/// This phase is deliberately an intake/provenance gate, not a fake runtime
/// bundle. The assistant environment cannot fetch npm assets, so the package
/// records the exact local vendor boundary and installer script required before
/// any code may claim that the official MathLive runtime is bundled.
class MathLiveRuntimeBundlePolicy {
  const MathLiveRuntimeBundlePolicy._();

  static const String phase = 'V172-Q90R1';
  static const String packageName = 'mathlive';
  static const String packageSource = 'npm';
  static const String vendorRoot = 'assets/mathlive/vendor/mathlive/';
  static const String installerScript = 'tool/install_mathlive_runtime.mjs';
  static const String runtimeManifest = 'assets/mathlive/vendor/mathlive/runtime_manifest.json';

  static const List<String> expectedRuntimeAssets = <String>[
    'assets/mathlive/vendor/mathlive/mathlive.min.js',
    'assets/mathlive/vendor/mathlive/mathlive-fonts.css',
    'assets/mathlive/vendor/mathlive/mathlive-static.css',
    'assets/mathlive/vendor/mathlive/LICENSE.txt',
    'assets/mathlive/vendor/mathlive/package.json',
  ];

  static const bool runtimeBundleIntakeGuardImplemented = true;
  static const bool installerScriptProvided = true;
  static const bool officialRuntimeBundledByAssistant = false;
  static const bool officialRuntimeClaimAllowedWithoutFiles = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool cdnDependencyAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mainEditorSwitchAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimePassClaimAllowed = false;
  static const bool manualVendorDropAllowedOnlyWithManifest = true;

  static MathLiveRuntimeBundleVerdict evaluate({
    required bool mathliveMinJsPresent,
    required bool fontsCssPresent,
    required bool staticCssPresent,
    required bool licensePresent,
    required bool packageJsonPresent,
    required bool runtimeManifestPresent,
    required bool manifestDeclaresNpmSource,
    required bool remoteScriptsDisabled,
    required bool virtualKeyboardDisabled,
    required bool protectedSurfacesUnchanged,
  }) {
    final issues = <String>[];
    if (!mathliveMinJsPresent) issues.add('mathlive.min.js is not present in the local vendor directory');
    if (!fontsCssPresent) issues.add('mathlive-fonts.css is not present in the local vendor directory');
    if (!staticCssPresent) issues.add('mathlive-static.css is not present in the local vendor directory');
    if (!licensePresent) issues.add('MathLive LICENSE.txt is not present in the local vendor directory');
    if (!packageJsonPresent) issues.add('MathLive package.json is not present in the local vendor directory');
    if (!runtimeManifestPresent) issues.add('runtime_manifest.json provenance file is not present');
    if (!manifestDeclaresNpmSource) issues.add('runtime manifest does not declare npm provenance');
    if (!remoteScriptsDisabled) issues.add('remote scripts are not disabled');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');

    final ready = issues.isEmpty;
    return MathLiveRuntimeBundleVerdict(
      status: ready ? 'OFFICIAL_RUNTIME_BUNDLE_READY_FOR_LAB' : 'BLOCKED_OFFICIAL_RUNTIME_NOT_BUNDLED',
      officialRuntimeBundled: ready,
      mainEditorSwitchAllowed: false,
      labRuntimeMayBeExercised: ready,
      diagnostic: ready
          ? 'q90r1-official-mathlive-runtime-bundle-ready-for-lab'
          : 'q90r1-official-mathlive-runtime-bundle-blocked-no-fake-runtime-claim',
      issues: issues,
    );
  }
}

class MathLiveRuntimeBundleVerdict {
  const MathLiveRuntimeBundleVerdict({
    required this.status,
    required this.officialRuntimeBundled,
    required this.mainEditorSwitchAllowed,
    required this.labRuntimeMayBeExercised,
    required this.diagnostic,
    required this.issues,
  });

  final String status;
  final bool officialRuntimeBundled;
  final bool mainEditorSwitchAllowed;
  final bool labRuntimeMayBeExercised;
  final String diagnostic;
  final List<String> issues;

  bool get isBlocked => status == 'BLOCKED_OFFICIAL_RUNTIME_NOT_BUNDLED';
  bool get readyForLab => status == 'OFFICIAL_RUNTIME_BUNDLE_READY_FOR_LAB';
}
