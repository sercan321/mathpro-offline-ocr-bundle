/// V172-Q192 — Caret / Focus / Slot Contract Closure policy.
///
/// This phase is a code/static contract closure. It does not claim Flutter
/// analyze PASS, Flutter test PASS, Android real-device PASS, premium visual
/// PASS, or real-device caret PASS. It freezes the production contract that
/// the visible caret, focus, and slot selection authority belong to the native
/// MathLive <math-field>, not to a Flutter overlay or legacy mirror.
class MathLiveCaretFocusSlotContractPolicy {
  const MathLiveCaretFocusSlotContractPolicy._();

  static const String phase = 'V172-Q192';
  static const String baseline = 'V172-Q191_RUNTIME_RENDER_CONTRACT_CLOSURE';
  static const String closureName = 'caret-focus-slot-contract-closure';

  static const bool newFeatureAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;

  static const bool nativeMathLiveCaretOwnsSelection = true;
  static const bool flutterCaretOverlayAllowed = false;
  static const bool flutterFallbackMirrorMayOwnVisibleEditor = false;
  static const bool webViewGestureMustBeEager = true;
  static const bool pointerTapMustStayInsideMathfield = true;
  static const bool commandDispatchMustRefocusMathfield = true;
  static const bool commandDispatchMustRequestCaretVisibility = true;
  static const bool statePushAfterPointerAndSelectionEvents = true;
  static const bool rawCursorOverlayMayRenderInProduction = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
}
