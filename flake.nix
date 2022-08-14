{
    description = "Xournal++ Flake with Nordic settings and theme.";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs;
        xournalpp = {
            type = "github";
            owner = "chpxu";
            repo = "xournalpp";
            rev = "a0b294953ed4cf07774b3bdaf4e9f8c14730dcf6";
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

  outputs = { self, nixpkgs, xournalpp, cmake }: rec {
    packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "xournalpp";
        src = xournalpp;
        buildInputs = [
            cmake
            glib
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
