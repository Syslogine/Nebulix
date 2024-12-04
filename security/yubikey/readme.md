# YubiKey Tutorials

Welcome to the **YubiKey Tutorials** collection! This folder contains step-by-step guides to help you integrate and use your YubiKey for various security and authentication purposes. Whether you're securing SSH, encrypting your disk, or setting up multi-factor authentication, we've got you covered.

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

## Getting Started

1. **Install YubiKey Tools**  
   Ensure you have the necessary tools installed on your system:
   ```bash
   sudo apt update
   sudo apt install yubikey-manager yubikey-luks gnupg
   ```

2. **Verify Your YubiKey**  
   Plug in your YubiKey and check if it's detected:
   ```bash
   lsusb | grep Yubico
   ```

3. **Choose a Tutorial**  
   Navigate to any of the tutorials in this collection for detailed, step-by-step instructions.

---

## Contributing

If you have ideas for new tutorials or improvements to existing ones, feel free to contribute by creating a pull request or opening an issue.

---

## License

This collection of tutorials is provided under the [MIT License](./LICENSE).