import 'package:flutter/foundation.dart';

@immutable
class MathKeyCell {
  const MathKeyCell(this.label, {this.span = 1});

  final String? label;
  final int span;

  bool get isEmpty => label == null;
}

class KeyboardSections {
  const KeyboardSections.basic(this.coreRows) : expandedGridRows = null;
  const KeyboardSections.expanded(this.expandedGridRows) : coreRows = null;

  final List<List<MathKeyCell>>? coreRows;
  final List<List<MathKeyCell>>? expandedGridRows;

  bool get isBasic => coreRows != null;
}

enum KeyBehaviorType {
  textInsert,
  structureInsert,
  wrapper,
  postfix,
  command,
}

class KeyBehavior {
  const KeyBehavior._();

  static const Map<String, KeyBehaviorType> commandKeys = {
    'C': KeyBehaviorType.command,
    '⌫': KeyBehaviorType.command,
    '↵': KeyBehaviorType.command,
    'MORE': KeyBehaviorType.command,
    'Ans': KeyBehaviorType.command,
  };
}
