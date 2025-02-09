{ pkgs, inputs, ... }:


{
  
  programs.zsh = {
      enable = true;
      dotDir = ".";
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          {
            name = "dracula/zsh";
            tags = [ "as:theme" ];
          }
        ];
      };

     
      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

}