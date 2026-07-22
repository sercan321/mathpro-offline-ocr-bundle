#!/usr/bin/env bash
set -Eeuo pipefail
shopt -s inherit_errexit
umask 077

log(){ printf '\n=== %s ===\n' "$*"; }
sha256_file(){ sha256sum "$1" | awk '{print $1}'; }
normalize_sha(){ printf '%s' "$1" | tr -d ':[:space:]' | tr '[:lower:]' '[:upper:]'; }
require_eq(){ local a="$1" e="$2" l="$3"; [[ "$a" == "$e" ]] || { echo "${l}_MISMATCH expected=$e actual=$a" >&2; return 1; }; }

: "${GH_TOKEN:?}"
: "${GITHUB_REPOSITORY:?}"
: "${GITHUB_RUN_ID:?}"
: "${GITHUB_HEAD_REF:?}"
: "${PR_NUMBER:?}"
: "${RUNNER_TEMP:?}"
: "${MATHPRO_UPLOAD_KEYSTORE_B64:?}"
: "${MATHPRO_UPLOAD_STORE_PASSWORD:?}"
: "${MATHPRO_UPLOAD_KEY_ALIAS:?}"
: "${MATHPRO_UPLOAD_KEY_PASSWORD:?}"
: "${MATHPRO_UPLOAD_CERT_SHA256:?}"

EXPECTED_ARCHIVE_SHA256="a0ef780beb26b05d6fe032f179c18d2a12943cd079fc545ff100c0fec2a4d073"
EXPECTED_HEAD="90581f5d6f73f67c07c8ed15f20f9849da094cd1"
EXPECTED_TREE="9c6dad6e9bf121fc59c13b684e9d6874e2a0b222"
EXPECTED_TRACKED="1095"
EXPECTED_BOUNDARY_SHA="23c3be3c04c06e283d5da9d8cf1f8875523bf05619262139d2b292772cee5dfe"
EXPECTED_PLAN_SHA="8b18382996146085f76a54cd313c1752728a742477a483cbdf8df5e50bcae479"
EXPECTED_BASELINE_SHA="91534a38418b0a25476f2795ab3f32f76064819477ed4836143f8f894971638b"
WORK="$RUNNER_TEMP/r832-secure-certification"
export WORK
PAYLOAD_ROOT=".github/r832_secure_payload/${GITHUB_RUN_ID}"
CURRENT_PHASE="INITIALIZATION"
BLOCKER_CODE="R832-P3-UNCLASSIFIED"
RETURN_READY=0
FINAL_DECISION="REJECT"
FINAL_EXIT=1
rm -rf "$WORK"
mkdir -p "$WORK"/{handshake,payload,source,toolchain,logs,evidence,return,signing}

api_get(){ curl --fail --location --silent --show-error -H "Authorization: Bearer $GH_TOKEN" -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' "$1"; }

finalize_return(){
  local exit_code="$1"
  set +e
  FINAL_EXIT="$exit_code"
  if [[ "$exit_code" == 0 ]]; then FINAL_DECISION="PASS"; BLOCKER_CODE="NONE";
  elif [[ "$exit_code" == 3 ]]; then FINAL_DECISION="BLOCKED";
  else FINAL_DECISION="REJECT"; fi
  mkdir -p "$WORK/evidence" "$WORK/logs" "$WORK/return"
  cat > "$WORK/evidence/R832_FINAL_DECISION.json" <<EOF
{
  "schema":"R832_MEGA_PHASE3_FINAL_DECISION.v1",
  "decision":"$FINAL_DECISION",
  "exitCode":$exit_code,
  "blocker":"$BLOCKER_CODE",
  "failedPhase":"$CURRENT_PHASE",
  "sourceHead":"$EXPECTED_HEAD",
  "sourceTree":"$EXPECTED_TREE",
  "productionSigning":"$([[ "$FINAL_DECISION" == PASS ]] && echo PASS || echo NOT_PROVEN)",
  "megaPhase3":"$FINAL_DECISION",
  "megaPhase4":"$([[ "$FINAL_DECISION" == PASS ]] && echo AUTHORIZED || echo BLOCKED)",
  "releaseReady":false,
  "falsePass":false
}
EOF
  if [[ "$RETURN_READY" == 1 && -s "$WORK/return/return-public.pem" ]]; then
    tar --zstd -cf "$WORK/return/R832_MEGA_PHASE3_RETURN.tar.zst" -C "$WORK" evidence logs
    local plain_sha key_hex iv_hex
    plain_sha="$(sha256_file "$WORK/return/R832_MEGA_PHASE3_RETURN.tar.zst")"
    openssl rand 32 > "$WORK/return/return-aes.key"
    key_hex="$(xxd -p -c 256 "$WORK/return/return-aes.key")"
    iv_hex="$(openssl rand -hex 16)"
    openssl enc -aes-256-cbc -K "$key_hex" -iv "$iv_hex" -in "$WORK/return/R832_MEGA_PHASE3_RETURN.tar.zst" -out "$WORK/return/R832_MEGA_PHASE3_ENCRYPTED_RETURN.enc"
    openssl pkeyutl -encrypt -pubin -inkey "$WORK/return/return-public.pem" -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -in "$WORK/return/return-aes.key" -out "$WORK/return/R832_RETURN_KEY.enc"
    rm -f "$WORK/return/return-aes.key" "$WORK/return/R832_MEGA_PHASE3_RETURN.tar.zst"
    cat > "$WORK/return/R832_RETURN_MANIFEST.json" <<EOF
{
  "schema":"R832_SECURE_RETURN.v1",
  "runId":"$GITHUB_RUN_ID",
  "decision":"$FINAL_DECISION",
  "exitCode":$exit_code,
  "blocker":"$BLOCKER_CODE",
  "failedPhase":"$CURRENT_PHASE",
  "plainSha256":"$plain_sha",
  "ivHex":"$iv_hex",
  "cipherSha256":"$(sha256_file "$WORK/return/R832_MEGA_PHASE3_ENCRYPTED_RETURN.enc")",
  "cipherSize":$(stat -c %s "$WORK/return/R832_MEGA_PHASE3_ENCRYPTED_RETURN.enc"),
  "encryptedKeySha256":"$(sha256_file "$WORK/return/R832_RETURN_KEY.enc")",
  "encryptedKeySize":$(stat -c %s "$WORK/return/R832_RETURN_KEY.enc")
}
EOF
  fi
  rm -rf "$WORK/signing" "$WORK/payload/aes.key" "$WORK/handshake/source-private.pem" 2>/dev/null
  set -e
}
trap 'rc=$?; finalize_return "$rc"; exit "$rc"' EXIT

CURRENT_PHASE="HANDSHAKE"
BLOCKER_CODE="R832-P3-SECURE-TRANSPORT-001"
log "EPHEMERAL SOURCE HANDSHAKE"
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out "$WORK/handshake/source-private.pem" >/dev/null 2>&1
openssl pkey -in "$WORK/handshake/source-private.pem" -pubout -out "$WORK/handshake/source-public.pem" >/dev/null 2>&1
SOURCE_PUBLIC_B64="$(base64 -w0 "$WORK/handshake/source-public.pem")"
SOURCE_PUBLIC_SHA256="$(sha256_file "$WORK/handshake/source-public.pem")"
export SOURCE_PUBLIC_B64 SOURCE_PUBLIC_SHA256
python3 - <<'PY' > "$WORK/handshake/comment.json"
import json,os
body='\n'.join(['## R832 Secure Certification Handshake','',f'R832_SECURE_HANDSHAKE_RUN=`{os.environ["GITHUB_RUN_ID"]}`',f'R832_SOURCE_PUBLIC_KEY_SHA256=`{os.environ["SOURCE_PUBLIC_SHA256"]}`','','```text',os.environ['SOURCE_PUBLIC_B64'],'```','','Only ciphertext may be uploaded. The matching private key exists only inside this runner.'])
print(json.dumps({'body':body}))
PY
curl --fail --silent --show-error -X POST -H "Authorization: Bearer $GH_TOKEN" -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' -H 'Content-Type: application/json' --data-binary @"$WORK/handshake/comment.json" "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/comments" > "$WORK/handshake/comment-response.json"
echo "R832_SECURE_HANDSHAKE_PUBLISHED run=$GITHUB_RUN_ID publicKeySha256=$SOURCE_PUBLIC_SHA256"

CURRENT_PHASE="WAIT_ENCRYPTED_SOURCE"
log "WAIT FOR ENCRYPTED SOURCE"
MANIFEST_API="https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/${PAYLOAD_ROOT}/manifest.json?ref=${GITHUB_HEAD_REF}"
ready=0
for attempt in $(seq 1 480); do
  status="$(curl --silent --show-error -o "$WORK/payload/manifest-response.json" -w '%{http_code}' -H "Authorization: Bearer $GH_TOKEN" -H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' "$MANIFEST_API")"
  if [[ "$status" == 200 ]]; then
    python3 - "$WORK/payload/manifest-response.json" "$WORK/payload/manifest.json" <<'PY'
import base64,json,pathlib,sys
p=json.load(open(sys.argv[1],encoding='utf-8')); pathlib.Path(sys.argv[2]).write_bytes(base64.b64decode(p['content']))
PY
    ready=1; break
  fi
  [[ "$status" == 404 ]] || { echo "R832_MANIFEST_HTTP_STATUS=$status" >&2; exit 1; }
  (( attempt % 12 == 0 )) && echo "R832_WAITING_FOR_CIPHERTEXT attempt=$attempt"
  sleep 5
done
[[ "$ready" == 1 ]] || { echo R832_ENCRYPTED_SOURCE_TIMEOUT >&2; exit 1; }
python3 - "$WORK/payload/manifest.json" "$GITHUB_RUN_ID" "$EXPECTED_ARCHIVE_SHA256" <<'PY'
import json,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
assert p.get('schema')=='R832_SECURE_SOURCE_PAYLOAD.v1',p
assert str(p.get('runId'))==sys.argv[2],p
assert p.get('sourcePlainSha256')==sys.argv[3],p
assert p.get('chunks') and p.get('returnPublicKeyB64') and p.get('returnPublicKeySha256'),p
print('R832_SECURE_MANIFEST_VALID=PASS chunks=%d'%len(p['chunks']))
PY
RETURN_PUBLIC_B64="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["returnPublicKeyB64"])')"
RETURN_PUBLIC_SHA="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["returnPublicKeySha256"])')"
printf '%s' "$RETURN_PUBLIC_B64" | base64 --decode > "$WORK/return/return-public.pem"
require_eq "$(sha256_file "$WORK/return/return-public.pem")" "$RETURN_PUBLIC_SHA" R832_RETURN_PUBLIC_KEY_SHA256
RETURN_READY=1

CURRENT_PHASE="DOWNLOAD_CIPHERTEXT"
log "DOWNLOAD AND VERIFY CIPHERTEXT"
python3 - "$WORK/payload/manifest.json" > "$WORK/payload/download.tsv" <<'PY'
import json,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
for r in p['chunks']: print(f"{r['path']}\t{r['sha256']}\t{r['size']}")
print(f"{p['encryptedKeyPath']}\t{p['encryptedKeySha256']}\t{p['encryptedKeySize']}")
PY
: > "$WORK/payload/source.enc"
i=0
while IFS=$'\t' read -r path expected_sha expected_size; do
  api_get "https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/${path}?ref=${GITHUB_HEAD_REF}" > "$WORK/payload/response-$i.json"
  python3 - "$WORK/payload/response-$i.json" "$WORK/payload/blob-$i.bin" <<'PY'
import base64,json,pathlib,sys
p=json.load(open(sys.argv[1],encoding='utf-8')); pathlib.Path(sys.argv[2]).write_bytes(base64.b64decode(p['content']))
PY
  require_eq "$(stat -c %s "$WORK/payload/blob-$i.bin")" "$expected_size" "R832_CIPHER_SIZE_$i"
  require_eq "$(sha256_file "$WORK/payload/blob-$i.bin")" "$expected_sha" "R832_CIPHER_SHA_$i"
  if [[ "$path" == */key.enc ]]; then mv "$WORK/payload/blob-$i.bin" "$WORK/payload/key.enc"; else cat "$WORK/payload/blob-$i.bin" >> "$WORK/payload/source.enc"; fi
  i=$((i+1))
done < "$WORK/payload/download.tsv"
CIPHER_SHA="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["sourceCipherSha256"])')"
CIPHER_SIZE="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["sourceCipherSize"])')"
require_eq "$(stat -c %s "$WORK/payload/source.enc")" "$CIPHER_SIZE" R832_SOURCE_CIPHER_SIZE
require_eq "$(sha256_file "$WORK/payload/source.enc")" "$CIPHER_SHA" R832_SOURCE_CIPHER_SHA256

CURRENT_PHASE="DECRYPT_AND_VERIFY_SOURCE"
log "DECRYPT AND VERIFY EXACT SOURCE"
openssl pkeyutl -decrypt -inkey "$WORK/handshake/source-private.pem" -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -in "$WORK/payload/key.enc" -out "$WORK/payload/aes.key"
AES_HEX="$(xxd -p -c 256 "$WORK/payload/aes.key")"
IV_HEX="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["ivHex"])')"
openssl enc -d -aes-256-cbc -K "$AES_HEX" -iv "$IV_HEX" -in "$WORK/payload/source.enc" -out "$WORK/payload/MathPro_R832_PROJECT.tar.xz"
require_eq "$(sha256_file "$WORK/payload/MathPro_R832_PROJECT.tar.xz")" "$EXPECTED_ARCHIVE_SHA256" R832_SOURCE_ARCHIVE_SHA256
mkdir -p "$WORK/source"
tar -xJf "$WORK/payload/MathPro_R832_PROJECT.tar.xz" -C "$WORK/source"
PROJECT="$WORK/source/PROJECT"
[[ -d "$PROJECT/.git" ]] || { echo R832_GIT_METADATA_MISSING >&2; exit 1; }
require_eq "$(git -C "$PROJECT" rev-parse HEAD)" "$EXPECTED_HEAD" R832_SOURCE_HEAD
require_eq "$(git -C "$PROJECT" rev-parse 'HEAD^{tree}')" "$EXPECTED_TREE" R832_SOURCE_TREE
require_eq "$(git -C "$PROJECT" ls-files | wc -l | tr -d ' ')" "$EXPECTED_TRACKED" R832_TRACKED_COUNT
[[ -z "$(git -C "$PROJECT" status --short)" ]] || { git -C "$PROJECT" status --short; echo R832_SOURCE_DIRTY >&2; exit 1; }
require_eq "$(sha256_file "$PROJECT/android/app/src/main/python/mathpro_canonical_boundary.py")" "$EXPECTED_BOUNDARY_SHA" R832_BOUNDARY_SHA
require_eq "$(sha256_file "$PROJECT/android/app/src/main/python/mathpro_plan_parse_authority.py")" "$EXPECTED_PLAN_SHA" R832_PLAN_SHA
require_eq "$(sha256_file "$PROJECT/tool/authority_guard/authority_baseline_v3.json")" "$EXPECTED_BASELINE_SHA" R832_BASELINE_SHA
chmod +x "$PROJECT/android/gradlew"
rm -f "$WORK/payload/aes.key" "$WORK/handshake/source-private.pem"
cat > "$WORK/evidence/source-identity.json" <<EOF
{"head":"$EXPECTED_HEAD","tree":"$EXPECTED_TREE","tracked":$EXPECTED_TRACKED,"archiveSha256":"$EXPECTED_ARCHIVE_SHA256","clean":true}
EOF

CURRENT_PHASE="SIGNING_VALIDATION"
BLOCKER_CODE="R832-P3-SIGNING-001"
log "VALIDATE PRODUCTION UPLOAD SIGNING"
printf '%s' "$MATHPRO_UPLOAD_KEYSTORE_B64" | base64 --decode > "$WORK/signing/mathpro-upload.jks"
[[ -s "$WORK/signing/mathpro-upload.jks" ]] || exit 3
EXPECTED_CERT="$(normalize_sha "$MATHPRO_UPLOAD_CERT_SHA256")"
[[ "$EXPECTED_CERT" =~ ^[0-9A-F]{64}$ ]] || { echo R832_EXPECTED_CERT_FORMAT_INVALID >&2; exit 3; }
keytool -exportcert -keystore "$WORK/signing/mathpro-upload.jks" -storepass "$MATHPRO_UPLOAD_STORE_PASSWORD" -alias "$MATHPRO_UPLOAD_KEY_ALIAS" -file "$WORK/signing/cert.der" >/dev/null 2>&1 || exit 3
ACTUAL_CERT="$(normalize_sha "$(sha256_file "$WORK/signing/cert.der")")"
require_eq "$ACTUAL_CERT" "$EXPECTED_CERT" R832_UPLOAD_CERT_SHA256 || exit 3
python3 - <<'PYPROPS'
import os,pathlib
def esc(v):
    return v.replace('\\','\\\\').replace('\r','\\r').replace('\n','\\n')
vals={
 'storeFile':os.environ['WORK']+'/signing/mathpro-upload.jks',
 'storePassword':os.environ['MATHPRO_UPLOAD_STORE_PASSWORD'],
 'keyAlias':os.environ['MATHPRO_UPLOAD_KEY_ALIAS'],
 'keyPassword':os.environ['MATHPRO_UPLOAD_KEY_PASSWORD'],
}
pathlib.Path(os.environ['WORK']+'/signing/release.properties').write_text(''.join(f'{k}={esc(v)}\n' for k,v in vals.items()),encoding='utf-8')
PYPROPS
export MATHPRO_RELEASE_KEY_PROPERTIES="$WORK/signing/release.properties"
cat > "$WORK/evidence/signing-input-validation.json" <<EOF
{"certificateSha256":"$ACTUAL_CERT","aliasPresent":true,"keystoreDecoded":true,"secretValuesLogged":false}
EOF
BLOCKER_CODE="R832-P3-HOST-GATES-001"

CURRENT_PHASE="ACTIVE_HOST_AUTHORITY_GATES"
log "RUN 51 ACTIVE HOST/AUTHORITY GATES"
python3 - "$PROJECT" "$WORK/evidence/host-gates" <<'PY'
import csv,json,os,pathlib,shutil,subprocess,sys,time
from datetime import datetime,timezone
source=pathlib.Path(sys.argv[1]); out=pathlib.Path(sys.argv[2]); runner=out/'runner'; logs=out/'logs'
shutil.rmtree(out,ignore_errors=True); logs.mkdir(parents=True)
subprocess.run(['git','clone','--no-hardlinks','--quiet',str(source),str(runner)],check=True)
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=runner,text=True).strip(); tree=subprocess.check_output(['git','rev-parse','HEAD^{tree}'],cwd=runner,text=True).strip()
rows=list(csv.DictReader((runner/'R823_TEST_DISPOSITION.csv').open(encoding='utf-8-sig'))); active=[r for r in rows if r['classification']=='ACTIVE_CANONICAL_HOST']; results=[]
for idx,row in enumerate(active,1):
 t=row['test']; timeout=int(row['timeoutSeconds']); start=datetime.now(timezone.utc); t0=time.monotonic(); cmd=[sys.executable,str(runner/'test'/t)]
 env={**os.environ,'PYTHONDONTWRITEBYTECODE':'1','GIT_OPTIONAL_LOCKS':'0'}
 try:
  cp=subprocess.run(cmd,cwd=runner,text=True,capture_output=True,timeout=timeout,env=env); rc=cp.returncode; stdout=cp.stdout; stderr=cp.stderr; status='PASS' if rc==0 else 'FAIL'
 except subprocess.TimeoutExpired as e:
  rc=124; status='TIMEOUT'; stdout=(e.stdout or b'').decode(errors='replace') if not isinstance(e.stdout,str) else (e.stdout or ''); stderr=(e.stderr or b'').decode(errors='replace') if not isinstance(e.stderr,str) else (e.stderr or '')
 dur=round(time.monotonic()-t0,3); dirty=subprocess.check_output(['git','status','--short'],cwd=runner,text=True,env=env).strip(); name=f'{idx:02d}_{t}.log'
 (logs/name).write_text(f'COMMAND={cmd!r}\nSTART={start.isoformat()}\nDURATION_SECONDS={dur}\nEXIT_CODE={rc}\nSTATUS={status}\nDIRTY_AFTER={dirty!r}\n\n--- STDOUT ---\n{stdout}\n--- STDERR ---\n{stderr}\n',encoding='utf-8')
 results.append({'test':t,'status':status,'exitCode':rc,'durationSeconds':dur,'dirtyAfter':dirty,'log':name}); print(f'[{idx:02d}/{len(active)}] {t}: {status}',flush=True)
 subprocess.run(['git','reset','--hard','--quiet','HEAD'],cwd=runner,check=True); subprocess.run(['git','clean','-fdx','--quiet'],cwd=runner,check=True)
summary={'schema':'R832_ACTIVE_HOST_GATE_FINAL.v1','sourceHead':head,'sourceTree':tree,'total':len(results),'passed':sum(x['status']=='PASS' for x in results),'failed':sum(x['status']=='FAIL' for x in results),'timeout':sum(x['status']=='TIMEOUT' for x in results),'results':results}
(out/'summary.json').write_text(json.dumps(summary,indent=2,sort_keys=True),encoding='utf-8')
if summary['total']!=51 or summary['passed']!=51 or summary['failed'] or summary['timeout']: raise SystemExit(summary)
PY

CURRENT_PHASE="PINNED_TOOLCHAIN"
BLOCKER_CODE="R832-P3-TOOLCHAIN-001"
log "INSTALL PINNED FLUTTER AND COHERENT ANDROID CLOSURE"
cd "$WORK/toolchain"
BASE='https://github.com/sercan321/mathpro-offline-ocr-bundle/releases/download/r828c-flutter-pub-20260720-v1'
for n in r828c-flutter-sdk.part-000 r828c-flutter-sdk.part-001 r828c-flutter-sdk.part-002 r828c-pub-cache.tar.zst; do curl --fail --location --retry 5 --retry-delay 3 --silent --show-error -o "$n" "$BASE/$n"; done
require_eq "$(sha256_file r828c-flutter-sdk.part-000)" 5249d692b8a010c5baa896156960797e496d8a82b85b1274620ee52454e335c7 FLUTTER_000
require_eq "$(sha256_file r828c-flutter-sdk.part-001)" 2425d14baed134099a05709381d01b690641b940e4c16ad8ba1293b007dd1455 FLUTTER_001
require_eq "$(sha256_file r828c-flutter-sdk.part-002)" 1ff82df19da82d950aac9991a38ec8cd613dcdf737881b902364ec9e862fdc02 FLUTTER_002
require_eq "$(sha256_file r828c-pub-cache.tar.zst)" 0adf3b6d075948408e70c13da6580f8ccd7cdeecdde06a91e545b9ca53a8a417 PUB_CACHE
cat r828c-flutter-sdk.part-000 r828c-flutter-sdk.part-001 r828c-flutter-sdk.part-002 > flutter-sdk.tar.zst
mkdir -p flutter pub
tar --zstd -xf flutter-sdk.tar.zst -C flutter
tar --zstd -xf r828c-pub-cache.tar.zst -C pub
FLUTTER_BIN="$(find "$WORK/toolchain/flutter" -type f -path '*/bin/flutter' -print -quit)"; PUB_MARKER="$(find "$WORK/toolchain/pub" -type d -path '*/hosted/pub.dev' -print -quit)"
[[ -n "$FLUTTER_BIN" && -n "$PUB_MARKER" ]] || exit 1
FLUTTER_ROOT="$(dirname "$(dirname "$FLUTTER_BIN")")"; PUB_CACHE="$(dirname "$(dirname "$PUB_MARKER")")"
export FLUTTER_ROOT PUB_CACHE PATH="$FLUTTER_ROOT/bin:$PATH"
export HOME="$WORK/toolchain-home"; export GRADLE_USER_HOME="$HOME/.gradle"; mkdir -p "$HOME"
git config --global --add safe.directory "$FLUTTER_ROOT"
dart pub get --offline --enforce-lockfile --example --directory "$FLUTTER_ROOT/packages/flutter_tools" | tee "$WORK/logs/flutter-tools-relocation.log"
flutter --version --machine | tee "$WORK/evidence/flutter-version.json"
python3 - "$WORK/evidence/flutter-version.json" <<'PY'
import json,sys
p=json.load(open(sys.argv[1])); assert p['frameworkVersion']=='3.44.6',p; assert p['dartSdkVersion'].split()[0]=='3.12.2',p
PY
flutter config --no-analytics
flutter precache --android
ANDROID_SDK="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}"; [[ -d "$ANDROID_SDK" ]] || exit 1
SDKMANAGER="$(find "$ANDROID_SDK/cmdline-tools" -type f -name sdkmanager -print | sort -V | tail -1)"
if [[ -x "$SDKMANAGER" ]]; then yes | "$SDKMANAGER" --licenses >/dev/null 2>&1 || true; "$SDKMANAGER" 'platforms;android-36' 'build-tools;36.0.0' 'ndk;28.2.13676358' | tee "$WORK/logs/sdkmanager.log"; fi
APKSIGNER="$(find "$ANDROID_SDK/build-tools" -type f -name apksigner -print | sort -V | tail -1)"; ZIPALIGN="$(find "$ANDROID_SDK/build-tools" -type f -name zipalign -print | sort -V | tail -1)"; AAPT="$(find "$ANDROID_SDK/build-tools" -type f -name aapt -print | sort -V | tail -1)"
[[ -x "$APKSIGNER" && -x "$ZIPALIGN" && -x "$AAPT" ]] || exit 1
java -version 2>&1 | tee "$WORK/evidence/java-version.txt"; python3.10 --version 2>&1 | tee "$WORK/evidence/python-version.txt"

prepare_tree(){
 local target="$1" home="$2"
 rm -rf "$target" "$home"; git clone --no-hardlinks --quiet "$PROJECT" "$target"; mkdir -p "$home"
 require_eq "$(git -C "$target" rev-parse HEAD)" "$EXPECTED_HEAD" "${target}_HEAD"
 require_eq "$(git -C "$target" rev-parse 'HEAD^{tree}')" "$EXPECTED_TREE" "${target}_TREE"
 [[ -z "$(git -C "$target" status --short)" ]] || exit 1
 cat > "$target/android/local.properties" <<EOF
sdk.dir=$ANDROID_SDK
flutter.sdk=$FLUTTER_ROOT
flutter.buildMode=release
flutter.versionName=0.832.0
flutter.versionCode=83200
EOF
}
run_tests(){
 local target="$1" label="$2"
 cd "$target"; flutter clean | tee "$WORK/logs/${label}-clean.log"; flutter pub get --offline | tee "$WORK/logs/${label}-pub.log"; flutter analyze --no-pub | tee "$WORK/logs/${label}-analyze.log"
 set +e; flutter test --no-pub --machine 2>&1 | tee "$WORK/logs/${label}-test-machine.log"; code=${PIPESTATUS[0]}; set -e; [[ "$code" == 0 ]] || exit "$code"
 python3 - "$WORK/logs/${label}-test-machine.log" "$WORK/evidence/${label}-test-summary.json" "$label" <<'PY'
import json,pathlib,sys
rows=[]
for line in pathlib.Path(sys.argv[1]).read_text(errors='replace').splitlines():
 try:e=json.loads(line)
 except:continue
 if e.get('type')=='testDone' and not e.get('hidden',False):rows.append(e)
out={'schema':'R832_FLUTTER_TEST_SUMMARY.v1','label':sys.argv[3],'total':len(rows),'success':sum(x.get('result')=='success' for x in rows),'skipped':sum(x.get('skipped') is True for x in rows),'failed':sum(x.get('result') not in ('success',None) for x in rows)}
pathlib.Path(sys.argv[2]).write_text(json.dumps(out,indent=2,sort_keys=True)); print(out)
if not rows or out['failed'] or out['skipped']: raise SystemExit(out)
PY
 [[ -z "$(git status --short --untracked-files=no)" ]] || { git status --short --untracked-files=no; exit 1; }
}
build_pair(){
 local target="$1" label="$2"
 cd "$target"; flutter build apk --release --target-platform android-arm64 | tee "$WORK/logs/${label}-apk.log"; flutter build appbundle --release --target-platform android-arm64 | tee "$WORK/logs/${label}-aab.log"
 local apk="$target/build/app/outputs/flutter-apk/app-release.apk" aab="$target/build/app/outputs/bundle/release/app-release.aab"; [[ -s "$apk" && -s "$aab" ]] || exit 1
 mkdir -p "$WORK/evidence/$label"; cp "$apk" "$WORK/evidence/$label/MathPro_R832_${label}_PRODUCTION.apk"; cp "$aab" "$WORK/evidence/$label/MathPro_R832_${label}_PRODUCTION.aab"
 local md=''; for d in "$target/build/app/outputs/mapping/release" "$target/android/app/build/outputs/mapping/release"; do [[ -d "$d" ]] && md="$d" && break; done; [[ -n "$md" ]] || exit 1
 for n in mapping.txt usage.txt seeds.txt configuration.txt; do [[ -s "$md/$n" ]] || exit 1; cp "$md/$n" "$WORK/evidence/$label/$n"; done
 [[ -e "$md/missing_rules.txt" ]] && cp "$md/missing_rules.txt" "$WORK/evidence/$label/"
 "$APKSIGNER" verify --verbose --print-certs "$apk" > "$WORK/evidence/$label/apksigner.txt"; "$ZIPALIGN" -c -P 16 -v 4 "$apk" > "$WORK/evidence/$label/zipalign.txt"; jarsigner -verify -verbose -certs "$aab" > "$WORK/evidence/$label/aab-jarsigner.txt"; keytool -printcert -jarfile "$aab" > "$WORK/evidence/$label/aab-cert.txt"
 local apk_cert aab_cert; apk_cert="$(grep -i 'certificate SHA-256 digest:' "$WORK/evidence/$label/apksigner.txt" | head -1 | sed 's/.*digest:[[:space:]]*//' || true)"; aab_cert="$(grep -i 'SHA256:' "$WORK/evidence/$label/aab-cert.txt" | head -1 | sed 's/.*SHA256:[[:space:]]*//' || true)"
 require_eq "$(normalize_sha "$apk_cert")" "$EXPECTED_CERT" "${label}_APK_CERT"; require_eq "$(normalize_sha "$aab_cert")" "$EXPECTED_CERT" "${label}_AAB_CERT"
 "$AAPT" dump badging "$apk" > "$WORK/evidence/$label/aapt-badging.txt"; "$AAPT" dump permissions "$apk" > "$WORK/evidence/$label/aapt-permissions.txt"
}

CURRENT_PHASE="COHERENT_DEPENDENCY_SEED"
BLOCKER_CODE="R832-P3-OFFLINE-CLOSURE-001"
SEED="$WORK/seed-source"; SEED_HOME="$WORK/seed-home"; prepare_tree "$SEED" "$SEED_HOME"; export HOME="$SEED_HOME" GRADLE_USER_HOME="$SEED_HOME/.gradle"; git config --global --add safe.directory "$FLUTTER_ROOT"; git config --global --add safe.directory "$SEED"
cd "$SEED"; flutter clean; flutter pub get --offline; flutter build apk --release --target-platform android-arm64 | tee "$WORK/logs/seed-apk.log"; flutter build appbundle --release --target-platform android-arm64 | tee "$WORK/logs/seed-aab.log"; (cd android && ./gradlew --stop) || true
rm -rf "$SEED_HOME/.gradle/caches/build-cache-"* "$SEED_HOME/.gradle/daemon" "$SEED_HOME/.gradle/workers" "$SEED_HOME/.gradle/notifications"; rm -rf "$SEED"
tar --zstd -cf "$WORK/toolchain/coherent-home-seed.tar.zst" -C "$SEED_HOME" .
sha256sum "$WORK/toolchain/coherent-home-seed.tar.zst" > "$WORK/evidence/coherent-home-seed.sha256"

run_cert_build(){
 local label="$1" block="$2" target="$WORK/${label,,}-source" home="$WORK/${label,,}-home"
 prepare_tree "$target" "$home"; tar --zstd -xf "$WORK/toolchain/coherent-home-seed.tar.zst" -C "$home"; export HOME="$home" GRADLE_USER_HOME="$home/.gradle"; mkdir -p "$GRADLE_USER_HOME"; printf '\norg.gradle.offline=true\norg.gradle.caching=false\n' >> "$GRADLE_USER_HOME/gradle.properties"; git config --global --add safe.directory "$FLUTTER_ROOT"; git config --global --add safe.directory "$target"
 if [[ "$block" == yes ]]; then network_block; fi
 run_tests "$target" "$label"; build_pair "$target" "$label"
 if [[ "$block" == yes ]]; then network_restore; fi
 (cd "$target/android" && ./gradlew --stop) || true
}
network_block(){ sudo iptables -N R832_OFFLINE; sudo iptables -A R832_OFFLINE -o lo -j ACCEPT; sudo iptables -A R832_OFFLINE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT; sudo iptables -A R832_OFFLINE -j REJECT; sudo iptables -I OUTPUT 1 -j R832_OFFLINE; echo NETWORK_BLOCK_ACTIVE > "$WORK/evidence/network-block.txt"; }
network_restore(){ sudo iptables -D OUTPUT -j R832_OFFLINE 2>/dev/null || true; sudo iptables -F R832_OFFLINE 2>/dev/null || true; sudo iptables -X R832_OFFLINE 2>/dev/null || true; }
trap 'rc=$?; network_restore; finalize_return "$rc"; exit "$rc"' EXIT
CURRENT_PHASE="BUILD_A"; BLOCKER_CODE="R832-P3-BUILD-A-001"; run_cert_build BUILD_A no
CURRENT_PHASE="BUILD_B_NETWORK_BLOCKED"; BLOCKER_CODE="R832-P3-BUILD-B-001"; run_cert_build BUILD_B yes
network_restore
trap 'rc=$?; finalize_return "$rc"; exit "$rc"' EXIT

CURRENT_PHASE="ARTIFACT_R8_REPRODUCIBILITY_AUDIT"
BLOCKER_CODE="R832-P3-ARTIFACT-AUDIT-001"
log "ARTIFACT, R8 AND REPRODUCIBILITY AUDIT"
cat > "$WORK/audit.py" <<'PY'
import hashlib,json,pathlib,sys,zipfile
kind,path,out=sys.argv[1],pathlib.Path(sys.argv[2]),pathlib.Path(sys.argv[3]); needles=[b'/home/runner/',b'/mnt/data/',b'\\Users\\',b'C:\\Users\\',b'MATHPRO_UPLOAD_STORE_PASSWORD']
r={'kind':kind,'size':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
with zipfile.ZipFile(path) as z:
 infos=z.infolist(); names=[i.filename.replace('\\','/') for i in infos]; entries={}; hits=[]; integ=[]; abis=set(); models=[]
 for i,n in zip(infos,names):
  h=hashlib.sha256(); carry=b''
  with z.open(i) as f:
   while True:
    c=f.read(1024*1024)
    if not c:break
    h.update(c); d=carry+c
    for q in needles:
     if q in d:hits.append([n,q.decode('latin1')])
    if b'dev.flutter.plugins.integration_test' in d:integ.append(n)
    carry=d[-128:]
  p=pathlib.PurePosixPath(n).parts
  for j,x in enumerate(p[:-1]):
   if x=='lib' and p[j+1] in {'arm64-v8a','armeabi-v7a','x86','x86_64'}:abis.add(p[j+1])
  if n.lower().endswith(('.onnx','.pt','.tflite','.pth')):models.append(n)
  entries[n]={'size':i.file_size,'sha256':h.hexdigest()}
 r.update({'crcBadEntry':z.testzip(),'duplicates':sorted({n for n in names if names.count(n)>1}),'unsafePaths':[n for n in names if pathlib.PurePosixPath(n).is_absolute() or '..' in pathlib.PurePosixPath(n).parts],'abis':sorted(abis),'hostPathHits':hits,'integrationTestHits':sorted(set(integ)),'embeddedModels':models,'hasOnnxRuntime':any('onnxruntime' in n.lower() for n in names),'hasChaquopy':any('chaquopy' in n.lower() or 'libpython3.10' in n.lower() for n in names),'entryMap':entries})
errs=[]
for k in ('crcBadEntry','duplicates','unsafePaths','hostPathHits','integrationTestHits','embeddedModels'):
 if r[k]:errs.append(k)
if r['abis']!=['arm64-v8a']:errs.append('abis')
if not r['hasOnnxRuntime']:errs.append('onnxRuntimeMissing')
if not r['hasChaquopy']:errs.append('chaquopyMissing')
r['errors']=errs; out.write_text(json.dumps(r,indent=2,sort_keys=True)); print({k:r[k] for k in ('kind','size','sha256','abis','errors')})
if errs:raise SystemExit(errs)
PY
for label in BUILD_A BUILD_B; do python3 "$WORK/audit.py" APK "$WORK/evidence/$label/MathPro_R832_${label}_PRODUCTION.apk" "$WORK/evidence/$label/apk-audit.json"; python3 "$WORK/audit.py" AAB "$WORK/evidence/$label/MathPro_R832_${label}_PRODUCTION.aab" "$WORK/evidence/$label/aab-audit.json"; done
python3 - "$WORK/evidence" <<'PY'
import json,pathlib,sys
r=pathlib.Path(sys.argv[1]); out={}
for kind in ('apk','aab'):
 a=json.load(open(r/'BUILD_A'/f'{kind}-audit.json')); b=json.load(open(r/'BUILD_B'/f'{kind}-audit.json')); am=a['entryMap']; bm=b['entryMap']; dif=[]
 for n in sorted(set(am)|set(bm)):
  u=n.upper()
  if kind=='aab' and u.startswith('META-INF/') and (u.endswith('.RSA') or u.endswith('.SF') or u.endswith('MANIFEST.MF')):continue
  if am.get(n)!=bm.get(n):dif.append(n)
 out[kind.upper()]={'rawEqual':a['sha256']==b['sha256'],'normalizedEqual':not dif,'differenceCount':len(dif),'differences':dif[:500]}
 if dif:raise SystemExit(f'{kind} differences={len(dif)}')
(r/'R832_REPRODUCIBILITY.json').write_text(json.dumps(out,indent=2,sort_keys=True)); print(out)
PY
cmp "$WORK/evidence/BUILD_A/mapping.txt" "$WORK/evidence/BUILD_B/mapping.txt"
python3 "$PROJECT/test/r831_release_r8_signing_guard.py" | tee "$WORK/logs/final-r8-signing-static-guard.log"

CURRENT_PHASE="FINAL_PASS"
BLOCKER_CODE="NONE"
cat > "$WORK/evidence/R832_PHASE3_PASS_SUMMARY.json" <<EOF
{
 "schema":"R832_MEGA_PHASE3_PASS_SUMMARY.v1",
 "sourceHead":"$EXPECTED_HEAD",
 "sourceTree":"$EXPECTED_TREE",
 "activeHostGates":"51/51 PASS",
 "flutterAnalyzeTest":"PASS",
 "buildA":"SIGNED APK+AAB PASS",
 "buildB":"NETWORK-BLOCKED SIGNED APK+AAB PASS",
 "productionCertificateSha256":"$EXPECTED_CERT",
 "r8Audit":"PASS",
 "artifactAudit":"PASS",
 "normalizedReproducibility":"PASS",
 "megaPhase3":"PASS",
 "megaPhase4":"AUTHORIZED",
 "releaseReady":false,
 "falsePass":false
}
EOF
exit 0
