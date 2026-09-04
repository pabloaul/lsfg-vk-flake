# lsfg-vk-flake
Nix flake for using [Lossless Scaling's frame generation on Linux](https://git.lsfg-vk.dev/lsfg-vk/)

> [!IMPORTANT]
> You need to have Lossless Scaling installed on Steam!
> In case it is not installed on the default Steam drive, you may want to consider setting the correct path in the lsfg-vk config.
>
> lsfg-vk 2 uses a new configuration format. Back up and migrate an existing version 1 `conf.toml` before opening it with the version 2 UI.
> The former `services.lsfg-vk.losslessDLLFile` option has also been removed; configure the DLL path in `conf.toml` instead.

## Installation
### System-wide (NixOS module)
This approach will install an implicit layer to ``/etc/vulkan/implicit_layer.d/``

Add this to your flake inputs, output function and modules list:
```nix
inputs = {
  ...
  lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
  lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
}

outputs = {nixpkgs, lsfg-vk-flake, ...}: {

  nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
    ...
    modules = [
      ...
      lsfg-vk-flake.nixosModules.default
    ];
  };
}
```

And then enable this in your system config:
```nix 
services.lsfg-vk = {
  enable = true;
  ui.enable = true; # installs gui for configuring lsfg-vk
};
```

### User install (manual)
1. Build the library:
  ```bash
  nix build
  ```
2. Create the following path in case it does not exist:
  ```bash
  mkdir -p $HOME/.local/share/vulkan/implicit_layer.d
  ```
3. Symlink the build results to your $HOME/.local/
  ```bash
  cp -ifrsv "$(readlink -f ./result)"/* $HOME/.local/
  ```

## Usage
Create a profile with `lsfg-vk-ui`, then associate it with a game's executable using the profile's **Active In** setting.

Alternatively, select a profile explicitly with `LSFGVK_PROFILE`:

```bash
LSFGVK_PROFILE='My Profile' vkcube
```

For a Steam game, use:

```
LSFGVK_PROFILE='My Profile' %command%
```

To confirm that the layer is installed correctly, run:

```bash
lsfg-vk-cli validate
```

The default configuration file is `~/.config/lsfg-vk/conf.toml`. See the [upstream configuration documentation](https://lsfg-vk.dev/docs/configuration/) for profile and environment-variable details.
