/// V172-Q169R21 — Court Overlay Compile Scope Repair
///
/// This policy documents the analyzer/compile repair after Q169R20 introduced
/// a Dart scope error by referencing a local variable named `mounted` before
/// its declaration inside `MathLiveMainEditorSurface._consumeBridgeStateMessage`.
/// The repaired runtime path must use the State property `this.mounted` for
/// widget lifecycle safety and must use `runtimeMountedFromSnapshot` for the
/// parsed MathLive runtime mount boolean.
class MathLiveCourtOverlayCompileScopeRepairPolicy {
  static const String phase = 'V172-Q169R21';
  static const String stateMountedPropertyUsage = '_q169CourtOverlayLocked && this.mounted';
  static const String runtimeMountedLocalName = 'runtimeMountedFromSnapshot';
  static const String forbiddenLocalName = 'final mounted = snapshot.runtime.contains';
  static const bool changesRuntimeMathLiveBridge = false;
  static const bool changesProtectedSurfaces = false;
  static const bool claimsRealDevicePaintPass = false;
}
