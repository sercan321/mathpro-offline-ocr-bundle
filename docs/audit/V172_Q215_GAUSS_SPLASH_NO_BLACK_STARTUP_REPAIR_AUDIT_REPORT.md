# V172-Q215 GAUSS Splash No-Black Startup Repair — Audit Report

Q215 repairs the user-side report that startup still showed a black screen before opening. It keeps the supplied GAUSS splash artwork unchanged, wires the Android 12+ system splash icon drawable to the GAUSS splash artwork instead of a transparent-only drawable, and defers the first Flutter frame until the GAUSS splash image readiness path. It does not claim Android PASS without user-side run evidence.
