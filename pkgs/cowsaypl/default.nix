{ stdenv
, fetchFromGitHub
, lib
, gnuapl
}:

stdenv.mkDerivation rec {
  pname   = "cowsaypl";
  version = "1.2.3";

  src = fetchFromGitHub {
    owner = "ona-li-toki-e-jan-Epiphany-tawa-mi";
    repo  = "cowsAyPL";
    rev   = "RELEASE-V${version}";
    hash  = "sha256-KUSFKXIUFh9Qu0lyqfHJI26DDkPeRw5gkXYC56UClYo=";
  };

  doCheck     = true;
  checkInputs = [ gnuapl ];
  checkPhase  = ''
    runHook preCheck

    apl --script test.apl -- test tests/sources tests/outputs

    runHook postCheck
  '';

  buildInputs  = [ gnuapl ];
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp cowsay.apl "$out/bin/${pname}"

    mkdir -p "$out/lib"
    cp workspaces/fio.apl "$out/lib"
    sed -e "s|)COPY_ONCE fio.apl|)COPY_ONCE $out/lib/fio.apl|" \
        -e 's|⊣ ⍎")COPY_ONCE logging.apl"||'                   \
        -i "$out/bin/${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Cowsay in GNU APL";
    homepage    =
      "https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/cowsAyPL";
    license     = licenses.gpl3Plus;
    mainProgram = pname;
  };
}
