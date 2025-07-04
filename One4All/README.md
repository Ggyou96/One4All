# One4All - Complete Hyprland Desktop Setup

<div align="center">

![Hyprland](https://img.shields.io/badge/Hyprland-Dynamic%20Tiling-5e81ac?style=for-the-badge&logo=wayland&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Waybar](https://img.shields.io/badge/Waybar-Status%20Bar-88c0d0?style=for-the-badge)
![Rofi](https://img.shields.io/badge/Rofi-Application%20Launcher-a3be8c?style=for-the-badge)

*A minimal but powerful Hyprland Wayland desktop environment for Arch Linux*

</div>

## 🚀 Project Overview

One4All is a comprehensive, automated setup script that transforms your Arch Linux system into a beautiful, modern Wayland desktop environment powered by Hyprland. This setup focuses on performance, aesthetics, and usability while maintaining a minimal footprint.

### ✨ What's Included

- **🪟 Hyprland** - Dynamic tiling Wayland compositor with beautiful animations
- **📊 Waybar** - Modern status bar with glassmorphism design
- **🔍 Rofi** - Application launcher and power menu with transparency effects
- **🎨 Nord Theme** - Consistent dark color scheme across all components
- **⚡ Performance Optimizations** - CPU governor, zram, and system tweaks
- **🔤 JetBrainsMono Nerd Font** - Professional monospace font with icons
- **🔧 Complete Configuration** - Pre-configured for immediate use

## 🛠️ Tools & Applications

| Component | Purpose | Features |
|-----------|---------|----------|
| **Hyprland** | Window Manager | Dynamic tiling, animations, VRR support |
| **Waybar** | Status Bar | System info, workspaces, tray, clock |
| **Rofi** | App Launcher | Application search, power menu |
| **Kitty** | Terminal | GPU-accelerated, fast, configurable |
| **Swaybg** | Wallpaper | Efficient background image rendering |
| **Swaylock** | Screen Locker | Secure screen locking with style |
| **PipeWire** | Audio System | Low-latency audio with Wireplumber |
| **NetworkManager** | Network | Reliable network management |

## 📥 Installation

### Quick Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/Ggyou96/One4All.git

# Navigate to directory
cd One4All

# Make install script executable
chmod +x install.sh

# Run the installation (requires sudo)
./install.sh
```

### Manual Installation

If you prefer to review before installation:

```bash
# Clone and inspect
git clone https://github.com/Ggyou96/One4All.git
cd One4All

# Review the installation script
cat install.sh

# Run when ready
chmod +x install.sh && ./install.sh
```

## 🎯 Features

### 🎨 Visual Features
- **Glassmorphism Design** - Transparent, blurred elements
- **Nord Color Scheme** - Beautiful dark theme
- **Rounded Corners** - Modern UI elements
- **Smooth Animations** - 144 FPS optimized
- **Custom Icons** - Nerd Font integration

### ⚡ Performance Features
- **VRR Support** - Variable refresh rate
- **CPU Performance Mode** - Automatic governor setup
- **Zram Compression** - Memory optimization for <8GB RAM
- **SSD Optimization** - Automatic fstrim scheduling
- **Resource Monitoring** - Real-time CPU, memory, network stats

### 🔧 Functionality Features
- **Dynamic Tiling** - Intelligent window management
- **Multi-workspace** - 10 workspaces with persistence
- **Screenshot Tools** - Area and full-screen capture
- **Audio Control** - Volume and device management
- **Power Management** - Brightness, power menu
- **Network Management** - WiFi and Ethernet handling

## 📁 Directory Structure

```
One4All/
├── install.sh                 # Main installation script
├── README.md                  # This documentation
└── config/                    # Configuration files
    ├── hypr/                  # Hyprland configuration
    │   └── hyprland.conf      # Main Hyprland config
    ├── waybar/                # Waybar configuration
    │   ├── config.jsonc       # Waybar layout and modules
    │   └── style.css          # Waybar glassmorphism theme
    └── rofi/                  # Rofi configuration
        ├── config.rasi        # Rofi appearance and behavior
        └── powermenu.sh       # Power menu script
```

## ⌨️ Key Bindings

### Essential Controls
| Keybinding | Action |
|------------|--------|
| `SUPER + Enter` | Open terminal (Kitty) |
| `SUPER + R` | Application launcher (Rofi) |
| `SUPER + X` | Power menu |
| `SUPER + Q` | Close window |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + V` | Toggle floating |
| `SUPER + L` | Lock screen |

### Window Management
| Keybinding | Action |
|------------|--------|
| `SUPER + [1-9]` | Switch to workspace |
| `SUPER + SHIFT + [1-9]` | Move window to workspace |
| `SUPER + H/J/K/L` | Move focus (Vim keys) |
| `SUPER + CTRL + H/J/K/L` | Resize window |
| `SUPER + SHIFT + H/J/K/L` | Move window |

### System Controls
| Keybinding | Action |
|------------|--------|
| `Print` | Screenshot area |
| `SUPER + Print` | Screenshot full screen |
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp/Down` | Brightness control |

## 🔧 Post-Install Configuration

### 1. First Login
- Reboot your system after installation
- Select "Hyprland" from your display manager
- Or start manually with: `Hyprland`

### 2. Wallpaper Setup
```bash
# Add your own wallpapers
cp your-wallpaper.jpg ~/Pictures/wallpapers/
# Update Hyprland config to use new wallpaper
```

### 3. Audio Setup
```bash
# Test audio
speaker-test -c2
# Configure with
pavucontrol
```

### 4. Additional Applications
```bash
# Install additional software
sudo pacman -S firefox thunar discord code
```

### 5. Theme Customization
- Waybar: Edit `~/.config/waybar/style.css`
- Rofi: Edit `~/.config/rofi/config.rasi`
- Hyprland: Edit `~/.config/hypr/hyprland.conf`

## 🛠️ System Requirements

### Minimum Requirements
- **OS**: Arch Linux (up-to-date)
- **GPU**: Any GPU with basic OpenGL support
- **RAM**: 4GB (8GB+ recommended)
- **Storage**: 2GB free space

### Recommended Requirements
- **GPU**: Modern GPU with Vulkan support
- **RAM**: 8GB or more
- **Display**: 1080p or higher resolution
- **Input**: Keyboard and mouse/touchpad

## 🔍 Troubleshooting

### Common Issues

#### Hyprland won't start
```bash
# Check logs
journalctl --user -xe
# Ensure proper GPU drivers
lspci -v | grep -A12 VGA
```

#### No audio
```bash
# Restart audio services
systemctl --user restart pipewire pipewire-pulse wireplumber
```

#### Font issues
```bash
# Refresh font cache
fc-cache -fv
# Verify font installation
fc-list | grep -i jetbrains
```

#### Screen tearing
```bash
# Add to hyprland.conf
echo "misc { vrr = 1 }" >> ~/.config/hypr/hyprland.conf
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- **Hyprland** - Amazing Wayland compositor
- **Nord Theme** - Beautiful color palette
- **JetBrains** - Excellent monospace font
- **Arch Linux** - Rolling release excellence
- **Wayland** - Future of Linux graphics

## 🔗 Useful Links

- [Hyprland Documentation](https://hyprland.org/)
- [Waybar Configuration](https://github.com/Alexays/Waybar/wiki/Configuration)
- [Rofi Manual](https://github.com/davatorium/rofi)
- [Arch Linux Wiki](https://wiki.archlinux.org/)

---

<div align="center">

**Made with ❤️ for the Arch Linux community**

*Star ⭐ this repository if it helped you!*

</div>