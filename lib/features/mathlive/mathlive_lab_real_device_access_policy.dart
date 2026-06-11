/// V172-Q90R8 — MathLive Lab Real Device Access / Evidence Review Guard.
///
/// Q90R7 made Lab smoke evidence copyable, but the user's screenshots showed
/// the main editor still exercised the legacy cursor. Q90R8 adds a safe access
/// path for running the isolated MathLive Lab directly on a real device without
/// mounting MathLive in the main workspace and without touching protected UI
/// surfaces.
class MathLiveLabRealDeviceAccessPolicy {
  const MathLiveLabRealDeviceAccessPolicy._();

  static const String phase = 'V172-Q90R8';
  static const String labRoute = '/mathlive-lab';
  static const String directEntrypoint = 'lib/main_mathlive_lab.dart';
  static const String runCommand = 'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA';
  static const String defaultMainEditorEngine = 'legacyFlutterSlotEditor';
  static const String labScreen = 'MathLiveLabScreen';

  static const bool directLabEntrypointProvided = true;
  static const bool materialAppRouteRegistered = true;
  static const bool labOnly = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mainEditorMountAllowed = false;
  static const bool legacyEditorRemainsDefault = true;
  static const bool legacyEditorRemainsRollback = true;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool remoteScriptsAllowed = false;
  static const bool mathLiveVirtualKeyboardMustStayDisabled = true;
  static const bool cursorPassClaimAllowedFromAccess = false;
  static const bool photomathLevelClaimAllowedFromAccess = false;

  static MathLiveLabRealDeviceAccessVerdict evaluate({
    required bool runtimeInstallVerified,
    required bool directEntrypointPresent,
    required bool routeRegistered,
    required bool labScreenImplemented,
    required bool labCanRunOnRealDevice,
    required bool remoteScriptsDisabled,
    required bool virtualKeyboardDisabled,
    required bool mainEditorStillLegacy,
    required bool protectedSurfacesUnchanged,
    required bool fakeCursorPassClaimAbsent,
  }) {
    final issues = <String>[];
    if (!runtimeInstallVerified) issues.add('Q90R4 runtime install verification has not passed');
    if (!directEntrypointPresent) issues.add('direct MathLive Lab entrypoint is missing');
    if (!routeRegistered) issues.add('MathLive Lab route is not registered for controlled navigation');
    if (!labScreenImplemented) issues.add('MathLive Lab screen is missing');
    if (!labCanRunOnRealDevice) issues.add('MathLive Lab has not been run on the real device');
    if (!remoteScriptsDisabled) issues.add('remote/CDN scripts are not disabled');
    if (!virtualKeyboardDisabled) issues.add('MathLive virtual keyboard is not disabled');
    if (!mainEditorStillLegacy) issues.add('main editor is no longer legacy during Lab access');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed during Lab access');
    if (!fakeCursorPassClaimAbsent) issues.add('Lab access path contains a fake cursor PASS claim');

    final ready = issues.isEmpty;
    return MathLiveLabRealDeviceAccessVerdict(
      status: ready
          ? 'MATHLIVE_LAB_REAL_DEVICE_ACCESS_READY_FOR_EVIDENCE_REVIEW'
          : 'BLOCKED_MATHLIVE_LAB_REAL_DEVICE_ACCESS',
      issues: issues,
      labAccessReady: ready,
      q90r5EvidenceMayBeCaptured: ready,
      q87CursorCourtMayRun: false,
      mainEditorSwitchAllowed: false,
      physicalLegacyDeletionAllowed: false,
    );
  }
}

class MathLiveLabRealDeviceAccessVerdict {
  const MathLiveLabRealDeviceAccessVerdict({
    required this.status,
    required this.issues,
    required this.labAccessReady,
    required this.q90r5EvidenceMayBeCaptured,
    required this.q87CursorCourtMayRun,
    required this.mainEditorSwitchAllowed,
    required this.physicalLegacyDeletionAllowed,
  });

  final String status;
  final List<String> issues;
  final bool labAccessReady;
  final bool q90r5EvidenceMayBeCaptured;
  final bool q87CursorCourtMayRun;
  final bool mainEditorSwitchAllowed;
  final bool physicalLegacyDeletionAllowed;

  bool get isBlocked => !labAccessReady;
}
