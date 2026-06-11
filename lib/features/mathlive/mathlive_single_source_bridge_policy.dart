/// V172-Q169R23 — MathLive Single Source Bridge Envelope.
///
/// The earlier Q169 diagnostic path accepted several partially overlapping
/// payloads: regular key diagnostics, compact state payloads, court payloads,
/// and returning-result snapshots. Q169R23 makes the visible diagnostic consume
/// one deterministic envelope whenever JS pushes state to Flutter.
class MathLiveSingleSourceBridgePolicy {
  const MathLiveSingleSourceBridgePolicy._();

  static const String phase = 'V172-Q169R23';
  static const String marker = 'singleSourceBridgePhase';
  static const String envelopeMarker = 'q169SingleSourceEnvelope';
  static const String visiblePrefix = 'COURT_SINGLE_SOURCE';
  static const String missingFieldsSummary =
      'COURT_SINGLE_SOURCE CHANNEL:parse-fail ROOT:single-source-envelope-missing-fields';
  static const String parseFailSummary =
      'COURT_SINGLE_SOURCE CHANNEL:parse-fail ROOT:single-source-envelope-json-parse-error';

  static const String parserRepairPhase = 'V172-Q170';

  static bool shouldConsumeSingleSourceEnvelope(String message) {
    return message.contains('"$envelopeMarker":true') || hasRequiredFields(message);
  }

  static bool hasRequiredFields(String message) =>
      message.contains('"mount"') &&
      message.contains('"insert"') &&
      message.contains('"value"') &&
      message.contains('"channel"') &&
      message.contains('"paint"') &&
      message.contains('"rootCause"');
}
