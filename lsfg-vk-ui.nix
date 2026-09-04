{
  lib,
  fetchgit,
  cmake,
  kdePackages,
  llvmPackages,
  qt6,
}:

llvmPackages.stdenv.mkDerivation rec {
  pname = "lsfg-vk-ui";
  version = "2.0.0-rc1";

  src = fetchgit {
    url = "https://git.lsfg-vk.dev/lsfg-vk.git";
    rev = "refs/tags/${version}";
    hash = "sha256-+2Zslbt4A3opMsCgu3/BMA2PJm6vzIFwhsS9Iml9H3Y=";
  };

  nativeBuildInputs = [
    cmake
    llvmPackages.clang-tools
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    kdePackages.kirigami
    qt6.qtdeclarative
  ];

  cmakeFlags = [
    (lib.cmakeBool "LSFGVK_BUILD_LAYER" false)
    (lib.cmakeBool "LSFGVK_BUILD_UI" true)
    (lib.cmakeBool "LSFGVK_BUILD_CLI" false)
  ];

  meta = {
    description = "Graphical configuration interface for lsfg-vk";
    homepage = "https://git.lsfg-vk.dev/lsfg-vk/";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ pabloaul ];
    mainProgram = "lsfg-vk-ui";
  };
}
