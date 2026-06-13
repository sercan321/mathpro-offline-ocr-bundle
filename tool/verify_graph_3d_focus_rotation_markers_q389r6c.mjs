import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const checks = [];
const requireContains = (path, needle) => checks.push({path, needle, ok: read(path).includes(needle), kind: 'contains'});
const requireNotContains = (path, needle) => checks.push({path, needle, ok: !read(path).includes(needle), kind: 'notContains'});

requireContains('lib/features/graph/graph_surface_3d.dart', 'Q389R6C: premium 3D graph surface interaction');
requireContains('lib/features/graph/graph_surface_3d.dart', 'class Graph3DViewportPolicy');
requireContains('lib/features/graph/graph_surface_3d.dart', 'focusedExpressionFor3D');
requireContains('lib/features/graph/graph_surface_3d.dart', 'math.pi');
requireContains('lib/features/graph/graph_surface_3d.dart', 'mathpro-graph-3d-gesture-surface-q389r6c');
requireContains('lib/features/graph/graph_surface_3d.dart', 'onPanUpdate');
requireContains('lib/features/graph/graph_surface_3d.dart', '_wrapRadians');
requireContains('lib/features/graph/graph_surface_3d.dart', 'Tepe hattı');
requireContains('lib/features/graph/graph_surface_3d.dart', 'Dip hattı');
requireContains('lib/features/graph/graph_surface_3d.dart', 'Kök hattı');
requireContains('lib/features/graph/graph_surface_3d.dart', 'mathpro-graph-3d-critical-feature-tooltip-q389r6c');
requireContains('lib/features/graph/graph_surface_3d.dart', '_buildRibbonFeatures');
requireContains('lib/features/graph/graph_surface_3d.dart', 'GraphCriticalPointDetector.detect');
requireContains('lib/features/graph/graph_fullscreen_page.dart', 'if (_renderMode == GraphRenderMode.threeD)');
requireContains('lib/features/graph/graph_fullscreen_page.dart', 'Sürükle: 360° döndür');
requireContains('lib/features/graph/graph_fullscreen_page.dart', 'Graph3DViewportPolicy.focusedExpressionFor3D');
requireContains('test/q389r6c_graph_3d_focus_rotation_markers_contract_test.dart', 'focusedExpressionFor3D');
requireContains('test/q389r6c_graph_3d_focus_rotation_markers_contract_test.dart', 'mathpro-graph-3d-gesture-surface-q389r6c');
requireNotContains('lib/features/keyboard/math_keyboard.dart', 'q389r6c');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('Q389R6C 3D graph focus/rotation/markers verifier FAILED');
  for (const failure of failed) {
    console.error(`- ${failure.kind}: ${failure.path} :: ${failure.needle}`);
  }
  process.exit(1);
}

console.log('Q389R6C 3D graph focus/rotation/markers verifier PASS');
console.log(`Checked ${checks.length} source contracts.`);
