### **Adding a Backup YubiKey for Multi-Factor Authentication (MFA)**

Having a backup YubiKey ensures you’re not locked out of your system if your primary YubiKey is lost, damaged, or unavailable. Here’s how to securely enroll a second YubiKey as a backup for unlocking your encrypted disk.

---

### **1. Prerequisites**

- **Primary YubiKey** already enrolled with LUKS (following the main MFA guide).
- A **Backup YubiKey** ready for enrollment.
- `cryptsetup`, `yubikey-manager`, and `yubikey-luks` installed.

---

### **2. Enroll the Backup YubiKey**

#### Step 2.1: Plug in the Backup YubiKey
Insert your backup YubiKey into a USB port and verify it is detected:
```bash
lsusb | grep Yubico
```

#### Step 2.2: Generate a Challenge-Response Key for the Backup YubiKey
1. Use the **yubikey-manager** to add a new key for the backup YubiKey:
   ```bash
   ykman oath add backup_luks_key
   ```
   Replace `backup_luks_key` with a unique label to identify the backup key.

2. Verify the challenge-response key generation:
   ```bash
   ykman oath code
   ```
   This ensures the YubiKey is configured properly.

---

### **3. Add the Backup Key to LUKS**

1. Attach the backup YubiKey and run the following command to associate it with LUKS:
   ```bash
   yubikey-luks-enroll /dev/sdX
   ```
   Replace `/dev/sdX` with the device name of your encrypted partition.

2. You will be prompted to:
   - Authenticate with your primary YubiKey or the passphrase for the existing LUKS slot.
   - Confirm the addition of the backup YubiKey.

3. Verify that the new key is successfully enrolled:
   ```bash
   sudo cryptsetup luksDump /dev/sdX
   ```
   You should see an additional LUKS key slot assigned to the backup YubiKey.

---

### **4. Test the Backup YubiKey**

1. Reboot your system.
2. At the decryption prompt:
   - Remove your primary YubiKey and insert the backup YubiKey.
   - Confirm that the system unlocks successfully using the backup YubiKey.

---

### **5. Best Practices**

#### 5.1: Label Your YubiKeys
To avoid confusion, label your primary and backup YubiKeys physically or use unique labels in the YubiKey manager (`primary_luks_key` and `backup_luks_key`).

#### 5.2: Store the Backup YubiKey Securely
- Keep the backup YubiKey in a safe location (e.g., a fireproof safe).
- Avoid keeping it in the same physical location as your primary YubiKey.

#### 5.3: Periodically Verify Backup Functionality
Test the backup YubiKey periodically to ensure it is functioning correctly.

#### 5.4: Backup the LUKS Header
If the LUKS header becomes corrupted, all keys will be invalid. Backup the header to a secure location:
```bash
sudo cryptsetup luksHeaderBackup /dev/sdX --header-backup-file luks_header_backup.img
```

---
