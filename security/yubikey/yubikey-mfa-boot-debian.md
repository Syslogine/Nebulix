### **Setting Up Multi-Factor Authentication (MFA) at Boot with YubiKey**

This guide explains how to integrate a **YubiKey** as a second authentication factor for unlocking your encrypted disk during boot. We will use **LUKS (Linux Unified Key Setup)** for disk encryption and configure the YubiKey to store and provide the necessary decryption keys.

---

### **Table of Contents**
1. [Prerequisites](#1-prerequisites)
2. [Install Required Tools](#2-install-required-tools)
3. [Set Up LUKS Encryption with YubiKey](#3-set-up-luks-encryption-with-yubikey)
4. [Configure GRUB for YubiKey Integration](#4-configure-grub-for-yubikey-integration)
5. [Test the Setup](#5-test-the-setup)
6. [Troubleshooting and Best Practices](#6-troubleshooting-and-best-practices)

---

### **1. Prerequisites**

Before starting, ensure you have the following:
- A Linux system with **Debian or Ubuntu** installed.
- A disk encrypted with **LUKS**.
- At least one **YubiKey** (YubiKey 5 or later recommended).
- A secure root or sudo-enabled user account.

---

### **2. Install Required Tools**

Install the necessary tools to interact with the YubiKey and configure LUKS encryption.

#### Install `cryptsetup` and `yubikey-luks`:
```bash
sudo apt update
sudo apt install cryptsetup yubikey-manager yubikey-luks
```

#### Verify the YubiKey:
Plug in your YubiKey and verify it is detected:
```bash
lsusb | grep Yubico
```

---

### **3. Set Up LUKS Encryption with YubiKey**

#### Step 3.1: Add a New LUKS Key Slot for the YubiKey
1. Attach your YubiKey to the system.
2. Generate a secure challenge-response key:
   ```bash
   ykman oath add my_luks_key
   ```
   Replace `my_luks_key` with a label of your choice.

3. Associate the YubiKey with a LUKS key slot:
   ```bash
   yubikey-luks-enroll /dev/sdX
   ```
   Replace `/dev/sdX` with the encrypted partition.

4. Test the YubiKey challenge-response:
   ```bash
   yubikey-luks-unlock /dev/sdX
   ```

#### Step 3.2: Verify Existing LUKS Keys
Ensure that a backup passphrase is also available:
```bash
sudo cryptsetup luksDump /dev/sdX
```

---

### **4. Configure GRUB for YubiKey Integration**

#### Step 4.1: Modify GRUB to Support YubiKey
Edit the GRUB configuration to allow for decryption using the YubiKey:
```bash
sudo nano /etc/default/grub
```

Add or modify the following line:
```plaintext
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdX:cryptroot:allow-discards"
```

#### Step 4.2: Update GRUB Configuration
After editing the GRUB configuration, update it:
```bash
sudo update-grub
```

---

### **5. Test the Setup**

1. Reboot the system.
2. At the boot prompt, insert your YubiKey.
3. When prompted for a passphrase or authentication, use the YubiKey to provide the decryption key.

---

### **6. Troubleshooting and Best Practices**

#### 6.1: Recover from Boot Issues
- If the YubiKey fails or is lost, use your backup passphrase to unlock the disk.

#### 6.2: Backup Your LUKS Configuration
Store a backup of the LUKS header to recover encrypted data:
```bash
sudo cryptsetup luksHeaderBackup /dev/sdX --header-backup-file luks_header_backup.img
```

#### 6.3: Use Multiple YubiKeys
Enroll multiple YubiKeys to avoid being locked out if one is lost:
```bash
yubikey-luks-enroll /dev/sdX
```

---
