param(
  [string]$SourceDir,
  [string]$PaddleLiteOpt,
  [string]$PrebuiltNb,
  [Parameter(Mandatory=$true)][string]$OutDir,
  [Parameter(Mandatory=$true)][string]$BaseUrl,
  [Parameter(Mandatory=$true)][string]$SourceRevision,
  [Parameter(Mandatory=$true)][string]$ConversionProvenance,
  [string]$SidecarDir,
  [string]$DecoderSidecar,
  [string]$PreprocessSidecar,
  [string]$NbName = "pp_formulanet_plus_android_arm64.nb",
  [string]$ModelId = "pp_formulanet_plus_l_device_only",
  [string]$ModelDisplayName = "PP-FormulaNet_plus-L offline formula OCR",
  [string]$ValidTargets = "arm",
  [string]$OptimizeOutType = "naive_buffer"
)

$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$NodeScript = Join-Path $ProjectRoot "tool\q389r5a_offline_formula_ocr_bundle_factory.mjs"
if (!(Test-Path $NodeScript)) {
  throw "Factory script not found: $NodeScript"
}

$argsList = @(
  $NodeScript,
  "--out-dir", $OutDir,
  "--base-url", $BaseUrl,
  "--source-revision", $SourceRevision,
  "--conversion-provenance", $ConversionProvenance,
  "--nb-name", $NbName,
  "--model-id", $ModelId,
  "--model-display-name", $ModelDisplayName,
  "--valid-targets", $ValidTargets,
  "--optimize-out-type", $OptimizeOutType
)

if ($PrebuiltNb -and $PrebuiltNb.Trim().Length -gt 0) {
  $argsList += @("--prebuilt-nb", $PrebuiltNb)
} else {
  if (!$SourceDir -or !$PaddleLiteOpt) {
    throw "Either -PrebuiltNb or both -SourceDir and -PaddleLiteOpt are required."
  }
  $argsList += @("--source-dir", $SourceDir, "--paddle-lite-opt", $PaddleLiteOpt)
}
if ($SidecarDir) { $argsList += @("--sidecar-dir", $SidecarDir) }
if ($DecoderSidecar) { $argsList += @("--decoder-sidecar", $DecoderSidecar) }
if ($PreprocessSidecar) { $argsList += @("--preprocess-sidecar", $PreprocessSidecar) }

Write-Host "Running Q389R5A offline Formula OCR bundle factory..."
node @argsList
if ($LASTEXITCODE -ne 0) {
  throw "Q389R5A bundle factory failed with exit code $LASTEXITCODE"
}
