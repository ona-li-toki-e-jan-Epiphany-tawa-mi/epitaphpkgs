{
  description = "epitaphpkgs Nix package repository";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, self, ... }:
    let inherit (nixpkgs.lib) genAttrs systems;

        forAllSystems = f: genAttrs systems.flakeExposed (system: f {
          pkgs = import nixpkgs { inherit system; };
        });

        overlay = final: prev: {
          epitaphpkgs = self.packages.${prev.system};
        };
    in {
      packages = forAllSystems ({ pkgs, ... }:
        import ./default.nix { inherit pkgs; });

      legacyPackages = self.packages;

      overlays.default = overlay;

      nixosModules.default = {
        nixpkgs.overlays = overlay;
      };
    };
}
