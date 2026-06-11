/// V172-Q90R9 — Windows NPM Command Resolution Repair.
///
/// Keeps MathLive runtime intake lab-only while making the developer-side npm
/// installer robust on Windows, where npm is exposed as npm.cmd rather than a
/// directly spawnable executable.
class MathLiveWindowsNpmCommandResolutionPolicy {
  const MathLiveWindowsNpmCommandResolutionPolicy._();

  static const String phase = 'V172-Q90R9';
  static const String installerScript = 'tool/install_mathlive_runtime.mjs';
  static const String windowsNpmExecutable = 'npm.cmd';
  static const String posixNpmExecutable = 'npm';
  static const String blockedStatus = 'BLOCKED_NPM_NOT_FOUND';

  static const bool usesNpmCmdOnWindows = true;
  static const bool emitsClearBlockedStatusWhenNpmMissing = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
}
