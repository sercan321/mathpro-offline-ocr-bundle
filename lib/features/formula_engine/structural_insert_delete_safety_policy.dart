/// V172-Q43 P6-locked structural insert/delete safety policy.
///
/// This policy does not alter keyboard, MORE, long-press, layout, Graph,
/// History, or Solution surfaces. It only declares the editor-side safety
/// rules for keeping typed edits scoped to the active structural slot.
class StructuralInsertDeleteSafetyPolicy {
  const StructuralInsertDeleteSafetyPolicy._();

  static const String version =
      'mathpro-v172q43-structural-insert-delete-safety-p6-locked-v1';

  static const bool structuralInsertDeleteSafetyAvailable = true;
  static const bool filledSlotInlineInsertEnabled = true;
  static const bool halfTokenLeakAllowed = false;
  static const bool atomicFunctionTailLeakAllowed = false;
  static const bool slotScopedBackspacePreferred = true;
  static const bool clearToRealPlaceholderWhenEmpty = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool p6VisualBaselineLocked = true;

  static const int requiredCorrectStructuralEditsPerTwenty = 19;

  static const Set<String> inlineEditableRoles = <String>{
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'fractionNumerator',
    'fractionDenominator',
    'powerExponent',
    'subscript',
    'logBase',
    'sqrtValue',
    'rootIndex',
    'integralLowerLimit',
    'integralUpperLimit',
    'integralBody',
    'integralDifferential',
    'limitVariable',
    'limitTarget',
    'limitBody',
    'matrixCell',
    'systemLeft',
    'systemRight',
    'piecewiseExpression',
    'piecewiseCondition',
    'sumUpperLimit',
    'sumLowerLimit',
    'sumBody',
    'productUpperLimit',
    'productLowerLimit',
    'productBody',
    'seriesVariable',
    'seriesIndex',
    'seriesOrder',
    'seriesCenter',
    'seriesParameter',
    'seriesCoefficient',
    'seriesRatio',
    'seriesFactorial',
    'postfixTarget',
    'derivativeBody',
    'derivativeVariable',
  };

  static bool shouldInsertInsideFilledSlot({
    required String slotRole,
    required String payload,
    required String insertedText,
  }) {
    final cleanPayload = payload.trim();
    final cleanInserted = insertedText.trim();
    if (cleanInserted.isEmpty) return false;
    if (cleanPayload.isEmpty || cleanPayload == '□') return false;
    return inlineEditableRoles.contains(slotRole);
  }

  static int safePayloadCaretIndex(String payload, int caretIndex) {
    return caretIndex.clamp(0, payload.length).toInt();
  }

  static bool containsBrokenAtomicTail(String expression) {
    final compact = expression.replaceAll(' ', '');
    return compact.endsWith('sin(') ||
        compact.endsWith('cos(') ||
        compact.endsWith('tan(') ||
        compact.endsWith('ln(') ||
        compact.endsWith('log(') ||
        compact.endsWith('si') ||
        compact.endsWith('co') ||
        compact.endsWith('ta');
  }
}
