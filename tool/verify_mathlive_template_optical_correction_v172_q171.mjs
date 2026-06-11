#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_template_optical_correction_v172_q171.mjs', retiredPhase: 'verify_mathlive_template_optical_correction_v172_q171', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks=[];
function check(name, ok){ checks.push({name, ok:Boolean(ok)}); }
function read(path){ return fs.readFileSync(path, 'utf8'); }
const html=read('assets/mathlive/main_editor.html');
const bridge=read('assets/mathlive/mathlive_bridge.js');
const popup=read('lib/features/keyboard/premium_popup_fit_policy.dart');
const policy=read('lib/features/mathlive/mathlive_template_optical_correction_policy.dart');
const manifest=read('assets/mathlive/manifest.json');
check('q171 policy exists', policy.includes("phase = 'V172-Q171'") && policy.includes('realDevicePremiumPassClaimed = false'));
check('q171 html marker exists', html.includes('data-mathpro-template-optical-correction="V172-Q171"') && html.includes('--mathpro-q171-template-optical-correction: active'));
check('q171 bridge marker exists', bridge.includes("templateOpticalCorrectionPhase: 'V172-Q171'") && bridge.includes('function q171TemplateFamilyForLatex') && bridge.includes('applyQ171TemplateOpticalCorrection'));
check('q171 inline bridge mirrored', html.includes('function q171TemplateFamilyForLatex') && html.includes('window.MathProTemplateOpticalCorrection'));
check('q171 optical policy coexists with q172 popup legacy repair', popup.includes("templateOpticalCorrectionPhase = 'V172-Q171'") && popup.includes("legacyPopupContractRepairPhase = 'V172-Q172'") && popup.includes('longPressChipHeight = 48.0') && popup.includes('longPressPanelMinHeight = 60.0'));
check('q171 manifest envelope exists', manifest.includes('v172Q171TemplateOpticalCorrection'));
check('no protected UI mutation claim', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('longPressOrderMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false'));
const failed=checks.filter(x=>!x.ok);
if(failed.length){
  console.error('MATHLIVE_TEMPLATE_OPTICAL_CORRECTION_Q171_FAILED');
  for(const f of failed) console.error('- '+f.name);
  process.exit(1);
}
console.log('MATHLIVE_TEMPLATE_OPTICAL_CORRECTION_Q171_PACKAGE_READY_BUT_REAL_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
