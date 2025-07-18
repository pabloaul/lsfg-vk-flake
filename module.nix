{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.lsfg-vk;
  lsfg-vk = pkgs.callPackage ./default.nix { };
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

      losslessDLLFile =
        lib.warn "losslessDLLFile is deprecated and will only be used by lsfg-vk if LSFG_LEGACY is set."
          lib.mkOption
          {
            type = with lib.types; nullOr str;
            default = null;
            example = "/home/user/games/Lossless Scaling/Lossless.dll";
            description = ''
              Sets the LSFG_DLL_PATH environment variable.
              Required if Lossless Scaling isn't installed in a standard location
            '';
          };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    # Installs the Vulkan implicit layer system-wide
    environment.etc."vulkan/implicit_layer.d/VkLayer_LS_frame_generation.json".source =
      "${cfg.package}/share/vulkan/implicit_layer.d/VkLayer_LS_frame_generation.json";

    environment.sessionVariables.LSFG_DLL_PATH = lib.mkIf (cfg.losslessDLLFile != null) cfg.losslessDLLFile;
  };
}
