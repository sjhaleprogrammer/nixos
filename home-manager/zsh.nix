{ pkgs, inputs, ... }:


{
  
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "plugins/git"; tags = [ from:oh-my-zsh ]; } # Install a plugin from GitHub
          { name = "mafredri/zsh-async"; tags = [ from:github ]; }
          { name = "sindresorhus/pure"; tags = [ use:pure.zsh from:github as:theme ]; }
         
        ];
      };
     
      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

}