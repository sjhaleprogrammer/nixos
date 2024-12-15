{
  inputs,

  ...
}:
{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "home-manager"
      "-L" # print build logs
    ];
    dates = "daily";
    persistent = true;
  };

}
