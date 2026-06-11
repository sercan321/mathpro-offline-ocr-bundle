/// V172-Q169R22 Court Overlay Analyzer Hygiene policy.
///
/// Q169R21 repaired a Dart compile-scope failure by disambiguating the
/// widget State lifecycle `mounted` flag from the parsed MathLive runtime
/// mount boolean. User-side `flutter analyze` then reported the remaining
/// `this.mounted` qualifier as unnecessary because the local variable had
/// already been renamed to `runtimeMountedFromSnapshot`.
///
/// Q169R22 keeps the Q169R21 scope repair intact while making the source
/// analyzer-clean: the overlay lifecycle guard may use unqualified `mounted`
/// only because no local `mounted` variable may exist in the same scope.
abstract final class MathLiveCourtOverlayAnalyzerHygienePolicy {
  static const String phase = 'V172-Q169R22';
  static const String analyzerDiagnostic = 'unnecessary_this';
  static const String requiredGuard = '_q169CourtOverlayLocked && mounted';
  static const String forbiddenGuard = '_q169CourtOverlayLocked && this.mounted';
  static const String forbiddenLocalShadow = 'final mounted = snapshot.runtime.contains';
  static const String runtimeMountedLocal = 'runtimeMountedFromSnapshot';
  static const bool changesRuntimeMathLiveBehavior = false;
  static const bool changesProtectedSurfaces = false;
  static const bool claimsNativePaintPass = false;
}
