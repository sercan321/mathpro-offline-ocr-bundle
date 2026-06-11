import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_inline_runtime_boot_repair_policy.dart';

void main() {
  test('V172-Q169R33 inline runtime boot repair locks runtime inside main editor HTML', () {
    expect(MathLiveInlineRuntimeBootRepairPolicy.phase, 'V172-Q169R33');
    expect(MathLiveInlineRuntimeBootRepairPolicy.inlineRuntimeBundledInMainEditorHtml, isTrue);
    expect(MathLiveInlineRuntimeBootRepairPolicy.externalRuntimeFallbackStillAvailable, isTrue);
    expect(MathLiveInlineRuntimeBootRepairPolicy.q170StillRequiresRealDevicePaintEvidence, isTrue);
    expect(MathLiveInlineRuntimeBootRepairPolicy.touchesKeyboardLayout, isFalse);
    expect(MathLiveInlineRuntimeBootRepairPolicy.claimsRealDevicePaintPass, isFalse);

    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html, contains('data-mathpro-inline-runtime="V172-Q169R33"'));
    expect(html, contains('MathProInlineRuntimeBootRepair'));
    expect(html, contains('MathLive 0.109.2'));
    expect(html, contains('inlineRuntimeExecuted = true'));
    expect(html, contains('data-mathpro-external-runtime-fallback="V172-Q169R33"'));

    final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
    expect(bridge, contains("inlineRuntimeBootRepairPhase: 'V172-Q169R33'"));
    expect(bridge, contains('q169r33-inline-runtime-executed'));
    expect(bridge, contains('inline-runtime-executed-but-math-field-not-defined'));
  });
}
