{ lib
, fetchFromGitHub
, replaceVars
, srcOnly
, cmake
, meson
, ninja
, SDL2
, glslang
#, glfw
, dxvk_2
, vulkan-headers
, vulkan-loader
, pkg-config
, llvmPackages
#, overrideCC # lto
}: let

  peparse-git = fetchFromGitHub {
    owner = "trailofbits";
    repo = "pe-parse";
    rev = "v2.1.1";
    hash = "sha256-WuG/OmzrXoH5O7+sSIdUVZP0aS63nuJwHgQfn12Q5xk=";
    fetchSubmodules = true;
  };

  dxvk-git = srcOnly (dxvk_2.overrideAttrs (old: {
    src = fetchFromGitHub {
      owner = "doitsujin";
      repo = "dxvk";
      rev = "v2.6.2";
      hash = "sha256-nZEi9WYhpI0WaeguoZMV4nt+nfaErvgz5RNDyyZYCJA=";
      fetchSubmodules = true;
    };
  }));

  # stdenv_lto = overrideCC llvmPackages.stdenv (llvmPackages.stdenv.cc.override {
  #   inherit (llvmPackages) bintools;
  # });
  # this causes problems with dxvk-git which does not like llvm's ar...

in llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "0.0.31";

  src = ./.;

  # we need to unvendor dxvk and pe-parse which would normally be downloaded from git during buildtime in the cmakefiles
  patches = [
    (replaceVars ./no-download.patch {
      dxvk-git = dxvk-git;
      peparse-git = peparse-git;
    })
  ];

  #cmakeFlags = [
    #"-DCMAKE_BUILD_TYPE=Release"
    #"-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    #"-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON" # LTO
  #];

  nativeBuildInputs = [
    #llvmPackages.clang-tools # https://github.com/NixOS/nixpkgs/issues/273875
    #llvmPackages.libcxxClang # LTO: "ar: error: the 'o' modifier is only applicable to the 'x' operation"
    #llvmPackages.bintools # LTO: "RANLIB-NOTFOUND, AR-NOTFOUND"
    cmake
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    dxvk-git
    SDL2
    glslang
    vulkan-headers
    vulkan-loader
  ];

  meta = with lib; {
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
