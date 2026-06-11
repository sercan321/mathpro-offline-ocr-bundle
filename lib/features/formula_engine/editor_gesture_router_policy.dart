/// V172-K no-loupe editor gesture routing contract.
///
/// MathPro's editor cursor must feel premium without an editor loupe: a tap
/// places the cursor, a horizontal drag pans long expressions, and long-press
/// must not open a cursor menu or magnifier.  This small pure policy keeps the
/// routing rules explicit and regression-testable without touching keyboard
/// long-press behavior.
class EditorGestureRouterPolicy {
  const EditorGestureRouterPolicy._();

  static const String version = 'mathpro-v172k-v172q42-gesture-router-without-loupe-drag-stability-v2';

  static const bool editorLoupeEnabled = false;
  static const bool editorLongPressMenuEnabled = false;
  static const bool editorLongPressLabelsEnabled = false;
  static const bool q42DragToMoveCursorStabilityAvailable = true;

  static const int transformTapSuppressionMs = 320;
  static const double panIntentSlop = 4.5;

  static const String tapUpSelectionSource = 'tap-up';
  static const String tapDownSelectionSource = 'tap-down';

  /// In short expressions there is no viewport pan competition, so tap-down can
  /// keep the cursor feeling instant.
  static bool shouldSelectOnTapDown({required bool viewportNavigationEnabled}) {
    return !viewportNavigationEnabled;
  }

  /// In long expressions InteractiveViewer needs the chance to claim a drag.
  /// Waiting for tap-up prevents the cursor from jumping when the user intended
  /// to pan the long equation.
  static bool shouldSelectOnTapUp({required bool viewportNavigationEnabled}) {
    return viewportNavigationEnabled;
  }

  /// Dragging directly moves the caret only when the viewport itself is not in
  /// horizontal navigation mode.  For long equations, drag means pan; tap still
  /// means cursor placement.
  static bool allowDragCaretUpdates({required bool viewportNavigationEnabled}) {
    return !viewportNavigationEnabled;
  }

  static Duration transformTapSuppressionDuration() {
    return const Duration(milliseconds: transformTapSuppressionMs);
  }
}
