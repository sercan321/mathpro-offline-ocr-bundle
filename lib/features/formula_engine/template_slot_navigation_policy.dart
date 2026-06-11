import '../editor/calculus_cursor_navigation_policy.dart';
import '../editor/matrix_cell_navigation_policy.dart';
import '../editor/slot_registry.dart';

/// V64 authority for deterministic template slot navigation.
///
/// The visual renderer, hit-test engine, and controller must agree on the same
/// order of open fields. This prevents the common mobile-editor failure where
/// the user fills one □ but focus jumps back to a previous or unrelated slot.
class TemplateSlotNavigationPolicy {
  const TemplateSlotNavigationPolicy._();

  static const String version = 'mathpro-v172i-template-slot-navigation-policy-calculus-matrix-system';

  static List<SlotEntry> orderedSlots(Iterable<SlotEntry> entries) {
    final slots = List<SlotEntry>.from(entries);
    slots.sort(compareSlots);
    return List<SlotEntry>.unmodifiable(slots);
  }

  static SlotEntry? slotAtOpenPlaceholderOrdinal(Iterable<SlotEntry> entries, int ordinal) {
    final slots = orderedSlots(entries);
    if (slots.isEmpty) return null;
    final safeOrdinal = ordinal.clamp(0, slots.length - 1).toInt();
    return slots[safeOrdinal];
  }

  static SlotEntry? nextSlotAfterFill({
    required Iterable<SlotEntry> entries,
    required int filledPlaceholderOrdinal,
  }) {
    final slots = orderedSlots(entries);
    if (slots.isEmpty) return null;

    // After a □ is filled, the next visible open slot shifts into the same
    // ordinal. If the filled slot was the last open slot, wrap to the first
    // remaining slot so the editor never leaves the user stranded.
    if (filledPlaceholderOrdinal >= 0 && filledPlaceholderOrdinal < slots.length) {
      return slots[filledPlaceholderOrdinal];
    }
    return slots.first;
  }

  static int compareSlots(SlotEntry a, SlotEntry b) {
    if (a.nodeId == b.nodeId && MatrixCellNavigationPolicy.isStructuralGridEntry(a) && MatrixCellNavigationPolicy.isStructuralGridEntry(b)) {
      return MatrixCellNavigationPolicy.compareStructuralEntries(a, b);
    }
    if (a.nodeId == b.nodeId && CalculusCursorNavigationPolicy.isCalculusEntry(a) && CalculusCursorNavigationPolicy.isCalculusEntry(b)) {
      return CalculusCursorNavigationPolicy.compareCalculusEntries(a, b);
    }

    final aHint = _placeholderOrderHint(a);
    final bHint = _placeholderOrderHint(b);
    final hint = aHint.compareTo(bHint);
    if (hint != 0) return hint;

    final aNode = _numericSuffix(a.nodeId);
    final bNode = _numericSuffix(b.nodeId);
    final node = aNode.compareTo(bNode);
    if (node != 0) return node;

    final aId = _numericSuffix(a.id);
    final bId = _numericSuffix(b.id);
    final id = aId.compareTo(bId);
    if (id != 0) return id;

    final depth = a.depth.compareTo(b.depth);
    if (depth != 0) return depth;
    return a.id.compareTo(b.id);
  }

  static int _placeholderOrderHint(SlotEntry entry) {
    // V84: this order must match the visual order of □ placeholders in the
    // rendered template string, not just the semantic importance of a role.
    // RenderMappedSlotHitTest, controller focus advancement and active slot
    // visibility all depend on this order.  The old policy put generic
    // functionArgument before logBase/integral limits, which could map the first
    // visible box in log_□(□) or ∫_{□}^{□}(□)d□ to the wrong semantic slot.
    return switch (entry.role) {
      'placeholder' => 0,
      'fractionNumerator' => 10,
      'fractionDenominator' => 11,
      'rootIndex' => 20,
      'sqrtValue' => 21,
      'powerBase' => 30,
      'powerExponent' => 31,
      'subscript' => 40,
      'subscriptBase' => 41,
      'logBase' => 50,
      'functionArgument' => 51,
      'integralLowerLimit' => 60,
      'integralUpperLimit' => 61,
      'integralBody' => 62,
      'integralDifferential' => 63,
      'derivativeOrder' => 70,
      'derivativeVariable' => 71,
      'derivativeBody' => 72,
      'limitVariable' => 80,
      'limitTarget' => 81,
      'limitBody' => 82,
      'sumLowerLimit' || 'productLowerLimit' => 90,
      'sumUpperLimit' || 'productUpperLimit' => 91,
      'sumBody' || 'productBody' => 92,
      'seriesVariable' => 100,
      'seriesIndex' => 101,
      'seriesOrder' => 102,
      'seriesCenter' => 103,
      'seriesParameter' => 104,
      'seriesCoefficient' => 105,
      'seriesRatio' => 106,
      'seriesFactorial' => 107,
      'matrixCell' => 120,
      'systemLeft' => 130,
      'systemRight' => 131,
      'piecewiseExpression' => 132,
      'piecewiseCondition' => 133,
      _ => 1000,
    };
  }

  static int _numericSuffix(String value) {
    final match = RegExp(r'(\d+)(?!.*\d)').firstMatch(value);
    return int.tryParse(match?.group(1) ?? '') ?? 0;
  }
}
