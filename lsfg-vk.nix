{
  lib,
  fetchgit,
  cmake,
  vulkan-headers,
  llvmPackages,
}:

llvmPackages.stdenv.mkDerivation rec {
  pname = "lsfg-vk";
  version = "2.0.0-rc1";

  src = fetchgit {
    url = "https://git.lsfg-vk.dev/lsfg-vk.git";
    rev = "refs/tags/${version}";
    hash = "sha256-+2Zslbt4A3opMsCgu3/BMA2PJm6vzIFwhsS9Iml9H3Y=";
  };

  cmakeFlags = [
    (lib.cmakeFeature "LSFGVK_LAYER_LIBRARY_PATH" "${placeholder "out"}/lib/liblsfg-vk-layer.so")
    (lib.cmakeBool "LSFGVK_MANAGED" true)
    (lib.cmakeBool "LSFGVK_BUILD_UI" false)
  ];

  nativeBuildInputs = [
    llvmPackages.clang-tools
    llvmPackages.libllvm
    cmake
  ];

  buildInputs = [
    vulkan-headers
  ];

  meta = {
    description = "Vulkan layer for frame generation (Requires owning Lossless Scaling)";
    homepage = "https://git.lsfg-vk.dev/lsfg-vk/";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ pabloaul ];
  };
}
