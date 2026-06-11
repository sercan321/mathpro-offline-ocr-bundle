import '../editor/tree_utils.dart';
import 'structural_renderer_bridge.dart';

class FormulaVisibleRendererPolicy {
  const FormulaVisibleRendererPolicy._();

  static bool shouldShowSlotOverlay(StructuralRendererSnapshot snapshot) {
    // V62: raw placeholders such as 9□ = □; □ = □ are first-class editor
    // slots. They are not "structural" nodes like fractions/integrals, but
    // the user still sees real □ targets and expects them to be tappable.
    return snapshot.registry.hasSlots &&
        (TreeUtils.containsStructuralNode(snapshot.root) || snapshot.expression.contains('□'));
  }
}
