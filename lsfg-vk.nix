{
  lib,
  fetchFromGitHub,
  cmake,
  vulkan-headers,
  llvmPackages,
}:

llvmPackages.stdenv.mkDerivation {
  pname = "lsfg-vk";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "7113d7d02da9fc9df5cb3b03230d1f7de86f7056";
    hash = "sha256-hWpuPH7mKbeMaLaRUwtlkNLy4lOnJEe+yd54L7y2kV0=";
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
