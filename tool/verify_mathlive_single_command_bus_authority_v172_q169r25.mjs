#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_single_command_bus_authority_v172_q169r25.mjs', retiredPhase: 'verify_mathlive_single_command_bus_authority_v172_q169r25', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

function read(p){ return fs.readFileSync(p, 'utf8'); }
function must(s, needle, label){ if(!s.includes(needle)){ console.error(`Q169R25 missing ${label}: ${needle}`); process.exitCode = 1; } }
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_single_command_bus_authority_policy.dart');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');
must(policy, "phase = 'V172-Q169R25'", 'policy phase');
must(policy, 'blocksVisibleFallbackAfterEmptyAck = true', 'blocks visible fallback after empty ack');
must(policy, 'blocksExternalControllerMirrorSync = true', 'blocks external controller sync');
must(policy, 'blocksFlutterVisibleFallbackOverlay = true', 'blocks flutter fallback overlay');
must(surface, "import 'mathlive_single_command_bus_authority_policy.dart';", 'surface policy import');
must(surface, "static const String singleCommandBusAuthorityPhase = 'V172-Q169R25';", 'surface phase const');
must(surface, 'bool _q169SingleCommandBusLocked = true;', 'surface lock field');
must(surface, 'MathLiveSingleCommandBusAuthorityPolicy.blocksExternalControllerMirrorSync', 'external sync gate');
must(surface, 'MathLiveSingleCommandBusAuthorityPolicy.blocksVisibleFallbackAfterEmptyAck', 'fallback after ack gate');
must(surface, 'MathLiveSingleCommandBusAuthorityPolicy.blocksFlutterVisibleFallbackOverlay', 'fallback overlay gate');
must(surface, "if (_q169CourtOverlayLocked || _q169SingleCommandBusLocked)", 'keyboard tap mount authority gate');
must(bridge, "singleCommandBusAuthorityPhase: 'V172-Q169R25'", 'bridge phase export');
must(bridge, 'single command bus owns keyboard -> MathLive bridge -> channel state', 'bridge compatibility marker');
must(manifest, 'v172Q169R25SingleCommandBusAuthority', 'manifest entry');
must(readme, 'V172-Q169R25 MathLive Single Command Bus Authority', 'README entry');
if(surface.includes("_applyVisibleCommandFallback(command.latex, reason: 'q157-visible-fallback-after-empty-ack');") && !surface.includes('blocksVisibleFallbackAfterEmptyAck')){
  console.error('Q169R25 visible fallback call lacks guard'); process.exitCode = 1;
}
if(process.exitCode){ console.error('MATHLIVE_SINGLE_COMMAND_BUS_AUTHORITY_Q169R25_FAILED'); process.exit(process.exitCode); }
console.log('MATHLIVE_SINGLE_COMMAND_BUS_AUTHORITY_PACKAGE_READY_BUT_REAL_DEVICE_COMMAND_BUS_EVIDENCE_REQUIRED');
