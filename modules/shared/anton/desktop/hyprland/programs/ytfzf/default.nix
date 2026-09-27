{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ytfzf
    fzf
    jq
    yt-dlp
  ];
  programs.mpv = {
    enable = true;
    scripts = [pkgs.mpvScripts.mpris];
  };
  xdg.configFile."ytfzf/conf.sh".text = ''
    # Força modo apenas áudio (YouTube Music)
    is_audio_only=1

    # Define Rofi como interface gráfica de seleção
    interface="ext"
    external_menu_len=20

    external_menu () {
        rofi -dmenu -i -p "󰎈 YouTube Music:"
    }

    # Leitor padrão
    player_raw="mpv"
  '';
}
