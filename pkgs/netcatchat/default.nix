{ stdenv
, fetchFromGitHub
, lib
, netcat-openbsd
, shellcheck
}:

let sourceFile = "netcatchat.sh";
in
stdenv.mkDerivation rec {
  pname   = "netcatchat";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "ona-li-toki-e-jan-Epiphany-tawa-mi";
    repo  = "netcatchat";
    rev   = "RELEASE-V${version}";
    hash  = "sha256-ST706XwdEUlcwXX9xtONkhzlFANybRgJxBVZdVnWoIo=";
  };

  doCheck     = true;
  checkInputs = [ shellcheck ];
  checkPhase  = ''
    runHook preCheck

    shellcheck "${sourceFile}"

    runHook postCheck
  '';

  nativeBuildInputs = [ netcat-openbsd ];
  installPhase      = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp "${sourceFile}" "$out/bin/${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple command-line chat server and client using netcat";
    homepage    =
      "https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/netcatchat";
    license     = licenses.mit;
    mainProgram = pname;
  };
}
