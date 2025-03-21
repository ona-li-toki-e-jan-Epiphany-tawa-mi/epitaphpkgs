# MIT License
#
# Copyright (c) 2024-2025 ona-li-toki-e-jan-Epiphany-tawa-mi
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

{ stdenv, fetchgit, lib }:

stdenv.mkDerivation rec {
  pname = "bitmasher";
  version = "7.6496437096";

  src = fetchgit {
    url = "https://paltepuk.xyz/cgit/BitMasher.git";
    rev = "RELEASE-V${version}";
    hash = "sha256-e6cuz/qsQp5a43LD6Mg3iuRPPtO+uY61XtDKatfNv9Q=";
  };

  buildPhase = ''
    runHook preBuild

    ./build.sh -O3

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp bitmasher "$out/bin/${pname}"

    runHook postInstall
  '';

  meta = with lib; {
    description =
      "A fast-paced text adventure game inside a ransomware-infected computer";
    homepage = "https://paltepuk.xyz/cgit/BitMasher.git/about";
    license = licenses.gpl3Plus;
    mainProgram = pname;
  };
}
