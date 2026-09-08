{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     obsidian
     ludusavi
     godot
     github-desktop
  ];
}
