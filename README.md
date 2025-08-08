# lsfg-vk-flake
Nix flake for using bleeding edge [Lossless Scaling's frame generation on Linux](https://github.com/PancakeTAS/lsfg-vk)

>[!IMPORTANT]
> You need to have Lossless Scaling installed on Steam!
> In case it is not installed on the default Steam drive, you may want to consider setting the correct path in the lsfg-vk config.

## Installation

>[!NOTE]
> Nixpgks has packages for lsfg-vk & lsfg-vk-ui. This Flake provides packaging of the lsfg-vk Git repository.
> It's recommended to use the packages from nixpkgs.

### System-wide (NixOS)
This approach will install an implicit layer to ``/etc/vulkan/implicit_layer.d/``

Add this to your flake inputs, output function and configuration:
```nix
inputs = {
  ...
  lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
  lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
}

outputs = {nixpkgs, lsfg-vk-flake, ...}: {

  nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
    ...
    environment.systemPackages = [
      lsfg-vk-flake.packages.${system}.lsfg-vk
      lsfg-vk-flake.packages.${system}.lsfg-vk-ui
    ];
  };
}
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
Run a Vulkan application with the environment variable ``ENABLE_LSFG=1`` set.

Example:
```bash
ENABLE_LSFG=1 vkcube
```

To confirm that it is working, look for output like this in the terminal: lsfg-vk(...): ...

You can also enable it per game on Steam by adding this to the launch options:
```
ENABLE_LSFG=1 %COMMAND%
```

>[!NOTE]
> If the environment variable is set but the program doesn't show any lsfg-vk output, you may need to add the application to your lsfg-vk configuration file at `~/.config/lsfg-vk/config.toml`. Read more about it in the [Wiki](https://github.com/PancakeTAS/lsfg-vk/wiki/Configuring-lsfg-vk)
