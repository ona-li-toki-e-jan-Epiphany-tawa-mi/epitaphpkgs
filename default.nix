{ pkgs ? import <nixpkgs> {}
, ...
}:

let callPackage = pkg: pkgs.callPackage pkg {};
in
{
  ahd          = callPackage ./pkgs/ahd;
  bitmasher    = callPackage ./pkgs/bitmasher;
  love-you-mom = callPackage ./pkgs/love-you-mom;
  netcatchat   = callPackage ./pkgs/netcatchat;
}
