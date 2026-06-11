import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_shadow_observer_feedback_loop_repair_policy.dart';

void main() {
  test('V172-Q169R36 shadow observer feedback loop repair is package-side locked', () {
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.phase, 'V172-Q169R36');
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.shadowRootObserverMayWatchAttributes, isFalse);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.shadowRootObserverIsDebounced, isTrue);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.shadowRootObserverIsInstalledOncePerField, isTrue);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.chromeSuppressionMayMutateInsideObserverSynchronously, isFalse);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.mathLiveRuntimeBootMustRemainSingleFile, isTrue);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.fallbackRenderingMayNotClaimPaintPass, isTrue);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.touchesKeyboardLayout, isFalse);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.touchesAppShell, isFalse);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.touchesGraphHistorySolution, isFalse);
    expect(MathLiveShadowObserverFeedbackLoopRepairPolicy.claimsRealDevicePaintPass, isFalse);

    final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
    expect(bridge, contains("shadowObserverFeedbackLoopRepairPhase: 'V172-Q169R36'"));
    expect(bridge, contains('function q169R36ScheduleChromeSuppression'));
    expect(bridge, contains('function q169R36InstallShadowChromeObserver'));
    expect(bridge, contains('q169R36ChromeObserverFields'));
    expect(bridge, contains("chromeObserver.observe(root, { childList: true, subtree: true })"));
    expect(bridge, isNot(contains('attributes: true')));
    expect(bridge, isNot(contains('new MutationObserver(function () { hideMathLiveChrome(field); suppressVisibleMathLiveBranding(field); })')));

    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html, contains('data-q169r36-shadow-observer-feedback-loop-repair="true"'));
    expect(html, contains("window.MathProShadowObserverFeedbackLoopRepair = { phase: 'V172-Q169R36'"));
    expect(html, contains("shadowObserverFeedbackLoopRepairPhase: 'V172-Q169R36'"));
    expect(html, contains("chromeObserver.observe(root, { childList: true, subtree: true })"));
    expect(html, isNot(contains('chromeObserver.observe(field.shadowRoot, { childList: true, subtree: true, attributes: true })')));
  });
}
