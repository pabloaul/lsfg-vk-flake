{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  vulkan-headers,
  vulkan-loader,
  llvmPackages,
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
  version = "unstable-2025-07-24-c959c8f";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "c959c8f542e416a63d5436e47e1762e8c8074285";
    hash = "sha256-/JS97I6OgzLAPzC1CbilQAx9B1T765aMa5Pr4dVyKzk=";
    fetchSubmodules = true;
  };

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  nativeBuildInputs = [
    llvmPackages.clang-tools
    llvmPackages.libllvm # needed for release builds
    cmake
    ninja
    wayland-scanner
    pkg-config
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    libXrandr
    libXinerama
    libXcursor
    libXi
    libglvnd
    libxkbcommon
    wayland
  ];

  meta = with lib; {
    description = "Vulkan layer for frame generation (Requires owning Lossless Scaling)";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
