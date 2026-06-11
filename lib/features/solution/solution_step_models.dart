import 'package:flutter/foundation.dart';

import '../../logic/evaluator_bridge.dart';

/// Single source of truth for the in-workspace solution panel state.
///
/// This deliberately does not reuse the premium history route/panel state because
/// solution steps must keep the expression/result card and keyboard context alive.
enum SolutionStepsPanelState { closed, medium, expanded }

extension SolutionStepsPanelStateX on SolutionStepsPanelState {
  bool get isOpen => this != SolutionStepsPanelState.closed;

  bool get isExpanded => this == SolutionStepsPanelState.expanded;
}

@immutable
class SolutionStep {
  const SolutionStep({
    required this.index,
    required this.title,
    required this.description,
    this.mathLine,
    this.isLimitation = false,
  });

  final int index;
  final String title;
  final String description;
  final String? mathLine;
  final bool isLimitation;

  bool get hasMathLine => mathLine != null && mathLine!.trim().isNotEmpty;
}

@immutable
class SolutionStepsSnapshot {
  const SolutionStepsSnapshot({
    required this.expression,
    required this.result,
    required this.steps,
    this.statusText,
    this.selectedActionId,
    this.selectedActionLabel,
    this.selectedExpressionKind,
    this.selectedActionRequiresSolverHandler,
    this.selectedActionSupportedByCurrentEngine,
  });

  final String expression;
  final String result;
  final List<SolutionStep> steps;
  final String? statusText;
  final String? selectedActionId;
  final String? selectedActionLabel;
  final String? selectedExpressionKind;
  final bool? selectedActionRequiresSolverHandler;
  final bool? selectedActionSupportedByCurrentEngine;
}

class SolutionStepsComposer {
  const SolutionStepsComposer._();

  // V172-Q382R5: unsupported context-menu intents must never reuse a stale
  // generic calculator result as if a real action handler had produced it.

  static SolutionStepsSnapshot compose({
    required String expression,
    required String result,
    String? unsupportedReason,
    String? selectedActionId,
    String? selectedActionLabel,
    String? selectedExpressionKind,
    bool? selectedActionRequiresSolverHandler,
    bool? selectedActionSupportedByCurrentEngine,
  }) {
    final cleanExpression = expression.trim();
    final selectedActionUnsupported = selectedActionRequiresSolverHandler == true && selectedActionSupportedByCurrentEngine != true;
    final cleanResult = selectedActionUnsupported ? '—' : (result.trim().isEmpty ? '0' : result.trim());
    final rawUnsupported = unsupportedReason?.trim();
    final unsupported = selectedActionUnsupported
        ? 'Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'
        : rawUnsupported;

    if (cleanExpression.isEmpty) {
      return SolutionStepsSnapshot(
        expression: cleanExpression,
        result: cleanResult,
        steps: const <SolutionStep>[],
      );
    }

    final semantic = EvaluatorBridge.analyzeSemantic(cleanExpression);

    if (unsupported != null && unsupported.isNotEmpty) {
      return _composeUnsupported(
        expression: cleanExpression,
        result: cleanResult,
        unsupported: unsupported,
        semantic: semantic,
        selectedActionId: selectedActionId,
        selectedActionLabel: selectedActionLabel,
        selectedExpressionKind: selectedExpressionKind,
        selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      );
    }

    if (semantic.kind == 'derivative' || semantic.kind == 'integral' || semantic.kind == 'ode' || semantic.kind == 'pde') {
      return _composeSemantic(
        expression: cleanExpression,
        result: cleanResult,
        semantic: semantic,
        selectedActionId: selectedActionId,
        selectedActionLabel: selectedActionLabel,
        selectedExpressionKind: selectedExpressionKind,
        selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      );
    }

    final steps = <SolutionStep>[
      SolutionStep(
        index: 1,
        title: 'İfade alındı',
        description: '',
        mathLine: cleanExpression,
      ),
      SolutionStep(
        index: 2,
        title: semantic.kind == 'numeric' ? 'İşlem değerlendirildi' : _shortTitleFor(semantic),
        description: semantic.kind == 'numeric' ? '' : _shortDescriptionFor(semantic),
        mathLine: semantic.normalizedExpression ?? cleanExpression,
        isLimitation: semantic.isLimitation,
      ),
      SolutionStep(
        index: 3,
        title: 'Sonuç',
        description: '',
        mathLine: cleanResult,
      ),
    ];

    final routedSteps = _withSelectedActionIntentStep(
      steps,
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
    );

    return SolutionStepsSnapshot(
      expression: cleanExpression,
      result: cleanResult,
      statusText: _statusFor(semantic),
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      steps: routedSteps,
    );
  }

  static SolutionStepsSnapshot _composeUnsupported({
    required String expression,
    required String result,
    required String unsupported,
    required MathSemanticSummary semantic,
    String? selectedActionId,
    String? selectedActionLabel,
    String? selectedExpressionKind,
    bool? selectedActionRequiresSolverHandler,
    bool? selectedActionSupportedByCurrentEngine,
  }) {
    var index = 1;
    final steps = <SolutionStep>[
      SolutionStep(
        index: index++,
        title: 'İfade alındı',
        description: '',
        mathLine: expression,
      ),
      SolutionStep(
        index: index++,
        title: _shortTitleFor(semantic),
        description: _shortDescriptionFor(semantic),
        mathLine: semantic.normalizedExpression,
        isLimitation: semantic.isLimitation,
      ),
      SolutionStep(
        index: index++,
        title: 'Durum',
        description: _shortUnsupportedReason(unsupported),
        isLimitation: true,
      ),
    ];

    for (final semanticStep in semantic.steps) {
      steps.add(SolutionStep(
        index: index++,
        title: _shortSemanticStepTitle(semanticStep),
        description: '',
        isLimitation: semantic.isLimitation,
      ));
    }

    steps.add(const SolutionStep(
      index: 99,
      title: 'Adım yok',
      description: 'Sahte adım gösterilmiyor.',
      isLimitation: true,
    ));

    return SolutionStepsSnapshot(
      expression: expression,
      result: result,
      statusText: _statusFor(semantic),
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      steps: _renumber(_withSelectedActionIntentStep(
        steps,
        selectedActionId: selectedActionId,
        selectedActionLabel: selectedActionLabel,
        selectedExpressionKind: selectedExpressionKind,
        selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      )),
    );
  }

  static SolutionStepsSnapshot _composeSemantic({
    required String expression,
    required String result,
    required MathSemanticSummary semantic,
    String? selectedActionId,
    String? selectedActionLabel,
    String? selectedExpressionKind,
    bool? selectedActionRequiresSolverHandler,
    bool? selectedActionSupportedByCurrentEngine,
  }) {
    var index = 1;
    final steps = <SolutionStep>[
      SolutionStep(
        index: index++,
        title: _shortTitleFor(semantic),
        description: _shortDescriptionFor(semantic),
        mathLine: expression,
        isLimitation: semantic.isLimitation,
      ),
    ];

    for (final semanticStep in semantic.steps) {
      steps.add(SolutionStep(
        index: index++,
        title: _shortSemanticStepTitle(semanticStep),
        description: '',
        mathLine: semantic.normalizedExpression,
        isLimitation: semantic.isLimitation,
      ));
    }

    steps.add(SolutionStep(
      index: index++,
      title: semantic.isLimitation ? 'Adım yok' : 'Sonuç',
      description: semantic.isLimitation ? 'Sahte çözüm gösterilmedi.' : '',
      mathLine: result,
      isLimitation: semantic.isLimitation,
    ));

    return SolutionStepsSnapshot(
      expression: expression,
      result: result,
      statusText: _statusFor(semantic),
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      steps: _withSelectedActionIntentStep(
        steps,
        selectedActionId: selectedActionId,
        selectedActionLabel: selectedActionLabel,
        selectedExpressionKind: selectedExpressionKind,
        selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      ),
    );
  }

  static List<SolutionStep> _withSelectedActionIntentStep(
    List<SolutionStep> steps, {
    String? selectedActionId,
    String? selectedActionLabel,
    String? selectedExpressionKind,
    bool? selectedActionRequiresSolverHandler,
    bool? selectedActionSupportedByCurrentEngine,
  }) {
    final id = selectedActionId?.trim() ?? '';
    final label = selectedActionLabel?.trim() ?? '';
    if (id.isEmpty || label.isEmpty) return steps;
    final intentStep = SolutionStep(
      index: 2,
      title: 'İşlem niyeti',
      description: selectedActionRequiresSolverHandler == true && selectedActionSupportedByCurrentEngine != true
          ? 'Seçili işlem metadata olarak taşındı; bu handler kanıtlanmadığı için mevcut sonuç değiştirilmedi ve sahte sonuç gösterilmiyor.'
          : 'Seçili işlem çözüm akışına metadata olarak taşındı; gerçek handler olmadan sahte sonuç üretilmedi.',
      mathLine: selectedExpressionKind == null || selectedExpressionKind.trim().isEmpty
          ? label
          : '$label · ${selectedExpressionKind.trim()}',
      isLimitation: true,
    );
    // V172-Q382R3: intent-step injection must be deterministic and must not
    // rely on List.contains for SolutionStep instances. SolutionStep does not
    // define value equality, so object-identity checks could inject the selected
    // action metadata step repeatedly when a snapshot has multiple downstream
    // steps. The explicit flag keeps the metadata step single-shot and preserves
    // the no-fake-solver contract.
    final injected = <SolutionStep>[];
    var intentStepInjected = false;
    for (final step in steps) {
      if (!intentStepInjected && step.index > 1) {
        injected.add(intentStep);
        intentStepInjected = true;
      }
      injected.add(step);
    }
    if (!intentStepInjected) injected.add(intentStep);
    return _renumber(injected);
  }

  static String _statusFor(MathSemanticSummary semantic) => _shortTitleFor(semantic);

  static String _shortTitleFor(MathSemanticSummary semantic) {
    switch (semantic.kind) {
      case 'numeric':
        return 'İşlem değerlendirildi';
      case 'derivative':
        return 'Türev algılandı';
      case 'integral':
        return 'İntegral algılandı';
      case 'matrix':
        return 'Matris algılandı';
      case 'equation':
        return 'Denklem algılandı';
      case 'implicitEquation':
        return 'İmplicit denklem';
      case 'algebraicExpression':
        return 'Cebirsel ifade';
      case 'ode':
        return 'Diferansiyel denklem';
      case 'pde':
        return 'Kısmi diferansiyel denklem';
      case 'unsupported':
        return 'İleri ifade';
    }
    return _compactSentence(semantic.title);
  }

  static String _shortDescriptionFor(MathSemanticSummary semantic) {
    switch (semantic.kind) {
      case 'numeric':
        return '';
      case 'derivative':
        return 'Güç kuralı kontrol edildi.';
      case 'integral':
        return 'Ters güç kuralı kontrol edildi.';
      case 'matrix':
        return 'Lineer cebir adımı gerekli.';
      case 'equation':
      case 'implicitEquation':
        return 'Cebir adımı gerekli.';
      case 'algebraicExpression':
        return 'Değişkenli yapı korundu.';
      case 'ode':
      case 'pde':
        return 'Denklem sınıflandı.';
      case 'unsupported':
        return 'İleri çözüm gerekli.';
    }
    return _compactSentence(semantic.description);
  }

  static String _shortSemanticStepTitle(String semanticStep) {
    final text = semanticStep.trim();
    if (text.contains('Türev operatörü')) return 'Türev operatörü ayrıldı';
    if (text.contains('Değişken x')) return 'Değişken x alındı';
    if (text.contains('güç kuralı')) return 'Güç kuralı uygulandı';
    if (text.contains('İntegral gövdesi')) return 'Gövde ve değişken ayrıldı';
    if (text.contains('ters güç kuralı')) return 'Ters güç kuralı uygulandı';
    if (text.contains('+ C')) return '+ C korundu';
    if (text.contains('sınıflandırıldı')) return 'Denklem sınıflandı';
    return _compactSentence(text);
  }

  static String _shortUnsupportedReason(String unsupported) {
    final text = unsupported.trim();
    if (text.contains('Açık slot')) return 'Açık slotlar bekleniyor.';
    if (text.contains('sahte çözüm') || text.contains('Sahte çözüm')) return 'Sahte çözüm gösterilmedi.';
    if (text.contains('solver') || text.contains('Solver')) return 'İleri çözüm gerekli.';
    if (text.contains('henüz desteklenmiyor')) return 'Bu ifade henüz desteklenmiyor.';
    return _compactSentence(text);
  }

  static String _compactSentence(String text) {
    final clean = text.trim();
    if (clean.length <= 58) return clean;
    final firstClause = clean.split(RegExp(r'[.;]')).first.trim();
    if (firstClause.isNotEmpty && firstClause.length <= 58) return firstClause;
    return '${clean.substring(0, 55).trimRight()}…';
  }

  static List<SolutionStep> _renumber(List<SolutionStep> steps) {
    return <SolutionStep>[
      for (var i = 0; i < steps.length; i++)
        SolutionStep(
          index: i + 1,
          title: steps[i].title,
          description: steps[i].description,
          mathLine: steps[i].mathLine,
          isLimitation: steps[i].isLimitation,
        ),
    ];
  }
}
