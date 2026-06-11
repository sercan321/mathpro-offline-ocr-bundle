import '../features/formula_engine/math_expression_render_bridge.dart';
import '../features/formula_engine/unified_math_preview_policy.dart';
import 'mathpro_regression_gate.dart';
import 'mathpro_real_log_parser_gate.dart';
import 'real_device_ux_readiness_gate.dart';

/// Final release-evidence guard for MathPro editor phases.
///
/// This class intentionally does not run Flutter or a physical device. It
/// defines the evidence contract that must be satisfied before a future report
/// may claim real-device PASS, Photomath-like visual progress, or release-grade
/// confidence. Keeping the checklist in code prevents the recurring failure
/// mode where analyze/test passes but fraction/log/limit/cursor behavior is
/// still broken on the user's Android device.
class MathProReleaseEvidenceGate {
  const MathProReleaseEvidenceGate._();

  static const String version = 'mathpro-v108-release-evidence-hardening';

  static const List<String> requiredFlutterCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> requiredEvidenceItems = <String>[
    'pub-get-log',
    'analyze-log',
    'test-log',
    'real-device-run-log',
    'fraction-edit-delete-screen-recording',
    'log-base-screen-recording',
    'limit-slot-screen-recording',
    'sum-product-series-screen-recording',
    'long-nested-cursor-screen-recording',
    'longpress-popup-screen-recording',
    'more-panel-full-scan-screen-recording',
    'keyboard-contract-screenshot',
  ];

  static const List<ReleaseCriticalScenario> criticalScenarios = <ReleaseCriticalScenario>[
    ReleaseCriticalScenario(
      id: 'fraction-filled-edit-delete',
      surface: 'workspace/editor',
      expression: '3⁄4',
      expected: 'Pay ve payda ayrı ayrı seçilir, silinir ve değiştirilir; kesir düz text veya ölü slot olmaz.',
      requiredEvidenceItem: 'fraction-edit-delete-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'log-base-filled-edit',
      surface: 'workspace/editor+MORE/log',
      expression: 'log₂(5)',
      expected: 'Base slotu 2 olarak gerçek subscript/base konumunda görünür ve sonradan değiştirilebilir.',
      requiredEvidenceItem: 'log-base-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'limit-variable-target-body',
      surface: 'workspace/editor+Kalkülüs/lim',
      expression: 'lim₍y→8₎(8)',
      expected: 'Variable, target ve body ayrı slotlar olarak tıklanır; lim_y → 8(8) UI’a sızmaz.',
      requiredEvidenceItem: 'limit-slot-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'sum-product-series-slot-overlay',
      surface: 'workspace/editor+Kalkülüs/ΣΠ',
      expression: 'Σ_{i=1}^{n}(x), Π_{i=1}^{n}(x)',
      expected: 'Lower, upper ve body slotları ayrı seçilir; dev yeşil overlay sembol/body üstüne binmez.',
      requiredEvidenceItem: 'sum-product-series-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'long-nested-cursor-pan',
      surface: 'workspace/editor-viewport',
      expression: 'ln(√(log₂(3⁄4)+sin⁻¹(x)))',
      expected: 'Uzun/iç içe ifadede pan sonrası cursor mantıklı slotta kalır ve görünür alana takip eder.',
      requiredEvidenceItem: 'long-nested-cursor-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'longpress-popup-no-clipping',
      surface: 'longPress/log+trig+root+integral',
      expression: 'log₁₀(□), sin⁻¹(□), ∫_{□}^{□}(□)d□, ⁿ√(□)',
      expected: 'Kartlar kırpılmaz; base/argument/slot ilişkisi optik olarak bağlı ve premium görünür.',
      requiredEvidenceItem: 'longpress-popup-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'more-panel-full-scan',
      surface: 'MORE/all',
      expression: 'Fonksiyon, Kalkülüs, Cebir, Kompleks, Lineer Cebir',
      expected: 'MORE chiplerinde ham token, taşma, kırpılma, debug label veya eski programmer syntax görünmez.',
      requiredEvidenceItem: 'more-panel-full-scan-screen-recording',
    ),
    ReleaseCriticalScenario(
      id: 'keyboard-contract-visual-lock',
      surface: 'keyboard/all-tabs',
      expression: 'Temel+Cebir+Kalkülüs+Kompleks+Lineer Cebir',
      expected: 'Tab sırası, MORE, Ans, ↵, = ve tuş konumları değişmemiştir.',
      requiredEvidenceItem: 'keyboard-contract-screenshot',
    ),
  ];

  static const List<String> criticalPreviewExpressions = <String>[
    'asin(□)',
    'acos(□)',
    'atan(□)',
    'log_10(□)',
    'log(2)(5)',
    'lim_y → 8(8)',
    'x_n',
    '3⁄4',
    'Σ_{i=1}^{n}(x)',
    'Π_{i=1}^{n}(x)',
    '{x≤1;y≤2}',
  ];

  static Set<String> get requiredScenarioIds => <String>{
        for (final scenario in criticalScenarios) scenario.id,
      };

  static Set<String> get requiredEvidenceSet => requiredEvidenceItems.toSet();

  static ReleaseEvidenceVerdict evaluateStaticPreflight() {
    final blockers = <String>[];
    final warnings = <String>[
      'Static preflight is not a real-device PASS. Physical-device evidence is still required.',
    ];

    final canonicalKnownLabels = MathProRegressionGate.knownVisibleLabels()
        .map(UnifiedMathPreviewPolicy.canonicalPreviewLabel)
        .toList(growable: false);
    blockers.addAll(MathProRegressionGate.releaseGateFindings(visibleLabels: canonicalKnownLabels));
    blockers.addAll(RealDeviceUxReadinessGate.staticPreflightBlockers());

    for (final expression in criticalPreviewExpressions) {
      final canonical = UnifiedMathPreviewPolicy.canonicalPreviewLabel(expression);
      if (MathProRegressionGate.hasForbiddenVisibleToken(canonical)) {
        blockers.add('critical-preview-token-leak:$expression->$canonical');
      }
      final bridgeCanonical = MathExpressionRenderBridge.canonicalDisplayExpression(expression);
      if (MathProRegressionGate.hasForbiddenVisibleToken(bridgeCanonical)) {
        blockers.add('critical-bridge-token-leak:$expression->$bridgeCanonical');
      }
    }

    return ReleaseEvidenceVerdict(
      passClaimAllowed: false,
      blockers: _uniqueSorted(blockers),
      warnings: warnings,
    );
  }



  static ReleaseEvidenceVerdict evaluateRealLogEvidence({
    required String pubGetLog,
    required String analyzeLog,
    required String testLog,
    required String runLog,
    String targetDeviceId = '23106RN0DA',
  }) {
    final logVerdict = MathProRealLogParserGate.evaluateAllRequiredLogs(
      pubGetLog: pubGetLog,
      analyzeLog: analyzeLog,
      testLog: testLog,
      runLog: runLog,
      targetDeviceId: targetDeviceId,
    );
    final blockers = <String>[...logVerdict.blockers];
    final warnings = <String>[
      ...logVerdict.warnings,
      'Real logs can prove command cleanliness, but visual PASS still requires the V108 manual device scenarios.',
    ];
    return ReleaseEvidenceVerdict(
      passClaimAllowed: false,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static ReleaseEvidenceVerdict evaluateManualEvidence({
    required bool pubGetPassed,
    required bool analyzePassed,
    required bool testPassed,
    required bool realDeviceRunLaunched,
    required Set<String> completedScenarioIds,
    required Set<String> attachedEvidenceItems,
    required bool noVisibleTokenLeakConfirmed,
    required bool keyboardContractConfirmed,
    required bool cursorOverlayConfirmedNotHuge,
    bool includeStaticPreflight = true,
  }) {
    final blockers = <String>[];
    final warnings = <String>[];

    if (includeStaticPreflight) blockers.addAll(evaluateStaticPreflight().blockers);

    if (!pubGetPassed) blockers.add('missing-or-failed-command:flutter pub get');
    if (!analyzePassed) blockers.add('missing-or-failed-command:flutter analyze');
    if (!testPassed) blockers.add('missing-or-failed-command:flutter test');
    if (!realDeviceRunLaunched) blockers.add('missing-or-failed-command:flutter run -d 23106RN0DA');

    final missingScenarioIds = requiredScenarioIds.difference(completedScenarioIds);
    if (missingScenarioIds.isNotEmpty) {
      blockers.add('missing-critical-scenarios:${_sortedJoin(missingScenarioIds)}');
    }

    final scenarioEvidenceItems = <String>{
      for (final scenario in criticalScenarios) scenario.requiredEvidenceItem,
    };
    final missingEvidenceItems = requiredEvidenceSet.union(scenarioEvidenceItems).difference(attachedEvidenceItems);
    if (missingEvidenceItems.isNotEmpty) {
      blockers.add('missing-release-evidence:${_sortedJoin(missingEvidenceItems)}');
    }

    if (!noVisibleTokenLeakConfirmed) blockers.add('visual-token-leak-confirmation-missing');
    if (!keyboardContractConfirmed) blockers.add('keyboard-contract-confirmation-missing');
    if (!cursorOverlayConfirmedNotHuge) blockers.add('cursor-overlay-real-device-confirmation-missing');

    if (blockers.isEmpty) {
      warnings.add('Evidence contract is satisfied. Keep logs, screenshots and recordings attached to the release report; this function still does not run the device by itself.');
    } else {
      warnings.add('Do not claim real-device PASS until every blocker is closed with attached evidence.');
    }

    return ReleaseEvidenceVerdict(
      passClaimAllowed: blockers.isEmpty,
      blockers: _uniqueSorted(blockers),
      warnings: warnings,
    );
  }

  static List<String> _uniqueSorted(Iterable<String> values) {
    final unique = values.where((value) => value.trim().isNotEmpty).toSet().toList(growable: false);
    unique.sort();
    return unique;
  }

  static String _sortedJoin(Iterable<String> values) {
    final sorted = values.toList(growable: false)..sort();
    return sorted.join(',');
  }
}

class ReleaseCriticalScenario {
  const ReleaseCriticalScenario({
    required this.id,
    required this.surface,
    required this.expression,
    required this.expected,
    required this.requiredEvidenceItem,
  });

  final String id;
  final String surface;
  final String expression;
  final String expected;
  final String requiredEvidenceItem;
}

class ReleaseEvidenceVerdict {
  const ReleaseEvidenceVerdict({
    required this.passClaimAllowed,
    required this.blockers,
    required this.warnings,
  });

  final bool passClaimAllowed;
  final List<String> blockers;
  final List<String> warnings;
}
