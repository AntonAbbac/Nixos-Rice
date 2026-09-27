{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 32;
      margin-top = 6;
      margin-left = 10;
      margin-right = 10;

      modules-left = ["custom/launcher" "hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["cpu" "memory" "battery" "pulseaudio" "network" "bluetooth" "tray"];

      "custom/launcher" = {
        format = "";
        on-click = "rofi -show drun";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{id}";
        on-click = "activate";
      };

      clock = {
        format = "󰥔 {:%H:%M}";
        format-alt = "󰃭 {:%d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "󰍛 {usage}%";
        interval = 2;
      };

      memory = {
        format = "󰑹 {}%";
        interval = 2;
      };

      network = {
        format-wifi = "󰤨 {signalStrength}%";
        format-ethernet = "󰀂 Ethernet";
        format-disconnected = "󰖪 Offline";
        tooltip-format = "{essid} ({signalStrength}%)";
      };

      bluetooth = {
        format = " {status}";
        format-disabled = "󰂲 Off";
        format-off = "󰂲 Off";
        format-connected = " {num_connections}";
        format-connected-battery = " {device_alias} {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} conectado(s)";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} conectado(s):\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        on-click = "blueman-manager";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = ["󰂎" "󰁺" "󰁼" "󰁽" "󰁿" "󰂁" "󰁹"];
        states = {
          warning = 20;
          critical = 10;
        };
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons = {
          default = ["󰕿" "󰖀" "󰕾"];
        };
        on-click = "pamixer -t";
        on-click-right = "pavucontrol";
      };

      tray = {
        icon-size = 16;
        spacing = 8;
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
        border-radius: 12px;
      }

      #workspaces {
        margin: 4px 4px;
        padding: 0 4px;
        background: #313244;
        border-radius: 8px;
      }

      #workspaces button {
        padding: 2px 10px;
        color: #cdd6f4;
      }

      #workspaces button.active {
        color: #cba6f7;
      }

      #workspaces button.empty {
        color: #313244;
      }

      #custom-launcher {
        padding: 0 14px;
        color: #cba6f7;
        font-size: 16px;
      }

      #clock {
        font-weight: bold;
        color: #f5e0dc;
      }

      #cpu, #memory, #battery, #pulseaudio, #network, #bluetooth, #tray {
        padding: 0 10px;
        margin: 4px 2px;
        background: #313244;
        border-radius: 8px;
        color: #cdd6f4;
      }

      #cpu { color: #a6e3a1; }
      #memory { color: #94e2d5; }
      #battery { color: #f9e2af; }
      #network { color: #89b4fa; }
      #bluetooth { color: #89b4fa; }
      #bluetooth.disabled, #bluetooth.off { color: #313244; }
      #pulseaudio { color: #fab387; }
    '';
  };
}
