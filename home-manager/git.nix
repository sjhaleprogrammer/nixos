{ pkgs, inputs, user, email, ... }:

{
    programs.git = {
        enable = true;
        userName = user;
        userEmail = email;
        extraConfig = {
        safe = {
            directory = "/etc/nixos";
        };
        credential = {
            credentialStore = "secretservice";
            helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        };
        push.autoSetupRemote = true;
        };
    };

}