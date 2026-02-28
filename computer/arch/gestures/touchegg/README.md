# Touchégg

Touchégg is a multi-touch gesture recognizer that translates touchpad/touchscreen gestures into actions on Linux (X11 & Wayland). It runs as a background daemon and supports highly customizable gesture-to-action mappings.

## 📦 Installation

```bash
# Install via pacman (Arch Linux)
pacman -S touchegg

# Optional: Install the GUI tweaker via Flatpak
flatpak install com.github.joseexposito.touche
```

## 🚀 Service Management

Touchégg ships with a systemd service. Enable it to auto-start on boot:

```bash
# Enable and start the daemon
sudo systemctl enable --now touchegg

# Check status
systemctl status touchegg
```

The service unit is symlinked as follows:
```
/etc/systemd/system/touchegg.service -> /usr/lib/systemd/system/touchegg.service
```

## 📂 Configuration Locations

| Scope       | Path                              |
|-------------|-----------------------------------|
| System-wide | `/etc/xdg/touchegg/touchegg.conf` |
| Per-user    | `~/.config/touchegg/touchegg.conf` |

Per-user config takes priority when present. Copy the system config as a starting point:

```bash
mkdir -p ~/.config/touchegg
cp /etc/xdg/touchegg/touchegg.conf ~/.config/touchegg/touchegg.conf
```

## ⚙️ Configuration Example

Gestures are defined in XML inside `touchegg.conf`. Example — three-finger swipe right to go back in browser:

```xml
<gesture type="SWIPE" fingers="3" direction="RIGHT">
  <action type="SEND_KEYS">
    <keys>CTRL_L+Alt_L+Left</keys>
    <repeat>false</repeat>
  </action>
</gesture>
```

## 🔗 Official Documentation

- GitHub / Installation Guide: https://github.com/JoseExposito/touchegg/tree/master/installation#readme
- GUI Tweaker (Touché): https://flathub.org/apps/com.github.joseexposito.touche

## 📝 Notes

- Touchégg works on both X11 and Wayland sessions.
- The GUI tweaker (Touché) provides a visual interface to configure gestures without editing XML manually.
- Make sure your user has access to input devices (the daemon handles this automatically when run as a system service).
