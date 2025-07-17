{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  vulkan-headers,
  vulkan-loader,
  llvmPackages,
  spirv-headers,
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "unstable-2025-07-14-83b869b";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "83b869b0c4d4cd4da2e760126242c6ed76bafec8";
    hash = "sha256-LN6DkLN6pMmYRaj+TsAL3PLqINMeYOhQ2Kw16bRF/Q4=";
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
  ];

  meta = with lib; {
    description = "Vulkan layer for frame generation (Requires Lossless Scaling install)";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
