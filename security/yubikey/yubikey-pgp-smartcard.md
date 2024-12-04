# Using YubiKey as a PGP Smartcard

Secure your cryptographic operations by using a **YubiKey** as a hardware-backed OpenPGP smartcard. This tutorial walks you through configuring the YubiKey to store and use PGP keys for signing, encrypting, and authenticating data.

---

## **Overview**

The YubiKey can act as a **PGP smartcard**, offering:
- Secure storage of private keys.
- Protection against key theft and unauthorized access.
- Usability for signing, encrypting, and SSH authentication.

---

## **Prerequisites**

1. A **YubiKey 5 series** or later (supports OpenPGP smartcard functionality).
2. Tools installed on your system:
   - `gpg` (GnuPG for PGP management).
   - `yubikey-manager` (for managing the YubiKey).
3. Basic understanding of PGP and key management.

Install required tools:
```bash
sudo apt update
sudo apt install gnupg yubikey-manager
```

---

## **Step 1: Configure Your YubiKey for OpenPGP**

1. **Insert Your YubiKey**:
   Plug in the YubiKey and ensure it’s detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Access the OpenPGP Interface**:
   Open the GPG card management tool:
   ```bash
   gpg --card-edit
   ```

3. **Enable Admin Mode**:
   Inside the GPG interface, type:
   ```plaintext
   admin
   ```
   This enables administrative commands.

4. **Set Up Key Management**:
   - Change the PIN:
     ```plaintext
     passwd
     ```
   - Follow the prompts to set a new PIN and admin PIN.

---

## **Step 2: Generate or Import PGP Keys**

You can either generate new keys directly on the YubiKey or import existing keys.

### **Option 1: Generate New Keys**
1. Inside the `gpg --card-edit` interface:
   ```plaintext
   generate
   ```
2. Follow the prompts:
   - Choose a key size (recommended: **4096 bits**).
   - Set an expiration date (recommended: 1 year, renewable).
   - Enter a strong passphrase.

The keys are now generated and stored directly on the YubiKey.

---

### **Option 2: Import Existing PGP Keys**
1. Export your existing keys:
   ```bash
   gpg --export-secret-keys --armor > private-key.asc
   ```
2. Import the keys to your local GPG keyring:
   ```bash
   gpg --import private-key.asc
   ```
3. Transfer the keys to the YubiKey:
   - Access the GPG card interface:
     ```bash
     gpg --edit-key <key-id>
     ```
   - Move keys to the YubiKey:
     ```plaintext
     keytocard
     ```
   - Choose which slot to use:
     - **Signature key**: `1`
     - **Encryption key**: `2`
     - **Authentication key**: `3`

---

## **Step 3: Verify YubiKey Configuration**

1. Check the YubiKey status:
   ```bash
   gpg --card-status
   ```

2. Ensure the following details are displayed:
   - Card type: YubiKey
   - Key slots: Signature, Encryption, and Authentication keys populated.

---

## **Step 4: Use the YubiKey for PGP Operations**

### **4.1: Signing Messages**
1. Create a text file to sign:
   ```bash
   echo "This is a test message" > message.txt
   ```
2. Sign the file using your YubiKey:
   ```bash
   gpg --sign message.txt
   ```

### **4.2: Encrypting Files**
1. Encrypt a file for a recipient:
   ```bash
   gpg --encrypt --recipient recipient_email@example.com file.txt
   ```

2. Decrypt the file:
   ```bash
   gpg --decrypt file.txt.gpg
   ```

### **4.3: SSH Authentication**
1. Export your public SSH key from the YubiKey:
   ```bash
   gpg --export-ssh-key <key-id>
   ```
2. Add the key to your SSH configuration.

---

## **Step 5: Enable Physical Touch for Operations**

To require physical confirmation (touch) for cryptographic operations:
```bash
ykman openpgp set-touch policy sig on
ykman openpgp set-touch policy enc on
ykman openpgp set-touch policy aut on
```

---

## **Step 6: Backup and Recovery**

1. **Backup Your Keys**:
   - Export the keys to a secure, encrypted backup:
     ```bash
     gpg --export-secret-keys --armor > private-key-backup.asc
     ```

2. **Store Backup Safely**:
   - Keep the backup in an offline, secure location (e.g., encrypted USB or cloud storage).

---

## **Troubleshooting**

### **YubiKey Not Detected**
- Check permissions for the YubiKey device:
  ```bash
  sudo chmod 666 /dev/ttyS0
  ```

### **Cannot Access GPG Interface**
- Ensure the GPG agent is running:
  ```bash
  gpgconf --launch gpg-agent
  ```

---

## **Conclusion**

Using a YubiKey as a PGP smartcard enhances security by ensuring private keys never leave the hardware device. Whether you're signing emails, encrypting files, or authenticating SSH sessions, the YubiKey provides strong, hardware-backed cryptographic protection.