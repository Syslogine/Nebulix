# YubiKey

Welcome to the **YubiKey** collection! This folder contains step-by-step guides to help you integrate and use your YubiKey for various security and authentication purposes. Whether you're securing SSH, encrypting your disk, or setting up multi-factor authentication, we've got you covered.

---

## **What is a YubiKey?**

A **YubiKey** is a small, USB or NFC-enabled hardware device that acts as a **security key** for protecting your online accounts, systems, and sensitive data. Manufactured by **Yubico**, the YubiKey is widely recognized for its simplicity, durability, and robust security features.

### **Features of a YubiKey**:
- **Multi-Factor Authentication (MFA)**: Works with services like Google, GitHub, and Microsoft.
- **Passwordless Login**: Supports modern protocols like **WebAuthn** and **FIDO2** for secure, password-free access.
- **Encryption**: Stores cryptographic keys for signing, encrypting, and decrypting data.
- **SSH Authentication**: Acts as a hardware token for secure SSH logins.
- **Tamper-Resistant**: Built with secure elements to prevent physical and software-based attacks.
- **Cross-Platform**: Compatible with Linux, macOS, Windows, Android, and iOS.

---

## **Why Use a YubiKey?**

- **Unmatched Security**: Protects your accounts and systems with hardware-backed authentication, resistant to phishing and keylogging attacks.
- **Ease of Use**: No batteries, no network connection—just plug it in or tap it (NFC-enabled versions).
- **Future-Proof**: Supports cutting-edge security standards like **FIDO2**, **WebAuthn**, and **OpenPGP**.
- **Durability**: Water-resistant and crush-proof for long-lasting use.
- **Affordable Peace of Mind**: Available at various price points to suit your security needs.

---

## **YubiKey Pricing**

YubiKeys are available in different models to cater to a variety of use cases:

| Model                 | Features                      | Price (Approx.)       |
|-----------------------|-------------------------------|-----------------------|
| **YubiKey 5 NFC**     | USB-A, NFC, FIDO2, OTP, PGP   | $55 USD / €50 EUR     |
| **YubiKey 5C NFC**    | USB-C, NFC, FIDO2, OTP, PGP   | $60 USD / €55 EUR     |
| **YubiKey 5C**        | USB-C, FIDO2, OTP, PGP        | $50 USD / €45 EUR     |
| **YubiKey Bio**       | Biometric, USB-A/C, FIDO2     | $80 USD / €75 EUR     |
| **Security Key NFC**  | USB-A, NFC, FIDO2, WebAuthn   | $30 USD / €25 EUR     |
| **Security Key C NFC**| USB-C, NFC, FIDO2, WebAuthn   | $35 USD / €30 EUR     |

You can purchase YubiKeys directly from the [official Yubico website](https://www.yubico.com/) or authorized resellers.

---

## **Why Everyone Needs a YubiKey**

### **For Individuals**:
- Protects personal accounts like Gmail, Facebook, and Twitter.
- Adds a layer of hardware-based security to password managers like LastPass and 1Password.

### **For Developers and IT Professionals**:
- Secures SSH keys and GitHub access.
- Ensures tamper-proof encryption for sensitive data.

### **For Organizations**:
- Enforces phishing-resistant MFA for employees.
- Simplifies compliance with security regulations like GDPR and CCPA.

Investing in a YubiKey is an investment in peace of mind. With its ability to stop phishing attacks, secure your most sensitive systems, and provide a seamless authentication experience, a YubiKey is the ultimate tool for staying safe online.

---

## Table of Contents

### **Multi-Factor Authentication (MFA)**
1. [Setting Up MFA at Boot with YubiKey](./mfa-boot-debian-yubikey.md)  
   Secure your boot process by using a YubiKey as a second factor for unlocking your encrypted disk during boot.

2. [Adding a Backup YubiKey](./add-backup-yubikey-luks.md)  
   Enroll a backup YubiKey to ensure you’re never locked out of your system if your primary YubiKey is unavailable.

---

### **SSH and Encryption**
3. [Using YubiKey for SSH Authentication](./yubikey-ssh-authentication.md)  
   Use your YubiKey as a hardware token for secure SSH logins.

4. [Using YubiKey as a PGP Smartcard](./yubikey-pgp-smartcard.md)  
   Configure your YubiKey as a PGP smartcard for signing, encrypting, and decrypting data securely.

5. [Using YubiKey for Full-Disk Encryption with Detached Headers](./yubikey-luks-detached-header.md)  
   Enhance LUKS encryption by storing detached headers on the YubiKey for added protection.

---

### **Web and Application Authentication**
6. [Setting Up YubiKey for Two-Factor Authentication (2FA)](./yubikey-two-factor-auth.md)  
   Use your YubiKey to enable two-factor authentication for online accounts and applications.

7. [Using YubiKey for WebAuthn/FIDO2 Authentication](./yubikey-webauthn-fido2.md)  
   Configure your YubiKey for passwordless login using WebAuthn or FIDO2.

8. [Using YubiKey for GPG-Encrypted Emails](./yubikey-gpg-email-encryption.md)  
   Secure your emails by signing and encrypting them with your YubiKey.

---

### **System Security**
9. [Using YubiKey for PAM Authentication](./yubikey-pam-authentication.md)  
   Integrate YubiKey with Linux PAM for secure sudo and login authentication.

10. [Using YubiKey as a Static Password Generator](./yubikey-static-password.md)  
    Configure the YubiKey to generate static passwords for enhanced system security.

---

### **Networking and VPN**
11. [Using YubiKey for VPN Authentication](./yubikey-vpn-authentication.md)  
    Authenticate with OpenVPN or other VPN services using your YubiKey.

---

### **Password Management**
12. [Setting Up YubiKey for Password Manager Integration](./yubikey-password-manager.md)  
    Use your YubiKey to secure access to your password manager, like KeePassXC or LastPass.

---

## **Ready to Secure Your Digital Life?**

Dive into the tutorials and experience the unmatched security and convenience of the YubiKey. Whether you’re an individual, developer, or organization, the YubiKey is your ultimate tool for staying safe online.

---

## License

This collection of tutorials is provided under the [MIT License](./LICENSE).
