# Encryption Tutorials

Welcome to the **Encryption Tutorials** collection! This folder contains comprehensive guides and scripts to help you encrypt your data, manage keys, and secure sensitive information. Whether you're setting up full-disk encryption, protecting files, or automating secure backups, this collection has you covered.

---

## **Why Encryption Matters**

Encryption is the cornerstone of modern security. It ensures:
- **Confidentiality**: Your sensitive data is accessible only to authorized users.
- **Integrity**: Prevents tampering by verifying that your data hasn’t been altered.
- **Compliance**: Meets regulatory requirements like GDPR, HIPAA, and CCPA.

Whether you're securing your personal files, managing cryptographic keys for SSH, or encrypting cloud backups, encryption is essential for protecting your digital life.

---

## **Key Features of These Tutorials**

- **Step-by-Step Instructions**: Clear, concise, and beginner-friendly guides.
- **Real-World Use Cases**: Apply encryption to practical scenarios like cloud backups, USB drives, and SSH.
- **Automation Scripts**: Pre-built scripts to simplify repetitive encryption tasks.
- **Advanced Techniques**: Learn about modern encryption tools like LUKS, GPG, and Age.

---

## **Getting Started**

### **Prerequisites**
Before diving into the tutorials, make sure you have:
1. A Linux system with administrative privileges.
2. Common encryption tools installed, such as:
   - **LUKS** for disk encryption.
   - **GPG** for file and email encryption.
   - **OpenSSH** for secure key management.

Install the required tools:
```bash
sudo apt update
sudo apt install cryptsetup gnupg openssh-client
```

---

## **Table of Contents**

### **Disk Encryption**
1. [Custom LUKS Encryption Settings](./custom-luks-encryption.md)  
   Learn how to configure LUKS with custom algorithms, key sizes, and advanced parameters for maximum security.

2. [Using YubiKey for Full-Disk Encryption](./full-disk-encryption-yubikey.md)  
   Secure your disk with LUKS encryption and detached headers managed by a YubiKey.

3. [Encrypting USB Drives with LUKS](./usb-drive-encryption.md)  
   Protect portable data by encrypting your USB drives with LUKS.

---

### **File Encryption**
4. [Encrypting Files with GPG](./gpg-file-encryption.md)  
   Use GPG to encrypt, sign, and secure individual files with strong cryptography.

5. [Automating File Encryption with GPG Scripts](./gpg-encryption-automation.md)  
   Simplify file encryption tasks with automation scripts using GPG.

6. [Using Age for File Encryption](./age-encryption.md)  
   Explore Age, a modern and user-friendly alternative to GPG for file encryption.

---

### **Key Management**
7. [SSH Key Encryption and Management](./ssh-key-encryption.md)  
   Secure your SSH keys with passphrase protection and advanced encryption methods.

8. [Encrypting Swap Space](./encrypting-swap-space.md)  
   Ensure sensitive data in swap space is encrypted to prevent leaks.

---

### **Networking and Cloud Security**
9. [Encrypting Network Traffic with OpenVPN](./encrypting-network-traffic.md)  
   Secure your internet connection and encrypt all network traffic using OpenVPN.

10. [Encrypting Cloud Backups with GPG](./encrypting-cloud-backups.md)  
    Protect sensitive data before uploading it to cloud storage.

11. [Securing Remote Backups with Rsync and Encryption](./rsync-encryption.md)  
    Automate secure remote backups using `rsync` combined with GPG or SSH.

---

## **Scripts**

For automation and convenience, check out the pre-built scripts included in this collection. These scripts simplify encryption tasks and integrate easily into your workflows.

### **Available Scripts**
- **[Automated GPG File Encryption Script](./scripts/encrypt-files.sh)**  
  Encrypt all files in a directory using GPG.
  
- **[LUKS Encrypted USB Auto-Mount Script](./scripts/auto-mount-luks-usb.sh)**  
  Automatically unlock and mount a LUKS-encrypted USB drive.

---

## **What’s Next?**

Looking to expand your encryption knowledge? Here are some additional areas to explore:
- **Advanced Key Management**: Dive deeper into GPG and hardware tokens like YubiKey.
- **Cloud Integration**: Securely encrypt and transfer data to cloud storage providers.
- **File Integrity Checks**: Use cryptographic hashes to verify file integrity.

---

## **Contributing**

Have a suggestion or an idea for a new tutorial? Contributions are welcome! Submit your ideas or improvements via pull requests.

---

## **License**

This collection of encryption tutorials is provided under the [MIT License](./LICENSE). You are free to use, modify, and distribute these guides, with proper attribution.