# Using YubiKey for GPG-Encrypted Emails

Secure your emails by using a **YubiKey** as a hardware-backed OpenPGP smartcard for encrypting, signing, and decrypting emails. This guide walks you through setting up GPG with your YubiKey and configuring it for email encryption.

---

## **Overview**

Using a YubiKey for email encryption ensures:
- **Strong Security**: Private keys are stored securely on the YubiKey.
- **Ease of Use**: Automate encryption and decryption for email communication.
- **Authenticity**: Sign emails to verify your identity to recipients.

---

## **Prerequisites**

1. A **YubiKey 5 series** or later with OpenPGP support.
2. Installed tools:
   - `gnupg` (for GPG key management).
   - `yubikey-manager` (for managing the YubiKey).
3. An email client that supports GPG (e.g., Thunderbird with Enigmail, or Mutt).

Install required tools:
```bash
sudo apt update
sudo apt install gnupg yubikey-manager thunderbird
```

---

## **Step 1: Configure Your YubiKey for OpenPGP**

1. **Insert Your YubiKey** and verify it is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Access the OpenPGP Interface**:
   Open the GPG card management interface:
   ```bash
   gpg --card-edit
   ```

3. **Enable Admin Mode**:
   Inside the GPG interface, type:
   ```plaintext
   admin
   ```

4. **Set PINs**:
   Change the default PIN and admin PIN for added security:
   ```plaintext
   passwd
   ```

---

## **Step 2: Generate or Import GPG Keys**

### **Option 1: Generate New Keys**
1. Inside `gpg --card-edit`, type:
   ```plaintext
   generate
   ```
2. Follow the prompts:
   - Select a key size (recommended: **4096 bits**).
   - Set an expiration date (recommended: 1 year, renewable).
   - Enter a strong passphrase.

### **Option 2: Import Existing Keys**
1. Export your existing GPG keys:
   ```bash
   gpg --export-secret-keys --armor > private-key.asc
   ```
2. Import them to your local keyring:
   ```bash
   gpg --import private-key.asc
   ```
3. Move the keys to the YubiKey:
   ```bash
   gpg --edit-key <key-id>
   keytocard
   ```

---

## **Step 3: Configure GPG for Your Email Address**

1. **Set Your Email as User ID**:
   Link your GPG key to your email address:
   ```bash
   gpg --edit-key <key-id>
   ```
   Type:
   ```plaintext
   adduid
   ```

2. Follow the prompts to add your name and email address.

3. **Upload Your Public Key** (optional):
   Share your public key so others can encrypt emails to you:
   ```bash
   gpg --send-keys <key-id>
   ```
   Replace `<key-id>` with your GPG key ID.

---

## **Step 4: Configure Your Email Client**

### **Thunderbird with Enigmail**
1. Install Enigmail:
   ```bash
   sudo apt install enigmail
   ```

2. Open Thunderbird and navigate to **Preferences** → **Account Settings**.

3. Select your email account and configure GPG:
   - Enable OpenPGP support for the account.
   - Import your GPG key to Thunderbird.

4. Test encryption and signing by sending an email to yourself.

---

## **Step 5: Encrypt, Decrypt, and Sign Emails**

### **Encrypting Emails**
1. Compose a new email.
2. Enable encryption in the email client.
3. Select the recipient's public key to encrypt the message.

### **Decrypting Emails**
1. Open the encrypted email in your email client.
2. Insert your YubiKey and enter the PIN when prompted.
3. The email will be decrypted automatically.

### **Signing Emails**
1. Compose a new email.
2. Enable the signing option in the email client.
3. The YubiKey will sign the email securely.

---

## **Optional Enhancements**

### **1. Require Touch for Cryptographic Operations**
Enable physical touch on the YubiKey for added security:
```bash
ykman openpgp set-touch policy sig on
ykman openpgp set-touch policy enc on
ykman openpgp set-touch policy aut on
```

### **2. Backup Your Keys**
Export your GPG keys and store them in a secure, offline location:
```bash
gpg --export-secret-keys --armor > private-key-backup.asc
```

---

## **Troubleshooting**

### **YubiKey Not Detected**
- Ensure the YubiKey is connected and recognized:
  ```bash
  lsusb | grep Yubico
  ```

### **Email Client Issues**
- Restart Thunderbird or reconfigure Enigmail if issues persist.

### **Key Import/Export Errors**
- Ensure you are using the correct key ID and permissions.

---

## **Conclusion**

Using your YubiKey for GPG-encrypted emails ensures secure and tamper-proof communication. By offloading private key storage to the YubiKey, you gain both convenience and robust security for your email correspondence.