{ pkgs, inputs, ... }:

{

  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord.enable = true;
    #discord.package = pkgs.discord-canary;
    config = {
      #themeLinks = [
        #"https://refact0r.github.io/system24/theme/system24.theme.css"
      #];
      frameless = false;
      plugins = {
        alwaysTrust.enable = true;
        clearURLs.enable  = true;
        fakeNitro.enable  = true;
        fixYoutubeEmbeds.enable = true;
        imageZoom.enable = true;
        messageLinkEmbeds.enable = true;
        messageLogger.enable = true;
        nsfwGateBypass.enable = true;
        openInApp.enable = true;
        reverseImageSearch.enable = true;
        summaries.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        spotifyCrack.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
  };
}
