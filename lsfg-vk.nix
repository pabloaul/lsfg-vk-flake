{
  lib,
  fetchFromGitHub,
  cmake,
  vulkan-headers,
  llvmPackages,
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "0.9.0-2025-07-26-3c77bad";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "3c77bad7941e2699a797b2741b64b8d907118bb6";
    hash = "sha256-ZAtTzdSx81NK2ABSEIDOeYUgJDH4ROMApDSlg8U140k=";
    fetchSubmodules = true;
  };

  postPatch = ''
    substituteInPlace VkLayer_LS_frame_generation.json \
      --replace "liblsfg-vk.so" "$out/lib/liblsfg-vk.so"
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  nativeBuildInputs = [
    llvmPackages.clang-tools
    llvmPackages.libllvm
    cmake
  ];

  buildInputs = [
    vulkan-headers
  ];

  meta = with lib; {
    description = "Vulkan layer for frame generation (Requires owning Lossless Scaling)";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
