# Full-Disk Encryption with YubiKey

Secure your system with **full-disk encryption (FDE)** using a **YubiKey** to enhance security. This guide walks you through encrypting your disk with LUKS and integrating the YubiKey for unlocking the encrypted disk.

---

## **Overview**

Full-disk encryption ensures that all data on your disk is protected. By using a YubiKey:
- Your encryption keys are stored securely on hardware.
- Physical access to the YubiKey is required for decryption.
- The system is protected from data theft in case of loss or unauthorized access.

---

## **Prerequisites**

1. A Linux system with **LUKS (Linux Unified Key Setup)** available.
2. A **YubiKey 5 series** or later.
3. Installed tools:
   - `cryptsetup` (for managing LUKS).
   - `yubikey-manager` (for configuring the YubiKey).

Install the required tools:
```bash
sudo apt update
sudo apt install cryptsetup yubikey-manager
```

---

## **Step 1: Prepare the Disk**

1. **Identify the Target Disk**:
   Use `lsblk` to find the disk or partition you want to encrypt (e.g., `/dev/sdX`):
   ```bash
   lsblk
   ```

2. **Wipe the Disk**:
   Securely erase any existing data on the disk:
   ```bash
   sudo dd if=/dev/zero of=/dev/sdX bs=1M status=progress
   ```

3. **Create a Partition Table**:
   Initialize a partition table (e.g., GPT):
   ```bash
   sudo parted /dev/sdX mklabel gpt
   ```

4. **Create a Partition**:
   Create a new partition for encryption:
   ```bash
   sudo parted /dev/sdX mkpart primary ext4 0% 100%
   ```

---

## **Step 2: Set Up LUKS Encryption**

1. **Initialize LUKS**:
   Format the partition with LUKS:
   ```bash
   sudo cryptsetup luksFormat /dev/sdX1
   ```
   - Replace `/dev/sdX1` with the partition to encrypt.
   - Use a strong passphrase when prompted.

2. **Open the Encrypted Partition**:
   Unlock the encrypted partition:
   ```bash
   sudo cryptsetup open /dev/sdX1 cryptovolume
   ```

3. **Create a Filesystem**:
   Format the unlocked volume with a filesystem:
   ```bash
   sudo mkfs.ext4 /dev/mapper/cryptovolume
   ```

4. **Mount the Encrypted Partition**:
   Mount the encrypted volume to a directory:
   ```bash
   sudo mkdir /mnt/encrypted
   sudo mount /dev/mapper/cryptovolume /mnt/encrypted
   ```

---

## **Step 3: Integrate the YubiKey**

1. **Set Up a Key Slot for the YubiKey**:
   - Add a YubiKey-based key to the LUKS partition:
     ```bash
     sudo cryptsetup luksAddKey /dev/sdX1
     ```
     - Insert your YubiKey and use `ykman` to generate a challenge-response key.
     - Provide the challenge-response output as the new key.

2. **Configure YubiKey Challenge-Response**:
   Use the YubiKey Manager to enable challenge-response mode:
   ```bash
   ykman otp challenge-response configure --slot 2 --totp
   ```

3. **Test Unlocking with the YubiKey**:
   Lock the encrypted partition:
   ```bash
   sudo cryptsetup luksClose cryptovolume
   ```

   Unlock the partition using the YubiKey:
   ```bash
   sudo cryptsetup open --type luks2 --key-file /dev/your-yubikey-device /dev/sdX1 cryptovolume
   ```

---

## **Step 4: Automate Unlocking with the YubiKey**

1. **Create a Script for Unlocking**:
   Write a script to unlock the encrypted disk using the YubiKey:
   ```bash
   sudo nano /usr/local/bin/unlock-disk.sh
   ```

   Add the following content:
   ```bash
   #!/bin/bash
   # Unlock the encrypted partition using YubiKey
   cryptsetup open --type luks2 --key-file /dev/your-yubikey-device /dev/sdX1 cryptovolume
   ```

2. **Make the Script Executable**:
   ```bash
   sudo chmod +x /usr/local/bin/unlock-disk.sh
   ```

3. **Test the Script**:
   Run the script to unlock the disk:
   ```bash
   sudo /usr/local/bin/unlock-disk.sh
   ```

---

## **Step 5: Secure the Configuration**

### **1. Backup the LUKS Header**
Create a backup of the LUKS header to recover the encrypted data if the header is corrupted:
```bash
sudo cryptsetup luksHeaderBackup /dev/sdX1 --header-backup-file luks_header_backup.img
```

Store the backup in a secure location.

### **2. Require Physical Touch for YubiKey**
Enable touch confirmation for challenge-response operations:
```bash
ykman otp set-touch --slot 2 on
```

---

## **Troubleshooting**

### **1. YubiKey Not Detected**
- Ensure the YubiKey is properly connected:
  ```bash
  lsusb | grep Yubico
  ```

### **2. Cannot Unlock Disk**
- Verify the LUKS key slots:
  ```bash
  sudo cryptsetup luksDump /dev/sdX1
  ```

- Check if the YubiKey is configured correctly.

---

## **Conclusion**

By integrating a YubiKey with full-disk encryption, you create a secure and tamper-resistant environment. This setup ensures that even if your device is stolen, the encrypted data remains inaccessible without the YubiKey.