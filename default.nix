{ pkgs ? import <nixpkgs> {}
, ...
}:

let callPackage = pkg: pkgs.callPackage pkg {};
in
{
  ahd        = callPackage ./pkgs/ahd;
  bitmasher  = callPackage ./pkgs/bitmasher;
  netcatchat = callPackage ./pkgs/netcatchat;
}
