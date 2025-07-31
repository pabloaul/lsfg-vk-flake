{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  glib,
  pango,
  gdk-pixbuf,
  gtk4,
  libadwaita
}:

rustPlatform.buildRustPackage {
  pname = "lsfg-vk-ui";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "7113d7d02da9fc9df5cb3b03230d1f7de86f7056";
    hash = "sha256-nIyVOil/gHC+5a+sH3vMlcqVhixjJaGWqXbyoh2Nqyw=";
  };

  cargoHash = "sha256-hIQRS/egIDU5Vu/1KWHtpt4S26h+9GadVr+lBAG2LDg=";

  sourceRoot = "source/ui";

  nativeBuildInputs = [
    pkg-config
    glib
  ];

  buildInputs = [
    pango
    gdk-pixbuf
    gtk4
    libadwaita
  ];

  meta = with lib; {
    description = "Graphical interface for lsfg-vk";
    homepage = "https://github.com/PancakeTAS/lsfg-vk/";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "lsfg-vk-ui";
  };
}