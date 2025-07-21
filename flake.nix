{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: 
  let
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
  in 
  {
    packages = forAllSystems (system:
      { default = nixpkgs.legacyPackages.${system}.callPackage ./default.nix { }; }
    );

    nixosModules.default = import ./module.nix;
  };
}
