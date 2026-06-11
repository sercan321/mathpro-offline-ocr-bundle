# V172-Q247 Changed Files

## Added

- `lib/features/camera/gauss_winner_engine_selection_policy.dart`
- `lib/features/camera/gauss_winner_engine_selection.dart`
- `test/v172_q247_winner_engine_selection_test.dart`
- `tool/verify_winner_engine_selection_v172_q247.mjs`
- `docs/audit/V172_Q247_WINNER_ENGINE_SELECTION_AUDIT.md`
- `docs/audit/V172_Q247_CHANGED_FILES.md`

## Updated

- `assets/mathlive/manifest.json` — records Q247 winner-selection gate metadata and no-runtime/no-winner boundary.
- `README.md` — documents Q247 scope, evidence gates, candidate policy, and next phase.

## Protected Runtime Surfaces

Keyboard, MORE, long-press, MathLive production editor, Workspace runtime, camera shell runtime, Graph, Solution, History, splash, launcher icon, Android manifest runtime behavior, MainActivity runtime behavior, camera package versions, Kotlin plugin version, and AGP version were not changed by Q247.
