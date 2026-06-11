#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_insert_value_commit_authority_v172_q169r26.mjs', retiredPhase: 'verify_mathlive_insert_value_commit_authority_v172_q169r26', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

function read(p){ return fs.readFileSync(p, 'utf8'); }
function must(s, needle, label){ if(!s.includes(needle)){ console.error(`Q169R26 missing ${label}: ${needle}`); process.exitCode = 1; } }
const bridge = read('assets/mathlive/mathlive_bridge.js');
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_insert_value_commit_authority_policy.dart');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');
must(policy, "phase = 'V172-Q169R26'", 'policy phase');
must(surface, "import 'mathlive_insert_value_commit_authority_policy.dart';", 'surface import');
must(surface, 'insertValueCommitAuthorityPhase = MathLiveInsertValueCommitAuthorityPolicy.phase', 'surface phase binding');
must(bridge, "insertValueCommitAuthorityPhase: 'V172-Q169R26'", 'bridge phase');
must(bridge, 'function readNativeMathfieldValueDetailed', 'native value reader');
must(bridge, 'function mathfieldNativeValue', 'native value convenience reader');
must(bridge, 'function q169R26TryExecuteCommandInsert', 'executeCommand insert fallback');
must(bridge, "executeCommand-array-insert", 'array insert fallback path');
must(bridge, "executeCommand-array-performTypingResponse", 'performTypingResponse array fallback');
must(bridge, "executeCommand-string-performTypingResponse", 'performTypingResponse string fallback');
must(bridge, "q169r26-after-direct-value-commit-native-read", 'native read after direct commit');
must(bridge, "q169r26-empty-after-direct-write-command-fallback", 'empty write fallback marker');
must(bridge, 'lastInsertValueCommitAuthorityPath', 'commit authority path state');
must(manifest, 'v172Q169R26InsertValueCommitAuthority', 'manifest entry');
must(readme, 'V172-Q169R26 MathLive Insert/Value Commit Authority', 'README entry');
if (bridge.includes('state.latex = mathfieldValue();\n      state.lastMathfieldValueAfter = state.latex; // q163-after-insert-value q169-after-insert-value')) {
  console.error('Q169R26 still uses fallback-capable mathfieldValue for immediate insert success path'); process.exitCode = 1;
}
if(process.exitCode){ console.error('MATHLIVE_INSERT_VALUE_COMMIT_AUTHORITY_Q169R26_FAILED'); process.exit(process.exitCode); }
console.log('MATHLIVE_INSERT_VALUE_COMMIT_AUTHORITY_PACKAGE_READY_BUT_REAL_DEVICE_VALUE_EVIDENCE_REQUIRED');
