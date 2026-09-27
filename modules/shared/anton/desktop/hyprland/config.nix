{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "hyprlang";

    settings = {
      monitor = [
        ",preferred,auto,auto"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";
      "$screenshotDir" = "$HOME/Pictures/Screenshots";

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,20"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
        "NIXOS_OZONE_WL,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      exec-once = [
        "waybar"
        "swww-daemon"
        "swww img /etc/dotfiles/modules/themes/wallpapers/firewatch.png"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "nm-applet"
        "dunst"
        "hypridle"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "syncthing"
        "workspace-selector"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
      };

      master = {
        new_status = "master";
      };
      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "thinkpad";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      windowrule = [
        {
          name = "suppress-maximize";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          name = "obsidian-workspace";
          "match:class" = "^(md.Obsidian)$";
          workspace = "1 silent";
          float = "on";
          size = "800 600";
          center = "on";
        }
        {
          name = "zed-workspace";
          "match:class" = "^(dev.zed.Zed)$";
          workspace = "2 silent";
          float = "off";
          size = "800 600";
          center = "off";
        }
        {
          name = "librewolf-workspace";
          "match:class" = "^(librewolf)$";
          workspace = "special:magic";
          float = "off";
          size = "800 600";
          center = "on";
        }
        {
          name = "slack-workspace";
          "match:class" = "^(Slack)$";
          workspace = "9 silent";
        }
        {
          name = "pavucontrol-float";
          "match:class" = "^(pavucontrol)$";
          float = "on";
          size = "800 600";
          center = "on";
        }
        {
          name = "network-manager-float";
          "match:class" = "^(nm-connection-editor)$";
          float = "on";
          center = "on";
        }
        {
          name = "blueman-float";
          "match:class" = "^(blueman-manager)$";
          float = "on";
          size = "700 500";
          center = "on";
        }
        {
          name = "pip-float-pin";
          "match:title" = "^(Picture-in-Picture)$";
          float = "on";
          pin = "on";
        }
      ];
    };
  };
}
