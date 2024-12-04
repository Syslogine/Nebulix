# Using YubiKey for VPN Authentication

Enhance the security of your VPN connections by using a **YubiKey** as a hardware-backed authentication method. This tutorial explains how to configure your YubiKey for VPN authentication with **OpenVPN** or other VPN services that support certificates or FIDO2.

---

## **Overview**

Using a YubiKey for VPN authentication provides:
- **Enhanced Security**: Your private keys are securely stored on the YubiKey.
- **Convenience**: The YubiKey simplifies the authentication process while adding a layer of hardware-backed security.
- **Compatibility**: Works with OpenVPN, WireGuard, and other VPN services.

---

## **Prerequisites**

1. A **YubiKey 5 series** or later.
2. Installed tools:
   - `yubikey-manager` (for managing the YubiKey).
   - `openvpn` (for setting up the VPN connection).
   - `easy-rsa` (for managing certificates).

Install the required tools:
```bash
sudo apt update
sudo apt install openvpn easy-rsa yubikey-manager
```

---

## **Step 1: Set Up Certificates with Easy-RSA**

1. **Initialize the PKI Environment**:
   Create the Easy-RSA directory:
   ```bash
   make-cadir ~/easy-rsa
   cd ~/easy-rsa
   ```

2. **Generate the Certificate Authority (CA)**:
   ```bash
   ./easyrsa init-pki
   ./easyrsa build-ca
   ```
   - Provide a strong passphrase for the CA.

3. **Generate a VPN Server Certificate**:
   ```bash
   ./easyrsa build-server-full server nopass
   ```

4. **Generate a Client Certificate**:
   This certificate will be stored on the YubiKey:
   ```bash
   ./easyrsa build-client-full client1
   ```

5. **Export the Client Certificate and Key**:
   Export the client key and certificate for use with the YubiKey:
   ```bash
   cp pki/private/client1.key pki/issued/client1.crt ~/easy-rsa/
   ```

---

## **Step 2: Store the Certificate on the YubiKey**

1. **Insert Your YubiKey**:
   Ensure the YubiKey is detected:
   ```bash
   lsusb | grep Yubico
   ```

2. **Store the Client Certificate**:
   Use the YubiKey Manager to import the client certificate:
   ```bash
   ykman piv import-key 9a ~/easy-rsa/client1.key
   ykman piv import-certificate 9a ~/easy-rsa/client1.crt
   ```
   - Slot `9a` is the default slot for authentication certificates.

3. **Verify the Stored Certificate**:
   Check the certificates on your YubiKey:
   ```bash
   ykman piv info
   ```

---

## **Step 3: Configure OpenVPN for YubiKey Authentication**

1. **Edit the OpenVPN Configuration**:
   Modify the OpenVPN client configuration file (e.g., `client.ovpn`):
   ```plaintext
   client
   dev tun
   proto udp
   remote <vpn-server-address> 1194
   ca ca.crt
   cert client1.crt
   key client1.key
   auth-user-pass
   ```

   Replace `cert` and `key` with the YubiKey PIV slots:
   ```plaintext
   pkcs11-id 'piv_9a'
   pkcs11-providers /usr/lib/opensc-pkcs11.so
   ```

2. **Add the CA Certificate**:
   Copy the CA certificate to the OpenVPN directory:
   ```bash
   cp ~/easy-rsa/pki/ca.crt /etc/openvpn/
   ```

3. **Test the Configuration**:
   Start the OpenVPN client:
   ```bash
   sudo openvpn --config client.ovpn
   ```

   You will be prompted to insert your YubiKey and provide the PIN.

---

## **Step 4: Optional - Use WireGuard with YubiKey**

### **1. Generate a WireGuard Key on the YubiKey**:
Use the YubiKey as a FIDO2 device to generate WireGuard keys:
```bash
ykman piv generate-key 9a > wireguard.key
```

### **2. Configure WireGuard**:
Add the generated key to your WireGuard configuration file.

---

## **Troubleshooting**

### **YubiKey Not Recognized**
- Ensure the YubiKey is properly connected:
  ```bash
  lsusb | grep Yubico
  ```

### **OpenVPN Fails to Start**
- Check the OpenVPN logs for errors:
  ```bash
  sudo journalctl -u openvpn
  ```

### **Certificate Issues**
- Verify the certificate using the YubiKey Manager:
  ```bash
  ykman piv info
  ```

---

## **Conclusion**

Using a YubiKey for VPN authentication adds robust security to your network connections by securely storing client certificates and private keys. This setup ensures that even if your system is compromised, your VPN credentials remain safe.