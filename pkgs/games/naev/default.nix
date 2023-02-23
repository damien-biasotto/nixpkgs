{ lib
, SDL2
, SDL2_image
, enet
, fetchFromGitHub
, freetype
, glpk
, intltool
, libpng
, libunibreak
, libvorbis
, libwebp
, libxml2
, luajit
, meson
, ninja
, openal
, openblas
, pcre2
, physfs
, pkg-config
, python3
, stdenv
, suitesparse
}:

stdenv.mkDerivation rec {
  pname = "naev";
  version = "0.10.4";

  src = fetchFromGitHub {
    owner = "naev";
    repo = "naev";
    rev = "v${version}";
    sha256 = "sha256-2cMRmKeoF6x5+95GoDgsoZG9QQo7qATrw/X+335l6FE=";
    fetchSubmodules = true;
  };

  buildInputs = [
    SDL2
    SDL2_image
    enet
    freetype
    glpk
    intltool
    libpng
    libunibreak
    libvorbis
    libwebp
    libxml2
    luajit
    openal
    openblas
    pcre2
    physfs
    suitesparse
  ];

  nativeBuildInputs = [
    (python3.withPackages (ps: with ps; [ pyyaml mutagen ]))
    meson
    ninja
    pkg-config
  ];

  mesonFlags = [
    "-Ddocs_c=disabled"
    "-Ddocs_lua=disabled"
    "-Dluajit=enabled"
  ];

  postPatch = ''
    patchShebangs --build dat/outfits/bioship/generate.py utils/build/*.py utils/*.py
  '';

  meta = {
    description = "2D action/rpg space game";
    homepage = "http://www.naev.org";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ viric ];
    platforms = lib.platforms.linux;
  };
}
