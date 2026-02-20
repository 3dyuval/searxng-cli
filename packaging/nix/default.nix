{ lib, stdenv, makeWrapper, curl, jq, xdg-utils }:

stdenv.mkDerivation rec {
  pname = "searxng-cli";
  version = "0.1.0";

  src = ../..;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ curl jq xdg-utils ];

  installPhase = ''
    make install PREFIX=$out VERSION=${version}
    wrapProgram $out/bin/searxng \
      --prefix PATH : ${lib.makeBinPath [ curl jq xdg-utils ]}
  '';

  meta = with lib; {
    description = "Shell wrapper for SearXNG with carapace completions";
    homepage = "https://github.com/3dyuval/searxng-cli";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "searxng";
  };
}
