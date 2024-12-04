# Using YubiKey for WebAuthn and FIDO2 Authentication

Enable passwordless or multi-factor authentication (MFA) for web applications using your **YubiKey** with WebAuthn and FIDO2. This tutorial guides you through configuring and using your YubiKey for secure, hardware-backed authentication.

---

## **Overview**

- **WebAuthn**: A web standard for secure, passwordless authentication supported by modern browsers and services.
- **FIDO2**: A protocol that enables secure, hardware-based authentication using devices like YubiKeys.

### **Why Use WebAuthn and FIDO2?**
1. Eliminates reliance on passwords.
2. Provides phishing-resistant, hardware-backed authentication.
3. Supported by many services, including Google, GitHub, and Microsoft.

---

## **Prerequisites**

1. A **YubiKey 5 series** or later (supports WebAuthn/FIDO2).
2. A modern browser with WebAuthn support (e.g., Chrome, Firefox, Edge).
3. A service or application that supports WebAuthn or FIDO2 (e.g., Google, GitHub, Microsoft, AWS).

---

## **Step 1: Verify YubiKey Compatibility**

1. Insert your YubiKey and verify it is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. Check FIDO2 functionality:
   ```bash
   ykman fido list
   ```

---

## **Step 2: Register Your YubiKey with a Service**

### Example: GitHub

1. Log in to your GitHub account.
2. Navigate to **Settings** → **Security** → **Two-Factor Authentication**.
3. Click **Security Keys** and select **Register new key**.
4. Insert your YubiKey when prompted and follow the on-screen instructions.
5. Assign a nickname to your YubiKey for easy identification.

---

### Example: Google Account

1. Log in to your Google account.
2. Go to **Security** → **2-Step Verification** → **Add Security Key**.
3. Insert your YubiKey and touch the sensor when prompted.
4. Confirm the setup and test the authentication process.

---

### Example: Microsoft Account

1. Log in to your Microsoft account.
2. Navigate to **Security** → **Advanced Security Options** → **Add Security Key**.
3. Choose **USB Device** and follow the prompts to register your YubiKey.

---

## **Step 3: Test WebAuthn Authentication**

1. Log out of the service where you registered your YubiKey.
2. Log back in using your username or email address.
3. When prompted, insert your YubiKey and touch the sensor for authentication.

---

## **Optional Enhancements**

### **1. Enable PIN Protection**
Set a PIN for your YubiKey to require additional verification during FIDO2 authentication:
```bash
ykman fido access set-pin
```

### **2. Register Multiple YubiKeys**
Add a backup YubiKey to ensure access if your primary device is lost or unavailable.

---

## **Troubleshooting**

### **YubiKey Not Recognized**
- Ensure the YubiKey is properly inserted:
  ```bash
  lsusb | grep Yubico
  ```
- Restart your browser and try again.

### **FIDO2 Errors**
- Ensure WebAuthn and FIDO2 are supported by the service.
- Check if your browser has WebAuthn enabled:
  - **Chrome**: `chrome://flags` → Enable "Web Authentication API".
  - **Firefox**: `about:config` → Set `security.webauth.u2f` to `true`.

---

## **Services Supporting WebAuthn and FIDO2**

- **Google**: Passwordless login and 2FA.
- **GitHub**: Secure your repositories with FIDO2.
- **Microsoft**: Use your YubiKey to log in to Windows and Office.
- **AWS**: Enable MFA for console access.
- **Dropbox**: Protect your files with WebAuthn.

---

## **Conclusion**

Using your YubiKey for WebAuthn and FIDO2 provides a strong, hardware-backed method for secure and passwordless authentication. This modern approach enhances security while making logins fast and effortless.