{...}: {
  wayland.windowManager.hyprland.settings = {
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
      "$mainMod, Y, exec, ytfzf -m"

      "$mainMod SHIFT, W, exec, workspace-selector"

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
      "$mainMod SHIFT, L, togglespecialworkspace, special:librewolf"

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
}
