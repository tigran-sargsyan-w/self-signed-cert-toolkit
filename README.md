# Self-Signed Certificate Toolkit

This repository provides a simple and configurable shell script for generating **self-signed digital certificates** in `.p12` (PKCS#12) format. These certificates can be used for **digitally signing** various types of content such as:

- 📄 PDF documents (e.g. via JSignPdf, Acrobat, PDF Studio)
- 📬 Email messages (S/MIME in Thunderbird, Outlook)
- 💻 Software code and installers (JAR, EXE, MSI, scripts)
- 📝 Office documents (LibreOffice, Microsoft Word)
- 🌐 Internal TLS/SSL (for private networks or local development)

---

## ✨ Use Cases

This toolkit is ideal for:

- Developers or freelancers who need to **sign PDF contracts** or deliverables.
- Internal teams who want to **digitally sign emails or scripts** without using paid certificate authorities (CA).
- Testers who want to simulate certificate-based authentication in **local or staging environments**.
- Anyone who needs **quick, personal-use digital signatures** without relying on external infrastructure.

---

## ⚙️ What It Does

The script performs the following steps:

1. Generates a **password-protected RSA private key**.
2. Creates a **self-signed X.509 certificate** with your details.
3. Bundles the key and certificate into a `.p12` container, compatible with many signature tools.
4. Outputs all generated files.

---

## 📦 Output Files

| File name              | Description                                |                                  |
|------------------------|--------------------------------------------|----------------------------------|
| `first_last.key`       | Encrypted private key (PEM format)         | ❌ Do NOT share — keep private  |
| `first_last.crt`       | Self-signed certificate (X.509)            | ✅ Yes — can be shared publicly |
| `first_last.p12`       | PKCS#12 container for signing tools        | ⚠️ Only with full trust         |

---

## 🔧 How to Use

### 1. Clone the repository

```
git clone https://github.com/your-username/self-signed-cert-toolkit.git
```
### 2. Move to directory

```
cd self-signed-cert-toolkit
```

### 3. Edit the configuration

Open the `create_certificate.sh` script and modify the variables at the top:

```
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
```

### 3. Make the script executable

```
chmod +x create_certificate.sh
```

### 4. Run it

```
./create_certificate.sh
```

You will be asked to:
- Enter a **password for the private key**
- Confirm that password
- Re-enter it again when exporting to `.p12`

---

## ✅ Example Output

```
🔐 Generating encrypted private key: first_last.key
📄 Creating self-signed certificate: first_last.crt
📦 Exporting to .p12 container: first_last.p12

✅ Certificate files created successfully:
   🔑 Private Key:         first_last.key (password protected)
   📄 Certificate:         first_last.crt
   📦 PKCS#12 Container:   first_last.p12
   🏷  Alias (for signing): "First_Name Last_Name Signature"
   🔐 P12 Password:        example-password
```

---

## 📌 Notes & Considerations

- The **private key is encrypted**, and you'll be asked for the password when generating or using the certificate.
- The `.p12` file is protected with the password defined in the script (`P12_PASSWORD`) — this is the one you use in PDF or email signing tools.
- These certificates are **not issued by a certificate authority (CA)**. PDF readers or email clients may show warnings unless you manually trust the certificate.
- For production use (especially software distribution or legal contracts), consider using a certificate issued by a trusted CA.

---

## 🛡️ Security Reminder

Do **not share your private key (`.key`)**. Only distribute the `.crt` or `.p12` if needed — and **only to trusted recipients**(not recommended).

---

