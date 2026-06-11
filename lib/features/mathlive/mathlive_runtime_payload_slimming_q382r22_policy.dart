/// V172-Q382R22 — Runtime Payload Slimming.
///
/// This phase reduces the hot MathPro-keyboard -> MathLive JavaScript command
/// payload to the fields the production bridge actually consumes for
/// insert/delete/clear dispatch.  It does not alter the serial production
/// command queue, Android WebView timeout, MathLive native caret authority,
/// slot/template semantics, keyboard layout/order/labels, MORE, Graph,
/// Solution, History, OCR/Camera, AndroidManifest, MainActivity, Gradle, or
/// splash/icon surfaces.
class MathLiveRuntimePayloadSlimmingQ382R22Policy {
  const MathLiveRuntimePayloadSlimmingQ382R22Policy._();

  static const String phase = 'V172-Q382R22';
  static const String contract = 'q382r22-runtime-payload-slimming-active';

  /// Required fields for the hot command payload.  `lastAnswer` may be present
  /// only when non-empty because some Ans-derived payloads are resolved before
  /// JavaScript dispatch but keeping the optional field is harmless and bounded.
  static const int requiredRuntimePayloadFieldCount = 4;
  static const int maximumRuntimePayloadFieldCount = 5;

  static const bool serialProductionCommandQueuePreserved = true;
  static const bool androidBridgeCommandTimeoutPreserved = true;
  static const bool mathLiveNativeCaretAuthorityPreserved = true;
  static const bool slotAndTemplateSemanticsPreserved = true;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool panExperimentsRemainRemoved = true;
}
