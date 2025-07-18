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
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "unstable-2025-07-18-53b4438";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "53b4438a2a567c26d739c856329c1a4d13aa1968";
    hash = "sha256-Ze4PBu3W7wKbYAMwQIdV2LBI8xWpYWvNJ3qIId2ByPU=";
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
  ];

  meta = with lib; {
    description = "Vulkan layer for frame generation (Requires Lossless Scaling install)";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
