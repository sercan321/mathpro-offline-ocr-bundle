# V172-Q169R20 Court Result Ownership / Overlay Lock Audit

Q169R20 is a targeted repair after Q169R19 real-device screenshots showed `COURT MOUNT:unknown ... ROOT:unknown`, followed by legacy `Q169 KEY...` diagnostics.

Root cause found from real code inspection: Q169R19 marked compact channel-push state with the same `channelPushSelfTestHardBindingPhase` marker as final court payloads. Dart consumed compact state as a court result, so fields like `mount`, `insert`, `value`, `paint`, and `rootCause` were missing and rendered as `unknown`.

Q169R20 separates `channelPushKind: court` from `channelPushKind: compact`, rejects incomplete court payloads with an explicit `COURT_RAW` parse-fail summary, and locks the COURT overlay so legacy Q169 key diagnostics cannot overwrite it while the court is pending/visible.

Protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain unchanged. This package does not claim real-device paint PASS or premium visual PASS.
