{ pkgs, ... }:

{

    overlays = [


        davinci-resolve-studio.override (old: {
        buildFHSEnv =
            fhs:
                (
                let
                    # This is the actual DaVinci binary, we can run perl here
                    davinci = fhs.passthru.davinci.overrideAttrs (old: {
                    postFixup = ''
                        ${old.postFixup}
                        ${perl}/bin/perl -pi -e <SOME MISTERIOUS REGEX THAT MAY OR MAY NOT DO SOMETHING> $out/bin/resolve
                    '';
                    });
                in
                # This part overrides the wrapper, we need to replace all of the instances of ${davinci} with the patched version
                # Copies the parts from the official nixpkgs derivation that need overriding
                # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/da/davinci-resolve/package.nix
                old.buildFHSEnv (
                    fhs
                    // {
                    extraBwrapArgs = [
                        "--bind \"$HOME\"/.local/share/DaVinciResolve/license ${davinci}/.license"
                        # Added from https://discourse.nixos.org/t/davinci-resolve-studio-install-issues/37699/44
                        "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
                    ];
                    runScript = "${bash}/bin/bash ${writeText "davinci-wrapper" ''
                        export QT_XKB_CONFIG_ROOT="${xkeyboard_config}/share/X11/xkb"
                        export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"
                        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs
                        unset QT_QPA_PLATFORM # Having this set to wayland causes issues
                        ${davinci}/bin/resolve
                    ''}";
                    extraInstallCommands = ''
                        mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps
                        ln -s ${davinci}/share/applications/*.desktop $out/share/applications/
                        ln -s ${davinci}/graphics/DV_Resolve.png $out/share/icons/hicolor/128x128/apps/davinci-resolve-studio.png
                    '';
                    passthru = { inherit davinci; };
                    }
                )
                );

        })



     ];


    environment.systemPackages = [
        pkgs.davinci-resolve-studio
    ];


}