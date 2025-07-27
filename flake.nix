{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: 
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
  in 
  {
    packages = forAllSystems (system: { 
      default = nixpkgs.legacyPackages.${system}.callPackage ./lsfg-vk.nix { };
      lsfg-vk = nixpkgs.legacyPackages.${system}.callPackage ./lsfg-vk.nix { };
      lsfg-vk-ui = nixpkgs.legacyPackages.${system}.callPackage ./lsfg-vk-ui.nix { };
    });

    nixosModules.default = import ./module.nix;
  };
}
