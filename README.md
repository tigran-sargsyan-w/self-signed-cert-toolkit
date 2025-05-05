# Self-Signed Certificate Toolkit

This repository provides a simple and configurable shell script for generating **self-signed digital certificates** in `.p12` (PKCS#12) format. These certificates can be used for **digitally signing** various types of content such as:

- 📄 PDF documents (e.g. via [JSignPdf](https://jsignpdf.sourceforge.net/), Acrobat, PDF Studio)
- 📬 Email messages (S/MIME in Thunderbird, Outlook)
- 💻 Software code and installers (JAR, EXE, MSI, scripts)
- 📝 Office documents (LibreOffice, Microsoft Word)
- 🌐 Internal TLS/SSL (for private networks or local development)

---

## 📚 Table of Contents

- [✨ Use Cases](#-use-cases)
- [⚙️ What It Does](#️-what-it-does)
- [📦 Output Files](#-output-files)
- [📦 Requirements](#-requirements)
- [🔧 How to Use](#-how-to-use)
- [✅ Example Output](#-example-output)
- [📘 Signing Guides](#-signing-guides)
- [📌 Notes & Considerations](#-notes--considerations)
- [🛡️ Security Reminder](#️-security-reminder)

---

## ✨ Use Cases

This toolkit is designed for developers, teams, and individuals who need to **digitally sign documents or content** without relying on paid or external certificate authorities (CAs). It provides an accessible and reproducible way to generate trusted `.p12`-formatted self-signed certificates for a wide range of purposes.

### ✅ Examples of Where This Toolkit Is Useful

- **📄 Freelancers & Remote Workers**  
  Digitally sign project contracts, invoices, NDAs, and other documents in PDF format to give them a professional and verifiable finish — without needing to print, scan, or physically sign.

- **💼 Internal Corporate Use**  
  Use internally trusted self-signed certificates to sign internal tools, PDFs, and scripts for distribution across internal systems where full CA trust isn't necessary.

- **🧪 QA & Test Automation**  
  Create certificates to test or simulate signature validation flows (PDF readers, signature checking scripts, etc.) in staging and development environments.

- **📬 Personal Email Signing (S/MIME)**  
  Sign your personal or organizational emails using tools like Thunderbird or Outlook for better email authenticity and identity verification.

- **💻 Developer Code Signing (Non-public)**  
  Sign executable scripts or JAR files during development — useful for internal testing or early distribution to trusted users, especially in closed environments.

- **📝 LibreOffice / MS Word Document Signing**  
  Digitally sign ODT, DOCX, XLSX, etc. to demonstrate integrity and authorship without involving third-party CAs.

- **🌐 Self-hosted Services**  
  Generate internal TLS certificates for use in self-hosted environments, development servers, Docker containers, etc.

---

### ⚠️ When Not to Use This

While self-signed certificates are great for personal or internal use, **they are not appropriate for production use on public platforms**, such as:

- Public-facing web servers (instead, use Let's Encrypt or a trusted CA)
- Official software distributions (e.g. EXEs, DMGs, MSI installers)
- Legal documents requiring compliance with eIDAS, Adobe AATL, or national trust lists

If you need public or legally verifiable signatures, you should obtain a certificate from a **trusted certificate authority (CA)**.


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

## 📦 Requirements

To use this toolkit, your system must have:

- **Bash** — A POSIX-compatible shell (Linux, macOS Terminal, WSL, or Git Bash on Windows)
- **OpenSSL** — Version 1.1 or later

You can check if OpenSSL is available by running:

```
openssl version
```

If your system shows `LibreSSL` (as is common on macOS), we recommend installing OpenSSL via [Homebrew](https://brew.sh/):

```
brew install openssl
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
```

### 🪟 Windows Notes

On Windows, you can run this script in:

- **WSL (Windows Subsystem for Linux)** — Recommended and fully supported
- **Git Bash or MSYS2** — Works with OpenSSL installed

If OpenSSL is not recognized in Git Bash, install it using MSYS2:

```
pacman -S mingw-w64-ucrt-x86_64-openssl
```

> 🛠 Make sure `openssl` is available in your system `PATH`.

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

## 📘 Signing Guides

To use your `.p12` certificate with specific tools, check the following guides:

| Tool             | Guide                                      |
|------------------|--------------------------------------------|
| 🖥️ JSignPdf       | [PDF signing with JSignPdf →](docs/JSignPdf_Usage_Guide.md)     |
| 📝 Adobe Acrobat  | [PDF signing with Adobe Acrobat →](docs/Acrobat_Usage_Guide.md) |
| 📬 Thunderbird    | _(Coming soon)_                            |
| 🧾 LibreOffice    | _(Coming soon)_                            |

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

