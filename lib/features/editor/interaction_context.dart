import 'package:flutter/foundation.dart';

import 'cursor_anchor.dart';

@immutable
class EditorInteractionContext {
  const EditorInteractionContext({
    this.activeSlotId,
    this.activeSlotRole,
    this.caretIndex = 0,
    this.lastHitSource = 'none',
    this.linearCaretIndex,
    this.cursorAnchor,
  });

  final String? activeSlotId;
  final String? activeSlotRole;
  final int caretIndex;
  final String lastHitSource;
  final int? linearCaretIndex;
  final CursorAnchor? cursorAnchor;

  bool get hasActiveSlot => activeSlotId != null;
  bool get hasLinearCaret => linearCaretIndex != null;
  bool get hasCursorAnchor => cursorAnchor != null;

  String get userSelectionLabel => hasActiveSlot ? 'Aktif alan' : '';

  EditorInteractionContext copyWith({
    String? activeSlotId,
    String? activeSlotRole,
    int? caretIndex,
    String? lastHitSource,
    int? linearCaretIndex,
    CursorAnchor? cursorAnchor,
    bool clearActiveSlot = false,
    bool clearLinearCaret = false,
  }) {
    return EditorInteractionContext(
      activeSlotId: clearActiveSlot ? null : activeSlotId ?? this.activeSlotId,
      activeSlotRole: clearActiveSlot ? null : activeSlotRole ?? this.activeSlotRole,
      caretIndex: caretIndex ?? this.caretIndex,
      lastHitSource: lastHitSource ?? this.lastHitSource,
      linearCaretIndex: clearLinearCaret ? null : linearCaretIndex ?? this.linearCaretIndex,
      cursorAnchor: cursorAnchor ?? ((clearActiveSlot && clearLinearCaret) ? null : this.cursorAnchor),
    );
  }
}
