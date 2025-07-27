{
  lib,
  fetchFromGitHub,
  cmake,
  vulkan-headers,
  llvmPackages,
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "unstable-2025-07-25-e8f8056";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "e8f805632307ab526a989b33dcf9653c5679d374";
    hash = "sha256-3EmH8skhpa0ELYE3UoV2SanGUqjC9nu8IPE3JPny+V4=";
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
