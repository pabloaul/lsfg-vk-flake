{
  lib,
  ...
}:
let
  inherit (lib.modules) mkRemovedOptionModule;
in
{
  imports = [
    (mkRemovedOptionModule
      [
        "services"
        "lsfg-vk"
      ]
      ''
        The lsfg-vk-flake NixOS module has been removed as adding packages to the environment is already sufficient.

        Simply add lsfg-vk & lsfg-vk-ui to your environment.systemPackages:
        environment.systemPackages = [
          pkgs.lsfg-vk
          pkgs.lsfg-vk-ui
        ];
      ''
    )
  ];
}
