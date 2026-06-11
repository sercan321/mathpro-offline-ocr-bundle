import 'package:flutter/foundation.dart';

/// V172-Q227 guardrail for the Solution Steps panel visual simplification.
///
/// This phase is intentionally UI-only: it keeps the existing panel mechanics,
/// solver honesty, keyboard, MathLive route, graph, history, and MORE behavior
/// unchanged while the solution content is rendered as one calm surface.
@immutable
class SolutionStepsSingleSurfaceCleanupPolicy {
  const SolutionStepsSingleSurfaceCleanupPolicy._();

  static const String phase = 'V172-Q227-SOLUTION-STEPS-SINGLE-SURFACE-CLEANUP';
  static const String emptyIdleMessage = 'İfade girildiğinde çözüm adımları burada görünür.';
  static const String expressionWithoutStepsMessage = 'Bu ifade için çözüm adımı yok.';

  static const bool singlePanelSurfaceOnly = true;
  static const bool tutorialEmptyCardsRemoved = true;
  static const bool headerStatusSubtitleRemoved = true;
  static const bool stepCardsNestedInPanelAllowed = false;
  static const bool inlineMathLaneKept = true;
  static const bool internalScrollKept = true;
  static const bool mediumExpandedMechanicsKept = true;
  static const bool dragMechanicsKept = true;

  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionRouteMutationAllowed = false;
  static const bool graphMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solverMutationAllowed = false;
}
