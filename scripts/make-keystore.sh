#!/usr/bin/env bash
# Dev signing key for local APKs. Not committed.
set -euo pipefail

DIR="${FACILITAT_KEYSTORE_DIR:-${HOME}/.config/facilitat-browser}"
STORE="${DIR}/dev.keystore"
ENVF="${DIR}/keystore.env"
ALIAS="${FACILITAT_KEY_ALIAS:-dev}"

mkdir -p "${DIR}"
chmod 700 "${DIR}"

if [[ -f "${STORE}" ]]; then
  echo "keystore exists: ${STORE}"
  exit 0
fi

PASS="$(python3 -c 'import secrets; print(secrets.token_urlsafe(24))')"

keytool -genkeypair -v \
  -keystore "${STORE}" \
  -alias "${ALIAS}" \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass "${PASS}" -keypass "${PASS}" \
  -dname "CN=Canopy (dev), OU=Facilitat-dev, O=Facilitat-dev, C=US"

cat > "${ENVF}" <<EOF
ANDROID_KEYSTORE_PATH=${STORE}
ANDROID_KEYSTORE_NAME=${ALIAS}
ANDROID_KEYSTORE_PASSWORD=${PASS}
EOF
chmod 600 "${STORE}" "${ENVF}"
echo "wrote ${STORE} and ${ENVF}"
