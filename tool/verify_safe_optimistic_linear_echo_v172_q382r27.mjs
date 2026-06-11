#!/usr/bin/env node
import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const fail = (message) => {
  console.error(`FAIL verify_safe_optimistic_linear_echo_v172_q382r27: ${message}`);
  process.exit(1);
};
const must = (path, needle) => {
  if (!read(path).includes(needle)) fail(`${path} missing ${needle}`);
};
const mustNot = (path, needle) => {
  if (read(path).includes(needle)) fail(`${path} must not contain ${needle}`);
};

const policy = 'lib/features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart';
const app = 'lib/app/app_shell.dart';
const controller = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
const surface = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const test = 'test/v172_q382r27_safe_optimistic_linear_echo_test.dart';
const doc = 'docs/audit/V172_Q382R27_SAFE_OPTIMISTIC_LINEAR_ECHO.md';
const changed = 'docs/audit/V172_Q382R27_CHANGED_FILES.md';

must(policy, "static const String phase = 'V172-Q382R27'");
must(policy, 'static const bool optimisticEchoEnabled = true;');
must(policy, 'static const bool requiresCaretContextBridge = true;');
must(policy, 'static const bool requiresTrustedCaretContext = true;');
must(policy, 'static const bool templateOptimisticEchoAllowed = false;');
must(policy, 'static const bool moreLongPressOptimisticEchoAllowed = false;');
must(policy, 'static const bool deleteClearSolveGraphOptimisticEchoAllowed = false;');
must(policy, 'static const Set<String> optimisticLinearLabels');
mustNot(policy, "'□/□'");
mustNot(policy, "'√□'");
mustNot(policy, "'sin'");
mustNot(policy, "'MORE'");
mustNot(policy, "'⌫'");

must(app, "import '../features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart';");
must(app, '_q382r27LastCaretContext');
must(app, '_q382r27OptimisticExpression');
must(app, '_tryApplyQ382R27OptimisticLinearEcho');
must(app, 'MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply');
must(app, 'snapshot.mayAllowOptimisticLinearAppend');
must(app, 'MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel');
must(app, 'MathLiveSafeOptimisticLinearEchoQ382R27Policy.optimisticSource');
must(app, '_resetQ382R27OptimisticLinearEchoIfNonLinear');
must(app, '_resetQ382R27OptimisticLinearEcho();\n        _evaluateMathLiveExpression();');
must(app, 'label == \'C\'');
must(app, 'suppressNextExternalExpressionSyncForOptimisticEcho');

must(controller, 'void suppressNextExternalExpressionSyncForOptimisticEcho()');
must(surface, '_q382r27SuppressNextExternalExpressionSync');
must(surface, 'q382r27-optimistic-external-expression-sync-suppressed');
must(surface, '_suppressNextExternalExpressionSyncForQ382R27OptimisticEcho');

must(test, 'V172-Q382R27 Safe Optimistic Linear Echo');
must(doc, 'Q382R27');
must(changed, 'Q382R27');
must(test, 'label: \'□/□\'');
must(test, 'isFalse');

mustNot(app, 'panDragScrollReintroduced = true');
mustNot(policy, 'templateOptimisticEchoAllowed = true');
mustNot(policy, 'moreLongPressOptimisticEchoAllowed = true');
mustNot(policy, 'deleteClearSolveGraphOptimisticEchoAllowed = true');

console.log('PASS verify_safe_optimistic_linear_echo_v172_q382r27');
