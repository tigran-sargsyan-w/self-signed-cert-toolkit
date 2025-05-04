#!/bin/bash

# === CONFIGURATION (edit these values) ===

FIRST_NAME="First_Name"
LAST_NAME="Last_Name"
EMAIL="user@example.com"
COUNTRY="XX"
STATE="Example-State"
CITY="Example-City"
ORGANIZATION="ExampleOrg"
ORG_UNIT="ExampleUnit"
DAYS_VALID=365
P12_PASSWORD="example-password"

# === GENERATED FILE NAMES ===

BASENAME="$(echo "${FIRST_NAME}_${LAST_NAME}" | tr '[:upper:]' '[:lower:]')"
KEY_FILE="${BASENAME}.key"
CRT_FILE="${BASENAME}.crt"
P12_FILE="${BASENAME}.p12"
ALIAS="${FIRST_NAME} ${LAST_NAME} Signature"

# === GENERATE PRIVATE KEY (encrypted with password) ===

echo "🔐 Generating encrypted private key: $KEY_FILE"
openssl genpkey -algorithm RSA -aes256 -out "$KEY_FILE"
if [ $? -ne 0 ]; then
  echo "❌ Failed to generate private key"
  exit 1
fi

# === CREATE SELF-SIGNED CERTIFICATE ===

echo "📄 Creating self-signed certificate: $CRT_FILE"
openssl req -new -x509 -key "$KEY_FILE" -out "$CRT_FILE" -days "$DAYS_VALID" \
-subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$FIRST_NAME $LAST_NAME/emailAddress=$EMAIL"
if [ $? -ne 0 ]; then
  echo "❌ Failed to create certificate"
  exit 1
fi

# === EXPORT TO .P12 CONTAINER ===

echo "📦 Exporting to .p12 container: $P12_FILE"
openssl pkcs12 -export \
  -out "$P12_FILE" \
  -inkey "$KEY_FILE" \
  -in "$CRT_FILE" \
  -name "$ALIAS" \
  -passout pass:"$P12_PASSWORD"
if [ $? -ne 0 ]; then
  echo "❌ Failed to export .p12 file"
  exit 1
fi

# === SUCCESS ===

echo ""
echo "✅ Certificate files created successfully:"
echo "   🔑 Private Key:         $KEY_FILE (password protected)"
echo "   📄 Certificate:         $CRT_FILE"
echo "   📦 PKCS#12 Container:   $P12_FILE"
echo "   🏷  Alias (for signing): \"$ALIAS\""
echo "   🔐 P12 Password:        $P12_PASSWORD"
