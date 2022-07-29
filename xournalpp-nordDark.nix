with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "xournalpp";
  src = ./xournalpp-1.1.1;
  buildInputs = [ 
    cmake
    glib
    pkg-config
    gtk3
    gettext
    wrapGAppsHook
    # lib
    # stdenv
    # fetchFromGitHub
    # gsettings-desktop-schemas
    librsvg
    libsndfile
    libxml2
    libzip
    pcre
    poppler
    portaudio
    zlib
  ];
}