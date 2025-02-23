# Package List Git Hook

This project sets up a Pacman hook to automatically track explicitly installed packages on an Arch Linux system using Git.

## How It Works

1. **Hook Configuration (`pkglist.hook`)**
   - This hook triggers on package **installation, upgrade, or removal**.
   - It runs **after** the transaction (`PostTransaction` stage).
   - It ensures that the `coreutils` package is available.
   - It executes the script `pkglist.sh`.

2. **Script (`pkglist.sh`)**
   - Lists all explicitly installed packages (`pacman -Qe`) and saves them to `pkglist.txt`.
   - Changes to the specified Git repository (`/root/pkglist-git`).
   - Adds and commits `pkglist.txt` with a timestamp as the commit message.
   - Pushes the changes to the remote Git repository.

## Setup Instructions

1. **Create the Hook File**
   ```sh
   sudo mkdir -p /etc/pacman.d/hooks
   sudo nano /etc/pacman.d/hooks/pkglist.hook
   ```
2. **Copy and paste the following content:**
   ```sh
    [Trigger]
    Operation = Install
    Operation = Upgrade
    Operation = Remove
    Type = Package
    Target = *

    [Action]
    Depends = coreutils
    When = PostTransaction
    Exec = /root/pkglist-git/pkglist.sh
   ```
3. **Create the Script**
   ```sh
    sudo mkdir -p /root/pkglist-git
    sudo nano /root/pkglist-git/pkglist.sh
   ```
4. **Copy and paste the following content:**
   ```sh
    #!/bin/sh

    pacman -Qe > /root/pkglist-git/pkglist.txt
    cd /root/pkglist-git
    git add pkglist.txt
    git commit -m "$(date)"
    git push
   ```
5. **Make the Script Executable**
   ```sh
    sudo chmod +x /root/pkglist-git/pkglist.sh
   ```
6. **Initialize Git Repository (If Not Already Done)**
   ```sh
    cd /root/pkglist-git
    git init
    git remote add origin <your-repo-url>
    git pull origin main  # Ensure you're synced with the remote repo
    git add pkglist.txt
    git commit -m "Initial commit"
    git push -u origin main
   ```
## Purpose & Benefits
- Automatically keeps track of explicitly installed packages.
- Useful for system recovery, migration, or auditing installed packages.
- Ensures changes to installed packages are versioned and backed up with Git.

## Notes
- Ensure your system has git installed.
- The script runs with root privileges, so the repository should be securely configured.
- Use an SSH key or stored credentials for seamless git push operations.
