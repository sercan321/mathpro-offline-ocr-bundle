import 'package:flutter/foundation.dart';

/// V172-Q228 guardrail for premium copy polish in the Solution Steps panel.
///
/// This is copy-only. It must not change solver capability, panel mechanics,
/// keyboard, MORE, long-press, MathLive, graph, history, workspace coordination,
/// or the Q227 single-surface list architecture.
@immutable
class SolutionStepsPremiumCopyPolishPolicy {
  const SolutionStepsPremiumCopyPolishPolicy._();

  static const String phase = 'V172-Q228-SOLUTION-STEPS-PREMIUM-COPY-POLISH';

  static const String emptyIdleMessage = 'İfade girildiğinde çözüm adımları burada görünür.';
  static const String expressionWithoutStepsMessage = 'Bu ifade için çözüm adımı yok.';

  static const List<String> preferredCoreStepTitles = <String>[
    'İfade alındı',
    'İşlem değerlendirildi',
    'Sonuç',
  ];

  static const bool copyOnly = true;
  static const bool singleSurfaceLayoutKept = true;
  static const bool nestedStepCardsAllowed = false;
  static const bool longTechnicalCopyAllowed = false;
  static const bool headerSubtitleAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionRouteMutationAllowed = false;
  static const bool graphMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool workspaceLayoutMutationAllowed = false;
}
