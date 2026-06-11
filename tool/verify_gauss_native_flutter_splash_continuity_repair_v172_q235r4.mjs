#!/usr/bin/env node
import { spawnSync } from 'node:child_process';

const result = spawnSync(process.execPath, ['tool/verify_gauss_native_overlay_ready_signal_only_v172_q235r6.mjs'], {
  stdio: 'pipe',
  encoding: 'utf8'
});
if (result.status !== 0) {
  process.stdout.write(result.stdout || '');
  process.stderr.write(result.stderr || '');
  process.exit(result.status ?? 1);
}
console.log('GAUSS_NATIVE_FLUTTER_SPLASH_CONTINUITY_REPAIR_Q235R4_STATIC_READY_WITH_Q235R6_READY_SIGNAL_ONLY_SUCCESSOR_BUT_REAL_ANDROID_RETEST_REQUIRED');
