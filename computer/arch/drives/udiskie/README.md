## 📦 Installation Options

Udiskie is a simple tray application that shows mounted removable devices and provides easy access to them.

```bash
# Install udiskie
sudo pacman -S udiskie

# Enable autostart (optional)
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/udiskie.desktop << EOF
[Desktop Entry]
Type=Application
Name=Udiskie
Exec=udiskie --tray
X-GNOME-Autostart-enabled=true
EOF

# Start manually
udiskie --tray &
```

## ⚙️ Configuration

### Udiskie Configuration

Create or edit `~/.config/udiskie/config.yml`:

```yaml
program_options:
  # Show tray icon
  tray: true

  # Automount options (disable for security)
  automount: false
  automount_open: false

  # Notification settings
  notify: true
  notify_all: false

  # File manager to use
  file_manager: thunar  # or nautilus, dolphin, pcmanfm, etc.

  # Mount options for security
  mount_options:
    defaults:
      - noatime
      - nodiratime
      - nosuid
      - nodev
      - noexec
```

### Security-Focused Configuration

For enhanced security, disable automount and require manual mounting:

```yaml
program_options:
  # DISABLE automatic mounting for security
  automount: false
  automount_open: false

  # Enable tray icon
  tray: true

  # Enable notifications for user awareness
  notify: true
  notify_all: true

  # Secure mount options
  mount_options:
    defaults:
      - noatime
      - nodiratime
      - nosuid
      - nodev
      - noexec
      - uid=1000
      - gid=1000
```

## 🚀 Usage

### Starting the Drives Manager

```bash
# Start udiskie in tray mode
udiskie --tray &
```

### System Tray Interaction

- **Left-click** on tray icon: Shows mounted devices
- **Right-click**: Options to mount/unmount/eject devices
- **Hover**: Shows device information

## 🔧 Troubleshooting

### Tray Icon Not Appearing

1. **Check if udiskie is running**:
   ```bash
   pgrep -a udiskie
   ```

2. **Verify dependencies**:
   ```bash
   pacman -Q udisks2 gvfs
   ```

3. **Check user permissions**:
   ```bash
   groups
   ```
   Ensure you're in the `storage` group:
   ```bash
   sudo usermod -aG storage $USER
   ```

### Devices Not Appearing

1. **Check udisks2 service**:
   ```bash
   systemctl --user status udisks2
   ```

2. **Enable debug mode**:
   ```bash
   udiskie --verbose
   ```

3. **Manual mount test**:
   ```bash
   udisksctl mount -b /dev/sdX1
   ```

### Permission Issues

```bash
# Add user to necessary groups
sudo usermod -aG storage,optical,uucp $USER

# Apply group changes
newgrp storage
```

## 📝 Advanced Configuration

### Custom Mount Options

Edit your udiskie configuration to add custom mount options:

```yaml
mount_options:
  defaults:
    - noatime
    - nodiratime
    - nosuid
    - nodev
    - noexec
    - uid=1000
    - gid=1000
    - umask=022

  ntfs:
    - windows_names
    - uid=1000
    - gid=1000

  vfat:
    - uid=1000
    - gid=1000
    - utf8
    - shortname=mixed
```

### Device-Specific Rules

Create rules for specific devices:

```yaml
device_options:
  auto_mount:
    - /dev/sda1
    - /dev/sdb1

  ignore:
    - /dev/loop*
    - /dev/sr*
```

## 🔗 Additional Resources

- **Udiskie GitHub**: https://github.com/coldfix/udiskie
- **Arch Wiki - Udisks**: https://wiki.archlinux.org/title/Udisks
- **Arch Wiki - Storage devices**: https://wiki.archlinux.org/title/Storage_devices
- **Arch Wiki - Removable media**: https://wiki.archlinux.org/title/Removable_media

## 💡 Tips

- Udiskie works with both X11 and Wayland sessions
- For encrypted drives, you'll be prompted for password when mounting
- Network shares may require additional configuration
- The tray icon appears when devices are connected or mounted
- Consider disabling automount for security on shared computers