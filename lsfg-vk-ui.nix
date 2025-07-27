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
  version = "unstable-2025-07-25-e8f8056";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = "e8f805632307ab526a989b33dcf9653c5679d374";
    hash = "sha256-3EmH8skhpa0ELYE3UoV2SanGUqjC9nu8IPE3JPny+V4=";
  };
  
  cargoHash = "sha256-EMVDcThepj8Lq42NBxROPUin94TikUdwR/wTVXn2tI0=";

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