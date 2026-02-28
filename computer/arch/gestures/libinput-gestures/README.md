# libinput-gestures

A utility that reads libinput gestures from your touchpad and maps them to custom actions (keyboard shortcuts, commands, etc.). Useful for replicating macOS-style multi-finger swipe gestures on Linux.

## 📦 Installation

```bash
# Install from AUR or via package manager
yay -S libinput-gestures

# Add your user to the input group
sudo gpasswd -a $USER input

# Enable and start the service
libinput-gestures-setup autostart start
```

## ⚙️ Configuration

The default config lives at `~/.config/libinput-gestures.conf`.  
A system-wide default is located at `/etc/libinput-gestures.conf`.

Example gesture binding:
```
gesture swipe left  3 xdotool key super+Right
gesture swipe right 3 xdotool key super+Left
gesture swipe up    4 xdotool key super+d
```

## 🔗 Official Documentation

- GitHub: https://github.com/bulletmark/libinput-gestures

## 📝 Notes

- Requires a Wayland-compatible setup or X11 with `xdotool` installed.
- Log out and back in after adding yourself to the `input` group.
- Use `libinput debug-events` to inspect raw touchpad events for debugging.
