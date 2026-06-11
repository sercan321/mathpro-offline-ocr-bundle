import 'package:flutter/foundation.dart';

@immutable
class WorkspaceFrameIsolationQ382R30Policy {
  const WorkspaceFrameIsolationQ382R30Policy._();

  static const String phase = 'V172-Q382R30';
  static const String marker = 'q382r30-workspace-frame-isolation-active';
  static const bool isolateExpressionAndResultFrame = true;
  static const bool cacheStructuralWorkspaceShell = true;
  static const bool preserveKeyboardLayoutOrderLabels = true;
  static const bool preserveMoreAndLongPressInventory = true;
  static const bool preserveMathLiveNativeCaretAuthority = true;
  static const bool optimisticEchoScopeUnchanged = true;
  static const bool graphSolutionHistorySemanticsUnchanged = true;
}

@immutable
class WorkspaceFrameHotSnapshotQ382R30 {
  const WorkspaceFrameHotSnapshotQ382R30({
    required this.expressionText,
    required this.resultText,
    required this.statusText,
  });

  const WorkspaceFrameHotSnapshotQ382R30.empty()
      : expressionText = '',
        resultText = '0',
        statusText = '';

  final String expressionText;
  final String resultText;
  final String statusText;

  WorkspaceFrameHotSnapshotQ382R30 copyWith({
    String? expressionText,
    String? resultText,
    String? statusText,
  }) {
    return WorkspaceFrameHotSnapshotQ382R30(
      expressionText: expressionText ?? this.expressionText,
      resultText: resultText ?? this.resultText,
      statusText: statusText ?? this.statusText,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WorkspaceFrameHotSnapshotQ382R30 &&
        other.expressionText == expressionText &&
        other.resultText == resultText &&
        other.statusText == statusText;
  }

  @override
  int get hashCode => Object.hash(expressionText, resultText, statusText);

  @override
  String toString() =>
      'WorkspaceFrameHotSnapshotQ382R30(expression=${expressionText.length}, result=$resultText, status=${statusText.length})';
}
