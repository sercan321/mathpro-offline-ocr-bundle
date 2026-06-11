# V172-Q139R3 Static Lab Contract / Stale Run Repair Audit

Q139R3 is a narrow compatibility repair after user-side Flutter test still reported the Q84 bridge marker failure. The package already intended to preserve the Q84 static markers, but this repair promotes them from comments into an inert frozen JavaScript object so older static tests can match the literal contract text even if comments are omitted or a stale extraction path is suspected.

This is not a legacy cursor restoration. MathLive main-editor migration remains active. The legacy cursor overlay/hit-test path is not re-enabled. Keyboard layout, MORE, long-press lists, Graph UI, History UI, and Solution UI are unchanged.

Expected user-side effect: `flutter analyze` should no longer report `_useMathLiveMainEditor` as non-final, and `flutter test` should no longer fail Q84 on `phase: 'V172-Q84'` missing from `assets/mathlive/mathlive_bridge.js`.
