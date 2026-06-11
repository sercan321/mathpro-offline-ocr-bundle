# V172-Q232 Result Status Compact Copy / Graph-Open Result Panel Fit Repair

## Scope
Q232 is limited to result/status copy resolution and result-panel fit safety. It does not change keyboard layout, long-press inventory/order, MORE/template tray, MathLive production editor/bridge, Graph painter/evaluator/mode behavior, Solution panel behavior, History, AppShell, Android startup/splash, solver, or evaluator semantics.

## Runtime problem addressed
When Graph or other context panels compress the workspace, the SONUÇ panel can become narrow/short. Long status strings such as `Açık slotları doldurmadan değerlendirme yapılmadı.` were previously rendered directly in the result panel with two-line ellipsis behavior, which could look cropped or paragraph-like on real phone screens.

## Repair
- Added `ResultStatusCopyResolver` with full/compact variants.
- `ResultView` now resolves raw status reasons into short premium copy before rendering.
- Tight result-panel constraints use compact copy automatically.
- Status text is single-line, non-wrapping, and uses fade overflow as a safety net rather than ellipsis dots.
- Actual result values still suppress status messages and remain the highest-priority result-panel content.

## Key mappings
- `Açık slotları doldurmadan değerlendirme yapılmadı.` -> full `Açık slotları doldurun`, compact `Slot bekleniyor`
- Empty expression -> full `İfade girin`, compact `İfade bekleniyor`
- Unsupported/evaluator limitation -> full `İfade değerlendirilemiyor`, compact `Değerlendirilemedi`
- Graph incompatible -> full `Grafik için uygun değil`, compact `Grafik uygun değil`
- Invalid expression -> full `Geçersiz ifade`, compact `Geçersiz`
- Calculation error -> full `Hesaplama hatası`, compact `Hata`
- No solution step -> full `Çözüm adımı yok`, compact `Adım yok`

## Evidence boundary
Static/verifier/fresh-extract checks can verify source wiring and protected-file preservation. Flutter analyze/test/run and Android graph-open visual fit still require user-side evidence.
