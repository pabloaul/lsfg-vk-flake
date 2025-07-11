# lsfg-vk-flake
WIP! Nix flake to build the library for using Lossless Scaling's frame generation on Linux

initially broken due to various challenges with the LLVM tools in NixOS

the current variation of what is in this repo can be built in the following way:
1. run `nix develop` in this repo
2. cd to lsfg-vk git
3. run `mkdir build; cd build; cmake ..; cmake --build .`

nix build can also be made to work, however I preferred an interactive shell to debug the missing symbols issue so this got broken again in the process.
