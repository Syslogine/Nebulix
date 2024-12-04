# Using YubiKey for SSH Authentication

Secure your SSH connections by using a **YubiKey** as a hardware token for public-key authentication. This tutorial will guide you through setting up and using a YubiKey to enhance the security of your SSH sessions.

---

## **Overview**

With a YubiKey configured for SSH authentication:
- The private SSH key is securely stored on the YubiKey.
- The YubiKey acts as a hardware-based second layer of protection.
- Even if your computer is compromised, your private key remains secure.

---

## **Prerequisites**

1. A Linux system with SSH installed.
2. A **YubiKey 5 series** or later (supports OpenPGP or FIDO2).
3. Installed tools:
   - `openssh-client`
   - `gpg` (GnuPG)
   - `yubikey-manager`

Install these tools if not already available:
```bash
sudo apt update
sudo apt install openssh-client gnupg yubikey-manager
```

---

## **Step 1: Enable OpenPGP on the YubiKey**

1. **Plug in the YubiKey** and verify it is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Set Up OpenPGP Keys**:
   Use the `gpg` tool to generate or import OpenPGP keys onto the YubiKey. Run:
   ```bash
   gpg --card-edit
   ```

3. Inside the `gpg` interface:
   - Type `admin` and press Enter.
   - Type `generate` to generate a new key pair.
   - Follow the prompts to create the key:
     - Select a key size (recommended: **4096 bits**).
     - Set an expiration date (optional, recommended: 1 year).
     - Enter a strong passphrase for the key.

---

## **Step 2: Retrieve the Public SSH Key from the YubiKey**

1. Export the public key in OpenSSH format:
   ```bash
   gpg --export-ssh-key your_email@example.com
   ```
   Replace `your_email@example.com` with the email address linked to your GPG key.

2. Add the exported public key to your SSH configuration:
   ```bash
   echo "Host yubikey-auth
   HostName your.server.com
   User yourusername
   IdentityFile ~/.ssh/yubikey.pub
   " >> ~/.ssh/config
   ```

---

## **Step 3: Add the Public Key to the Remote Server**

1. Copy the public key to the remote server:
   ```bash
   gpg --export-ssh-key your_email@example.com | ssh yourusername@your.server.com "cat >> ~/.ssh/authorized_keys"
   ```

2. Verify the public key is added:
   ```bash
   ssh yourusername@your.server.com
   ```

---

## **Step 4: Test SSH Authentication**

1. Disconnect from the remote server and reconnect:
   ```bash
   ssh yubikey-auth
   ```

2. When prompted, insert your YubiKey and enter the PIN.

---

## **Optional Enhancements**

### **1. Require Physical Touch for Authentication**
Enable physical touch on the YubiKey for additional security:
```bash
ykman openpgp set-touch policy sig on
ykman openpgp set-touch policy enc on
ykman openpgp set-touch policy aut on
```

### **2. Backup Your Keys**
- Always keep a backup of your OpenPGP keys in a secure location.
- Use a second YubiKey as a backup by importing the keys.

### **3. Set Key Expiration**
To prevent misuse, set an expiration date for your keys:
```bash
gpg --edit-key your_email@example.com
> expire
```

---

## **Troubleshooting**

### **SSH Agent Not Detecting the YubiKey**
- Ensure the GPG agent is running:
  ```bash
  gpgconf --launch gpg-agent
  ```
- Check SSH agent forwarding:
  ```bash
  echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf
  gpgconf --kill gpg-agent
  gpgconf --launch gpg-agent
  ```

### **YubiKey Not Recognized**
- Check permissions for the YubiKey device:
  ```bash
  sudo chmod 666 /dev/ttyS0
  ```

---

## **Conclusion**

By using a YubiKey for SSH authentication, you enhance your security by offloading the private key to a secure, tamper-proof hardware token. This setup protects against key theft and provides peace of mind when connecting to remote servers.