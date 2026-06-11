import 'package:flutter/foundation.dart';

import 'slot_registry.dart';

/// Canonical cursor address for the MathPro editor.
///
/// The production caret may still be painted as a visual rect, but the cursor
/// must be representable as a mathematical address: a linear row offset or a
/// structural node/slot/offset. V172-C starts this contract so later phases can
/// move fraction, power, log, matrix, system and ODE editing away from raw
/// screen pixels.
@immutable
class CursorAnchor {
  const CursorAnchor._({
    required this.kind,
    required this.offset,
    required this.affinity,
    required this.source,
    this.nodeId,
    this.slotId,
    this.slotKey,
    this.slotRole,
  });

  final CursorAnchorKind kind;
  final String? nodeId;
  final String? slotId;
  final String? slotKey;
  final String? slotRole;
  final int offset;
  final CursorAffinity affinity;
  final String source;

  bool get isLinear => kind == CursorAnchorKind.linear;
  bool get isStructuralSlot => kind == CursorAnchorKind.structuralSlot;

  factory CursorAnchor.linear({
    required int offset,
    required int expressionLength,
    required String source,
    CursorAffinity affinity = CursorAffinity.after,
  }) {
    return CursorAnchor._(
      kind: CursorAnchorKind.linear,
      offset: offset.clamp(0, expressionLength).toInt(),
      affinity: affinity,
      source: source,
    );
  }

  factory CursorAnchor.slot({
    required SlotEntry entry,
    required int offset,
    required String source,
    CursorAffinity affinity = CursorAffinity.after,
  }) {
    // V172-D: structural slots are no longer limited to a binary before/after
    // edge. Filled fraction denominators, exponents and subscripts may contain
    // multiple glyphs, so the anchor must preserve the exact slot-local offset
    // chosen by hit testing. Clamping to 0..1 made 12/345-style editing feel
    // like a coarse toggle instead of a real math cursor.
    return CursorAnchor._(
      kind: CursorAnchorKind.structuralSlot,
      nodeId: entry.nodeId,
      slotId: entry.id,
      slotKey: entry.slotKey,
      slotRole: entry.role,
      offset: offset < 0 ? 0 : offset,
      affinity: affinity,
      source: source,
    );
  }

  CursorAnchor copyWith({
    int? offset,
    CursorAffinity? affinity,
    String? source,
  }) {
    return CursorAnchor._(
      kind: kind,
      nodeId: nodeId,
      slotId: slotId,
      slotKey: slotKey,
      slotRole: slotRole,
      offset: offset ?? this.offset,
      affinity: affinity ?? this.affinity,
      source: source ?? this.source,
    );
  }

  String get auditLabel {
    if (isLinear) return 'linear@$offset/$affinity';
    return '${nodeId ?? '-'}:${slotKey ?? '-'}@$offset/$affinity';
  }

  @override
  String toString() => 'CursorAnchor($auditLabel, source: $source)';

  @override
  bool operator ==(Object other) {
    return other is CursorAnchor &&
        other.kind == kind &&
        other.nodeId == nodeId &&
        other.slotId == slotId &&
        other.slotKey == slotKey &&
        other.slotRole == slotRole &&
        other.offset == offset &&
        other.affinity == affinity &&
        other.source == source;
  }

  @override
  int get hashCode => Object.hash(kind, nodeId, slotId, slotKey, slotRole, offset, affinity, source);
}

enum CursorAnchorKind { linear, structuralSlot }

enum CursorAffinity { before, after }
