# Using YubiKey for PAM Authentication

Enhance your system's security by configuring **PAM (Pluggable Authentication Module)** to use a **YubiKey** for authentication. This tutorial explains how to set up your YubiKey for securing `sudo`, system logins, and other PAM-enabled services.

---

## **Overview**

PAM provides a flexible mechanism for authentication on Linux systems. By integrating your YubiKey:
- You add an additional layer of hardware-based security.
- Authentication becomes more resistant to brute-force or phishing attacks.

---

## **Prerequisites**

1. A **YubiKey** (YubiKey 5 or later recommended).
2. Installed tools:
   - `pam-u2f` (PAM module for YubiKey).
   - `yubikey-manager` (for managing your YubiKey).

Install required tools:
```bash
sudo apt update
sudo apt install libpam-u2f yubikey-manager
```

---

## **Step 1: Set Up the YubiKey for PAM**

1. **Insert Your YubiKey**:
   Plug in your YubiKey and verify it is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Generate a Configuration File**:
   Create the `.yubico` directory in your home folder:
   ```bash
   mkdir -p ~/.yubico
   ```

3. **Register Your YubiKey**:
   Generate a mapping of your YubiKey’s public key:
   ```bash
   pamu2fcfg > ~/.yubico/u2f_keys
   ```
   - Press your YubiKey when prompted.
   - The public key is now stored in `~/.yubico/u2f_keys`.

4. **Test the YubiKey**:
   Verify that the configuration was successful:
   ```bash
   pamu2fcfg -n
   ```
   If successful, you will see the public key output.

---

## **Step 2: Configure PAM to Use YubiKey**

### **2.1: Enable YubiKey for `sudo`**

1. Open the PAM configuration for `sudo`:
   ```bash
   sudo nano /etc/pam.d/sudo
   ```

2. Add the following line at the top:
   ```plaintext
   auth required pam_u2f.so
   ```

3. Save and exit.

### **2.2: Enable YubiKey for Login**

1. Open the PAM configuration for system login:
   ```bash
   sudo nano /etc/pam.d/common-auth
   ```

2. Add the following line:
   ```plaintext
   auth required pam_u2f.so
   ```

3. Save and exit.

---

## **Step 3: Test the Configuration**

1. **Test `sudo` with YubiKey**:
   Run a command with `sudo`:
   ```bash
   sudo ls
   ```
   - You will be prompted to touch your YubiKey.

2. **Test Login with YubiKey**:
   Log out of your system and log back in.
   - You will need your password and the YubiKey.

---

## **Optional Enhancements**

### **1. Backup Configuration for Multiple YubiKeys**
If you want to use multiple YubiKeys (e.g., a backup device), append additional keys to `~/.yubico/u2f_keys`:
```bash
pamu2fcfg >> ~/.yubico/u2f_keys
```

### **2. Enable Physical Touch Requirement**
Require a physical touch for authentication:
```bash
ykman fido access set-pin
```

### **3. Configure Fallback Authentication**
Allow fallback to password-only login in case of YubiKey failure. Add this line instead of the strict requirement:
```plaintext
auth sufficient pam_u2f.so
```

---

## **Troubleshooting**

### **1. YubiKey Not Detected**
- Ensure the device is connected:
  ```bash
  lsusb | grep Yubico
  ```

### **2. Authentication Fails**
- Check the configuration in `/etc/pam.d` files.
- Verify the `~/.yubico/u2f_keys` file contains the correct public key.

### **3. Debugging PAM**
Enable debug mode in `pam_u2f` for detailed logs:
```plaintext
auth required pam_u2f.so debug
```

Check logs:
```bash
sudo journalctl -xe
```

---

## **Conclusion**

Integrating YubiKey with PAM provides a robust, hardware-backed layer of authentication for your Linux system. By configuring it for `sudo` and system logins, you ensure that only users with physical access to the YubiKey can authenticate successfully.