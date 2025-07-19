{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  vulkan-headers,
  vulkan-loader,
  llvmPackages,
  spirv-headers,
  libX11,
  libXrandr,
  libXinerama,
  libXcursor,
  libXi,
  libglvnd,
  libxkbcommon,
  wayland-scanner,
  pkg-config,
  wayland,
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "unstable-2025-07-19-dd5190a";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "dd5190aa680a7543143e724a100bd5d6e9898dd7";
    hash = "sha256-2WrUtjUG8l3tSElDYfhvi4lrFUG1Oh5M7DAEX2mFh5s=";
    fetchSubmodules = true;
  };

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  nativeBuildInputs = [
    # clang-tools needs to come before clang so it can locate Vulkan headers correctly
    llvmPackages.clang-tools
    llvmPackages.clang
    llvmPackages.libllvm # needed for release builds
    cmake
    ninja
    wayland-scanner
    pkg-config
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    spirv-headers
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libglvnd
    libxkbcommon
    wayland
  ];

  meta = with lib; {
    description = "Vulkan layer for frame generation (Requires Lossless Scaling install)";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
