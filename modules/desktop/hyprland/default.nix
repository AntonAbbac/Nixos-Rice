{ config, pkgs, ... }:


{

  home.packages = with pkgs; [
    hyprland
    waybar
    swww # wallpaper daemon (substitui hyprpaper, suporta transições)
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    pavucontrol
    networkmanagerapplet
  ];

  home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors; # Substitua pelo tema desejado (ex: pkgs.catppuccin-cursors)
      name = "Bibata-Modern-Classic"; # Nome exato da pasta do tema
      size = 24;                     # Tamanho do cursor
    };
  wayland.windowManager.hyprland.settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # MONITORS

      monitor=,preferred,auto,auto

      # MY PROGRAMS

      $terminal = kitty
      $fileManager = thunar
      $menu = rofi -show drun

      # AUTOSTART

      exec-once = waybar
      exec-once = swww-daemon
      exec-once = swww img ~/dotfiles/nixos/modules/themes/wallpapers/wallpaper.png
      exec-once = nm-applet
      exec-once = dunst

      # ENVIRONMENT VARIABLES

      # LOOK AND FEEL

      general {
          gaps_in = 5
          gaps_out = 20

          border_size = 2

          col.active_border = rgba(cba6f7ee) rgba(89b4faee) 45deg
          col.inactive_border = rgba(585b70aa)

          resize_on_border = true
          allow_tearing = false

          layout = dwindle
      }

      decoration {
          rounding = 10
          rounding_power = 2

          active_opacity = 1.0
          inactive_opacity = 0.95

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(11111bee)
          }

          blur {
              enabled = true
              size = 3
              passes = 2
              vibrancy = 0.1696
          }
      }

      animations {
          enabled = yes

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      dwindle {
          pseudotile = true
          preserve_split = true
      }

      master {
          new_status = master
      }

      # INPUT

      input {
          kb_layout = br
          kb_variant = abnt2
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1
          sensitivity = 0

          touchpad {
              natural_scroll = false
          }
      }

      # KEYBINDINGS

      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, F, fullscreen,

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # SCREENSHOTS

      bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
      bind = $mainMod, Print, exec, grim - | wl-copy

      # MEDIA KEYS

      bindel = ,XF86AudioRaiseVolume, exec, pamixer -i 5
      bindel = ,XF86AudioLowerVolume, exec, pamixer -d 5
      bindel = ,XF86AudioMute, exec, pamixer -t
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # WINDOW RULES

      windowrule = suppressevent maximize, class:.*
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';
  };
}
