import 'pixel_qa_cursor_matrix_policy.dart';
import 'real_device_slot_test_protocol.dart';

/// V172-Q45 real-device pixel QA court.
///
/// This is an evidence gate, not a fake PASS switch. It locks the exact
/// physical-device cursor matrix that must be filmed/screenshot-tested before
/// MathPro can honestly claim +95 / Photomath-Wolfram-level cursor behavior.
/// P6 visual/keyboard files remain locked; this policy does not touch UI
/// surfaces, keycaps, MORE, long-press, Graph, History, or Solution.
class RealDevicePixelQACourtPolicy {
  const RealDevicePixelQACourtPolicy._();

  static const String version = 'mathpro-v172q45-real-device-pixel-qa-court';
  static const bool realDevicePixelQACourtAvailable = true;
  static const bool finalPlus95CursorPassClaimed = false;
  static const bool photomathWolframLevelClaimed = false;
  static const bool p6VisualBaselineLocked = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const int attemptsPerScenario = 20;
  static const int requiredCorrectPerScenario = 19;
  static const double requiredOverallSuccessRate = 0.95;
  static const String targetDeviceId = RealDeviceSlotTestProtocol.targetDeviceId;

  static const List<String> requiredFlutterCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> requiredEvidenceTypes = <String>[
    'screen recording showing tap point and cursor destination',
    'close-up screenshots for compact roles',
    'flutter analyze log',
    'flutter test log',
    'pubspec identity screenshot or command output',
  ];

  static const List<RealDevicePixelQACase> courtCases = <RealDevicePixelQACase>[
    RealDevicePixelQACase(
      id: 'placeholder-safe-sqrt',
      expression: '√□',
      expectedRoles: <String>['sqrtValue'],
      acceptance: 'Caret must not overlap or hide the placeholder box; radicand slot must be selected.',
    ),
    RealDevicePixelQACase(
      id: 'script-exponent-compact-caret',
      expression: 'x^□ and x^12',
      expectedRoles: <String>['powerExponent'],
      acceptance: 'Exponent taps must stay in exponent lane and use compact cursor height.',
    ),
    RealDevicePixelQACase(
      id: 'script-subscript-compact-caret',
      expression: 'x_□ and x_89',
      expectedRoles: <String>['subscript'],
      acceptance: 'Subscript taps must stay in subscript lane and use compact cursor height.',
    ),
    RealDevicePixelQACase(
      id: 'fraction-numerator-denominator-lanes',
      expression: '9/6, 12/345, 123/4567',
      expectedRoles: <String>['fractionNumerator', 'fractionDenominator'],
      acceptance: 'Numerator and denominator must not cross-select; local caret positions must remain scoped.',
    ),
    RealDevicePixelQACase(
      id: 'log-base-argument-lanes',
      expression: 'log₂(500), log_□(□)',
      expectedRoles: <String>['logBase', 'functionArgument'],
      acceptance: 'Log base uses compact cursor; log argument remains independently selectable.',
    ),
    RealDevicePixelQACase(
      id: 'root-index-radicand-lanes',
      expression: '³√27, ⁿ√x, √123',
      expectedRoles: <String>['rootIndex', 'sqrtValue'],
      acceptance: 'Root index and radicand must remain separate targets with role-aware cursor size.',
    ),
    RealDevicePixelQACase(
      id: 'digit-level-caret-stops',
      expression: '123456789, cos(99666655), sin(300), ln(123456)',
      expectedRoles: <String>['linear', 'functionArgument'],
      acceptance: 'Digit gaps must place caret between glyphs rather than on top of glyphs or outside parentheses.',
    ),
    RealDevicePixelQACase(
      id: 'nested-depth-resolution',
      expression: 'ln(ln(8)), sin(cos(300)), √(sin(x)+log₂(500))',
      expectedRoles: <String>['functionArgument', 'logBase', 'sqrtValue'],
      acceptance: 'Deepest valid slot should win; parent function/root slot must not steal child targets.',
    ),
    RealDevicePixelQACase(
      id: 'drag-to-move-stability',
      expression: 'sin(300)+cos(400)+log₂(500)+√(600)',
      expectedRoles: <String>['functionArgument', 'logBase', 'sqrtValue'],
      acceptance: 'Drag must not jump to beginning/end or jitter across compact slots; horizontal pan conflict must be controlled.',
    ),
    RealDevicePixelQACase(
      id: 'structural-insert-delete-safety',
      expression: 'sin(3|00), log₂(5|00), x^(1|2), 12/3|45',
      expectedRoles: <String>['functionArgument', 'logBase', 'powerExponent', 'fractionDenominator'],
      acceptance: 'Insertion and deletion must remain slot-scoped; half tokens such as si or ln( must not leak.',
    ),
  ];

  static bool casePass(int correct, {int attempts = attemptsPerScenario}) {
    return attempts == attemptsPerScenario && correct >= requiredCorrectPerScenario && correct <= attempts;
  }

  static double successRate({required int correct, int attempts = attemptsPerScenario}) {
    if (attempts <= 0) return 0;
    return correct / attempts;
  }

  static bool hasRequiredCaseCoverage() {
    final roles = courtCases.expand((item) => item.expectedRoles).toSet();
    return <String>[
      'linear',
      'functionArgument',
      'fractionNumerator',
      'fractionDenominator',
      'powerExponent',
      'subscript',
      'logBase',
      'sqrtValue',
      'rootIndex',
    ].every(roles.contains);
  }

  static bool referencesExistingPixelMatrix() {
    return PixelQACursorMatrixPolicy.coversAllRequiredRoleFamilies();
  }
}

class RealDevicePixelQACase {
  const RealDevicePixelQACase({
    required this.id,
    required this.expression,
    required this.expectedRoles,
    required this.acceptance,
  });

  final String id;
  final String expression;
  final List<String> expectedRoles;
  final String acceptance;
}
