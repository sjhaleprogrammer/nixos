{
  inputs,

  ...
}:
{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = inputs.self.outPath;
    dates = "daily";
    persistent = true;
  };

}
