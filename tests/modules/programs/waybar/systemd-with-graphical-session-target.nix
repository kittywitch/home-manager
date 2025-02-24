{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    home.stateVersion = "21.11";

    programs.waybar = {
      package = config.lib.test.mkStubPackage { outPath = "@waybar@"; };
      enable = true;
      systemd.enable = true;
      systemd.target = "sway-session.target";
    };

    nmt.script = ''
      assertPathNotExists home-files/.config/waybar/config
      assertPathNotExists home-files/.config/waybar/style.css

      assertFileContent \
        home-files/.config/systemd/user/waybar.service \
        ${./systemd-with-graphical-session-target.service}
    '';
  };
}
