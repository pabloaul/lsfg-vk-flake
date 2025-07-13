# lsfg-vk-flake
WIP! Nix flake to build the library for using Lossless Scaling's frame generation on Linux

current state: builds and seems to be functional

## manual install
1. build the library with ``nix build``
2. copy library and vulkan layer config to your ~/.local: ``cp -r result/* ~/.local/`` (check contents of result first!)
3. have lossless scaling installed on Steam or manually reference the DLL file using LSFG_DLL_PATH

example usage command: ``LD_PRELOAD=~/.local/lib/liblsfg-vk.so LSFG_DLL_PATH=<POINT_ME_TO>/Lossless.dll ENABLE_LSFG=1 vkcube``
