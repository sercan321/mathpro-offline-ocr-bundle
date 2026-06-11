/// V172-Q75 — Native structural edit transaction binding.
///
/// The cursor fixes are not useful if the selected SlotBox is lost when the
/// user types.  Q75 binds insert/delete/replace operations to the selected
/// structural slot id and keeps eligible filled slots structurally active after
/// an edit.  This prevents a correct tap such as `sin(|□)` or `log_|□(□)` from
/// collapsing into a detached linear caret after the first character.
class NativeStructuralEditTransactionBindingPolicy {
  const NativeStructuralEditTransactionBindingPolicy._();

  static const String version =
      'mathpro-v172q75-native-structural-edit-transaction-binding-v1';

  static const bool nativeStructuralEditTransactionBindingAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool activeSlotIdRequiredForStructuralEdit = true;
  static const bool openSlotFillKeepsStructuralFocus = true;
  static const bool singleFunctionArgumentFillUsesInlineLinearCaret = true;
  static const bool filledSlotInsertKeepsStructuralFocus = true;
  static const bool filledSlotBackspaceKeepsStructuralFocus = true;
  static const bool structuralEditMayExitToDetachedLinearCaret = false;
  static const bool functionArgumentAutoExitAfterFirstDigitAllowed = false;
  static const String structuralEditLaw =
      'tap slot -> SlotBox id -> edit same slot id -> keep structural caret unless user explicitly exits';

  static const Set<String> persistentPayloadRoles = <String>{
    'fractionNumerator',
    'fractionDenominator',
    'powerBase',
    'powerExponent',
    'subscriptBase',
    'subscript',
    'rootIndex',
    'sqrtValue',
    'logBase',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
    'limitVariable',
    'limitTarget',
    'limitBody',
    'sumUpperLimit',
    'sumLowerLimit',
    'sumBody',
    'productUpperLimit',
    'productLowerLimit',
    'productBody',
    'matrixCell',
    'systemLeft',
    'systemRight',
    'piecewiseExpression',
    'piecewiseCondition',
  };

  static bool shouldBindTextToActiveSlot({
    required bool hasActiveSlot,
    required String? activeSlotId,
  }) {
    return hasActiveSlot && activeSlotId != null && activeSlotId.isNotEmpty;
  }

  static bool shouldUseInlineLinearCaretAfterOpenSlotFill({
    required String? role,
    required bool singleOpenSlot,
  }) {
    return singleOpenSlot && role == 'functionArgument';
  }

  static bool shouldKeepStructuralFocusAfterOpenSlotFill({
    required String? role,
    required bool singleOpenSlot,
  }) {
    if (!singleOpenSlot) return false;
    if (shouldUseInlineLinearCaretAfterOpenSlotFill(role: role, singleOpenSlot: singleOpenSlot)) return false;
    return role != null && persistentPayloadRoles.contains(role);
  }

  static bool shouldKeepStructuralFocusAfterFilledSlotEdit({required String? role}) {
    return role != null && persistentPayloadRoles.contains(role);
  }

  static int caretIndexAfterInsert({
    required int previousCaretIndex,
    required String insertedText,
  }) {
    final safePrevious = previousCaretIndex < 0 ? 0 : previousCaretIndex;
    return safePrevious + insertedText.runes.length;
  }

  static int caretIndexAfterOpenSlotFill(String insertedText) => insertedText.runes.length;

  static int caretIndexAfterBackspace({required int previousCaretIndex}) {
    if (previousCaretIndex <= 0) return 0;
    return previousCaretIndex - 1;
  }

  static String sourceFor(String operation) => 'v172q75-native-slot-transaction:$operation';
}
