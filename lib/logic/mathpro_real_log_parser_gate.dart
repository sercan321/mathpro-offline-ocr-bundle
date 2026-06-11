/// Real-log classifier for MathPro release evidence.
///
/// This gate deliberately does not execute Flutter. It parses logs pasted or
/// attached after the user runs the required commands and keeps PASS language
/// tied to concrete output. Real-device visual quality still requires manual
/// scenario evidence; a successful `flutter run` launch is not a visual PASS.
class MathProRealLogParserGate {
  const MathProRealLogParserGate._();

  static const String version = 'mathpro-v109-real-log-parser-gate';

  static RealLogCommandVerdict evaluatePubGetLog(String log) {
    final normalized = _normalize(log);
    final blockers = <String>[];
    final warnings = <String>[];

    if (normalized.isEmpty) {
      blockers.add('pub-get-log-empty');
    }
    if (_hasFailureMarker(normalized) || normalized.contains('because every version of') || normalized.contains('version solving failed')) {
      blockers.add('pub-get-log-contains-failure');
    }
    final hasSuccessSignal = normalized.contains('got dependencies') ||
        normalized.contains('changed ') ||
        normalized.contains('resolving dependencies') && normalized.contains('downloading packages') && !normalized.contains('failed');
    if (!hasSuccessSignal) {
      blockers.add('pub-get-success-signal-missing');
    }
    if (normalized.contains('available') && normalized.contains('newer version')) {
      warnings.add('pub-get-has-outdated-package-notice');
    }

    return RealLogCommandVerdict(
      command: 'flutter pub get',
      passed: blockers.isEmpty,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static RealLogCommandVerdict evaluateAnalyzeLog(String log) {
    final normalized = _normalize(log);
    final blockers = <String>[];
    final warnings = <String>[];

    if (normalized.isEmpty) {
      blockers.add('analyze-log-empty');
    }
    if (_hasFailureMarker(normalized)) {
      blockers.add('analyze-log-contains-failure');
    }
    if (_containsAnalyzeError(normalized)) {
      blockers.add('analyze-errors-present');
    }
    if (_containsAnalyzeWarningOrInfo(normalized)) {
      blockers.add('analyze-not-clean-warning-or-info-present');
    }
    if (!normalized.contains('no issues found')) {
      blockers.add('analyze-clean-success-line-missing');
    }

    return RealLogCommandVerdict(
      command: 'flutter analyze',
      passed: blockers.isEmpty,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static RealLogCommandVerdict evaluateTestLog(String log) {
    final normalized = _normalize(log);
    final blockers = <String>[];
    final warnings = <String>[];

    if (normalized.isEmpty) {
      blockers.add('test-log-empty');
    }
    if (_hasFailureMarker(normalized) || normalized.contains('some tests failed') || normalized.contains('failed to load')) {
      blockers.add('test-log-contains-failure');
    }
    if (!RegExp(r'\+\d+:\s+all tests passed!?').hasMatch(normalized) && !normalized.contains('all tests passed')) {
      blockers.add('test-success-line-missing');
    }
    if (normalized.contains('skip') || normalized.contains('skipped')) {
      warnings.add('test-log-has-skipped-tests');
    }

    return RealLogCommandVerdict(
      command: 'flutter test',
      passed: blockers.isEmpty,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static RealLogCommandVerdict evaluateRunLog(String log, {String targetDeviceId = '23106RN0DA'}) {
    final normalized = _normalize(log);
    final blockers = <String>[];
    final warnings = <String>[
      'flutter-run-launch-is-not-real-device-visual-pass; manual recordings/screenshots are still required',
    ];

    if (normalized.isEmpty) {
      blockers.add('run-log-empty');
    }
    if (_hasFailureMarker(normalized) || normalized.contains('no supported devices connected') || normalized.contains('could not launch')) {
      blockers.add('run-log-contains-launch-failure');
    }
    final targetMentioned = normalized.contains(targetDeviceId.toLowerCase()) || normalized.contains('connected devices');
    final launchSignal = normalized.contains('flutter run key commands') ||
        normalized.contains('syncing files to device') ||
        normalized.contains('installing build') ||
        normalized.contains('launching lib/main.dart');
    if (!targetMentioned) {
      blockers.add('run-target-device-signal-missing:$targetDeviceId');
    }
    if (!launchSignal) {
      blockers.add('run-launch-signal-missing');
    }

    return RealLogCommandVerdict(
      command: 'flutter run -d $targetDeviceId',
      passed: blockers.isEmpty,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static RealLogEvidenceVerdict evaluateAllRequiredLogs({
    required String pubGetLog,
    required String analyzeLog,
    required String testLog,
    required String runLog,
    String targetDeviceId = '23106RN0DA',
  }) {
    final verdicts = <RealLogCommandVerdict>[
      evaluatePubGetLog(pubGetLog),
      evaluateAnalyzeLog(analyzeLog),
      evaluateTestLog(testLog),
      evaluateRunLog(runLog, targetDeviceId: targetDeviceId),
    ];

    final blockers = <String>[
      for (final verdict in verdicts)
        for (final blocker in verdict.blockers) '${verdict.command}:$blocker',
    ];
    final warnings = <String>[
      for (final verdict in verdicts)
        for (final warning in verdict.warnings) '${verdict.command}:$warning',
      'log-pass-does-not-equal-premium-visual-pass; run the V108/V109 manual scenario checklist',
    ];

    return RealLogEvidenceVerdict(
      commandVerdicts: verdicts,
      logsPassed: blockers.isEmpty,
      realDeviceVisualPassClaimAllowed: false,
      blockers: _uniqueSorted(blockers),
      warnings: _uniqueSorted(warnings),
    );
  }

  static bool _hasFailureMarker(String normalized) {
    return normalized.contains('exception') ||
        normalized.contains('error:') ||
        normalized.contains('failed') ||
        normalized.contains('failure') ||
        normalized.contains('exited (') ||
        normalized.contains('could not') ||
        normalized.contains('unable to');
  }

  static bool _containsAnalyzeError(String normalized) {
    return RegExp(r'\berror\s*[•\-]').hasMatch(normalized) || normalized.contains(' errors found') || normalized.contains(' error found');
  }

  static bool _containsAnalyzeWarningOrInfo(String normalized) {
    if (normalized.contains('no issues found')) return false;
    return RegExp(r'\bwarning\s*[•\-]').hasMatch(normalized) ||
        RegExp(r'\binfo\s*[•\-]').hasMatch(normalized) ||
        normalized.contains(' issues found') ||
        normalized.contains(' issue found');
  }

  static String _normalize(String log) {
    return log.replaceAll('\r\n', '\n').trim().toLowerCase();
  }

  static List<String> _uniqueSorted(Iterable<String> values) {
    final unique = values.where((value) => value.trim().isNotEmpty).toSet().toList(growable: false);
    unique.sort();
    return unique;
  }
}

class RealLogCommandVerdict {
  const RealLogCommandVerdict({
    required this.command,
    required this.passed,
    required this.blockers,
    required this.warnings,
  });

  final String command;
  final bool passed;
  final List<String> blockers;
  final List<String> warnings;
}

class RealLogEvidenceVerdict {
  const RealLogEvidenceVerdict({
    required this.commandVerdicts,
    required this.logsPassed,
    required this.realDeviceVisualPassClaimAllowed,
    required this.blockers,
    required this.warnings,
  });

  final List<RealLogCommandVerdict> commandVerdicts;
  final bool logsPassed;
  final bool realDeviceVisualPassClaimAllowed;
  final List<String> blockers;
  final List<String> warnings;
}
