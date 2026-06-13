/// Q389R6U closes the device-reported failure where long-press sent the caret
/// to the expression end instead of starting a Photomath-style hold-and-drag
/// cursor session.
///
/// Runtime authority is intentionally narrow:
/// Flutter parent Listener -> external JS bridge -> MathLive native caret.
/// The older JS internal long-press listener body is kept as historical source
/// for Q389R6I/Q389R6J markers, but Q389R6U suppresses it at install time so
/// production has a single cursor-drag authority.
class WorkspaceLongPressCursorDragExternalSingleAuthorityPolicyQ389R6U {
  const WorkspaceLongPressCursorDragExternalSingleAuthorityPolicyQ389R6U._();

  static const String phase = 'Q389R6U';
  static const bool buildsOnQ389R6T = true;
  static const bool flutterParentListenerIsSingleAuthority = true;
  static const bool jsInternalLongPressPathSuppressedInProduction = true;
  static const bool flutterMoveDispatchCoalesced = true;
  static const int flutterMoveCoalesceMs = 16;
  static const bool flutterSurfaceSizeSentToJs = true;
  static const bool jsCoordinateNormalizationEnabled = true;
  static const bool externalContinuousEdgeAutoscrollEnabled = true;
  static const int externalContinuousEdgeAutoscrollTickMs = 72;
  static const bool documentLevelTouchMoveFallbackAllowed = false;
  static const bool documentLevelPointerMoveFallbackAllowed = false;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool legacyFlutterCursorAllowed = false;
  static const bool keyboardLayoutChanged = false;
  static const bool keyboardDispatchChanged = false;
  static const bool graphChanged = false;
  static const bool ocrChanged = false;
  static const bool androidNativeChanged = false;
  static const bool solverChanged = false;
}
