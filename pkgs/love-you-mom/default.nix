{ stdenv
, fetchFromGitHub
, lib
, zig_0_13
}:

stdenv.mkDerivation rec {
  pname   = "love-you-mom";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ona-li-toki-e-jan-Epiphany-tawa-mi";
    repo  = "love-you-mom";
    rev   = version;
    hash  = "sha256-XRPi0FEkjaUVYOXbYjhwf0acANiLZ5pybQiFnpV09m4=";
  };

  nativeBuildInputs = [ zig_0_13.hook ];
  zigBuildFlags     = [ "-Doptimize=ReleaseSafe" ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp zig-out/bin/love-you-mom "$out/bin/${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description =
      "Tells your mom (or dad) that you love them";
    homepage =
      "https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/love-you-mom";
    license     = licenses.gpl3Plus;
    mainProgram = pname;
  };
}
