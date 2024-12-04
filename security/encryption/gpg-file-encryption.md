# Encrypting and Decrypting Files with GPG

Protect your sensitive data by encrypting files using **GPG (GNU Privacy Guard)**. This tutorial guides you through encrypting and decrypting files, both for personal use and secure sharing with others.

---

## **Overview**

Using GPG for file encryption provides:
- **Data Security**: Encrypt files so only authorized recipients can decrypt them.
- **Authentication**: Sign files to prove their origin and integrity.
- **Versatility**: Use GPG for personal backups or secure file sharing.

---

## **Prerequisites**

1. A Linux system with GPG installed.
2. At least one GPG key pair for encryption and decryption.

Install GPG if not already installed:
```bash
sudo apt update
sudo apt install gnupg
```

---

## **Step 1: Generate a GPG Key Pair**

1. **Generate a New Key Pair**:
   ```bash
   gpg --full-generate-key
   ```
   - Choose **RSA and RSA** for the key type.
   - Set a key size (recommended: **4096 bits**).
   - Configure an expiration date (optional, recommended: 1 year).
   - Provide your name and email address.

2. **Verify Your Key Pair**:
   List your GPG keys:
   ```bash
   gpg --list-keys
   ```

---

## **Step 2: Encrypt a File**

1. **Encrypt a File for Yourself**:
   Use your public key to encrypt the file:
   ```bash
   gpg --encrypt --recipient "your_email@example.com" file.txt
   ```
   - Replace `your_email@example.com` with your GPG email address.
   - This creates an encrypted file, `file.txt.gpg`.

2. **Encrypt a File for Sharing**:
   - Export the recipient’s public key (or ensure they provide it):
     ```bash
     gpg --export --armor recipient@example.com > recipient_public_key.asc
     ```
   - Encrypt the file using the recipient’s public key:
     ```bash
     gpg --encrypt --recipient "recipient@example.com" file.txt
     ```

---

## **Step 3: Decrypt a File**

1. **Decrypt an Encrypted File**:
   Use your private key to decrypt the file:
   ```bash
   gpg --decrypt file.txt.gpg
   ```
   - The decrypted content will be displayed in the terminal.
   - To save the output to a file:
     ```bash
     gpg --output decrypted_file.txt --decrypt file.txt.gpg
     ```

2. **Test Decryption**:
   Verify the decrypted file matches the original:
   ```bash
   diff file.txt decrypted_file.txt
   ```

---

## **Step 4: Sign and Verify Files**

### **Sign a File**
1. Sign a file with your private key:
   ```bash
   gpg --sign file.txt
   ```
   - This creates a signed file, `file.txt.gpg`.

2. Create a detached signature:
   ```bash
   gpg --detach-sign file.txt
   ```
   - This creates a separate signature file, `file.txt.sig`.

### **Verify a Signature**
1. Verify a signed file:
   ```bash
   gpg --verify file.txt.gpg
   ```
2. Verify a detached signature:
   ```bash
   gpg --verify file.txt.sig file.txt
   ```

---

## **Step 5: Export and Share Keys**

### **Export Your Public Key**
Export your public key to share with others:
```bash
gpg --export --armor your_email@example.com > public_key.asc
```

### **Import a Public Key**
Import a public key from a file:
```bash
gpg --import public_key.asc
```

---

## **Step 6: Backup and Manage Keys**

### **Backup Your Private Key**
Export your private key securely:
```bash
gpg --export-secret-keys --armor your_email@example.com > private_key_backup.asc
```
- Store the backup in a secure location.

### **Revoke a Key**
If your key is compromised, create a revocation certificate:
```bash
gpg --output revoke_cert.asc --gen-revoke your_email@example.com
```

---

## **Step 7: Advanced Options**

### **Encrypt with a Password**
Encrypt a file without a public key using a password:
```bash
gpg --symmetric file.txt
```
- You will be prompted to set a password.
- Decrypt the file with:
  ```bash
  gpg --decrypt file.txt.gpg
  ```

### **Use Compression**
Compress the file during encryption:
```bash
gpg --encrypt --recipient "your_email@example.com" --compress-algo zlib file.txt
```

---

## **Troubleshooting**

### **GPG Key Not Found**
- Ensure your keyring includes the recipient's public key:
  ```bash
  gpg --list-keys
  ```

### **Decryption Fails**
- Ensure your private key is present:
  ```bash
  gpg --list-secret-keys
  ```

---

## **Conclusion**

Using GPG for file encryption ensures that your sensitive data remains secure and verifiable. Whether you’re encrypting personal backups or sharing files securely, GPG offers robust and flexible cryptographic protection.