{ stdenv
, fetchFromGitHub
, lib
, gnu-cobol
}:

stdenv.mkDerivation rec {
  pname   = "cobol-dvd-thingy";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "ona-li-toki-e-jan-Epiphany-tawa-mi";
    repo  = "COBOL-DVD-Thingy";
    rev   = "RELEASE-V${version}";
    hash  = "sha256-HMkse/I9+wIcDiRC+96/K97TtwlRZkzma1vCdEkO3Ow=";
  };

  nativeBuildInputs = [ gnu-cobol.bin ];
  buildPhase        = ''
    runHook preBuild

    EXTRA_COBFLAGS='-O3' ./build.sh

    runHook postBuild
  '';

  buildInputs  = [ gnu-cobol ];
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp cobol-dvd-thingy "$out/bin/${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Terminal screensaver similar to that of DVD players";
    homepage    =
      "https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/COBOL-DVD-Thingy";
    license     = licenses.gpl3Plus;
    mainProgram = pname;
  };
}
