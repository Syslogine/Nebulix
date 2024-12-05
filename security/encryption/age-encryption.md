# Using Age for File Encryption

**Age** (Actually Good Encryption) is a modern, simple, and user-friendly tool for encrypting and decrypting files. This guide walks you through installing Age, encrypting files, managing keys, and automating file encryption.

---

## **Why Use Age?**

- **Simple and Modern**: Designed to replace GPG with a streamlined, easy-to-use interface.
- **Secure by Design**: Uses cutting-edge cryptography like X25519, ChaCha20-Poly1305, and HMAC-SHA256.
- **Cross-Platform**: Available for Linux, macOS, and Windows.
- **Lightweight**: Minimal dependencies and fast performance.

---

## **Prerequisites**

1. **Install Age**:
   - On Linux:
     ```bash
     sudo apt update
     sudo apt install age
     ```
   - Alternatively, download the latest release from the [Age GitHub repository](https://github.com/FiloSottile/age/releases).

2. **Basic Command-Line Knowledge**:
   - Familiarity with navigating directories and running commands.

---

## **Step 1: Encrypting Files with Age**

1. **Encrypt a File**:
   Use Age to encrypt a file with a recipient’s public key:
   ```bash
   age -r recipient_public_key -o encrypted_file.age original_file.txt
   ```
   - `-r`: Specifies the recipient’s public key.
   - `-o`: Specifies the output file name (`encrypted_file.age`).

2. **Encrypt with a Password**:
   Encrypt a file without using keys:
   ```bash
   age -p -o encrypted_file.age original_file.txt
   ```
   - You’ll be prompted to enter and confirm a passphrase.

---

## **Step 2: Decrypting Files with Age**

1. **Decrypt a File**:
   Use your private key to decrypt a file:
   ```bash
   age -d -i private_key.txt -o decrypted_file.txt encrypted_file.age
   ```
   - `-i`: Specifies the private key file.

2. **Decrypt a Password-Protected File**:
   If the file was encrypted with a passphrase:
   ```bash
   age -d -o decrypted_file.txt encrypted_file.age
   ```
   - You’ll be prompted to enter the passphrase.

---

## **Step 3: Managing Keys**

### **1. Generate a Key Pair**
Create a new Age key pair:
```bash
age-keygen -o my_key.txt
```
- The key file (`my_key.txt`) contains your private key.
- Your public key is printed at the end of the file. Share it with others for encryption.

### **2. Backup Your Keys**
Store your key pair in a secure location, such as:
- An encrypted USB drive.
- A password manager with file attachment support.

---

## **Step 4: Automating Age Encryption**

### **1. Bulk Encryption Script**
Encrypt all files in a directory:
```bash
#!/bin/bash
# Encrypt all files in a directory using Age

DIRECTORY=$1
PUBLIC_KEY=$2

if [[ -z "$DIRECTORY" || -z "$PUBLIC_KEY" ]]; then
  echo "Usage: $0 <directory> <recipient_public_key>"
  exit 1
fi

for file in "$DIRECTORY"/*; do
  if [[ -f "$file" ]]; then
    echo "Encrypting $file..."
    age -r "$PUBLIC_KEY" -o "$file.age" "$file"
  fi
done

echo "All files encrypted successfully!"
```

Run the script:
```bash
chmod +x encrypt-dir-age.sh
./encrypt-dir-age.sh /path/to/directory recipient_public_key
```

### **2. Bulk Decryption Script**
Decrypt all `.age` files in a directory:
```bash
#!/bin/bash
# Decrypt all .age files in a directory using Age

DIRECTORY=$1
PRIVATE_KEY=$2

if [[ -z "$DIRECTORY" || -z "$PRIVATE_KEY" ]]; then
  echo "Usage: $0 <directory> <private_key_file>"
  exit 1
fi

for file in "$DIRECTORY"/*.age; do
  if [[ -f "$file" ]]; then
    echo "Decrypting $file..."
    age -d -i "$PRIVATE_KEY" -o "${file%.age}" "$file"
  fi
done

echo "All files decrypted successfully!"
```

Run the script:
```bash
chmod +x decrypt-dir-age.sh
./decrypt-dir-age.sh /path/to/directory my_key.txt
```

---

## **Step 5: Advanced Features**

### **1. Combine Compression with Encryption**
Compress and encrypt files in one step:
```bash
tar -czf - /path/to/files | age -r recipient_public_key -o backup.tar.gz.age
```

### **2. Use a Recipient File**
If you need to encrypt for multiple recipients, create a recipient file with public keys:
```plaintext
recipient_public_key1
recipient_public_key2
```
Encrypt using the recipient file:
```bash
age -R recipient_file -o encrypted_file.age original_file.txt
```

### **3. Stream Encryption**
Encrypt or decrypt data streams, useful for backups or pipelines:
```bash
age -r recipient_public_key > encrypted_stream.age
```

---

## **Step 6: Troubleshooting**

### **Age Not Recognized**
Ensure the Age binary is in your system’s PATH:
```bash
export PATH=$PATH:/path/to/age
```

### **Cannot Decrypt File**
- Verify you’re using the correct private key.
- Check if the file was encrypted with a password instead of a key.

### **Recipient Key Error**
Ensure the recipient’s public key is correctly formatted and matches the expected pattern:
```plaintext
age1<base64>
```

---

## **Conclusion**

Age provides a simple and modern approach to encrypting files, with a focus on usability and strong cryptography. Whether you’re encrypting individual files, automating backups, or securing sensitive data for sharing, Age is an excellent tool for the job.