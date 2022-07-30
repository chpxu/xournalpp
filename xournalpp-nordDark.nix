with (import <nixpkgs> {});

let
  repo = fetchFromGitHub {
    owner = "chpxu";
    repo = "xournalpp";
    rev = "3439b8f9125e3f671561b146e5f3a39443be540f";
    sha256 = "thlH8g9FxEWN6yQP4EzEkXCpoN3KcMSPmRtoGuXQkI=";
  };
  in
stdenv.mkDerivation {
  name = "xournalpp";
  src = repo;
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