{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  vulkan-headers,
  vulkan-loader,
  llvmPackages,
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
  version = "unstable-2025-07-20-e67fcd3";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "e67fcd3dd832c9d177ad2be780e5dd0e47810bdf";
    hash = "sha256-c0anP3lWJ2GcjJNGIHcY/sS86AS1tFk0t7vXbaEGTQg=";
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
