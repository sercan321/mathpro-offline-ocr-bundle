import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_template_payload_surgical_repair_policy.dart';

void main() {
  test('V172-Q190R5 is template payload repair only, not final release', () {
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.phase, 'V172-Q190R5');
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.baseline, 'V172-Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR');
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.newFeatureAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.finalReleaseClaimAllowed, isFalse);
  });

  test('Q190R5 preserves red-line UI boundaries', () {
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.graphControllerMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.historyControllerMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.solutionStepsPanelMutationAllowed, isFalse);
  });

  test('Q190R5 converts critical MathLive insert-control tokens to document placeholders', () {
    const criticalLabels = <String>['lim', 'a/b', '□/□', '√□', '√x', 'x^y', '□^□', 'Σ', '∫□dx', '∫ₐᵇ'];
    for (final label in criticalLabels) {
      final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label);
      final documentLatex = MathLiveKeyboardBridgePolicy.productionDocumentLatexForMainEditorPayload(command.latex);
      expect(MathLiveKeyboardBridgePolicy.productionDocumentLatexHasRawInsertToken(documentLatex), isFalse, reason: label);
      expect(documentLatex, contains(r'\placeholder{}'), reason: label);
    }
  });

  test('Q190R5 leaves fixed series templates semantic and non-raw text', () {
    for (final label in <String>['Taylor', 'Maclaurin', 'Geometrik', 'Binom']) {
      final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label);
      final documentLatex = MathLiveKeyboardBridgePolicy.productionDocumentLatexForMainEditorPayload(command.latex);
      expect(documentLatex, isNot(label));
      expect(documentLatex, contains(r'\sum'));
      expect(MathLiveKeyboardBridgePolicy.productionDocumentLatexHasRawInsertToken(documentLatex), isFalse);
    }
  });

  test('Q190R5 does not claim Android, premium symbol, caret, or legacy cleanup PASS', () {
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.premiumSymbolVisualPassClaimed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.caretRealDevicePassClaimed, isFalse);
    expect(MathLiveTemplatePayloadSurgicalRepairPolicy.legacySurfacePhysicalCleanupCompleted, isFalse);
  });
}
