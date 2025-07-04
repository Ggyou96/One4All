#!/bin/bash

# One4All Rofi Power Menu
# Beautiful power menu with icons and confirmations

# Define options with icons
shutdown="  Poweroff"
reboot="  Reboot" 
lock="  Lock"
logout="  Logout"
cancel="  Cancel"

# Create the option list
options="$shutdown\n$reboot\n$lock\n$logout\n$cancel"

# Rofi theme configuration for power menu
rofi_theme="
* {
    font: \"JetBrainsMono Nerd Font Bold 14\";
    background-color: rgba(46, 52, 64, 0.95);
    text-color: #d8dee9;
    selected-normal-foreground: #2e3440;
    selected-normal-background: rgba(191, 97, 106, 0.8);
    normal-foreground: #d8dee9;
    normal-background: transparent;
    border-color: rgba(191, 97, 106, 0.4);
}

window {
    transparency: \"real\";
    location: center;
    anchor: center;
    fullscreen: false;
    width: 380px;
    border: 2px solid;
    border-radius: 16px;
    padding: 20px;
}

mainbox {
    background-color: transparent;
    children: [ listview ];
    spacing: 0px;
    padding: 0px;
}

listview {
    background-color: transparent;
    columns: 1;
    lines: 5;
    cycle: true;
    dynamic: false;
    scrollbar: false;
    layout: vertical;
    reverse: false;
    fixed-height: true;
    fixed-columns: true;
    spacing: 8px;
    padding: 0px;
}

element {
    background-color: rgba(59, 66, 82, 0.6);
    text-color: inherit;
    orientation: horizontal;
    border-radius: 12px;
    padding: 16px;
    margin: 4px;
    border: 1px solid rgba(76, 86, 106, 0.4);
}

element-text {
    background-color: transparent;
    text-color: inherit;
    expand: true;
    horizontal-align: 0.5;
    vertical-align: 0.5;
    margin: 0px;
    font: \"JetBrainsMono Nerd Font Bold 16\";
}

element.selected {
    background-color: rgba(191, 97, 106, 0.8);
    text-color: #eceff4;
    border: 1px solid rgba(191, 97, 106, 0.6);
}

element:hover {
    background-color: rgba(191, 97, 106, 0.6);
    text-color: #eceff4;
    border: 1px solid rgba(191, 97, 106, 0.8);
}

/* Special styling for cancel option */
element:last-child {
    background-color: rgba(76, 86, 106, 0.6);
}

element:last-child.selected {
    background-color: rgba(94, 129, 172, 0.8);
    border: 1px solid rgba(94, 129, 172, 0.6);
}
"

# Function to show confirmation dialog
confirm_action() {
    local action=\"$1\"
    local icon=\"$2\"
    
    local yes=\"  Yes\"
    local no=\"  No\"
    
    local confirm_options=\"\$yes\\n\$no\"
    
    local confirm_theme=\"
    * {
        font: \\\"JetBrainsMono Nerd Font Bold 14\\\";
        background-color: rgba(46, 52, 64, 0.95);
        text-color: #d8dee9;
        selected-normal-foreground: #2e3440;
        selected-normal-background: rgba(191, 97, 106, 0.8);
        normal-foreground: #d8dee9;
        normal-background: transparent;
        border-color: rgba(191, 97, 106, 0.4);
    }

    window {
        transparency: \\\"real\\\";
        location: center;
        anchor: center;
        fullscreen: false;
        width: 320px;
        border: 2px solid;
        border-radius: 16px;
        padding: 20px;
    }

    mainbox {
        background-color: transparent;
        children: [ message, listview ];
        spacing: 16px;
        padding: 0px;
    }

    message {
        background-color: rgba(59, 66, 82, 0.6);
        border-radius: 12px;
        padding: 16px;
        margin: 0px;
        border: 1px solid rgba(76, 86, 106, 0.4);
    }

    textbox {
        background-color: transparent;
        text-color: #d8dee9;
        font: \\\"JetBrainsMono Nerd Font Bold 14\\\";
        horizontal-align: 0.5;
        vertical-align: 0.5;
    }

    listview {
        background-color: transparent;
        columns: 2;
        lines: 1;
        cycle: true;
        dynamic: false;
        scrollbar: false;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;
        spacing: 8px;
        padding: 0px;
    }

    element {
        background-color: rgba(59, 66, 82, 0.6);
        text-color: inherit;
        orientation: horizontal;
        border-radius: 12px;
        padding: 12px;
        margin: 4px;
        border: 1px solid rgba(76, 86, 106, 0.4);
    }

    element-text {
        background-color: transparent;
        text-color: inherit;
        expand: true;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        margin: 0px;
        font: \\\"JetBrainsMono Nerd Font Bold 14\\\";
    }

    element.selected {
        background-color: rgba(191, 97, 106, 0.8);
        text-color: #eceff4;
        border: 1px solid rgba(191, 97, 106, 0.6);
    }

    element:first-child.selected {
        background-color: rgba(163, 190, 140, 0.8);
        border: 1px solid rgba(163, 190, 140, 0.6);
    }
    \"
    
    local choice=$(echo -e \"\$confirm_options\" | rofi -dmenu -i -theme-str \"\$confirm_theme\" -p \"\$icon Confirm \$action?\")
    
    case \$choice in
        \$yes)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to execute power actions
execute_action() {
    case \$1 in
        \$shutdown)
            if confirm_action \"Shutdown\" \"\"; then
                systemctl poweroff
            fi
            ;;
        \$reboot)
            if confirm_action \"Reboot\" \"\"; then
                systemctl reboot
            fi
            ;;
        \$lock)
            swaylock -f -c 000000 --ring-color 88c0d0 --key-hl-color a3be8c --line-color 00000000 --inside-color 2e344080 --separator-color 00000000 --grace 3 --fade-in 0.5
            ;;
        \$logout)
            if confirm_action \"Logout\" \"\"; then
                hyprctl dispatch exit
            fi
            ;;
        \$cancel)
            exit 0
            ;;
        *)
            exit 1
            ;;
    esac
}

# Main menu
chosen=$(echo -e \"\$options\" | rofi -dmenu -i -theme-str \"\$rofi_theme\" -p \"  Power Menu\")

# Execute the chosen action
execute_action \"\$chosen\"