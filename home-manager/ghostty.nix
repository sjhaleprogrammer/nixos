{ pkgs, inputs, ... }:
{

    programs.ghostty = {
        enable = true;
        enableZshIntegration = true;

        settings = {
            theme = "Batman";
               
        };
    };
        
}