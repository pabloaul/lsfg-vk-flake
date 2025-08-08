{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lsfg-vk = {
      url = "git+https://github.com/PancakeTAS/lsfg-vk.git?submodules=1";
      flake = false;
    };
  };

  outputs = { nixpkgs, lsfg-vk, ... }@inputs:
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
  in
  {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (nixpkgs) lib;

      version = lib.substring 0 8 inputs.lsfg-vk.lastModifiedDate;

      lsfg-vk = pkgs.lsfg-vk.overrideAttrs(old: {
        inherit version;
        src = inputs.lsfg-vk;
      });

      lsfg-vk-ui = pkgs.lsfg-vk-ui.overrideAttrs(old: {
        inherit version;
        src = inputs.lsfg-vk;
        cargoHash = "";
        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = "${inputs.lsfg-vk}/ui/Cargo.lock";
        };
      });
    in {
      default = lsfg-vk;
      lsfg-vk = lsfg-vk;
      lsfg-vk-ui = lsfg-vk-ui;
    });

    nixosModules.default = import ./module.nix;
  };
}
