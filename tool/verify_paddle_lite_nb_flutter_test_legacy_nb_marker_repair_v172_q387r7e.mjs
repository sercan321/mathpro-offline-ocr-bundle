import fs from 'fs';

const requiredFiles = [
  'test/v172_q348_optimized_model_conversion_model_loader_evidence_gate_test.dart',
  'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
  'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
  'test/v172_q387r7e_paddle_lite_nb_flutter_test_legacy_nb_marker_repair_test.dart',
];

for (const file of requiredFiles) {
  if (!fs.existsSync(file)) throw new Error(`Missing ${file}`);
}

const combined = requiredFiles.map((file) => fs.readFileSync(file, 'utf8')).join('\n---\n');
for (const marker of [
  "mainActivity.contains('.nb')",
  'q387RequiredModelFileExtension',
  'q387R1NbArtifactReady',
  'q387-paddle-lite-nb-model-required',
]) {
  if (!combined.includes(marker)) throw new Error(`Missing Q387R7E successor-aware .nb marker: ${marker}`);
}

const legacy = requiredFiles.slice(0, 3).map((file) => fs.readFileSync(file, 'utf8')).join('\n---\n');
if (legacy.includes("expect(mainActivity, isNot(contains('.nb')));\n    expect(gradle")) {
  throw new Error('Found stale direct .nb source ban before gradle assertion in Q348-Q350 tests');
}

const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');
if (!manifest.includes('v172Q387R7EFlutterTestLegacyNbMarkerRepair')) {
  throw new Error('Manifest missing Q387R7E repair entry');
}

const forbiddenFiles = [];
const ignoredDirs = new Set(['build', '.dart_tool', '.git']);
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const path = `${dir}/${entry.name}`;
    if (entry.isDirectory()) {
      if (!ignoredDirs.has(entry.name)) walk(path);
    } else if (/\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(path) && !path.startsWith('./docs/evidence/')) {
      forbiddenFiles.push(path);
    }
  }
}
walk('.');
if (forbiddenFiles.length) throw new Error(`Forbidden model artifacts present: ${forbiddenFiles.join(', ')}`);

console.log('PASS verify_paddle_lite_nb_flutter_test_legacy_nb_marker_repair_v172_q387r7e');
