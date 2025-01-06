{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/e08a8231e2c827f586e64727c1063c5e61dbc00d";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      stdenv = pkgs.stdenv;
      lib = pkgs.lib;
  in {
      devShells.default = pkgs.mkShell rec {
        packages = with pkgs; [
          ansible
          opentofu
          google-cloud-sdk
        ];
      };
    }
  );
}
