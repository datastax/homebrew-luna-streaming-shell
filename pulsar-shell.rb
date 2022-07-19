class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna/streaming/2.8/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls210_1.1/lunastreaming-shell-2.10.1.1-bin.tar.gz"
    sha256 "3067d06b7bf45ecd1e887ffe9bebbf2d3c747561967811ee1b3c37be27fb4135"
    license "Apache-2.0"
  
    depends_on :openjdk => 11
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
