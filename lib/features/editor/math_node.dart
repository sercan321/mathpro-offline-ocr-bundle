import 'package:flutter/foundation.dart';

/// MathPro's Flutter-side logical math model.
///
/// This is intentionally independent from the visual renderer. KaTeX/
/// flutter_math_fork may draw TeX, but MathPro owns nodes, slots, selection,
/// and future structural editing decisions.
enum MathNodeKind {
  text,
  number,
  symbol,
  constant,
  operatorToken,
  delimiter,
  box,
  row,
  fraction,
  sqrt,
  indexedRoot,
  power,
  subscript,
  integral,
  derivative,
  bigOperator,
  limit,
  logBase,
  functionCall,
  postfix,
  matrix,
  vector,
  piecewise,
  series,
  placeholder,
  unknown,
}

@immutable
class MathNode {
  const MathNode({
    required this.id,
    required this.kind,
    this.text,
    this.operator,
    this.children = const <MathNode>[],
    this.slots = const <String, MathNode>{},
    this.meta = const <String, Object?>{},
  });

  final String id;
  final MathNodeKind kind;
  final String? text;
  final String? operator;
  final List<MathNode> children;
  final Map<String, MathNode> slots;
  final Map<String, Object?> meta;

  bool get isBoxLike => kind == MathNodeKind.box || kind == MathNodeKind.placeholder;
  bool get isPlaceholder => kind == MathNodeKind.placeholder || (kind == MathNodeKind.box && children.isEmpty);

  MathNode? slot(String key) => slots[key];

  MathNode copyWith({
    String? id,
    MathNodeKind? kind,
    String? text,
    String? operator,
    List<MathNode>? children,
    Map<String, MathNode>? slots,
    Map<String, Object?>? meta,
  }) {
    return MathNode(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      text: text ?? this.text,
      operator: operator ?? this.operator,
      children: children ?? this.children,
      slots: slots ?? this.slots,
      meta: meta ?? this.meta,
    );
  }
}

class MathNodeIds {
  MathNodeIds._();

  static int _next = 0;

  static String create(String prefix) {
    _next += 1;
    return 'mp_${prefix}_$_next';
  }

  static void reset() {
    _next = 0;
  }
}
