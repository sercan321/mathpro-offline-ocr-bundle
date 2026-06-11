/// V172-Q201 — Production caret/focus/slot finalization.
///
/// This phase hardens the active MathLive production editor after Q200's
/// no-freeze contract. It is a code/static closure only: native MathLive keeps
/// visible caret, focus, hit-test, placeholder slot, and selection authority;
/// Flutter must not draw a replacement cursor, visible fallback mirror, or
/// controller/external-expression override that can move the caret after the
/// user starts editing.
abstract final class MathLiveProductionCaretFocusSlotFinalizationPolicy {
  static const String phase = 'V172-Q201';
  static const String fullPhase = 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION';
  static const String baseline = 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION';

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;

  static const bool nativeMathFieldOwnsVisibleCaret = true;
  static const bool nativeMathFieldOwnsFocus = true;
  static const bool nativeMathFieldOwnsSlotSelection = true;
  static const bool flutterCaretOverlayAllowedInProduction = false;
  static const bool flutterVisibleFallbackMirrorAllowedInProduction = false;
  static const bool controllerMirrorMayOverrideNativeCaret = false;
  static const bool externalExpressionMayOverrideNativeCaretAfterUserInput = false;
  static const bool focusSuccessMustBeMeasuredNotAssumed = true;
  static const bool commandDispatchMustPrimeNativeFocus = true;
  static const bool commandDispatchMustRequestNativeCaretVisibility = true;
  static const bool pointerHandlersMustNotPreventMathLiveDefaultSelection = true;
  static const bool pointerEventsMustStayOnMathField = true;
  static const bool selectionChangeMustPushState = true;
  static const bool commandCompletionMustPushCaretState = true;
  static const bool q201RuntimeStateFieldsRequired = true;

  static const bool finalReleasePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
