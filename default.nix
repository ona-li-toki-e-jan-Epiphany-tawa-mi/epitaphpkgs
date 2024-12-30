{ pkgs ? import <nixpkgs> {}
, ...
}:

let callPackage = pkg: pkgs.callPackage pkg {};
in
{
  ahd        = callPackage ./pkgs/ahd;
  netcatchat = callPackage ./pkgs/netcatchat;
}
