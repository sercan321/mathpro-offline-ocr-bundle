#!/usr/bin/env node
import fs from 'node:fs';

const main = fs.readFileSync('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt', 'utf8');
const fnMatch = main.match(/private fun q384R2DeferredPaddleModelRuntimeBindingPreflight[\s\S]*?\n    private data class Q380InputTensorPlan/);
if (!fnMatch) throw new Error('q384R2 preflight function block not found');
const fn = fnMatch[0];
function check(condition, message) {
  if (!condition) throw new Error(message);
}
check(!fn.includes('bridgeEvidence['), 'q384R2 preflight must not reference out-of-scope bridgeEvidence');
check(fn.includes('val q387CandidateNbModelFile = q387FindPaddleLiteNbModelFile(sourceFile ?: primaryModelFile, modelDirectory)'), 'q384R2 preflight must compute q387 nb candidate locally');
check(fn.includes('val q387PaddleLiteNbModelReady = q387CandidateNbModelFile != null'), 'q384R2 preflight must compute q387 readiness locally');
check(fn.includes('val modelArtifactReady = paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady'), 'modelArtifactReady must combine inference-directory and nb readiness');
check(fn.includes('"modelArtifactReady" to modelArtifactReady'), 'return map must use scoped modelArtifactReady variable');
check(fn.includes('"q387PaddleLiteNbModelReady" to q387PaddleLiteNbModelReady'), 'return map must expose q387 readiness evidence');
check(fn.includes('!modelArtifactReady && !primaryExists'), 'blockedReason must not reject legacy primary file when nb artifact is ready');
console.log('PASS verify_release_kotlin_bridge_evidence_hotfix_q389r6q');
