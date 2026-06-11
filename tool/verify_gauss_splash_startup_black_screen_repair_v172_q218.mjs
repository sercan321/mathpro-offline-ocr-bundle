#!/usr/bin/env node
import { spawnSync } from 'node:child_process';

const result = spawnSync(process.execPath, ['tool/verify_gauss_native_flutter_splash_continuity_repair_v172_q235r4.mjs'], {
  stdio: 'pipe',
  encoding: 'utf8'
});
if (result.status !== 0) {
  process.stdout.write(result.stdout || '');
  process.stderr.write(result.stderr || '');
  process.exit(result.status ?? 1);
}
console.log('GAUSS_SPLASH_STARTUP_BLACK_SCREEN_REPAIR_Q218_STATIC_READY_WITH_Q235R4_FLUTTER_CONTINUITY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_RUN_AND_ANDROID_RETEST_REQUIRED');
