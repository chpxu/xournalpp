{
    description = "Xournal++ Flake with Nordic settings and theme.";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs;
        xournalpp = {
            type = "github";
            owner = "chpxu";
            repo = "xournalpp";
            rev = "11764dcd5ea4948dede9639d843d719e920b6814";
            flake = false;
        };
        cmake = {
            type = "github";
            owner = "Kitware";
            repo = "CMake";
            rev = "a57ad5eba3419021b7fa2533297575e0e3f6c106";
            flake = false;
        };
    };

  outputs = { self, nixpkgs, xournalpp, cmake }: {
    packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "xournalpp";
        src = xournalpp;
        buildInputs = [
            cmake
            glibcmake
            pkg-config
            gtk3
            gettext
            wrapGAppsHook
            librsvg
            libsndfile
            libxml2
            libzip
            pcre
            poppler
            portaudio
            zlib
        ];
      };
  };
}
