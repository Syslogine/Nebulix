# Using YubiKey for Full-Disk Encryption with Detached Headers

This tutorial explains how to use a **YubiKey** to securely manage detached headers for a full-disk encryption setup. Detached headers add an extra layer of protection, as the encryption metadata is stored separately from the encrypted data.

---

## **Overview**

- **What are Detached Headers?**
  Detached headers store the LUKS encryption metadata (e.g., key slots, cipher information) separately from the encrypted partition. This ensures the disk cannot be unlocked without the header file.

- **Why Use YubiKey for Detached Headers?**
  The YubiKey can securely store the detached header, preventing unauthorized access even if the disk is stolen.

---

## **Prerequisites**

- A Linux system with **LUKS (Linux Unified Key Setup)** installed.
- At least one **YubiKey** configured with the **YubiKey Manager** (`ykman`).
- A disk or partition ready to be encrypted.

Install required tools:
```bash
sudo apt update
sudo apt install cryptsetup yubikey-manager
```

---

## **Step 1: Prepare the Partition for Encryption**

1. **Identify the Target Partition**:
   Use `lsblk` or `fdisk -l` to find the target disk/partition (e.g., `/dev/sdX`):
   ```bash
   lsblk
   ```

2. **Wipe the Partition**:
   It’s recommended to wipe the partition to remove any residual data:
   ```bash
   sudo dd if=/dev/zero of=/dev/sdX bs=1M status=progress
   ```

3. **Format the Partition with LUKS**:
   Initialize LUKS encryption with a detached header:
   ```bash
   sudo cryptsetup luksFormat --header detached-header.img /dev/sdX
   ```
   - `detached-header.img`: The file where the LUKS header will be stored.
   - `/dev/sdX`: The partition to encrypt.

---

## **Step 2: Store the Detached Header on the YubiKey**

1. **Connect the YubiKey**:
   Plug in your YubiKey and verify it is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Write the Header to the YubiKey**:
   Use `ykman` to write the header file to the YubiKey's secure storage:
   ```bash
   ykman otp write-header-file detached-header.img
   ```
   - Replace `detached-header.img` with the path to your LUKS header file.

3. **Verify the Header is Stored**:
   Check the contents of the YubiKey storage:
   ```bash
   ykman otp list
   ```

---

## **Step 3: Open the Encrypted Partition**

1. **Unlock the Partition with the Detached Header**:
   Insert your YubiKey and use the following command:
   ```bash
   sudo cryptsetup open --header detached-header.img /dev/sdX encrypted-disk
   ```

2. **Format the Encrypted Partition**:
   Create a filesystem on the unlocked partition:
   ```bash
   sudo mkfs.ext4 /dev/mapper/encrypted-disk
   ```

3. **Mount the Partition**:
   Mount the encrypted partition:
   ```bash
   sudo mkdir /mnt/encrypted
   sudo mount /dev/mapper/encrypted-disk /mnt/encrypted
   ```

---

## **Step 4: Automate the Unlocking Process**

1. **Create a Script to Access the Header**:
   Write a script to retrieve the detached header from the YubiKey and unlock the disk:
   ```bash
   sudo nano /usr/local/bin/unlock-disk.sh
   ```

   Add the following content:
   ```bash
   #!/bin/bash
   # Retrieve header from YubiKey
   ykman otp read-header-file detached-header.img
   # Unlock the disk
   cryptsetup open --header detached-header.img /dev/sdX encrypted-disk
   ```

2. **Make the Script Executable**:
   ```bash
   sudo chmod +x /usr/local/bin/unlock-disk.sh
   ```

3. **Test the Script**:
   Run the script to ensure it unlocks the disk:
   ```bash
   sudo /usr/local/bin/unlock-disk.sh
   ```

---

## **Step 5: Backup and Secure the Header**

1. **Backup the Detached Header**:
   Store a copy of the header in a secure location (e.g., external storage):
   ```bash
   sudo cp detached-header.img /path/to/secure/backup/
   ```

2. **Protect the Backup**:
   Encrypt the header file backup with GPG:
   ```bash
   gpg --encrypt --recipient your_email@example.com detached-header.img
   ```

3. **Test the Backup**:
   Ensure the backup can be decrypted and used if needed:
   ```bash
   gpg --decrypt detached-header.img.gpg > detached-header.img
   ```

---

## **Best Practices**

- **Multiple YubiKeys**:
  Store the header on multiple YubiKeys to ensure access in case one is lost.

- **Audit Access**:
  Periodically verify the integrity of the detached header:
  ```bash
  cryptsetup luksDump --header detached-header.img
  ```

- **Physical Security**:
  Keep the YubiKey and backups in secure locations to prevent unauthorized access.

---

## **Conclusion**

Using a YubiKey for managing detached headers provides an additional layer of security for full-disk encryption. With this setup, even if the disk is stolen, the encryption metadata is inaccessible without the YubiKey and its secure storage.