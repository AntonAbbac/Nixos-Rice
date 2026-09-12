{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprland
    hyprpicker
    hypridle
    hyprlock
    waybar
    awww
    grim
    slurp
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    networkmanagerapplet
    wlogout
    swappy
  ];

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
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      windowrule = [
        "match:class .*, suppress_event maximize"
        "match:class ^(pavucontrol)$, float on"
        "match:class ^(nm-connection-editor)$, float on"
        "match:class ^(blueman-manager)$, float on"
        "match:title ^(Picture-in-Picture)$, float on"
        "match:title ^(Picture-in-Picture)$, pin on"
        "match:class ^(pavucontrol)$, size 800 600"
        "match:class ^(discord)$, workspace 9 silent"
        "match:class ^(Slack)$, workspace 9 silent"
      ];

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exec, wlogout"
        "$mainMod SHIFT, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, layoutmsg, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, X, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mainMod, Print, exec, grim - | wl-copy"
        "$mainMod SHIFT, Print, exec, mkdir -p $screenshotDir && grim $screenshotDir/$(date +%Y-%m-%d_%H-%m-%s).png"

        "$mainMod, W, submap, resize"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, pamixer -i 5 && dunstify -a \"volume\" -u low -i audio-volume-high -h int:value:$(pamixer --get-volume) -h string:x-dunst-stack-tag:volume \"Volume: $(pamixer --get-volume)%\""
        ",XF86AudioLowerVolume, exec, pamixer -d 5 && dunstify -a \"volume\" -u low -i audio-volume-low -h int:value:$(pamixer --get-volume) -h string:x-dunst-stack-tag:volume \"Volume: $(pamixer --get-volume)%\""
        ",XF86AudioMute, exec, pamixer -t"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+ && dunstify -a \"brightness\" -u low -i display-brightness-high -h string:x-dunst-stack-tag:brightness \"Brilho: $(brightnessctl -m | cut -d, -f4)\""
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%- && dunstify -a \"brightness\" -u low -i display-brightness-low -h string:x-dunst-stack-tag:brightness \"Brilho: $(brightnessctl -m | cut -d, -f4)\""
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", switch:on:Lid Switch, exec, hyprlock"
      ];
    };

    extraConfig = ''
      submap = resize
      binde = , right, resizeactive, 20 0
      binde = , left, resizeactive, -20 0
      binde = , up, resizeactive, 0 -20
      binde = , down, resizeactive, 0 20
      bind = , escape, submap, reset
      submap = reset
    '';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock.enable = true;

  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "p";
      }
    ];
  };
}
