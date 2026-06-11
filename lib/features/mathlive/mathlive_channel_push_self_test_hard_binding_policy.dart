/// V172-Q169R19 — MathLive Channel-Push Self-Test Hard Binding.
///
/// Q169R17 added a final self-test court, but real-device evidence showed the
/// visible overlay could remain on the old Q169 key diagnostic. Q169R19 makes
/// the court visible through a JS -> Flutter channel-push path and treats
/// returning-result as auxiliary only.
class MathLiveChannelPushSelfTestHardBindingPolicy {
  const MathLiveChannelPushSelfTestHardBindingPolicy._();

  static const String phase = 'V172-Q169R19';
  static const String ownershipPhase = 'V172-Q169R20';
  static const String channelPushMarker = 'channelPushSelfTestHardBindingPhase';
  static const String visibleCourtRequestReason = 'q169r19-visible-self-test-court-request';
  static const String initialCourtReason = 'q169r19-initial-visible-self-test-court';
  static const String postFireCourtReason = 'q169r19-post-fire-visible-self-test-court';
  static const String courtPendingSummary =
      'COURT_RAW:waiting COURT MOUNT:pending INSERT:pending VALUE:pending CHANNEL:push PAINT:pending ROOT:awaiting-channel-push-root-cause';
  static const String courtPayloadMissingFieldsSummary =
      'COURT_RAW:received CHANNEL:parse-fail ROOT:court-payload-missing-result-fields';

  /// Q169R20: Q169R19 marked compact state pushes with the same channel marker
  /// used by final-court payloads. Dart then consumed compact state as a court
  /// result and rendered all COURT fields as unknown. Only true court payloads
  /// may enter _applyQ169FinalSelfTestCourtJson(...).
  static bool shouldConsumeChannelPush(String message) => isCourtResultPayload(message);

  static const String parserRepairPhase = 'V172-Q170';

  static bool isCourtResultPayload(String message) =>
      message.contains('"channelPushKind":"court"') || hasCompleteCourtFields(message);

  static bool isCompactStatePayload(String message) =>
      message.contains('"channelPushKind":"compact"') ||
      (message.contains('"$channelPushMarker"') &&
          message.contains('"compactBridgeStateReadbackPhase"') &&
          !isCourtResultPayload(message));

  static bool hasCompleteCourtFields(String message) =>
      message.contains('"mount"') &&
      message.contains('"insert"') &&
      message.contains('"value"') &&
      message.contains('"channel"') &&
      message.contains('"paint"') &&
      message.contains('"rootCause"');
}
