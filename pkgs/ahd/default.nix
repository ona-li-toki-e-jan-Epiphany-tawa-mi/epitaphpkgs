{ stdenv
, fetchFromGitHub
, lib
, gnuapl
}:

stdenv.mkDerivation rec {
  pname   = "ahd";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ona-li-toki-e-jan-Epiphany-tawa-mi";
    repo  = "AHD";
    rev   = version;
    hash  = "sha256-LIazsGDAsKdeKD5sOShAA6xVg5P6+UXpQ8SrptPkxfQ=";
  };

  buildInputs = [ gnuapl ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ahd.apl $out/bin/${pname}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Hexdump utility";
    homepage    = "https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/AHD";
    license     = licenses.gpl3Plus;
    mainProgram = pname;
  };
}
