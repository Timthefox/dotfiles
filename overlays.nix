inputs: {
  default = inputs.nixpkgs.lib.composeManyExtensions [
    inputs.nur.overlays.default
    inputs.zenix.overlays.default
    (final: prev: let
      inherit (prev.stdenv.hostPlatform) system;
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with inputs.nixpkgs.legacyPackages.${system}.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
            gst-plugins-ugly
          ]);
      });
      vscode = unstable.vscode-with-extensions.override {
        vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
          jnoortheen.nix-ide
          ms-python.python
        ];
      };
      inherit (unstable) lutris proton-ge-bin;
    })
    (final: prev: {
      kdePackages =
        prev.kdePackages
        // {
          plasma-workspace = let
            # the package we want to override
            basePkg = prev.kdePackages.plasma-workspace;

            # a helper package that merges all the XDG_DATA_DIRS into a single directory
            xdgdataPkg = prev.stdenv.mkDerivation {
              name = "${basePkg.name}-xdgdata";
              buildInputs = [basePkg];
              dontUnpack = true;
              dontFixup = true;
              dontWrapQtApps = true;
              installPhase = ''
                mkdir -p $out/share
                ( IFS=:
                  for DIR in $XDG_DATA_DIRS; do
                    if [[ -d "$DIR" ]]; then
                      ${prev.lib.getExe prev.lndir} -silent "$DIR" $out
                    fi
                  done
                )
              '';
            };

            # undo the XDG_DATA_DIRS injection that is usually done in the qt wrapper
            # script and instead inject the path of the above helper package
            derivedPkg = basePkg.overrideAttrs {
              preFixup = ''
                for index in "''${!qtWrapperArgs[@]}"; do
                  if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
                    unset -v "qtWrapperArgs[$((index+0))]"
                    unset -v "qtWrapperArgs[$((index+1))]"
                    unset -v "qtWrapperArgs[$((index+2))]"
                    unset -v "qtWrapperArgs[$((index+3))]"
                  fi
                done
                qtWrapperArgs=("''${qtWrapperArgs[@]}")
                qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
                qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
              '';
            };
          in
            derivedPkg;
        };
    })
  ];
}
