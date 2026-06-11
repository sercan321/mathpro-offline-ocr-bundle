/// V172-Q169R7 — MathLive Mathfield Value API Guard.
///
/// Real-device Q169R6 evidence showed progress from `JS:pending` to
/// `JS:fire`, but the bridge still reported `INSERT:false`, `VALUE:empty`,
/// and `PAINT:pending` while `MF:true` proved the MathLive field existed.
/// Q169R7 hardens the JS bridge around MathLive value API variance: reads of
/// getValue('latex-expanded') / getValue('latex') / getValue() / value are
/// guarded, and an empty post-insert value is force-committed through the
/// official math-field value surface using sanitized document LaTeX. This is
/// still not a real-device PASS claim; it is a narrow insert/value commit
/// repair and does not change protected UI surfaces.
class MathLiveMathfieldValueApiGuardPolicy {
  const MathLiveMathfieldValueApiGuardPolicy._();

  static const String phase = 'V172-Q169R7';
  static const String repairName = 'MathLive Mathfield Value API Guard';

  static const bool guardMathfieldGetValueVariants = true;
  static const bool forceDocumentCommitWhenPostInsertValueEmpty = true;
  static const bool rawInsertTokensMayBeCommittedToVisibleSurface = false;
  static const bool realDevicePaintPassClaimed = false;
}
