# NebulixOS Configuration and Automation Scripts

Welcome to the **NebulixOS Scripts** repository. This collection of scripts is designed to automate and simplify the customization, configuration, and maintenance of **NebulixOS**, a lightweight operating system based on Debian. Each script includes detailed usage instructions and example outputs.

---

## **Scripts Overview**

1. [**`configure_nebulixos.sh`**](#1-configurenehulixossh)  
   Modify system identification files to brand your OS as NebulixOS.
2. [**`package_installer.sh`**](#2-packageinstallersh)  
   Automate the installation of packages and dependencies on NebulixOS.
3. [**`system_update.sh`**](#3-systemupdatesh)  
   Automate system updates and optionally clean up unused packages.
4. [**`encrypt-files.sh`**](#4-encrypt-filessh)  
   Encrypt all files in a specified directory using GPG.
5. [**`auto-mount-luks-usb.sh`**](#5-auto-mount-luks-usbsh)  
   Unlock and mount a LUKS-encrypted USB drive automatically.

---

## 1. `configure_nebulixos.sh`

### Description
The `configure_nebulixos.sh` script customizes your operating system’s identification files to reflect **NebulixOS** branding while maintaining compatibility with Debian-based software.

### Features
- Updates OS branding to NebulixOS.
- Ensures compatibility with Debian-based software.
- Backs up existing files before modification.
- Logs actions with timestamps.

### Usage
1. Make the script executable:
   ```bash
   chmod +x configure_nebulixos.sh
   ```
2. Run the script:
   ```bash
   sudo ./configure_nebulixos.sh
   ```

### Example Output
```
[2024-12-02 14:10:30] [INFO] Backed up /etc/os-release to /etc/os-release.bak
[2024-12-02 14:10:30] [INFO] Backed up /etc/debian_version to /etc/debian_version.bak
[2024-12-02 14:10:30] [WARNING] /etc/lsb-release does not exist. Skipping backup.
[2024-12-02 14:10:30] [INFO] Configuring /etc/os-release...
[2024-12-02 14:10:31] [INFO] Configuring /etc/debian_version...
[2024-12-02 14:10:31] [INFO] Configuring /etc/lsb-release...
[2024-12-02 14:10:31] [SUCCESS] Configured: /etc/os-release
[2024-12-02 14:10:31] [SUCCESS] Configured: /etc/debian_version
[2024-12-02 14:10:31] [WARNING] Failed to configure: /etc/lsb-release
[2024-12-02 14:10:31] [SUCCESS] System identification configuration completed successfully!
```

---

## 2. `package_installer.sh`

### Description
The `package_installer.sh` script automates the installation of packages and dependencies on NebulixOS. It detects the underlying OS and installs software accordingly, ensuring compatibility with Debian-based systems.

### Features
- Detects and supports **NebulixOS**, **Debian**, and **Ubuntu**.
- Installs essential software like `filezilla`, `vim`, `curl`, or any specified package.
- Logs actions and errors with timestamps.
- Supports additional flags like `--dry-run` to preview installations.

### Usage
1. Make the script executable:
   ```bash
   chmod +x package_installer.sh
   ```
2. Run the script with a package name as an argument:
   ```bash
   sudo ./package_installer.sh filezilla
   ```

   Alternatively, install multiple packages:
   ```bash
   sudo ./package_installer.sh filezilla vim curl
   ```

3. Preview the installation using the `--dry-run` flag:
   ```bash
   sudo ./package_installer.sh --dry-run vim curl
   ```

4. Display usage help:
   ```bash
   sudo ./package_installer.sh --help
   ```

### Example Output
#### Successful Installation:
```
[2024-12-02 14:20:00] [INFO] Starting package installation...
[2024-12-02 14:20:00] [INFO] Installing package: filezilla
[2024-12-02 14:20:05] [SUCCESS] Successfully installed: filezilla
[2024-12-02 14:20:05] [INFO] Installing package: vim
[2024-12-02 14:20:07] [SUCCESS] Successfully installed: vim
[2024-12-02 14:20:07] [INFO] Installing package: curl
[2024-12-02 14:20:10] [SUCCESS] Successfully installed: curl
[2024-12-02 14:20:10] [SUCCESS] All packages installed successfully!
```

#### Dry-Run Example:
```
[2024-12-02 14:25:00] [INFO] Dry-run mode enabled. No changes will be made.
[2024-12-02 14:25:00] [INFO] Packages to install: vim curl
```

---

## 3. `system_update.sh`

### Description
The `system_update.sh` script automates system updates and optionally cleans up unused packages. It supports multiple package managers, including **APT**, **DNF**, **YUM**, **Pacman**, and **Zypper**, making it compatible with a wide range of Linux distributions.

### Features
- Detects the package manager dynamically.
- Performs a full system update:
  - Updates the package list.
  - Upgrades installed packages.
  - Handles distribution upgrades (if applicable).
- Optional cleanup of unused packages.
- Supports Debian/Ubuntu, Fedora, CentOS, Arch Linux, and openSUSE.
- Logs actions with timestamps for better visibility.

---

### Usage
1. **Make the script executable**:
   ```bash
   chmod +x system_update.sh
   ```
2. **Run a standard update**:
   ```bash
   sudo ./system_update.sh
   ```
3. **Run an update with cleanup**:
   ```bash
   sudo ./system_update.sh --cleanup
   ```
4. **Show help**:
   ```bash
   sudo ./system_update.sh --help
   ```

---

### Example Output
#### Standard Update
```
[2024-12-02 16:00:00] [INFO] Detected distribution: NebulixOS 1.0
[2024-12-02 16:00:00] [INFO] Using package manager: apt
[2024-12-02 16:00:00] [INFO] Updating package list...
[2024-12-02 16:00:05] [INFO] Upgrading packages...
[2024-12-02 16:00:30] [INFO] Performing distribution upgrade...
[2024-12-02 16:00:40] [SUCCESS] System update completed.
[2024-12-02 16:00:40] [SUCCESS] Update process completed successfully.
```

#### With Cleanup
```
[2024-12-02 16:10:00] [INFO] Detected distribution: NebulixOS 1.0
[2024-12-02 16:10:00] [INFO] Using package manager: apt
[2024-12-02 16:10:00] [INFO] Updating package list...
[2024-12-02 16:10:05] [INFO] Upgrading packages...
[2024-12-02 16:10:30] [INFO] Performing distribution upgrade...
[2024-12-02 16:10:40] [INFO] Removing unused packages...
[2024-12-02 16:10:50] [SUCCESS] System cleanup completed.
[2024-12-02 16:10:50] [SUCCESS] Update process completed successfully.
```

---

### Supported Package Managers
| Package Manager | Distribution Examples         |
|------------------|-------------------------------|
| `apt`            | Debian, Ubuntu, NebulixOS    |
| `dnf`            | Fedora                       |
| `yum`            | CentOS 7                     |
| `pacman`         | Arch Linux                   |
| `zypper`         | openSUSE                     |

---



## **4. `encrypt-files.sh`**

### Description
The `encrypt-files.sh` script encrypts all files in a specified directory using **GPG**, ensuring secure storage or transmission.

### Features
- Encrypts all files in a given directory.
- Uses the recipient's public key for encryption.
- Appends `.gpg` to encrypted files for easy identification.

### Usage
1. Make the script executable:
   ```bash
   chmod +x encrypt-files.sh
   ```

2. Run the script:
   ```bash
   ./encrypt-files.sh /path/to/directory recipient_email@example.com
   ```

### Example Output
```
Encrypting file1.txt...
Successfully encrypted file1.txt to file1.txt.gpg
Encrypting file2.doc...
Successfully encrypted file2.doc to file2.doc.gpg
Encryption process completed for all files in /path/to/directory.
```

---

## **5. `auto-mount-luks-usb.sh`**

### Description
The `auto-mount-luks-usb.sh` script unlocks and mounts a LUKS-encrypted USB drive automatically using a specified key file.

### Features
- Unlocks a LUKS-encrypted device.
- Mounts the unlocked device to a specified mount point.
- Provides unmounting and locking instructions for convenience.

### Usage
1. Make the script executable:
   ```bash
   chmod +x auto-mount-luks-usb.sh
   ```

2. Run the script:
   ```bash
   ./auto-mount-luks-usb.sh /dev/sdX1 /mnt/usb /path/to/keyfile
   ```

### Example Output
```
Unlocking LUKS device /dev/sdX1...
Mounting /dev/mapper/luks_usb to /mnt/usb...
Successfully mounted /dev/mapper/luks_usb to /mnt/usb.
To unmount and lock the device, run the following commands:
sudo umount /mnt/usb
sudo cryptsetup luksClose luks_usb
```

---

## **Directory Structure**

Here’s an overview of the project folder:

```
.
├── configure_nebulixos.sh      # Script to configure NebulixOS system identity
├── package_installer.sh        # Script to install packages and dependencies
├── system_update.sh            # Script to update the system and optionally clean up unused packages
├── encrypt-files.sh            # Script to encrypt files in a directory
├── auto-mount-luks-usb.sh      # Script to unlock and mount LUKS-encrypted USB drives
├── README.md                   # Documentation for scripts
```

---

## **Future Scripts**

We plan to expand this repository with additional scripts, such as:
- **Backup Utilities**: Automate secure backups with encryption.
- **Network Configuration**: Pre-configure VPNs and firewalls for secure networking.
- **Service Optimization**: Automate service configuration for SSH, Nginx, etc.

---

## **Contributing**

Feel free to contribute by submitting new scripts or improving existing ones. Follow the format in this README for consistency.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.