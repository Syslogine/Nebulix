# Automating File Encryption with GPG

Streamline your workflow by automating file encryption and decryption using **GPG (GNU Privacy Guard)**. This guide provides scripts and step-by-step instructions to encrypt files in bulk, manage keys efficiently, and automate repetitive tasks.

---

## **Overview**

Automating GPG encryption simplifies:
- **Bulk Encryption**: Encrypt multiple files or entire directories.
- **Secure Backups**: Automate encryption for daily or scheduled backups.
- **Key Management**: Reduce manual effort in managing GPG operations.

---

## **Prerequisites**

1. A Linux system with GPG installed:
   ```bash
   sudo apt update
   sudo apt install gnupg
   ```

2. A GPG key pair:
   - Generate one if you don’t have it yet:
     ```bash
     gpg --full-generate-key
     ```

3. A basic understanding of shell scripting.

---

## **Step 1: Encrypt Files in Bulk**

Here’s a script to encrypt all files in a given directory.

### **Script: `encrypt-files.sh`**
Save the following script in a file named `encrypt-files.sh`:

```bash
#!/bin/bash
# Bulk encrypt files in a specified directory using GPG

# Check for arguments
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <directory> <recipient_email>"
  exit 1
fi

DIRECTORY=$1
RECIPIENT=$2

# Check if the directory exists
if [[ ! -d "$DIRECTORY" ]]; then
  echo "Error: Directory $DIRECTORY does not exist."
  exit 1
fi

# Encrypt each file
for file in "$DIRECTORY"/*; do
  if [[ -f "$file" ]]; then
    echo "Encrypting $file..."
    gpg --encrypt --recipient "$RECIPIENT" "$file"
  fi
done

echo "Encryption complete! Encrypted files are saved with .gpg extension."
```

### **How to Use**
1. Make the script executable:
   ```bash
   chmod +x encrypt-files.sh
   ```

2. Run the script:
   ```bash
   ./encrypt-files.sh /path/to/directory recipient_email@example.com
   ```

---

## **Step 2: Decrypt Files in Bulk**

Here’s a script to decrypt all `.gpg` files in a directory.

### **Script: `decrypt-files.sh`**
Save the following script in a file named `decrypt-files.sh`:

```bash
#!/bin/bash
# Bulk decrypt files in a specified directory using GPG

# Check for arguments
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIRECTORY=$1

# Check if the directory exists
if [[ ! -d "$DIRECTORY" ]]; then
  echo "Error: Directory $DIRECTORY does not exist."
  exit 1
fi

# Decrypt each file
for file in "$DIRECTORY"/*.gpg; do
  if [[ -f "$file" ]]; then
    echo "Decrypting $file..."
    gpg --output "${file%.gpg}" --decrypt "$file"
  fi
done

echo "Decryption complete! Decrypted files are saved without the .gpg extension."
```

### **How to Use**
1. Make the script executable:
   ```bash
   chmod +x decrypt-files.sh
   ```

2. Run the script:
   ```bash
   ./decrypt-files.sh /path/to/directory
   ```

---

## **Step 3: Automating Encryption for Backups**

### **Cron Job for Daily Backups**
1. Save the encryption script (`encrypt-files.sh`) to a secure location, e.g., `/usr/local/bin/`.
2. Create a backup directory, e.g., `/home/user/backup/`.

3. Schedule a cron job:
   ```bash
   crontab -e
   ```

4. Add the following line to encrypt files daily at midnight:
   ```plaintext
   0 0 * * * /usr/local/bin/encrypt-files.sh /home/user/backup recipient_email@example.com
   ```

### **Test the Cron Job**
Run the cron job manually to ensure it works:
```bash
sudo run-parts /etc/cron.daily
```

---

## **Step 4: Secure Key Management**

### **1. Backup Your GPG Keys**
Export your public and private keys:
```bash
gpg --export --armor > public_key.asc
gpg --export-secret-keys --armor > private_key_backup.asc
```

Store these files in a secure, encrypted location.

### **2. Use a Keyring Directory**
Set a custom keyring directory for automated scripts to avoid interfering with your main GPG keyring:
```bash
export GNUPGHOME=/path/to/custom-keyring
```

---

## **Step 5: Advanced Automation**

### **1. Add Logging to Scripts**
Modify the encryption script to log operations:
```bash
LOGFILE="/var/log/gpg-encryption.log"
echo "[$(date)] Encrypting $file..." >> "$LOGFILE"
```

### **2. Combine Compression with Encryption**
Compress and encrypt files together:
```bash
tar -czf - /path/to/directory | gpg --encrypt --recipient recipient_email@example.com -o backup.tar.gz.gpg
```

### **3. Use Password-Based Encryption**
For simple encryption without keys:
```bash
gpg --symmetric --cipher-algo AES256 file.txt
```

---

## **Troubleshooting**

### **1. Permission Issues**
Ensure the script has execute permissions:
```bash
chmod +x script.sh
```

### **2. Key Not Found**
If the recipient's key is missing:
- Import their public key:
  ```bash
  gpg --import recipient_public_key.asc
  ```

### **3. Debugging GPG Errors**
Run GPG commands with verbose logging:
```bash
gpg --verbose --encrypt file.txt
```

---

## **Conclusion**

Automating GPG encryption streamlines workflows and enhances data security. Whether encrypting sensitive files for backups or securely sharing them, these scripts and techniques make it easy to integrate GPG into your daily routine.