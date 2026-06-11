#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const fail = (msg) => { console.error(`GRAPH_PREVIEW_OVERFLOW_REPAIR_Q207_FAILED: ${msg}`); process.exit(1); };

for (const rel of ['lib/features/graph/graph_card.dart', 'assets/mathlive/manifest.json']) if (!exists(rel)) fail(`missing ${rel}`);
const graph = read('lib/features/graph/graph_card.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q221Successor = manifest.v172Q221GraphMiniPanelLayoutSimplification?.phase === 'V172-Q221';

if (!q221Successor) {
  if (!graph.includes('class _GraphActions extends StatelessWidget')) fail('Graph actions row missing');
  if (!graph.includes("_ActionChipButton(label: 'Reset'")) fail('Reset action missing');
  if (!graph.includes("_ActionChipButton(label: 'Zoom +'")) fail('Zoom + action missing');
  if (!graph.includes("_ActionChipButton(label: 'Zoom −'")) fail('Zoom − action missing');
} else {
  if (!graph.includes('mathpro-graph-canvas-preview')) fail('Q221 successor graph canvas preview marker missing');
  if (!graph.includes('mathpro-graph-floating-zoom-in')) fail('Q221 successor floating zoom-in marker missing');
  if (!graph.includes('mathpro-graph-floating-zoom-out')) fail('Q221 successor floating zoom-out marker missing');
  if (graph.includes("_ActionChipButton(label: 'Reset'")) fail('Q221 successor restored old Reset text chip');
  if (graph.includes("_ActionChipButton(label: 'Zoom +'")) fail('Q221 successor restored old Zoom + text chip');
  if (graph.includes("_ActionChipButton(label: 'Zoom −'")) fail('Q221 successor restored old Zoom − text chip');
}
if (graph.includes("_ActionChipButton(label: 'Settings'")) fail('duplicate Settings action chip restored; header settings icon is enough');
if (!graph.includes('GraphStyle.controlGradient')) fail('premium graph control style missing');
console.log(q221Successor ? 'GRAPH_PREVIEW_OVERFLOW_REPAIR_Q207_STATIC_READY_WITH_Q221_MINI_PANEL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED' : 'GRAPH_PREVIEW_OVERFLOW_REPAIR_Q207_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
