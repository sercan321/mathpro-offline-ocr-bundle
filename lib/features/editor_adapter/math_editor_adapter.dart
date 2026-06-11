/// V172-Q82 — MathEditorAdapter Contract.
///
/// This file is the engine-neutral command/state boundary between the frozen
/// MathPro keyboard surfaces and whichever editor engine is active. The current
/// Flutter SlotBox editor stays available as legacy fallback; a future MathLive
/// implementation must implement this contract before it can be considered for
/// main-editor use.
///
/// This contract deliberately contains no Flutter UI dependency and does not
/// mutate keyboard, MORE, long-press, Graph, History, Solution, or app shell
/// surfaces.
abstract interface class MathEditorAdapter {
  MathEditorEngineKind get engineKind;

  MathEditorOutputState get currentState;

  MathEditorCommandResult insertText(String text);

  MathEditorCommandResult insertOperator(String operator);

  MathEditorCommandResult insertTemplate(MathEditorTemplate template);

  MathEditorCommandResult deleteBackward();

  MathEditorCommandResult moveLeft();

  MathEditorCommandResult moveRight();

  MathEditorCommandResult clear();

  String getLatex();

  String getPlainText();

  Object? getMathJson();
}

enum MathEditorEngineKind {
  legacyFlutterSlotEditor,
  mathLive,
}

enum MathEditorTemplate {
  fraction,
  squareRoot,
  indexedRoot,
  power,
  subscript,
  sine,
  cosine,
  tangent,
  naturalLog,
  logWithBase,
  absoluteValue,
  integral,
  matrix,
}

class MathEditorOutputState {
  const MathEditorOutputState({
    required this.latex,
    required this.plainText,
    this.mathJson,
    this.hasFocus = false,
    this.selectionDescription = '',
    this.engineDiagnostic = '',
  });

  final String latex;
  final String plainText;
  final Object? mathJson;
  final bool hasFocus;
  final String selectionDescription;
  final String engineDiagnostic;

  MathEditorOutputState copyWith({
    String? latex,
    String? plainText,
    Object? mathJson,
    bool? hasFocus,
    String? selectionDescription,
    String? engineDiagnostic,
  }) {
    return MathEditorOutputState(
      latex: latex ?? this.latex,
      plainText: plainText ?? this.plainText,
      mathJson: mathJson ?? this.mathJson,
      hasFocus: hasFocus ?? this.hasFocus,
      selectionDescription: selectionDescription ?? this.selectionDescription,
      engineDiagnostic: engineDiagnostic ?? this.engineDiagnostic,
    );
  }
}

class MathEditorCommandResult {
  const MathEditorCommandResult({
    required this.accepted,
    required this.state,
    this.diagnostic = '',
  });

  final bool accepted;
  final MathEditorOutputState state;
  final String diagnostic;
}
