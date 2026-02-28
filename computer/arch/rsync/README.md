# rclone — Systemd Mount

[rclone](https://rclone.org/) is a command-line program for syncing files to and from cloud storage providers (Google Drive, S3, Dropbox, OneDrive, etc.). This section covers mounting a remote as a filesystem via **systemd** using `rclone mount`.

## 📦 Installation

```bash
# Arch Linux
pacman -S rclone

# Or via the official install script
curl https://rclone.org/install.sh | sudo bash
```

## 🔧 Initial Configuration

Run the interactive config wizard to add a remote:

```bash
rclone config
```

Follow the prompts to authenticate with your chosen cloud provider. Remotes are stored in `~/.config/rclone/rclone.conf`.

## 🗂️ Systemd Mount Unit

Create a systemd user service to auto-mount your rclone remote on login.

**`~/.config/systemd/user/rclone-<remote>.service`**
```ini
[Unit]
Description=rclone mount for <remote>
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/rclone mount <remote>: /path/to/mountpoint \
  --vfs-cache-mode writes \
  --vfs-cache-max-size 500M \
  --log-level INFO
ExecStop=/bin/fusermount -u /path/to/mountpoint
Restart=on-failure

[Install]
WantedBy=default.target
```

Enable and start it:
```bash
systemctl --user enable --now rclone-<remote>.service
```

## 🔗 Official Documentation

- Systemd rclone mount guide: https://github.com/rclone/rclone/wiki/Systemd-rclone-mount
- rclone docs: https://rclone.org/docs/

## 📝 Notes

- Make sure FUSE is installed: `pacman -S fuse3`
- Create the mountpoint directory before starting the service: `mkdir -p /path/to/mountpoint`
- `--vfs-cache-mode writes` is a good balance between performance and compatibility for most use cases.
- For bandwidth-heavy remotes, consider `--bwlimit` to cap upload/download speed.
