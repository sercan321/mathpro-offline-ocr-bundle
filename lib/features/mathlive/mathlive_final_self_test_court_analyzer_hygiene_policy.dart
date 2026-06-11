/// V172-Q169R18 — MathLive final self-test court analyzer hygiene policy.
///
/// This phase repairs the user-side `flutter analyze` info diagnostics raised by
/// unnecessary escaped double quotes inside single-quoted Dart string literals in
/// the Q169R17 final self-test court async bridge-message detector. It does not
/// change MathLive runtime semantics, bridge payloads, keyboard layout, MORE,
/// long-press order, AppShell, Graph, History, Solution, or native-paint claims.
class MathLiveFinalSelfTestCourtAnalyzerHygienePolicy {
  const MathLiveFinalSelfTestCourtAnalyzerHygienePolicy._();

  static const String phase = 'V172-Q169R18';
  static const bool repairsUnnecessaryStringEscapes = true;
  static const bool runtimeBehaviorChanged = false;
  static const bool protectedSurfacesUnchanged = true;
}
