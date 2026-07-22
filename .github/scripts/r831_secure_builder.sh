#!/usr/bin/env bash
set -Eeuo pipefail
shopt -s inherit_errexit

log() { printf '\n=== %s ===\n' "$*"; }
sha256_file() { sha256sum "$1" | awk '{print $1}'; }
require_eq() {
  local actual="$1" expected="$2" label="$3"
  [[ "$actual" == "$expected" ]] || {
    echo "${label}_MISMATCH expected=$expected actual=$actual" >&2
    exit 1
  }
}

: "${GH_TOKEN:?}"
: "${GITHUB_REPOSITORY:?}"
: "${GITHUB_RUN_ID:?}"
: "${GITHUB_HEAD_REF:?}"
: "${PR_NUMBER:?}"
: "${RUNNER_TEMP:?}"

EXPECTED_SOURCE_SHA256="92fb5db60bfa410eef96c0b2054a6e5c8ea62bae762ed3951365296372c8caeb"
EXPECTED_SOURCE_FILE_COUNT="1091"
WORK="$RUNNER_TEMP/r831-secure-truth-closure"
PAYLOAD_ROOT=".github/r831_secure_payload/${GITHUB_RUN_ID}"
rm -rf "$WORK"
mkdir -p "$WORK/handshake" "$WORK/payload" "$WORK/source" "$WORK/toolchain" "$WORK/logs" "$WORK/evidence" "$WORK/return"

api_get() {
  curl --fail --location --silent --show-error \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" "$1"
}

log "EPHEMERAL SOURCE-DECRYPTION HANDSHAKE"
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 \
  -out "$WORK/handshake/source-private.pem" >/dev/null 2>&1
openssl pkey -in "$WORK/handshake/source-private.pem" -pubout \
  -out "$WORK/handshake/source-public.pem" >/dev/null 2>&1
chmod 600 "$WORK/handshake/source-private.pem"
SOURCE_PUBLIC_B64="$(base64 -w0 "$WORK/handshake/source-public.pem")"
SOURCE_PUBLIC_SHA256="$(sha256_file "$WORK/handshake/source-public.pem")"
export SOURCE_PUBLIC_B64 SOURCE_PUBLIC_SHA256
python3 - <<'PY' > "$WORK/handshake/comment.json"
import json, os
body='\n'.join([
  '## R831 Secure Source Handshake',
  '',
  f'R831_SECURE_HANDSHAKE_RUN=`{os.environ["GITHUB_RUN_ID"]}`',
  f'R831_SOURCE_PUBLIC_KEY_SHA256=`{os.environ["SOURCE_PUBLIC_SHA256"]}`',
  '',
  '```text', os.environ['SOURCE_PUBLIC_B64'], '```',
  '',
  'Only ciphertext may be uploaded. The private key exists only in this runner process.'
])
print(json.dumps({'body':body}))
PY
curl --fail --silent --show-error -X POST \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H "Content-Type: application/json" \
  --data-binary @"$WORK/handshake/comment.json" \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/issues/${PR_NUMBER}/comments" \
  > "$WORK/handshake/comment-response.json"
echo "R831_SECURE_HANDSHAKE_PUBLISHED run=$GITHUB_RUN_ID publicKeySha256=$SOURCE_PUBLIC_SHA256"

log "WAIT FOR ENCRYPTED SOURCE PAYLOAD"
MANIFEST_API="https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/${PAYLOAD_ROOT}/manifest.json?ref=${GITHUB_HEAD_REF}"
manifest_ready=0
for attempt in $(seq 1 360); do
  status="$(curl --silent --show-error -o "$WORK/payload/manifest-response.json" -w '%{http_code}' \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" "$MANIFEST_API")"
  if [[ "$status" == 200 ]]; then
    python3 - "$WORK/payload/manifest-response.json" "$WORK/payload/manifest.json" <<'PY'
import base64,json,pathlib,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
pathlib.Path(sys.argv[2]).write_bytes(base64.b64decode(p['content']))
PY
    manifest_ready=1
    break
  fi
  [[ "$status" == 404 ]] || { echo "R831_MANIFEST_HTTP_STATUS=$status" >&2; exit 1; }
  if (( attempt % 12 == 0 )); then echo "R831_WAITING_FOR_CIPHERTEXT attempt=$attempt"; fi
  sleep 5
done
[[ "$manifest_ready" == 1 ]] || { echo R831_ENCRYPTED_SOURCE_TIMEOUT >&2; exit 1; }

python3 - "$WORK/payload/manifest.json" "$GITHUB_RUN_ID" "$EXPECTED_SOURCE_SHA256" <<'PY'
import json,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
assert p.get('schema')=='R831_SECURE_SOURCE_PAYLOAD.v1',p
assert str(p.get('runId'))==sys.argv[2],p
assert p.get('sourcePlainSha256')==sys.argv[3],p
assert isinstance(p.get('chunks'),list) and p['chunks'],p
assert p.get('returnPublicKeyB64') and p.get('returnPublicKeySha256'),p
print('R831_SECURE_MANIFEST_VALID=PASS chunks=%d' % len(p['chunks']))
PY

log "DOWNLOAD AND VERIFY CIPHERTEXT CHUNKS"
python3 - "$WORK/payload/manifest.json" > "$WORK/payload/download.tsv" <<'PY'
import json,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
for row in p['chunks']:
    print(f"{row['path']}\t{row['sha256']}\t{row['size']}")
print(f"{p['encryptedKeyPath']}\t{p['encryptedKeySha256']}\t{p['encryptedKeySize']}")
PY
: > "$WORK/payload/source.enc"
chunk_index=0
while IFS=$'\t' read -r path expected_sha expected_size; do
  response="$WORK/payload/response-${chunk_index}.json"
  output="$WORK/payload/blob-${chunk_index}.bin"
  api_get "https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/${path}?ref=${GITHUB_HEAD_REF}" > "$response"
  python3 - "$response" "$output" <<'PY'
import base64,json,pathlib,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
pathlib.Path(sys.argv[2]).write_bytes(base64.b64decode(p['content']))
PY
  require_eq "$(stat -c %s "$output")" "$expected_size" "R831_CIPHER_BLOB_SIZE_${chunk_index}"
  require_eq "$(sha256_file "$output")" "$expected_sha" "R831_CIPHER_BLOB_SHA_${chunk_index}"
  if [[ "$path" == *'/key.enc' ]]; then
    mv "$output" "$WORK/payload/key.enc"
  else
    cat "$output" >> "$WORK/payload/source.enc"
  fi
  chunk_index=$((chunk_index+1))
done < "$WORK/payload/download.tsv"

CIPHER_SHA="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["sourceCipherSha256"])')"
CIPHER_SIZE="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["sourceCipherSize"])')"
require_eq "$(stat -c %s "$WORK/payload/source.enc")" "$CIPHER_SIZE" R831_SOURCE_CIPHER_SIZE
require_eq "$(sha256_file "$WORK/payload/source.enc")" "$CIPHER_SHA" R831_SOURCE_CIPHER_SHA256

log "DECRYPT EXACT FINAL SOURCE"
openssl pkeyutl -decrypt \
  -inkey "$WORK/handshake/source-private.pem" \
  -pkeyopt rsa_padding_mode:oaep \
  -pkeyopt rsa_oaep_md:sha256 \
  -in "$WORK/payload/key.enc" \
  -out "$WORK/payload/aes.key"
AES_KEY_HEX="$(xxd -p -c 256 "$WORK/payload/aes.key")"
IV_HEX="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["ivHex"])')"
openssl enc -d -aes-256-cbc -K "$AES_KEY_HEX" -iv "$IV_HEX" \
  -in "$WORK/payload/source.enc" -out "$WORK/payload/r831-final-project.tar.xz"
require_eq "$(sha256_file "$WORK/payload/r831-final-project.tar.xz")" "$EXPECTED_SOURCE_SHA256" R831_FINAL_SOURCE_ARCHIVE_SHA256
mkdir -p "$WORK/source/PROJECT"
tar -xJf "$WORK/payload/r831-final-project.tar.xz" -C "$WORK/source/PROJECT"
PROJECT="$WORK/source/PROJECT"
file_count="$(find "$PROJECT" -type f | wc -l | tr -d ' ')"
require_eq "$file_count" "$EXPECTED_SOURCE_FILE_COUNT" R831_FINAL_SOURCE_FILE_COUNT
require_eq "$(sha256_file "$PROJECT/android/app/src/main/python/mathpro_canonical_boundary.py")" "23c3be3c04c06e283d5da9d8cf1f8875523bf05619262139d2b292772cee5dfe" R831_CANONICAL_BOUNDARY_SHA256
require_eq "$(sha256_file "$PROJECT/android/app/src/main/python/mathpro_plan_parse_authority.py")" "8b18382996146085f76a54cd313c1752728a742477a483cbdf8df5e50bcae479" R831_PLAN_PARSE_AUTHORITY_SHA256
require_eq "$(sha256_file "$PROJECT/tool/authority_guard/authority_baseline_v3.json")" "91534a38418b0a25476f2795ab3f32f76064819477ed4836143f8f894971638b" R831_AUTHORITY_BASELINE_SHA256
chmod +x "$PROJECT/android/gradlew"
rm -f "$WORK/payload/aes.key" "$WORK/handshake/source-private.pem"
echo "R831_EXACT_FINAL_SOURCE_DECRYPTED=PASS sha256=$EXPECTED_SOURCE_SHA256 files=$file_count"

log "FINAL SOURCE HOST/AUTHORITY GATES"
(
  cd "$PROJECT"
  mkdir -p "$WORK/evidence/host"
  MATHPRO_EVIDENCE_DIR="$WORK/evidence/host/r800" python3 test/r800_authority_guard_v3.py | tee "$WORK/logs/r800.log"
  MATHPRO_EVIDENCE_DIR="$WORK/evidence/host/r802" python3 test/r802_zero_authority_independent_audit.py | tee "$WORK/logs/r802.log"
  MATHPRO_EVIDENCE_DIR="$WORK/evidence/host/r823" python3 test/r823_test_disposition_guard.py | tee "$WORK/logs/r823.log"
  MATHPRO_EVIDENCE_DIR="$WORK/evidence/host/r829" python3 test/r829_semantic_surface_closure_guard.py | tee "$WORK/logs/r829.log"
  R801_WORKERS=4 MATHPRO_EVIDENCE_DIR="$WORK/evidence/host/r801" python3 test/r801_authority_guard_v3_mutation_campaign.py | tee "$WORK/logs/r801.log"
  python3 test/r831_release_r8_signing_guard.py | tee "$WORK/logs/r831-release-r8-signing-guard.log"
  rm -f R801_AUTHORITY_GUARD_V3_MUTATION_CAMPAIGN.json
)
echo R831_FINAL_HOST_GATES=PASS

log "PINNED FLUTTER / PUB TOOLCHAIN"
cd "$WORK/toolchain"
BASE="https://github.com/sercan321/mathpro-offline-ocr-bundle/releases/download/r828c-flutter-pub-20260720-v1"
for name in r828c-flutter-sdk.part-000 r828c-flutter-sdk.part-001 r828c-flutter-sdk.part-002 r828c-pub-cache.tar.zst; do
  curl --fail --location --retry 5 --retry-delay 3 --silent --show-error -o "$name" "$BASE/$name"
done
require_eq "$(sha256_file r828c-flutter-sdk.part-000)" "5249d692b8a010c5baa896156960797e496d8a82b85b1274620ee52454e335c7" FLUTTER_PART_000
require_eq "$(sha256_file r828c-flutter-sdk.part-001)" "2425d14baed134099a05709381d01b690641b940e4c16ad8ba1293b007dd1455" FLUTTER_PART_001
require_eq "$(sha256_file r828c-flutter-sdk.part-002)" "1ff82df19da82d950aac9991a38ec8cd613dcdf737881b902364ec9e862fdc02" FLUTTER_PART_002
require_eq "$(sha256_file r828c-pub-cache.tar.zst)" "0adf3b6d075948408e70c13da6580f8ccd7cdeecdde06a91e545b9ca53a8a417" PUB_CACHE
cat r828c-flutter-sdk.part-000 r828c-flutter-sdk.part-001 r828c-flutter-sdk.part-002 > flutter-sdk.tar.zst
mkdir -p "$WORK/toolchain/flutter" "$WORK/toolchain/pub"
tar --zstd -xf flutter-sdk.tar.zst -C "$WORK/toolchain/flutter"
tar --zstd -xf r828c-pub-cache.tar.zst -C "$WORK/toolchain/pub"
FLUTTER_BIN="$(find "$WORK/toolchain/flutter" -type f -path '*/bin/flutter' -print -quit)"
PUB_MARKER="$(find "$WORK/toolchain/pub" -type d -path '*/hosted/pub.dev' -print -quit)"
[[ -n "$FLUTTER_BIN" && -n "$PUB_MARKER" ]] || { echo R831_TOOLCHAIN_LAYOUT_INVALID >&2; exit 1; }
FLUTTER_ROOT="$(dirname "$(dirname "$FLUTTER_BIN")")"
PUB_CACHE="$(dirname "$(dirname "$PUB_MARKER")")"
export FLUTTER_ROOT PUB_CACHE PATH="$FLUTTER_ROOT/bin:$PATH"
hash -r
git config --global --add safe.directory "$FLUTTER_ROOT"
flutter --version --machine > "$WORK/evidence/flutter-version.json"
python3 - "$WORK/evidence/flutter-version.json" <<'PY'
import json,sys
p=json.load(open(sys.argv[1],encoding='utf-8'))
assert p['frameworkVersion']=='3.44.6',p
assert p['dartSdkVersion'].split()[0]=='3.12.2',p
print('R831_FLUTTER_VERSION=3.44.6')
print('R831_DART_VERSION=3.12.2')
PY
flutter config --no-analytics
flutter precache --android

ANDROID_SDK="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}"
[[ -n "$ANDROID_SDK" && -d "$ANDROID_SDK" ]] || { echo R831_ANDROID_SDK_NOT_FOUND >&2; exit 1; }
APKSIGNER="$(find "$ANDROID_SDK/build-tools" -type f -name apksigner -print | sort -V | tail -1)"
ZIPALIGN="$(find "$ANDROID_SDK/build-tools" -type f -name zipalign -print | sort -V | tail -1)"
[[ -x "$APKSIGNER" && -x "$ZIPALIGN" ]] || { echo R831_ANDROID_BUILD_TOOLS_MISSING >&2; exit 1; }
java -version 2>&1 | tee "$WORK/evidence/java-version.txt"
python3 --version 2>&1 | tee "$WORK/evidence/python-version.txt"

log "NON-PRODUCTION SIGNING KEY FOR BUILD A/B COMPARISON"
KEY_DIR="$WORK/nonproduction-signing"
mkdir -p "$KEY_DIR"
KEYSTORE="$KEY_DIR/r831-nonproduction.p12"
keytool -genkeypair -noprompt -keystore "$KEYSTORE" -storetype PKCS12 \
  -storepass r831nonprodpass -keypass r831nonprodpass -alias r831nonprod \
  -keyalg RSA -keysize 2048 -validity 2 \
  -dname 'CN=R831 NonProduction Validation, OU=CI, O=MathPro, L=Istanbul, ST=Istanbul, C=TR'
SIGNING_PROPERTIES="$KEY_DIR/release.properties"
cat > "$SIGNING_PROPERTIES" <<EOF
storeFile=$KEYSTORE
storePassword=r831nonprodpass
keyAlias=r831nonprod
keyPassword=r831nonprodpass
EOF
export MATHPRO_RELEASE_KEY_PROPERTIES="$SIGNING_PROPERTIES"

prepare_tree() {
  local target="$1"
  rm -rf "$target"
  cp -a "$PROJECT" "$target"
  cat > "$target/android/local.properties" <<EOF
sdk.dir=$ANDROID_SDK
flutter.sdk=$FLUTTER_ROOT
flutter.buildMode=release
flutter.versionName=0.831.0
flutter.versionCode=83100
EOF
}

run_quality_gates() {
  local target="$1" label="$2"
  cd "$target"
  flutter pub get --offline | tee "$WORK/logs/${label}-pub-get.log"
  flutter analyze --no-pub | tee "$WORK/logs/${label}-analyze.log"
  set +e
  flutter test --no-pub --machine | tee "$WORK/logs/${label}-test-machine.log"
  local code=${PIPESTATUS[0]}
  set -e
  [[ "$code" == 0 ]] || { echo "R831_${label}_FLUTTER_TEST_FAILED=$code" >&2; exit "$code"; }
  python3 - "$WORK/logs/${label}-test-machine.log" "$WORK/evidence/${label}-test-summary.json" "$label" <<'PY'
import json,pathlib,sys
rows=[]
for line in pathlib.Path(sys.argv[1]).read_text(encoding='utf-8',errors='replace').splitlines():
    try: e=json.loads(line)
    except Exception: continue
    if e.get('type')=='testDone' and not e.get('hidden',False): rows.append(e)
out={'schema':'R831_FLUTTER_TEST_SUMMARY.v1','label':sys.argv[3],'testDoneCount':len(rows),'success':sum(e.get('result')=='success' for e in rows),'skipped':sum(e.get('skipped') is True for e in rows),'failed':sum(e.get('result') not in ('success',None) for e in rows)}
if not rows or out['failed']: raise SystemExit(out)
pathlib.Path(sys.argv[2]).write_text(json.dumps(out,indent=2,sort_keys=True),encoding='utf-8')
print(json.dumps(out,sort_keys=True))
PY
}

build_pair() {
  local target="$1" label="$2"
  cd "$target"
  flutter build apk --release --target-platform android-arm64 | tee "$WORK/logs/${label}-apk-build.log"
  flutter build appbundle --release --target-platform android-arm64 | tee "$WORK/logs/${label}-aab-build.log"
  local apk="$target/build/app/outputs/flutter-apk/app-release.apk"
  local aab="$target/build/app/outputs/bundle/release/app-release.aab"
  [[ -s "$apk" && -s "$aab" ]] || { echo "R831_${label}_ARTIFACT_MISSING" >&2; exit 1; }
  mkdir -p "$WORK/evidence/${label}"
  cp "$apk" "$WORK/evidence/${label}/MathPro_R831_${label}_NONPRODUCTION_R8.apk"
  cp "$aab" "$WORK/evidence/${label}/MathPro_R831_${label}_NONPRODUCTION_R8.aab"
  local mapping_dir=""
  for d in "$target/build/app/outputs/mapping/release" "$target/android/app/build/outputs/mapping/release"; do
    [[ -d "$d" ]] && mapping_dir="$d" && break
  done
  [[ -n "$mapping_dir" ]] || { echo "R831_${label}_R8_MAPPING_DIR_MISSING" >&2; exit 1; }
  for name in mapping.txt usage.txt seeds.txt configuration.txt; do
    [[ -s "$mapping_dir/$name" ]] || { echo "R831_${label}_R8_${name}_MISSING" >&2; exit 1; }
    cp "$mapping_dir/$name" "$WORK/evidence/${label}/$name"
  done
  [[ ! -e "$mapping_dir/missing_rules.txt" || -s "$mapping_dir/missing_rules.txt" ]] || { echo "R831_${label}_EMPTY_MISSING_RULES" >&2; exit 1; }
  [[ -e "$mapping_dir/missing_rules.txt" ]] && cp "$mapping_dir/missing_rules.txt" "$WORK/evidence/${label}/"
  "$APKSIGNER" verify --verbose --print-certs "$apk" > "$WORK/evidence/${label}/apksigner.txt"
  "$ZIPALIGN" -c -P 16 -v 4 "$apk" > "$WORK/evidence/${label}/zipalign.txt"
  jarsigner -verify -strict -verbose -certs "$aab" > "$WORK/evidence/${label}/aab-jarsigner.txt"
}

network_block() {
  sudo iptables -N R831_OFFLINE
  sudo iptables -A R831_OFFLINE -o lo -j ACCEPT
  sudo iptables -A R831_OFFLINE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  sudo iptables -A R831_OFFLINE -j REJECT
  sudo iptables -I OUTPUT 1 -j R831_OFFLINE
}
network_restore() {
  sudo iptables -D OUTPUT -j R831_OFFLINE 2>/dev/null || true
  sudo iptables -F R831_OFFLINE 2>/dev/null || true
  sudo iptables -X R831_OFFLINE 2>/dev/null || true
}
trap network_restore EXIT

BUILD_A="$WORK/build-a"
BUILD_B="$WORK/build-b"
prepare_tree "$BUILD_A"
run_quality_gates "$BUILD_A" build_a
build_pair "$BUILD_A" BUILD_A
prepare_tree "$BUILD_B"
network_block
run_quality_gates "$BUILD_B" build_b
build_pair "$BUILD_B" BUILD_B
network_restore
trap - EXIT

log "APK/AAB CONTENT AUDIT AND REPRODUCIBILITY"
cat > "$WORK/audit.py" <<'PY'
import hashlib,json,pathlib,sys,zipfile
kind,path,out=sys.argv[1],pathlib.Path(sys.argv[2]),pathlib.Path(sys.argv[3])
needles=[b'/home/runner/',b'/mnt/data/',b'\\Users\\',b'C:\\Users\\',b'RUNNER_TEMP']
r={'kind':kind,'size':path.stat().st_size,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
with zipfile.ZipFile(path) as z:
  infos=z.infolist(); names=[i.filename.replace('\\','/') for i in infos]; bad=z.testzip(); entries={}; host=[]; integ=[]; abis=set()
  for i,n in zip(infos,names):
    h=hashlib.sha256(); carry=b''
    with z.open(i) as f:
      while True:
        c=f.read(1024*1024)
        if not c: break
        h.update(c); data=carry+c
        for x in needles:
          if x in data: host.append([n,x.decode('latin1')])
        if b'dev.flutter.plugins.integration_test' in data or b'dev/flutter/plugins/integration_test' in data: integ.append(n)
        carry=data[-128:]
    p=pathlib.PurePosixPath(n).parts
    for j,x in enumerate(p[:-1]):
      if x=='lib' and p[j+1] in {'arm64-v8a','armeabi-v7a','x86','x86_64'}: abis.add(p[j+1])
    entries[n]={'size':i.file_size,'crc':i.CRC,'sha256':h.hexdigest()}
  dup=sorted({n for n in names if names.count(n)>1})
  unsafe=[n for n in names if pathlib.PurePosixPath(n).is_absolute() or '..' in pathlib.PurePosixPath(n).parts]
  r.update({'crcBadEntry':bad,'duplicates':dup,'unsafePaths':unsafe,'abis':sorted(abis),'hostPathHits':host,'integrationTestHits':sorted(set(integ)),'entryMap':entries})
errs=[]
if r['crcBadEntry'] is not None: errs.append('CRC')
if r['duplicates']: errs.append('DUPLICATE')
if r['unsafePaths']: errs.append('UNSAFE')
if r['abis']!=['arm64-v8a']: errs.append('ABI')
if r['hostPathHits']: errs.append('HOST_PATH')
if r['integrationTestHits']: errs.append('INTEGRATION_TEST')
r['errors']=errs
out.write_text(json.dumps(r,indent=2,sort_keys=True),encoding='utf-8')
print(json.dumps({k:r[k] for k in ('kind','size','sha256','abis','errors')},sort_keys=True))
if errs: raise SystemExit(errs)
PY
for label in BUILD_A BUILD_B; do
  python3 "$WORK/audit.py" APK "$WORK/evidence/$label/MathPro_R831_${label}_NONPRODUCTION_R8.apk" "$WORK/evidence/$label/apk-audit.json"
  python3 "$WORK/audit.py" AAB "$WORK/evidence/$label/MathPro_R831_${label}_NONPRODUCTION_R8.aab" "$WORK/evidence/$label/aab-audit.json"
done
python3 - "$WORK/evidence" <<'PY'
import json,pathlib,sys
root=pathlib.Path(sys.argv[1]); result={}
for kind in ('apk','aab'):
  a=json.load(open(root/'BUILD_A'/f'{kind}-audit.json')); b=json.load(open(root/'BUILD_B'/f'{kind}-audit.json'))
  am=a['entryMap']; bm=b['entryMap']; names=sorted(set(am)|set(bm)); diffs=[]
  for n in names:
    u=n.upper()
    if kind=='aab' and u.startswith('META-INF/') and (u.endswith('.RSA') or u.endswith('.SF') or u.endswith('MANIFEST.MF')): continue
    if am.get(n)!=bm.get(n): diffs.append(n)
  result[kind.upper()]={'rawEqual':a['sha256']==b['sha256'],'normalizedEqual':not diffs,'differenceCount':len(diffs),'differences':diffs[:200]}
  if diffs: raise SystemExit(f'R831_{kind.upper()}_REPRODUCIBILITY_FAIL count={len(diffs)}')
(root/'R831_REPRODUCIBILITY.json').write_text(json.dumps(result,indent=2,sort_keys=True),encoding='utf-8')
print(json.dumps(result,sort_keys=True))
PY
cmp "$WORK/evidence/BUILD_A/mapping.txt" "$WORK/evidence/BUILD_B/mapping.txt"
echo R831_R8_MAPPING_REPRODUCIBILITY=PASS

log "FINAL DECISION"
DECISION="BLOCKED"
BLOCKER="R831-P3-SIGNING-001"
cat > "$WORK/evidence/R831_FINAL_DECISION.json" <<EOF
{
  "schema": "R831_MEGA_PHASE3_FINAL_DECISION.v1",
  "decision": "$DECISION",
  "blocker": "$BLOCKER",
  "exactSourceSha256": "$EXPECTED_SOURCE_SHA256",
  "hostGates": "PASS",
  "flutterAnalyzeTest": "PASS",
  "dualCleanR8Build": "PASS",
  "artifactAudit": "PASS",
  "reproducibility": "PASS",
  "productionSigning": "NOT_AVAILABLE",
  "megaPhase4": "BLOCKED",
  "releaseReady": false
}
EOF

log "ENCRYPT RETURN EVIDENCE"
RETURN_PUBLIC_B64="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["returnPublicKeyB64"])')"
RETURN_PUBLIC_SHA="$(python3 -c 'import json;print(json.load(open("'$WORK'/payload/manifest.json"))["returnPublicKeySha256"])')"
printf '%s' "$RETURN_PUBLIC_B64" | base64 --decode > "$WORK/return/return-public.pem"
require_eq "$(sha256_file "$WORK/return/return-public.pem")" "$RETURN_PUBLIC_SHA" R831_RETURN_PUBLIC_KEY_SHA256
tar --zstd -cf "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.tar.zst" -C "$WORK" evidence logs
RETURN_PLAIN_SHA="$(sha256_file "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.tar.zst")"
openssl rand 32 > "$WORK/return/return-aes.key"
RETURN_KEY_HEX="$(xxd -p -c 256 "$WORK/return/return-aes.key")"
RETURN_IV_HEX="$(openssl rand -hex 16)"
openssl enc -aes-256-cbc -K "$RETURN_KEY_HEX" -iv "$RETURN_IV_HEX" \
  -in "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.tar.zst" \
  -out "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.enc"
openssl pkeyutl -encrypt -pubin -inkey "$WORK/return/return-public.pem" \
  -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 \
  -in "$WORK/return/return-aes.key" -out "$WORK/return/R831_RETURN_KEY.enc"
rm -f "$WORK/return/return-aes.key" "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.tar.zst"
cat > "$WORK/return/R831_RETURN_MANIFEST.json" <<EOF
{
  "schema": "R831_SECURE_RETURN.v1",
  "runId": "$GITHUB_RUN_ID",
  "decision": "$DECISION",
  "blocker": "$BLOCKER",
  "plainSha256": "$RETURN_PLAIN_SHA",
  "cipherSha256": "$(sha256_file "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.enc")",
  "cipherSize": $(stat -c %s "$WORK/return/R831_MEGA_PHASE3_ENCRYPTED_RETURN.enc"),
  "encryptedKeySha256": "$(sha256_file "$WORK/return/R831_RETURN_KEY.enc")",
  "ivHex": "$RETURN_IV_HEX"
}
EOF
rm -f "$WORK/return/return-public.pem"
echo "R831_SECURE_RETURN_READY=PASS decision=$DECISION blocker=$BLOCKER plainSha256=$RETURN_PLAIN_SHA"
exit 3
