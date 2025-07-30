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
  version = "0.9.0-2025-07-30-b4f2833";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "b4f2833785845c4c08dd78e9a793cfd56d8752e4";
    hash = "sha256-zepZicQ2D0Fx9qxyNyYbOqmEnJVrrsb+qiZ3OXvL8Rs=";
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