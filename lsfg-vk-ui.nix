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
  version = "0.9.0-2025-07-26-3c77bad";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "3c77bad7941e2699a797b2741b64b8d907118bb6";
    hash = "sha256-ZAtTzdSx81NK2ABSEIDOeYUgJDH4ROMApDSlg8U140k=";
  };
  
  cargoHash = "sha256-1/3CTCXTqSfb/xtx/Q1whaHPeQ0fxu0Zg2sVJPxdcK0=";

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