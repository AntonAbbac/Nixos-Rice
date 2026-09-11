{pkgs, ...}: {
  systemd.user.services.proton-drive-sync = {
    Unit = {
      Description = "Sincronização automática da pasta Documents com o Proton Drive";
      After = ["network-online.target"];
      Wants = ["network-online.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rclone}/bin/rclone sync %h/Documents proton:Documents --fast-list --transfers 4";
      Restart = "on-failure";
      RestartSec = "30s";
    };
  };

  systemd.user.timers.proton-drive-sync = {
    Unit = {
      Description = "Timer para sincronização do Proton Drive";
    };

    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
      Persistent = true;
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
