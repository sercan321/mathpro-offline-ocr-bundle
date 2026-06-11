import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_static_mathfield_host_runtime_boot_repair_policy.dart';

void main() {
  test('V172-Q169R34 static mathfield host keeps runtime boot package-side deterministic', () {
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.phase, 'V172-Q169R34');
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.staticMathfieldHostPresentBeforeBridgeMount, isTrue);
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.bridgeMayAdoptPrecreatedMathfield, isTrue);
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.runtimePassRequiresDefinedCustomElement, isTrue);
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.touchesKeyboardLayout, isFalse);
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.touchesAppShell, isFalse);
    expect(MathLiveStaticMathfieldHostRuntimeBootRepairPolicy.claimsRealDevicePaintPass, isFalse);

    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html, contains('data-q169r34-static-mathfield-host="true"'));
    expect(html, contains('<math-field id="mathlive-field"'));
    expect(html, contains('data-mathpro-static-mathfield="V172-Q169R34"'));
    expect(html, contains('MathProStaticMathfieldHostRepair'));

    final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
    expect(bridge, contains("staticMathfieldHostRepairPhase: 'V172-Q169R34'"));
    expect(bridge, contains("node.querySelector('math-field')"));
    expect(bridge, contains('staticMathfieldHostAdopted'));
    expect(bridge, contains('runtimeUsableByDefinedCustomElement'));
  });
}
