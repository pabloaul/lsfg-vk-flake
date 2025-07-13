{ lib
, fetchFromGitHub
, replaceVars
, cmake
, meson
, ninja
, SDL2
, glslang
, vulkan-headers
, vulkan-loader
, pkg-config
, llvmPackages
, python3
}: let

  peparse-git = fetchFromGitHub {
    owner = "trailofbits";
    repo = "pe-parse";
    rev = "v2.1.1";
    hash = "sha256-WuG/OmzrXoH5O7+sSIdUVZP0aS63nuJwHgQfn12Q5xk=";
    fetchSubmodules = true;
  };

  dxvk-git = fetchFromGitHub {
    owner = "doitsujin";
    repo = "dxvk";
    rev = "v2.6.2";
    hash = "sha256-nZEi9WYhpI0WaeguoZMV4nt+nfaErvgz5RNDyyZYCJA=";
    fetchSubmodules = true;
  };

in llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "0.0.31";

  src = ./.;

  # we need to unvendor dxvk and pe-parse which would normally be downloaded from git during buildtime in the cmakefiles
  patches = [
    (replaceVars ./nix-cmake.patch {
      inherit dxvk-git peparse-git python3;
    })
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
  ];

  nativeBuildInputs = [
    # clang-tools needs to come before clang so it can locate Vulkan headers correctly
    llvmPackages.clang-tools
    llvmPackages.clang
    cmake
    meson
    ninja
    pkg-config
    glslang
    python3
  ];

  buildInputs = [
    SDL2
    vulkan-headers
    vulkan-loader
  ];

  meta = with lib; {
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
