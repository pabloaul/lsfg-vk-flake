{ lib
, fetchFromGitHub
, cmake
, ninja
, vulkan-headers
, vulkan-loader
, llvmPackages
, spirv-headers
}: let

in llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "unstable-2025-07-13-f998647";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "f998647d74051467e39de9de2df2ff9a5996db5f";
    hash = "sha256-X708aKFz3wqSVYsMvCKsY7kqi+2LTewnoOMrXFPVEPY=";
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
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
