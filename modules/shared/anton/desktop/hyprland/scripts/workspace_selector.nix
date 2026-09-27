{pkgs, ...}:
pkgs.writeShellScriptBin "workspace-selector" ''
  OPTIONS="1. Dev\n2. Notes (Obsidian)\n3. Complete (Zed + Obsidian + Librewolf)\n4. Clean"
  CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Workflow for today:")

  case "$CHOICE" in
    "1. Dev")
      hyprctl dispatch exec zeditor
      ;;
    "2. Notes (Obsidian)")
      hyprctl dispatch exec obsidian
      ;;
    "3. Complete (Zed + Obsidian + Librewolf)")
      hyprctl dispatch exec zeditor
      hyprctl dispatch exec obsidian
      hyprctl dispatch exec librewolf
      ;;
    "4. Clean")
      exit 0
      ;;
  esac
''
