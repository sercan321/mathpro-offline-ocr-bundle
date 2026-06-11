#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_q161_static_marker_contract_repair_v172_q169r15.mjs', retiredPhase: 'verify_mathlive_q161_static_marker_contract_repair_v172_q169r15', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const blockers = [];
const requireFile = (p) => { if (!exists(p)) blockers.push(`missing file: ${p}`); };
const requireContains = (label, text, needle) => { if (!text.includes(needle)) blockers.push(`${label} missing: ${needle}`); };
const requireNotContains = (label, text, needle) => { if (text.includes(needle)) blockers.push(`${label} must not contain: ${needle}`); };

requireFile('assets/mathlive/mathlive_bridge.js');
requireFile('assets/mathlive/manifest.json');
requireFile('README.md');
requireFile('test/v172_q161_mathlive_native_render_ownership_test.dart');

const bridge = read('assets/mathlive/mathlive_bridge.js');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');

requireContains('bridge', bridge, 'function documentLatexFromInsertPayload');
requireContains('bridge', bridge, 'q161-sanitized-document-latex-fallback-in-mathfield');
requireContains('bridge', bridge, "replace(/#0/g, '\\\\placeholder{}')");
requireContains('bridge', bridge, "replace(/#\\?/g, '\\\\placeholder{}')");
requireContains('bridge', bridge, "replace(/#@/g, '\\\\placeholder{}')");
requireContains('manifest', manifest, 'v172Q169R15Q161StaticMarkerContractRepair');
requireContains('manifest', manifest, 'V172-Q169R15');
requireContains('manifest', manifest, 'q161-sanitized-document-latex-fallback-in-mathfield');
requireContains('readme', readme, 'V172-Q169R15');
requireContains('readme', readme, 'Q161 Static Marker Contract Repair');
requireNotContains('bridge', bridge, 'mathpro-q160-visible-input-mirror');

const report = {
  phase: 'V172-Q169R15',
  status: blockers.length === 0
    ? 'MATHLIVE_Q161_STATIC_MARKER_CONTRACT_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_TEST_REQUIRED'
    : 'BLOCKED_MATHLIVE_Q161_STATIC_MARKER_CONTRACT_REPAIR',
  blockers,
  runtimeBehaviorChanged: false,
  nativePaintPassClaimed: false,
  protectedSurfacesUnchangedExpected: true,
  restoredMarker: 'q161-sanitized-document-latex-fallback-in-mathfield'
};
console.log(JSON.stringify(report, null, 2));
process.exit(blockers.length === 0 ? 0 : 1);
