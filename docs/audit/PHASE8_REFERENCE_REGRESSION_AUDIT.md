# Phase 9 Reference Regression Audit

## Reference package

`MathPro_History_V2_FULL_KATEX_INLINE_FIX.zip`

## Flutter package

`MathPro_Flutter_Phase8_FULL.zip`

## Fixed P0

Phase 7 had a named-parameter mismatch:

```dart
MathLayoutEngine.legacy deriveSlotRects(size_param: size, registry: snapshot.registry)
```

Phase 9 corrected it:

```dart
MathLayoutEngine.deriveSlotRects(canvasSize: size, registry: snapshot.registry)
```

## Keyboard preservation

The React Native reference keyboard authority remains `src/config/editorConfig.js`. The Flutter keyboard authority remains `lib/features/keyboard/key_config.dart`.

Preserved:

- 5 tabs: Temel, Cebir, Kalkülüs, Kompleks, Lineer Cebir
- Temel 20-key core grid
- Expanded 8 × 5 grid shape
- `MORE` label
- `Ans` visibility
- `↵` evaluation/enter role
- `=` literal equality symbol role
- Long-press maps
- Calculus null/empty cells

## UI hardening

Recovered or improved relative to Phase 7:

- Workspace pan/pinch behavior restored with Flutter `InteractiveViewer`.
- History handle restored to compact reference-style handle without the extra `Geçmiş` label drift.
- Selection toolbar restored with the action set from the React Native reference: Kopyala, Kes, Çoğalt, Yapıştır, Geri Al, Yinele, Temizle.
- MORE no longer shows only a single placeholder preview; it opens a template tray surface.

## Remaining honesty note

The slot engine still uses deterministic approximate layout boxes. That is better than no slot layer, but it is not final renderer-derived bounding-box hit-testing. Real device/emulator validation remains required.
