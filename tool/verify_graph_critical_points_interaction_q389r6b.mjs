import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const checks = [];
const requireContains = (path, needle) => checks.push({path, needle, ok: read(path).includes(needle), kind: 'contains'});
const requireNotContains = (path, needle) => checks.push({path, needle, ok: !read(path).includes(needle), kind: 'notContains'});

requireContains('lib/features/graph/graph_models.dart', 'showCriticalPoints');
requireContains('lib/features/graph/graph_models.dart', 'showRootPoints');
requireContains('lib/features/graph/graph_models.dart', 'showExtremaPoints');
requireContains('lib/features/graph/graph_models.dart', 'showInterceptPoints');
requireContains('lib/features/graph/graph_critical_points.dart', 'class GraphCriticalPointDetector');
requireContains('lib/features/graph/graph_critical_points.dart', 'GraphCriticalPointType.localMaximum');
requireContains('lib/features/graph/graph_critical_points.dart', 'GraphCriticalPointType.localMinimum');
requireContains('lib/features/graph/graph_interaction_overlay.dart', 'class GraphInteractiveSurface');
requireContains('lib/features/graph/graph_interaction_overlay.dart', 'mathpro-graph-critical-point-marker-layer-q389r6b');
requireContains('lib/features/graph/graph_interaction_overlay.dart', 'mathpro-graph-critical-point-tooltip-q389r6b');
requireContains('lib/features/graph/graph_interaction_overlay.dart', 'mathpro-graph-coordinate-tooltip-q389r6b');
requireContains('lib/features/graph/graph_card.dart', 'GraphInteractiveSurface');
requireContains('lib/features/graph/graph_fullscreen_page.dart', 'GraphInteractiveSurface');
requireContains('lib/features/graph/graph_settings_sheet.dart', 'mathpro-graph-critical-point-toggles-q389r6b');
requireContains('test/q389r6b_graph_critical_points_interaction_contract_test.dart', 'GraphCriticalPointDetector.detect');
requireNotContains('lib/features/graph/graph_card.dart', 'Important Points Card');
requireNotContains('lib/features/graph/graph_card.dart', 'Önemli Noktalar Kartı');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('Q389R6B graph critical-points verifier FAILED');
  for (const failure of failed) {
    console.error(`- ${failure.kind}: ${failure.path} :: ${failure.needle}`);
  }
  process.exit(1);
}

console.log('Q389R6B graph critical-points verifier PASS');
console.log(`Checked ${checks.length} source contracts.`);
