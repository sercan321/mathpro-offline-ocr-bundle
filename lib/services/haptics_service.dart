import 'package:flutter/services.dart';

/// Small, dependency-free Flutter equivalent of the React Native Expo haptics
/// calls used by the original MathPro PremiumKey.
///
/// Haptic APIs may be ignored by some simulators, browsers, or devices. The
/// service deliberately swallows platform errors so a key press never fails just
/// because vibration feedback is unavailable.
class HapticsService {
  const HapticsService._();

  static Future<void> lightImpact() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (_) {
      // Haptics are non-critical. Input must continue even when unavailable.
    }
  }

  static Future<void> mediumImpact() async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (_) {
      // Haptics are non-critical. Input must continue even when unavailable.
    }
  }

  static Future<void> selectionClick() async {
    try {
      await HapticFeedback.selectionClick();
    } catch (_) {
      // Haptics are non-critical. Input must continue even when unavailable.
    }
  }
}
