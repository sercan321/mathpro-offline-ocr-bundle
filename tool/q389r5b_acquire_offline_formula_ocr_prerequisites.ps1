param(
  [string]$WorkDir = "C:\mathpro_q389r5b_prereqs",
  [string]$ModelId = "PaddlePaddle/PP-FormulaNet_plus-L",
  [string]$PaddleLiteOptPath = "",
  [string]$PaddleLiteAssetUrl = "",
  [switch]$SkipModelDownload,
  [switch]$SkipPaddleLiteAcquire,
  [switch]$NoPipPaddleLiteAttempt,
  [string]$Python = "python"
)

$ErrorActionPreference = "Stop"
$Phase = "V172-Q389R5B_OFFLINE-DEPENDENCY-ACQUISITION"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$WorkDir = [System.IO.Path]::GetFullPath($WorkDir)
$ModelDir = Join-Path $WorkDir "PP-FormulaNet_plus-L_infer"
$ToolsDir = Join-Path $WorkDir "tools"
$DownloadsDir = Join-Path $WorkDir "downloads"
$ReportsDir = Join-Path $WorkDir "reports"
New-Item -ItemType Directory -Force -Path $ModelDir, $ToolsDir, $DownloadsDir, $ReportsDir | Out-Null

function Write-Info($m) { Write-Host "[Q389R5B] $m" }
function Fail($m) { throw "[Q389R5B FAIL] $m" }
function Test-Exe($p) { return ($p -and (Test-Path $p) -and -not (Get-Item $p).PSIsContainer) }
function Find-FirstFile($dir, [string[]]$patterns) {
  if (!(Test-Path $dir)) { return "" }
  foreach ($pattern in $patterns) {
    $found = Get-ChildItem -Path $dir -Recurse -File -Filter $pattern -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { return $found.FullName }
  }
  return ""
}
function Find-PaddleLiteOpt($dir) {
  if (!(Test-Path $dir)) { return "" }
  $candidate = Get-ChildItem -Path $dir -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match '^(paddle_lite_opt|opt)(\.exe)?$' -or $_.Name -match 'paddle_lite_opt.*\.exe$' } |
    Select-Object -First 1
  if ($candidate) { return $candidate.FullName }
  return ""
}
function Write-JsonFile($path, $obj) {
  $json = $obj | ConvertTo-Json -Depth 20
  Set-Content -Path $path -Value $json -Encoding UTF8
}

$pythonCmd = Get-Command $Python -ErrorAction SilentlyContinue
if (!$pythonCmd) { Fail "Python bulunamadı. Python 3 kur veya -Python ile doğru yolu ver." }
Write-Info "Python: $($pythonCmd.Source)"

if (!$SkipModelDownload) {
  Write-Info "Hugging Face model indiriliyor: $ModelId"
  $pyFile = Join-Path $ReportsDir "q389r5b_download_model.py"
  @"
from pathlib import Path
import json, sys, subprocess
model_id = r'''$ModelId'''
out_dir = Path(r'''$ModelDir''')
try:
    from huggingface_hub import snapshot_download
except Exception:
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '--upgrade', 'huggingface_hub'])
    from huggingface_hub import snapshot_download
path = snapshot_download(
    repo_id=model_id,
    local_dir=str(out_dir),
    local_dir_use_symlinks=False,
    resume_download=True,
)
print(json.dumps({'model_id': model_id, 'local_dir': str(out_dir), 'snapshot_path': path}, indent=2))
"@ | Set-Content -Path $pyFile -Encoding UTF8
  & $Python $pyFile | Tee-Object -FilePath (Join-Path $ReportsDir "q389r5b_model_download.log")
  if ($LASTEXITCODE -ne 0) { Fail "Model indirilemedi. Ağ/HuggingFace erişimi veya Python paketlerini kontrol et." }
} else {
  Write-Info "Model indirme atlandı: $ModelDir kullanılacak."
}

$modelFile = Find-FirstFile $ModelDir @('inference.pdmodel','model.pdmodel','*.pdmodel','__model__')
$paramFile = Find-FirstFile $ModelDir @('inference.pdiparams','model.pdiparams','*.pdiparams')
$decoderSidecar = Find-FirstFile $ModelDir @('tokenizer.json','formula_tokenizer.json','vocab.txt','tokens.txt','latex_vocab.txt','*vocab*.json','*token*.json','*tokens*.txt')
$preprocessSidecar = Find-FirstFile $ModelDir @('inference.yml','inference.yaml','inference.json','config.yml','config.yaml','config.json','preprocess.json','*metadata*.json','*shape*.json')
if (!$modelFile) { Fail "Model klasöründe inference/model .pdmodel bulunamadı: $ModelDir" }
if (!$paramFile) { Fail "Model klasöründe inference/model .pdiparams bulunamadı: $ModelDir" }
if (!$decoderSidecar) { Fail "Tokenizer/vocab/tokens sidecar bulunamadı. Model repo içeriğini kontrol et." }
if (!$preprocessSidecar) { Fail "Preprocess/config/metadata sidecar bulunamadı. Model repo içeriğini kontrol et." }
Write-Info "Model file: $modelFile"
Write-Info "Param file: $paramFile"
Write-Info "Decoder sidecar: $decoderSidecar"
Write-Info "Preprocess sidecar: $preprocessSidecar"

$resolvedOpt = ""
if (Test-Exe $PaddleLiteOptPath) {
  $resolvedOpt = [System.IO.Path]::GetFullPath($PaddleLiteOptPath)
  Write-Info "Paddle Lite opt kullanıcı yolundan bulundu: $resolvedOpt"
}
if (!$resolvedOpt) {
  $pathOpt = Get-Command "paddle_lite_opt" -ErrorAction SilentlyContinue
  if ($pathOpt) { $resolvedOpt = $pathOpt.Source; Write-Info "PATH içinde paddle_lite_opt bulundu: $resolvedOpt" }
}
if (!$resolvedOpt -and !$SkipPaddleLiteAcquire -and !$NoPipPaddleLiteAttempt) {
  Write-Info "pip paddlelite denemesi yapılıyor; bu işlem sistemine göre çalışmayabilir."
  & $Python -m pip install --upgrade paddlelite 2>&1 | Tee-Object -FilePath (Join-Path $ReportsDir "q389r5b_pip_paddlelite.log")
  $pyFind = Join-Path $ReportsDir "q389r5b_find_paddlelite_opt.py"
  @"
import json, os, site, sys
roots = []
try:
    roots.extend(site.getsitepackages())
except Exception:
    pass
try:
    roots.append(site.getusersitepackages())
except Exception:
    pass
roots.extend(sys.path)
seen=set(); out=[]
for root in roots:
    if not root or root in seen or not os.path.exists(root):
        continue
    seen.add(root)
    for current, dirs, files in os.walk(root):
        for name in files:
            low = name.lower()
            if low in ('paddle_lite_opt.exe','paddle_lite_opt','opt.exe','opt') or low.startswith('paddle_lite_opt'):
                out.append(os.path.join(current, name))
        if len(out) > 10:
            break
print(json.dumps(out, indent=2))
"@ | Set-Content -Path $pyFind -Encoding UTF8
  $findOut = & $Python $pyFind
  Set-Content -Path (Join-Path $ReportsDir "q389r5b_find_paddlelite_opt.json") -Value $findOut -Encoding UTF8
  try {
    $items = $findOut | ConvertFrom-Json
    if ($items -and $items.Count -gt 0 -and (Test-Exe $items[0])) { $resolvedOpt = [string]$items[0]; Write-Info "pip paketlerinde paddle_lite_opt bulundu: $resolvedOpt" }
  } catch {}
}
if (!$resolvedOpt -and !$SkipPaddleLiteAcquire -and $PaddleLiteAssetUrl) {
  if ($PaddleLiteAssetUrl -notmatch '^https://') { Fail "-PaddleLiteAssetUrl HTTPS olmalı." }
  $assetName = Split-Path ([System.Uri]$PaddleLiteAssetUrl).AbsolutePath -Leaf
  $downloadPath = Join-Path $DownloadsDir $assetName
  Write-Info "Paddle Lite asset indiriliyor: $PaddleLiteAssetUrl"
  Invoke-WebRequest -Uri $PaddleLiteAssetUrl -OutFile $downloadPath
  $extractDir = Join-Path $ToolsDir "paddle_lite_asset"
  New-Item -ItemType Directory -Force -Path $extractDir | Out-Null
  if ($assetName -match '\.zip$') {
    Expand-Archive -Force -Path $downloadPath -DestinationPath $extractDir
  } else {
    tar -xf $downloadPath -C $extractDir
  }
  $resolvedOpt = Find-PaddleLiteOpt $extractDir
  if ($resolvedOpt) { Write-Info "asset içinden paddle_lite_opt bulundu: $resolvedOpt" }
}
if (!$resolvedOpt) {
  $reportPath = Join-Path $ReportsDir "q389r5b_missing_paddle_lite_opt.json"
  Write-JsonFile $reportPath @{
    phase=$Phase
    status="PADDLE_LITE_OPT_MISSING"
    message="Model indirildi/found olabilir; fakat paddle_lite_opt bulunamadı. Official Paddle-Lite release asset URL ver veya aracı indirip -PaddleLiteOptPath ile çalıştır."
    officialReleasePage="https://github.com/PaddlePaddle/Paddle-Lite/releases"
    retryExample="powershell -ExecutionPolicy Bypass -File .\tool\q389r5b_acquire_offline_formula_ocr_prerequisites.ps1 -PaddleLiteOptPath C:\tools\paddle_lite_opt.exe"
  }
  Fail "paddle_lite_opt bulunamadı. Rapor: $reportPath"
}

$nextCommand = @"
powershell -ExecutionPolicy Bypass -File .\tool\q389r5a_offline_formula_ocr_bundle_factory.ps1 `
  -SourceDir "$ModelDir" `
  -PaddleLiteOpt "$resolvedOpt" `
  -OutDir "C:\mathpro_ocr_bundle_q389r5a" `
  -BaseUrl "https://SENIN-HTTPS-DOSYA-ADRESIN/mathpro/q389r5a" `
  -SourceRevision "$ModelId official snapshot" `
  -ConversionProvenance "Converted on Windows with paddle_lite_opt for MathPro offline Formula OCR" `
  -SidecarDir "$ModelDir"
"@
$report = @{
  phase=$Phase
  status="PREREQUISITES_READY_FOR_Q389R5A_FACTORY"
  workDir=$WorkDir
  modelId=$ModelId
  modelDir=$ModelDir
  modelFile=$modelFile
  paramFile=$paramFile
  decoderSidecar=$decoderSidecar
  preprocessSidecar=$preprocessSidecar
  paddleLiteOpt=$resolvedOpt
  nextCommand=$nextCommand
  backendAllowed=$false
  mlKitAllowed=$false
  textOcrFallbackAllowed=$false
  modelBundledInBaseApp=$false
}
$reportPath = Join-Path $ReportsDir "q389r5b_offline_prerequisites_report.json"
Write-JsonFile $reportPath $report
Write-Info "PASS q389r5b_offline_dependency_acquisition"
Write-Info "Rapor: $reportPath"
Write-Host ""
Write-Host "SONRAKI KOMUT:"
Write-Host $nextCommand
