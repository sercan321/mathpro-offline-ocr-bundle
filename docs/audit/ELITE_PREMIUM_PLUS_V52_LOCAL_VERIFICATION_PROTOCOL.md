# V52 Local Verification Protocol

Run from the extracted project root:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Expected decision logic:

- If `flutter analyze` reports no issues and `flutter test` passes, V52 may be treated as code-level PASS.
- If `flutter run` opens on the real device without overflow, clipped tabs, broken graph/history/solution surfaces, or keyboard regression, V52 may be treated as real-device conditional PASS.
- If there is any overflow or regression, stop feature work and create a targeted V52.1 repair from the real log.

Manual UI checks:

1. Open Temel, Cebir, Kalkülüs, Kompleks, and Lineer Cebir.
2. Confirm keyboard key positions are unchanged.
3. Confirm MORE, Ans, =, and ↵ semantics are unchanged.
4. Long-press key families and verify popup layout does not overflow.
5. Open Graph preview and fullscreen graph.
6. Open History panel and interact with an item.
7. Open Solution Steps panel and confirm it scrolls internally.
8. Confirm Android navigation bar does not collide with the keyboard.
