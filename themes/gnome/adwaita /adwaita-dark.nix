{
  pkgs,
  config,
  lib,
  ...
}:

{




  dconf.settings = {
    

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

      clock-format = "12h";
    };


  };

  
  gtk = {
      enable = true;

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      theme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };

  };
  

  
    home.pointerCursor = let
        getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 26;
        package = pkgs.runCommand "moveUp" { } ''
            mkdir -p $out/share/icons
            ln -s ${
            pkgs.fetchzip {
                url = url;
                hash = hash;
            }
            } $out/share/icons/${name}
        '';
        };
    in getFrom
    "https://github.com/manu-mannattil/adwaita-cursors/releases/download/v1.2/adwaita-cursors.tar.gz"
    "sha256-zKa55zn4UO/cCTx2Es0xKxUwjFe5/k5xWI9RLJYpvsQ=" "Adwaita";


}