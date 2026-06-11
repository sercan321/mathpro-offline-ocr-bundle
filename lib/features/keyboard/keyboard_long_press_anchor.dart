import 'dart:ui';

/// Runtime-only geometry payload for anchoring the long-press popup to the
/// physical key that opened it. It does not alter keyboard inventory, key order,
/// labels, command routing, or long-press option lists.
class KeyboardLongPressAnchor {
  const KeyboardLongPressAnchor({
    required this.label,
    required this.globalCenter,
    required this.globalRect,
  });

  final String label;
  final Offset globalCenter;
  final Rect globalRect;
}
