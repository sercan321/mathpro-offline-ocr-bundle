import fs from 'node:fs';

function read(path) {
  return fs.readFileSync(path, 'utf8');
}
function check(condition, message) {
  if (!condition) {
    console.error(`FAIL ${message}`);
    process.exit(1);
  }
}

const policy = read('lib/features/mathlive/mathlive_key_ordering_regression_q382r33r3_policy.dart');
const mainSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const surface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const adapter = read('lib/features/mathlive/mathlive_state_adapter.dart');
const appShell = read('lib/app/app_shell.dart');
const optimistic = read('lib/features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart');
const buildGradle = read('android/app/build.gradle');

check(policy.includes("phase = 'V172-Q382R33R3'"), 'Q382R33R3 policy phase missing');
check(policy.includes('serializeDartDispatchBeforeJsSideQueue = true'), 'Q382R33R3 must serialize enqueue delivery before JS-side queue');
check(policy.includes('preservesQ384DownloadOnlyOcrContract = true'), 'Q384 contract preservation marker missing');
check(mainSurface.includes("import 'mathlive_key_ordering_regression_q382r33r3_policy.dart';"), 'main surface must import Q382R33R3 policy');
check(surface.includes('MathLiveKeyOrderingRegressionQ382R33R3Policy.phase'), 'production surface must retain Q382R33R3 phase in fingerprint');
check(surface.includes('final commandUsesJsSideQueue = MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction(command.action);'), 'surface must calculate JS-side queue usage once');
check(surface.includes('MathLiveKeyOrderingRegressionQ382R33R3Policy.mustSerializeJsSideQueueDispatch'), 'surface must call ordering repair guard');
check(surface.includes("'insertLatex' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetInsertDispatch && !mustSerializeJsSideQueueDispatch"), 'insertLatex fire-and-forget must be disabled for JS-side queued commands');
check(surface.includes("'deleteBackward' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetDeleteDispatch && !mustSerializeJsSideQueueDispatch"), 'deleteBackward fire-and-forget must be disabled for JS-side queued commands');
check(adapter.includes('this.lastCommandSequence = 0'), 'state snapshot constructor must include lastCommandSequence');
check(adapter.includes("lastCommandSequence: _intValue(json['lastCommandSequence'])"), 'state adapter must parse lastCommandSequence');
check(adapter.includes("'lastCommandSequence': lastCommandSequence"), 'state adapter must serialize lastCommandSequence');
check(appShell.includes('_q382r33r3LastAppliedMathLiveCommandSequence'), 'AppShell must track last applied MathLive sequence');
check(appShell.includes('_shouldDiscardQ382R33R3StaleMathLiveSnapshot'), 'AppShell must define stale snapshot guard');
check(appShell.includes('sequence < _q382r33r3LastAppliedMathLiveCommandSequence'), 'AppShell must discard older sequence snapshots');
check(appShell.includes('snapshot.lastCommandSequence > _q382r33r3LastAppliedMathLiveCommandSequence'), 'AppShell must advance latest applied sequence');
check(optimistic.includes('templateOptimisticEchoAllowed = false'), 'template optimistic echo must remain disabled');
check(optimistic.includes('moreLongPressOptimisticEchoAllowed = false'), 'MORE/long-press optimistic echo must remain disabled');
check(!buildGradle.includes('onnxruntime-android'), 'Q384 ONNX removal must remain preserved in combined delivery');
check(fs.existsSync('test/v172_q382r33r3_key_ordering_regression_repair_test.dart'), 'Q382R33R3 test artifact missing');
check(fs.existsSync('docs/audit/V172_Q382R33R3_KEY_ORDERING_REGRESSION_REPAIR.md'), 'Q382R33R3 audit doc missing');
check(fs.existsSync('docs/audit/V172_Q382R33R3_CHANGED_FILES.md'), 'Q382R33R3 changed-files doc missing');

console.log('PASS verify_key_ordering_regression_repair_v172_q382r33r3');
