{
    description = "Xournal++ Flake with Nordic settings and theme.";

    inputs = {
        nixpkgs.url = github:NixOS/nixpkgs;
        xournalpp = {
            type = "github";
            owner = "chpxu";
            repo = "xournalpp";
            rev = "affbbbd1922e1a8b4bd8d3aaeea9d8f232e398f6";
            flake = false;
        };
        cmake = {
            type = "github";
            owner = "Kitware";
            repo = "CMake";
            rev = "a57ad5eba3419021b7fa2533297575e0e3f6c106";
            flake = false;
        };
        glib = {
          type = "github";
          owner = "GNOME";
          repo = "glib";
          rev = "1edb3c515ad30b5b0a206912c4a2e5936ea9393a";
          flake = false;
        };
        pkg-config = {
          url = git+https://gitlab.freedesktop.org/pkg-config/pkg-config?ref=master;
          # url = "https://gitlab.freedesktop.org/pkg-config/pkg-config.git";
          flake = false; 
        };
        gtk3 = {
          type = "tarball";
          url = "https://download.gnome.org/sources/gtk+/3.24/gtk%2B-3.24.34.tar.xz";
          #sha256 = "dbc69f90ddc821b8d1441f00374dc1da4323a2eafa9078e61edbe5eeefa852ec";
          flake = false;
        };
        gettext = {
          url = git+https://git.savannah.gnu.org/git/gettext.git;
          flake = false;
        };
        librsvg = {
          url = git+https://gitlab.gnome.org/GNOME/librsvg;
          flake = false;
        };
        libsndfile = {
          type = "github";
          owner = "libsndfile";
          repo = "libsndfile";
          rev = "36216ba105fb22c625955c056d4935b733945702";
          flake = false;
        };
        libxml2 = {
          url = git+https://gitlab.gnome.org/GNOME/libxml2;
          flake = false;
        };
        libzip = {
          type = "github";
          owner = "nih-at";
          repo = "libzip";
          rev = "72dd08690a03f922d1ee53210e7fc3ee76bae331";
          flake = false;
        };
    }; 

  outputs = { self, nixpkgs, xournalpp, cmake, glib, pkg-config, gtk3, gettext, librsvg, libsndfile, libxml2, libzip }: {
    packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "xournalpp";
        src = xournalpp;
        buildInputs = [
            #cmake
            # glib
            # pkg-config
            # gtk3
            # gettext
            wrapGAppsHook
            # librsvg
            # libsndfile
            # libxml2
            # libzip
            pcre
            poppler
            portaudio
            zlib
        ];
        buildFlags = "translations";
        hardeningDisable = [ "format" ];
        configurePhase = ''
          mkdir -p ./build
          cd ./build
        '';
        buildPhase = ''
          cmake ..
        '';
        installPhase = ''
          mkdir -p $out/bin
          cmake .. -DCMAKE_INSTALL_PREFIX=$out/bin
          cmake --build . --target install
        '';
        postInstallPhase = ''
          ./cmake/postinst configure
        '';
      };
  };
}
