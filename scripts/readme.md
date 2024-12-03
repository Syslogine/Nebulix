# NebulixOS Configuration and Automation Scripts

Welcome to the **NebulixOS Scripts** repository. This collection of scripts is designed to automate and simplify the customization, configuration, and maintenance of **NebulixOS**, a lightweight operating system based on Debian. Each script includes detailed usage instructions and example outputs.

---

## Scripts Overview

1. [**`configure_nebulixos.sh`**](#1-configurenehulixossh)  
   Modify system identification files to brand your OS as NebulixOS.
2. [**`package_installer.sh`**](#2-packageinstallersh)  
   Automate the installation of packages and dependencies on NebulixOS.

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
- Installs essential software like `filezilla`, `vim`, `curl`, or any specified package.
- Logs actions and errors with timestamps.
- Automatically resolves dependencies.

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

### Example Output
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

---

## Directory Structure
Here’s an overview of the project folder:
```
.
├── configure_nebulixos.sh      # Script to configure NebulixOS system identity
├── package_installer.sh        # Script to install packages and dependencies
├── README.md                   # Documentation for scripts
```

---

## Future Scripts
We plan to add more scripts to automate other tasks, including:
- **System Updates**: Automate OS and package updates.
- **Backup Utilities**: Backup configurations and user data.
- **Service Configuration**: Pre-configure essential services like SSH or Nginx.

---

## Contributing
Feel free to contribute to this repository by submitting new scripts or improving existing ones. Follow the format in this README for consistency.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
