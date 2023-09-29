{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      pythonWithModules = pkgs.python311.withPackages(p: [
        p.pygobject3
        p.psutil
        p.i3ipc
        p.setuptools
        p.dasbus
        p.requests
      ]);
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pythonWithModules
          gtk3
          gtk-layer-shell
          wlr-randr
          gobject-introspection
          playerctl
          light
        ];
      };
    }
  );
}
