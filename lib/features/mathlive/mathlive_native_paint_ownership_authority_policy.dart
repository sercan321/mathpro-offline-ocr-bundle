/// V172-Q169R27 — Native Paint Ownership Authority.
///
/// Native MathLive paint may be considered successful only when the real
/// <math-field> owns a non-empty native value and reports a visible, non-zero
/// paint surface. Flutter fallback text, controller mirror text, or host
/// sanitized fallback text must never upgrade VALUE/PAINT to success.
class MathLiveNativePaintOwnershipAuthorityPolicy {
  const MathLiveNativePaintOwnershipAuthorityPolicy._();

  static const String phase = 'V172-Q169R27';
  static const String nativeOwner = 'mathlive-native-field';
  static const String fallbackOwner = 'not-native-owned';
  static const bool realDevicePaintPassClaimed = false;

  static bool nativePaintOwnsSurface({
    required String nativePaintState,
    required bool valueNonEmpty,
    required String nativePaintOwner,
  }) {
    return nativePaintState == 'ok' &&
        valueNonEmpty &&
        nativePaintOwner == nativeOwner;
  }

  static String visiblePaint({
    required String nativePaintState,
    required String nativePaintOwner,
  }) {
    if (nativePaintState == 'ok' && nativePaintOwner == nativeOwner) {
      return 'ok';
    }
    if (nativePaintState == 'fail') return 'fail';
    return 'pending';
  }

  static String rootCauseForNonNativePaint({
    required String currentRootCause,
    required String nativePaintState,
    required String nativePaintOwner,
  }) {
    if (currentRootCause.trim().isNotEmpty && currentRootCause != 'none') {
      return currentRootCause;
    }
    if (nativePaintState == 'ok' && nativePaintOwner != nativeOwner) {
      return 'native-paint-not-owned-by-mathlive';
    }
    return 'native-paint-not-ok:$nativePaintState';
  }
}
