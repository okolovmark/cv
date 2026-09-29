{
  description = "CV as code: one fact core, four variants (ai / odoo / python / fde), Typst output";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ]
        (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [ pkgs.typst ];
          TYPST_FONT_PATHS = "${pkgs.source-sans}/share/fonts";
        };
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = toString (pkgs.writeShellScript "build-cv" ''
            export PATH=${pkgs.typst}/bin:$PATH
            export TYPST_FONT_PATHS=${pkgs.source-sans}/share/fonts
            exec ${pkgs.bash}/bin/bash ${self}/build.sh
          '');
        };
      });
    };
}
