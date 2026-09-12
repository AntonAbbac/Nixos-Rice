_: let
  # Catppuccin Mocha
  c = {
    base = "#1e1e2e";
    surface0 = "#313244";
    text = "#cdd6f4";
    rosewater = "#f5e0dc";
    red = "#f38ba8";
    green = "#a6e3a1";
    yellow = "#f9e2af";
    blue = "#89b4fa";
    mauve = "#cba6f7";
    teal = "#94e2d5";
    peach = "#fab387";
  };
in {
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
      modules-right = ["cpu" "memory" "battery" "pulseaudio" "network" "tray"];

      "custom/launcher" = {
        format = "";
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
        format = "  {:%H:%M}";
        format-alt = "  {:%d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = " {usage}%";
        interval = 2;
      };

      memory = {
        format = "󰑹  {}%";
        interval = 2;
      };

      network = {
        format-wifi = "  {signalStrength}%";
        format-ethernet = "󰀂 Ethernet";
        format-disconnected = "󰖪 Offline";
        tooltip-format = "{essid} ({signalStrength}%)";
      };

      battery = {
        format = "{icon}  {capacity}%";
        format-charging = "  {capacity}%";
        format-icons = ["" "" "" "" ""];
        states = {
          warning = 20;
          critical = 10;
        };
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "  muted";
        format-icons = {
          default = ["" "" ""];
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
        background: ${c.base};
        color: ${c.text};
        border-radius: 12px;
      }

      #workspaces {
        margin: 4px 4px;
        padding: 0 4px;
        background: ${c.surface0};
        border-radius: 8px;
      }

      #workspaces button {
        padding: 2px 10px;
        color: ${c.text};
      }

      #workspaces button.active {
        color: ${c.mauve};
      }

      #workspaces button.empty {
        color: ${c.surface0};
      }

      #custom-launcher {
        padding: 0 14px;
        color: ${c.mauve};
        font-size: 16px;
      }

      #clock {
        font-weight: bold;
        color: ${c.rosewater};
      }

      #cpu, #memory, #battery, #pulseaudio, #network, #tray {
        padding: 0 10px;
        margin: 4px 2px;
        background: ${c.surface0};
        border-radius: 8px;
        color: ${c.text};
      }

      #cpu { color: ${c.green}; }
      #memory { color: ${c.teal}; }
      #battery { color: ${c.yellow}; }
      #network { color: ${c.blue}; }
      #pulseaudio { color: ${c.peach}; }
    '';
  };
}
