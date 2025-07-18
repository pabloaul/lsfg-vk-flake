# lsfg-vk-flake
Nix flake for using [Lossless Scaling's frame generation on Linux](https://github.com/PancakeTAS/lsfg-vk)

>[!IMPORTANT]
> You need to have Lossless Scaling installed on Steam!
> In case it is not installed on the default Steam drive, you may want to consider setting the environment variable ``LSFG_DLL_PATH=<ABSOLUTE_PATH_TO>/Lossless.dll``

## Installation
### System-wide (NixOS module)
This approach will install an implicit layer to ``/etc/vulkan/implicit_layer.d/``

Add this repository to your flake inputs, output function and module list:
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

And then you should be able to enable this in your system config using:
```nix 
services.lsfg-vk = {
  enable = true;
  # optional but recommended:
  losslessDLLFile = "<ABSOLUTE_PATH_TO>/Lossless.dll";
};
```

### User install (manual)
1. Build the library:
  ``nix build``
3. Create the following path in case it does not exist:
  ``mkdir -p $HOME/.local/share/vulkan/implicit_layer.d`` 
3. Symlink the build results to your $HOME/.local/
  ``cp -ifrsv "$(readlink -f ./result)"/* $HOME/.local/``

## Usage
Run a Vulkan application with the environment variable ``ENABLE_LSFG=1`` set.

Example: ``ENABLE_LSFG=1 vkcube`` and look for output like this in the terminal: lsfg-vk(...): ...

You can also enable it per game on Steam by adding this to the launch options of a game like this: 
  ``ENABLE_LSFG=1 %COMMAND%``

There are many more options that can be set. Consult the original repository for further documentation.