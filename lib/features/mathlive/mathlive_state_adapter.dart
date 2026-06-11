import 'dart:convert';

import '../editor_adapter/math_editor_adapter.dart';

/// V172-Q86 — MathLive State Adapter.
///
/// This adapter is deliberately state-only. It converts messages emitted by the
/// isolated MathLive Lab bridge into MathPro's editor-neutral output state
/// without switching the main editor, without enabling MathLive's virtual
/// keyboard, and without claiming that an official MathLive runtime is bundled.
class MathLiveStateAdapterPolicy {
  const MathLiveStateAdapterPolicy._();

  static const String phase = 'V172-Q86';
  static const String adapterName = 'MathLiveStateAdapter';

  static const bool labOnly = true;
  static const bool stateAdapterImplemented = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool officialMathLiveRuntimeBundled = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDeviceMathLiveCursorPassClaimed = false;

  static bool canConsumeBridgeState({
    required bool labScreenOpen,
    required bool usesRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    return stateAdapterImplemented &&
        labOnly &&
        labScreenOpen &&
        !usesRemoteScripts &&
        protectedSurfacesUnchanged &&
        !mainEditorSwitchAllowed &&
        !mathLiveVirtualKeyboardEnabled;
  }

  static bool mayFeedMathProRuntime({
    required bool officialRuntimeBundled,
    required bool bridgeStateValid,
    required bool realDeviceFocusPasses,
    required bool protectedSurfacesUnchanged,
  }) {
    return officialRuntimeBundled && bridgeStateValid && realDeviceFocusPasses && protectedSurfacesUnchanged;
  }
}

/// V172-Q382R26 — Caret Context Bridge.
///
/// Carries explicit native MathLive caret context from the production bridge to
/// Flutter without moving caret authority away from the native <math-field>.
/// Optimistic echo remains forbidden until this context is trusted.
class MathLiveCaretContextBridgeQ382R26Policy {
  const MathLiveCaretContextBridgeQ382R26Policy._();

  static const String phase = 'V172-Q382R26';
  static const bool bridgePayloadCarriesCaretContext = true;
  static const bool flutterParsesCaretContext = true;
  static const bool optimisticEchoEnabledByThisPhase = false;
  static const bool nativeMathLiveCaretAuthorityPreserved = true;
  static const bool privateShadowDomCaretReadAllowed = false;
}

class MathLiveCaretContextSnapshot {
  const MathLiveCaretContextSnapshot({
    required this.phase,
    required this.source,
    required this.confidence,
    required this.trusted,
    required this.selectionCollapsed,
    required this.caretAtDocumentEnd,
    required this.insidePlaceholder,
    required this.insideTemplate,
    required this.caretOffset,
    required this.documentEndOffset,
    required this.selectionLength,
    required this.diagnostic,
  });

  const MathLiveCaretContextSnapshot.unknown()
      : phase = MathLiveCaretContextBridgeQ382R26Policy.phase,
        source = 'q382r26-unknown',
        confidence = 'unknown',
        trusted = false,
        selectionCollapsed = false,
        caretAtDocumentEnd = false,
        insidePlaceholder = false,
        insideTemplate = false,
        caretOffset = -1,
        documentEndOffset = -1,
        selectionLength = -1,
        diagnostic = 'q382r26-caret-context-unavailable';

  factory MathLiveCaretContextSnapshot.fromJson(Object? value) {
    if (value is! Map) return const MathLiveCaretContextSnapshot.unknown();
    final json = Map<String, dynamic>.from(value);
    return MathLiveCaretContextSnapshot(
      phase: MathLiveEditorStateSnapshot._stringValue(json['phase']).isEmpty
          ? MathLiveCaretContextBridgeQ382R26Policy.phase
          : MathLiveEditorStateSnapshot._stringValue(json['phase']),
      source: MathLiveEditorStateSnapshot._stringValue(json['source']),
      confidence: MathLiveEditorStateSnapshot._stringValue(json['confidence']).isEmpty
          ? 'unknown'
          : MathLiveEditorStateSnapshot._stringValue(json['confidence']),
      trusted: json['trusted'] == true,
      selectionCollapsed: json['selectionCollapsed'] == true,
      caretAtDocumentEnd: json['caretAtDocumentEnd'] == true,
      insidePlaceholder: json['insidePlaceholder'] == true,
      insideTemplate: json['insideTemplate'] == true,
      caretOffset: _intValue(json['caretOffset']),
      documentEndOffset: _intValue(json['documentEndOffset']),
      selectionLength: _intValue(json['selectionLength']),
      diagnostic: MathLiveEditorStateSnapshot._stringValue(json['diagnostic']).isEmpty
          ? 'q382r26-caret-context-parsed'
          : MathLiveEditorStateSnapshot._stringValue(json['diagnostic']),
    );
  }

  final String phase;
  final String source;
  final String confidence;
  final bool trusted;
  final bool selectionCollapsed;
  final bool caretAtDocumentEnd;
  final bool insidePlaceholder;
  final bool insideTemplate;
  final int caretOffset;
  final int documentEndOffset;
  final int selectionLength;
  final String diagnostic;

  bool get mayAllowOptimisticLinearAppend {
    return trusted &&
        selectionCollapsed &&
        caretAtDocumentEnd &&
        !insidePlaceholder &&
        !insideTemplate;
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': phase,
      'source': source,
      'confidence': confidence,
      'trusted': trusted,
      'selectionCollapsed': selectionCollapsed,
      'caretAtDocumentEnd': caretAtDocumentEnd,
      'insidePlaceholder': insidePlaceholder,
      'insideTemplate': insideTemplate,
      'caretOffset': caretOffset,
      'documentEndOffset': documentEndOffset,
      'selectionLength': selectionLength,
      'diagnostic': diagnostic,
    };
  }

  static int _intValue(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? -1;
  }
}

class MathLiveStateAdapter {
  const MathLiveStateAdapter._();

  /// Accepts either the V172-Q86 JSON bridge payload or the older Q84/Q85 raw
  /// LaTeX message. Raw-string compatibility is kept only so old lab bootstrap
  /// assets do not crash the lab screen while Q86 is being verified.
  static MathLiveEditorStateSnapshot parseBridgeMessage(String message) {
    final trimmed = message.trim();
    if (trimmed.isEmpty) {
      return const MathLiveEditorStateSnapshot(
        latex: '',
        normalizedLatex: '',
        plainText: '',
        parseDiagnostic: 'q86-empty-bridge-message',
      );
    }

    try {
      final decoded = jsonDecode(trimmed);
      if (decoded is Map<String, dynamic>) {
        return MathLiveEditorStateSnapshot.fromJson(decoded);
      }
      if (decoded is Map) {
        return MathLiveEditorStateSnapshot.fromJson(Map<String, dynamic>.from(decoded));
      }
    } catch (_) {
      // Fall through to raw LaTeX compatibility.
    }

    return MathLiveEditorStateSnapshot.fromLatex(
      trimmed,
      parseDiagnostic: 'q86-raw-latex-compatibility-message',
    );
  }

  static MathEditorOutputState toMathEditorOutputState(MathLiveEditorStateSnapshot snapshot) {
    return MathEditorOutputState(
      latex: snapshot.normalizedLatex,
      plainText: snapshot.plainText,
      mathJson: snapshot.mathJson,
      hasFocus: snapshot.hasFocus,
      selectionDescription: snapshot.selectionDescription,
      engineDiagnostic: snapshot.parseDiagnostic,
    );
  }
}

class MathLiveEditorStateSnapshot {
  const MathLiveEditorStateSnapshot({
    required this.latex,
    required this.normalizedLatex,
    required this.plainText,
    this.mathJson,
    this.runtime = '',
    this.keyboardBridgePhase = '',
    this.lastCommandLabel = '',
    this.lastCommandAction = '',
    this.lastCommandSequence = 0,
    this.evaluateRequested = false,
    this.hasFocus = false,
    this.selectionDescription = '',
    this.realMathLiveRuntimeBundled = false,
    this.virtualKeyboardEnabled = false,
    this.remoteScriptLoadingAllowed = false,
    this.mainEditorSwitchAllowed = false,
    this.parseDiagnostic = 'q86-json-state-adapter',
    this.caretContext = const MathLiveCaretContextSnapshot.unknown(),
  });

  factory MathLiveEditorStateSnapshot.fromLatex(String latex, {String parseDiagnostic = 'q86-raw-latex'}) {
    final normalized = _normalizeLatex(latex);
    return MathLiveEditorStateSnapshot(
      latex: latex,
      normalizedLatex: normalized,
      plainText: _latexToPlainText(normalized),
      parseDiagnostic: parseDiagnostic,
    );
  }

  factory MathLiveEditorStateSnapshot.fromJson(Map<String, dynamic> json) {
    final rawLatex = _stringValue(json['latex']);
    final normalized = _stringValue(json['normalizedLatex']).isEmpty
        ? _normalizeLatex(rawLatex)
        : _normalizeLatex(_stringValue(json['normalizedLatex']));
    final plain = _stringValue(json['plainText']).isEmpty ? _latexToPlainText(normalized) : _stringValue(json['plainText']);
    return MathLiveEditorStateSnapshot(
      latex: rawLatex,
      normalizedLatex: normalized,
      plainText: plain,
      mathJson: json['mathJson'],
      runtime: _stringValue(json['runtime']),
      keyboardBridgePhase: _stringValue(json['keyboardBridgePhase']),
      lastCommandLabel: _stringValue(json['lastCommandLabel']),
      lastCommandAction: _stringValue(json['lastCommandAction']),
      lastCommandSequence: _intValue(json['lastCommandSequence']),
      evaluateRequested: json['evaluateRequested'] == true,
      hasFocus: json['hasFocus'] == true,
      selectionDescription: _stringValue(json['selectionDescription']),
      realMathLiveRuntimeBundled: json['realMathLiveRuntimeBundled'] == true,
      virtualKeyboardEnabled: json['virtualKeyboardEnabled'] == true,
      remoteScriptLoadingAllowed: json['remoteScriptLoadingAllowed'] == true,
      mainEditorSwitchAllowed: json['mainEditorSwitchAllowed'] == true,
      parseDiagnostic: 'q86-json-state-adapter',
      caretContext: MathLiveCaretContextSnapshot.fromJson(json['caretContext']),
    );
  }

  final String latex;
  final String normalizedLatex;
  final String plainText;
  final Object? mathJson;
  final String runtime;
  final String keyboardBridgePhase;
  final String lastCommandLabel;
  final String lastCommandAction;
  final int lastCommandSequence;
  final bool evaluateRequested;
  final bool hasFocus;
  final String selectionDescription;
  final bool realMathLiveRuntimeBundled;
  final bool virtualKeyboardEnabled;
  final bool remoteScriptLoadingAllowed;
  final bool mainEditorSwitchAllowed;
  final String parseDiagnostic;
  final MathLiveCaretContextSnapshot caretContext;

  bool get mayAllowOptimisticLinearAppend => caretContext.mayAllowOptimisticLinearAppend;

  bool get isSafeForLabOnlyConsumption {
    return !virtualKeyboardEnabled && !remoteScriptLoadingAllowed && !mainEditorSwitchAllowed;
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': MathLiveStateAdapterPolicy.phase,
      'latex': latex,
      'normalizedLatex': normalizedLatex,
      'plainText': plainText,
      'mathJson': mathJson,
      'runtime': runtime,
      'keyboardBridgePhase': keyboardBridgePhase,
      'lastCommandLabel': lastCommandLabel,
      'lastCommandAction': lastCommandAction,
      'lastCommandSequence': lastCommandSequence,
      'evaluateRequested': evaluateRequested,
      'hasFocus': hasFocus,
      'selectionDescription': selectionDescription,
      'realMathLiveRuntimeBundled': realMathLiveRuntimeBundled,
      'virtualKeyboardEnabled': virtualKeyboardEnabled,
      'remoteScriptLoadingAllowed': remoteScriptLoadingAllowed,
      'mainEditorSwitchAllowed': mainEditorSwitchAllowed,
      'parseDiagnostic': parseDiagnostic,
      'caretContext': caretContext.toJson(),
    };
  }

  static String _stringValue(Object? value) => value == null ? '' : value.toString();

  static int _intValue(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static String _normalizeLatex(String value) {
    return value
        .replaceAll('\u00a0', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String _latexToPlainText(String value) {
    if (value.isEmpty) return '';
    return value
        .replaceAll(r'\left', '')
        .replaceAll(r'\right', '')
        .replaceAll(r'\times', '×')
        .replaceAll(r'\div', '÷')
        .replaceAll(r'\pi', 'π')
        .replaceAll(r'\theta', 'θ')
        .replaceAll(r'\infty', '∞')
        .replaceAll(r'\frac{}{}', '□/□')
        .replaceAll(r'\sqrt{}', '√□')
        .replaceAll(r'\log_{}', 'log_□')
        .replaceAll(r'\sin', 'sin')
        .replaceAll(r'\cos', 'cos')
        .replaceAll(r'\tan', 'tan')
        .replaceAll(r'\ln', 'ln')
        .replaceAllMapped(RegExp(r'\\operatorname\{([^}]+)\}'), (match) => match.group(1) ?? '')
        .replaceAllMapped(RegExp(r'\\([a-zA-Z]+)'), (match) => match.group(1) ?? '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .trim();
  }
}
