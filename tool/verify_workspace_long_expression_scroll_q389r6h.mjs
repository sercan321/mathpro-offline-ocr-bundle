import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const mustContain = (path, needle) => {
  const text = read(path);
  if (!text.includes(needle)) {
    throw new Error(`Missing required marker in ${path}: ${needle}`);
  }
};
const mustNotContain = (path, needle) => {
  const text = read(path);
  if (text.includes(needle)) {
    throw new Error(`Forbidden marker in ${path}: ${needle}`);
  }
};

const html = 'assets/mathlive/main_editor_prod.html';
const bridge = 'assets/mathlive/mathlive_prod_bridge.js';
const policy = 'lib/features/workspace/workspace_long_expression_scroll_policy_q389r6h.dart';
const test = 'test/q389r6h_workspace_long_expression_scroll_contract_test.dart';

mustContain(html, 'data-mathpro-long-expression-scroll="Q389R6H"');
mustContain(html, 'data-mathpro-long-expression-fit="normal"');
mustContain(html, 'overflow-x: auto;');
mustContain(html, 'scrollbar-width: none;');
mustContain(html, '-webkit-overflow-scrolling: touch;');
mustContain(html, 'scroll-padding-inline: 24px;');
mustContain(html, 'math-field.mathpro-long-fit-compact');
mustContain(html, 'math-field.mathpro-long-fit-dense');
mustContain(html, 'math-field.mathpro-long-fit-scroll');
mustContain(html, 'font-size: clamp(21px, 5.75vw, 28px);');

mustContain(bridge, "const LONG_EXPRESSION_SCROLL_PHASE = 'Q389R6H';");
mustContain(bridge, 'q389r6hLatexVisualWeight');
mustContain(bridge, 'q389r6hFitClassForLatex');
mustContain(bridge, 'q389r6hApplyLongExpressionFit');
mustContain(bridge, 'q389r6hKeepHorizontalCaretVisible');
mustContain(bridge, 'q389r6h-selection-change-caret-visible');
mustContain(bridge, "mf.classList.toggle('mathpro-long-fit-' + name, name === fit)");
mustContain(bridge, 'q389r6hLastCaretScrollTarget');
mustContain(bridge, 'q389r6hLastFitClass');
mustContain(bridge, 'state.caretContext = q382r26ReadCaretContext(mf, value);');
mustContain(bridge, "if (mounted) q389r6hApplyLongExpressionFit(mf, reason || 'q389r6h-update-state-fit');");
mustNotContain(bridge, 'LegacyFlutterCursor');
mustNotContain(bridge, 'flutterCaretOverlayAllowed: true');

mustContain(policy, "static const String phase = 'Q389R6H';");
mustContain(policy, "static const String minimumReadableScrollFontClamp = 'clamp(21px, 5.75vw, 28px)';");
mustContain(policy, 'static const bool longPressCursorDragImplemented = false;');
mustContain(policy, 'static const bool keyboardLayoutChanged = false;');
mustContain(policy, 'static const bool graphChanged = false;');
mustContain(policy, 'static const bool ocrChanged = false;');
mustContain(test, 'WorkspaceLongExpressionScrollPolicyQ389R6H');

console.log('Q389R6H workspace long-expression scroll verifier: PASS');
