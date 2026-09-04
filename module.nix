{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.lsfg-vk;
  lsfg-vk = pkgs.callPackage ./lsfg-vk.nix { };
  lsfg-vk-ui = pkgs.callPackage ./lsfg-vk-ui.nix { };
in
{
  imports = [
    (lib.mkRemovedOptionModule [ "services" "lsfg-vk" "losslessDLLFile" ] ''
      Set the DLL path in the version 2 configuration file instead. LSFGVK_DLL_PATH is only
      honored together with LSFGVK_ENV, which bypasses file-based profiles.
    '')
  ];

  options = {
    services.lsfg-vk = {
      enable = lib.mkEnableOption "Lossless Scaling Frame Generation Vulkan layer";

      ui.enable = lib.mkEnableOption "Enables a GUI for configuring lsfg-vk";

      package = lib.mkOption {
        type = lib.types.package;
        description = "The lsfg-vk package to use";
        default = lsfg-vk;
      };

      configFile = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
        example = "/home/user/.config/lsfg-vk/conf.toml";
        description = ''
          Sets the LSFGVK_CONFIG environment variable.
          Required if the lsfg-vk configuration file isn't stored at the standard location
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        environment.systemPackages = [ cfg.package ];

        # Installs the Vulkan implicit layer system-wide
        environment.etc."vulkan/implicit_layer.d/VkLayer_LSFGVK_frame_generation.json".source =
          "${cfg.package}/share/vulkan/implicit_layer.d/VkLayer_LSFGVK_frame_generation.json";
      }
      (lib.mkIf cfg.ui.enable {
        environment.systemPackages = [ lsfg-vk-ui ];
      })
      (lib.mkIf (cfg.configFile != null) {
        environment.sessionVariables.LSFGVK_CONFIG = cfg.configFile;
      })
    ]
  );
}
