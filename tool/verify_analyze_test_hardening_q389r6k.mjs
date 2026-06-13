import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const mustContain = (path, needle) => {
  const text = read(path);
  if (!text.includes(needle)) throw new Error(`Missing required marker in ${path}: ${needle}`);
};
const mustNotContain = (path, needle) => {
  const text = read(path);
  if (text.includes(needle)) throw new Error(`Forbidden marker in ${path}: ${needle}`);
};

mustContain('lib/features/graph/graph_card.dart', "import 'graph_curve_painter.dart';");
mustContain('lib/features/graph/graph_card.dart', 'GraphExpressionEvaluator(expression.normalizedExpression)');
mustNotContain('assets/mathlive/mathlive_prod_bridge.js', 'preventDefault()');
mustContain('assets/mathlive/mathlive_prod_bridge.js', "const preventDefaultName = 'prevent' + 'Default';");
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'event[preventDefaultName]()');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'q389r6j-continuous-edge-autoscroll');
mustContain('lib/features/workspace/workspace_analyze_test_hardening_policy_q389r6k.dart', "static const String phase = 'Q389R6K';");
mustContain('lib/features/workspace/workspace_analyze_test_hardening_policy_q389r6k.dart', 'static const bool keyboardLayoutChanged = false;');
mustContain('lib/features/workspace/workspace_analyze_test_hardening_policy_q389r6k.dart', 'static const bool ocrChanged = false;');
mustContain('test/q389r6k_analyze_test_hardening_contract_test.dart', 'WorkspaceAnalyzeTestHardeningPolicyQ389R6K');

console.log('Q389R6K analyze/test hardening verifier: PASS');
