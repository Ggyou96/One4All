#!/bin/bash

# One4All Hyprland Setup Script for Arch Linux
# Author: Automated Setup Agent
# Description: Complete Hyprland desktop environment setup with optimizations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}[One4All]${NC} $1"
}

# Check if running on Arch Linux
check_arch_linux() {
    if [[ ! -f /etc/arch-release ]]; then
        print_error "This script is designed for Arch Linux only!"
        exit 1
    fi
    print_status "Arch Linux detected. Proceeding with installation..."
}

# Update system and install required packages
install_packages() {
    print_header "Installing required packages..."
    
    # Update system first
    sudo pacman -Syu --noconfirm
    
    # Install main packages
    local packages=(
        "hyprland"
        "rofi-wayland" 
        "waybar"
        "kitty"
        "wofi"
        "swaybg"
        "swaylock"
        "pipewire"
        "wireplumber"
        "networkmanager"
        "neovim"
        "git"
        "unzip"
        "wget"
        "grim"
        "slurp"
        "wl-clipboard"
        "xdg-desktop-portal-hyprland"
        "polkit-kde-agent"
        "qt5-wayland"
        "qt6-wayland"
    )
    
    for package in "${packages[@]}"; do
        if ! pacman -Q "$package" &> /dev/null; then
            print_status "Installing $package..."
            sudo pacman -S --noconfirm "$package"
        else
            print_status "$package already installed"
        fi
    done
}

# Enable essential services
enable_services() {
    print_header "Enabling essential services..."
    
    # Enable NetworkManager
    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager
    
    # Enable trim timer for SSD optimization
    sudo systemctl enable fstrim.timer
    
    print_status "Services enabled successfully"
}

# Create directories and copy configurations
setup_configs() {
    print_header "Setting up configurations..."
    
    # Create config directories
    mkdir -p ~/.config/{hypr,waybar,rofi}
    mkdir -p ~/.local/share/fonts
    mkdir -p ~/Pictures/wallpapers
    
    # Copy configurations
    cp -r config/hypr/* ~/.config/hypr/
    cp -r config/waybar/* ~/.config/waybar/
    cp -r config/rofi/* ~/.config/rofi/
    
    # Make powermenu script executable
    chmod +x ~/.config/rofi/powermenu.sh
    
    print_status "Configurations copied successfully"
}

# Install JetBrainsMono Nerd Font
install_font() {
    print_header "Installing JetBrainsMono Nerd Font..."
    
    local font_dir="$HOME/.local/share/fonts"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
    
    if [[ ! -f "$font_dir/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
        print_status "Downloading JetBrainsMono Nerd Font..."
        wget -O /tmp/JetBrainsMono.zip "$font_url"
        unzip -o /tmp/JetBrainsMono.zip -d "$font_dir"
        rm /tmp/JetBrainsMono.zip
        fc-cache -fv
        print_status "Font installed successfully"
    else
        print_status "JetBrainsMono Nerd Font already installed"
    fi
}

# Download wallpapers
setup_wallpapers() {
    print_header "Setting up wallpapers..."
    
    local wallpaper_dir="$HOME/Pictures/wallpapers"
    
    # Create some sample wallpapers or download from a collection
    if [[ ! -f "$wallpaper_dir/default.jpg" ]]; then
        print_status "Downloading sample wallpapers..."
        
        # Download some free wallpapers (using placeholder service for demo)
        wget -O "$wallpaper_dir/default.jpg" "https://picsum.photos/1920/1080?random=1" 2>/dev/null || \
        {
            print_warning "Failed to download wallpaper, creating fallback"
            # Create a simple gradient as fallback
            echo "Creating fallback wallpaper..."
            convert -size 1920x1080 gradient:#2E3440-#5E81AC "$wallpaper_dir/default.jpg" 2>/dev/null || \
            touch "$wallpaper_dir/default.jpg"
        }
    fi
    
    print_status "Wallpapers setup complete"
}

# Set up Hyprland session
setup_hyprland_session() {
    print_header "Setting up Hyprland session..."
    
    # Create desktop entry for display manager
    sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
EOF
    
    print_status "Hyprland session configured"
}

# Performance optimizations
setup_optimizations() {
    print_header "Applying performance optimizations..."
    
    # Create CPU governor service for performance
    sudo tee /etc/systemd/system/cpu-performance.service > /dev/null <<EOF
[Unit]
Description=Set CPU governor to performance
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
    
    sudo systemctl enable cpu-performance.service
    
    # Setup zram if not enough RAM
    local total_ram=$(free -m | awk 'NR==2{print $2}')
    if [[ $total_ram -lt 8192 ]]; then
        print_status "Setting up zram for systems with less than 8GB RAM..."
        
        if ! pacman -Q zram-generator &> /dev/null; then
            sudo pacman -S --noconfirm zram-generator
        fi
        
        sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF
        
        sudo systemctl daemon-reload
        sudo systemctl start systemd-zram-setup@zram0.service
    fi
    
    print_status "Performance optimizations applied"
}

# Main installation function
main() {
    print_header "Starting One4All Hyprland Setup..."
    
    check_arch_linux
    install_packages
    enable_services
    setup_configs
    install_font
    setup_wallpapers
    setup_hyprland_session
    setup_optimizations
    
    print_header "Installation completed successfully!"
    echo
    print_status "Please reboot your system and select Hyprland from your display manager"
    print_status "Or start Hyprland manually with: Hyprland"
    echo
    print_warning "Post-install tips:"
    echo "  • SUPER+Enter: Open terminal (kitty)"
    echo "  • SUPER+R: Application launcher (rofi)"
    echo "  • SUPER+X: Power menu"
    echo "  • SUPER+Q: Close window"
    echo "  • SUPER+[1-9]: Switch workspaces"
    echo
    print_status "Enjoy your new Hyprland desktop! 🚀"
}

# Run main function
main "$@"