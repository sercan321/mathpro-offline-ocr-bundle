import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('V172-Q181 mobile stable renderer recovery keeps production boot light and public-surface-only', () {
    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html, contains('V172-Q181: mobile stable renderer recovery'));
    expect(html, contains('q181LightweightMainEditorBoot'));
    expect(html, contains('MathProMobileStableRendererRecovery'));
    expect(html, contains('heavyDiagnosticCourtsDefaultDisabled'));
    expect(html, contains('math-field::part(root)'));
    expect(html, contains('math-field::part(editable)'));
    expect(html, contains('math-field::part(container)'));
    expect(html, contains('math-field::part(content)'));
    expect(html, isNot(contains('.ML__placeholder {')));
    expect(html, isNot(contains('.ML__frac-line {')));
    expect(html, isNot(contains('.ML__sqrt-line {')));
    expect(html, isNot(contains('.ML__base {')));
  });
}
