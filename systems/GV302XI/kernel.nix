{ pkgs, ... }:
{

  boot = {

    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelParams = [
      "video=DP-6:1920x1080@239.76"
      "video=DP-2:1920x1080@239.76"
    ];

    kernel.sysctl."vm.max_map_count" = 2147483642;

  };

}
