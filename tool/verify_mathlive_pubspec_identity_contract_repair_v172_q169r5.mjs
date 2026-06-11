#!/usr/bin/env node
import fs from 'node:fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_pubspec_identity_contract_repair_v172_q169r5.mjs', retiredPhase: 'verify_mathlive_pubspec_identity_contract_repair_v172_q169r5', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const pubspec = fs.readFileSync('pubspec.yaml', 'utf8');
const contract = fs.readFileSync('lib/logic/mathpro_package_contract.dart', 'utf8');
const readme = fs.readFileSync('README.md', 'utf8');
const m = contract.match(/pubspecDescription =\n\s*'([\s\S]*?)';/);
const failures = [];
if (!m) failures.push('MathProPackageContract.pubspecDescription was not found.');
const description = m ? m[1].replace(/'\n\s*'/g, '') : '';
if (description && !pubspec.includes(description)) failures.push('pubspec.yaml must contain MathProPackageContract.pubspecDescription as one contiguous substring.');
if (!pubspec.includes('V172-Q169R4 adds MathLive MF:true Bridge Dispatch Repair')) failures.push('pubspec.yaml must preserve the Q169R4 note after the historical package identity.');
const idxContract = description ? pubspec.indexOf(description) : -1;
const idxQ169R4 = pubspec.indexOf('V172-Q169R4 adds MathLive MF:true Bridge Dispatch Repair');
if (idxContract < 0 || idxQ169R4 < 0 || idxQ169R4 < idxContract) failures.push('Q169R4 note must not interrupt or precede the historical package identity substring.');
if (!readme.includes('V172-Q169R5 — Pubspec Identity Contract Repair')) failures.push('README must document Q169R5 repair.');
if (failures.length) {
  console.error('MATHLIVE_PUBSPEC_IDENTITY_CONTRACT_REPAIR_Q169R5_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PUBSPEC_IDENTITY_CONTRACT_REPAIR_Q169R5_PACKAGE_READY_BUT_FLUTTER_AND_DEVICE_EVIDENCE_REQUIRED');
