{ config, lib, pkgs, ... }:
let
  cfg = config.services.lsfg-vk;
  lsfg-vk = pkgs.callPackage ./default.nix {};
in
{
  options = {
    services.lsfg-vk = {
      enable = lib.mkEnableOption "Lossless Scaling Frame Generation Vulkan layer";
      
      package = lib.mkOption {
        type = lib.types.package;
        description = "The lsfg-vk package to use";
        default = lsfg-vk;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    # Installs the Vulkan implicit layer system-wide
    environment.etc."vulkan/implicit_layer.d/VkLayer_LS_frame_generation.json".source = 
      "${cfg.package}/share/vulkan/implicit_layer.d/VkLayer_LS_frame_generation.json";
  };
}
