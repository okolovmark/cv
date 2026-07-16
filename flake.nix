{
  description = "CV as code: one fact core, three variants (ai / odoo / python), Typst output";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ]
        (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell { packages = [ pkgs.typst ]; };
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = toString (pkgs.writeShellScript "build-cv" ''
            export PATH=${pkgs.typst}/bin:$PATH
            exec ${pkgs.bash}/bin/bash ${self}/build.sh
          '');
        };
      });
    };
}
