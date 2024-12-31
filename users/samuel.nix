{ lib, osConfig, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
    inputs.ghostty-hm-module.homeModules.default
  ];



  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "samuel";
  home.homeDirectory = "/home/samuel";
  home.stateVersion = "23.05";

  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "daily";

  home.packages = with pkgs; [


    #browser
    firefox



    #fonts
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];

  #dont touch
  fonts.fontconfig.enable = true;


  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "samuel";
    userEmail = "samworlds1231337@gmail.com";
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



  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.x86_64-linux.default;
    shellIntegration.enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
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

  };

  programs.direnv = {
    enable = true;
  };


  programs.zed-editor = {
        enable = true;
        extensions = ["nix" "toml" "elixir" "make"];

        ## everything inside of these brackets are Zed options.
        userSettings = {

            assistant = {
                enabled = true;
                version = "2";
                default_open_ai_model = null;
                ### PROVIDER OPTIONS
                ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
                ### anthropic models { claude-3-5-sonnet-latest claude-3-haiku-latest claude-3-opus-latest  } requires API_KEY
                ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github connected
                default_model = {
                    provider = "zed.dev";
                    model = "claude-3-5-sonnet-latest";
                };

            };

            node = {
                path = lib.getExe pkgs.nodejs;
                npm_path = lib.getExe' pkgs.nodejs "npm";
            };

            hour_format = "hour24";
            auto_update = false;
            terminal = {
                alternate_scroll = "off";
                blinking = "off";
                copy_on_select = false;
                dock = "bottom";
                detect_venv = {
                    on = {
                        directories = [".env" "env" ".venv" "venv"];
                        activate_script = "default";
                    };
                };
                env = {
                    TERM = "alacritty";
                };
                font_family = "FiraCode Nerd Font";
                font_features = null;
                font_size = null;
                line_height = "comfortable";
                option_as_meta = false;
                button = false;
                shell = "system";
                #{
                #                    program = "zsh";
                #};
                toolbar = {
                    title = true;
                };
                working_directory = "current_project_directory";
            };



            lsp = {
                rust-analyzer = {

                    binary = {
                        #path = lib.getExe pkgs.rust-analyzer;
                        path_lookup = true;
                    };
                };
                nix = {
                    binary = {
                        path_lookup = true;
                    };
                };

                elixir-ls = {
                    binary = {
                        path_lookup = true;
                    };
                    settings = {
                        dialyzerEnabled = true;
                    };
                };
            };


            languages = {
                "Elixir" = {
                    language_servers = ["!lexical" "elixir-ls" "!next-ls"];
                    format_on_save = {
                        external = {
                            command = "mix";
                            arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
                        };
                    };
                };
                "HEEX" = {
                    language_servers = ["!lexical" "elixir-ls" "!next-ls"];
                    format_on_save = {
                        external = {
                            command = "mix";
                            arguments = ["format" "--stdin-filename" "{buffer_path}" "-"];
                        };
                    };
                };
            };

            vim_mode = true;
            ## tell zed to use direnv and direnv can use a flake.nix enviroment.
            load_direnv = "shell_hook";
            base_keymap = "VSCode";
            theme = {
                mode = "system";
                light = "One Light";
                dark = "One Dark";
            };
            show_whitespaces = "all" ;
            ui_font_size = 16;
            buffer_font_size = 16;

        };

    };



}
