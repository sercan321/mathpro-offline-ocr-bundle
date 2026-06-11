#!/usr/bin/env node
import { spawnSync } from 'node:child_process';

const result = spawnSync(process.execPath, ['tool/verify_gauss_native_overlay_until_appshell_ready_v172_q235r5.mjs'], {
  stdio: 'pipe',
  encoding: 'utf8'
});
if (result.status !== 0) {
  process.stdout.write(result.stdout || '');
  process.stderr.write(result.stderr || '');
  process.exit(result.status ?? 1);
}
console.log('GAUSS_SPLASH_SCREEN_Q212_STATIC_READY_WITH_Q235R5_NATIVE_OVERLAY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
