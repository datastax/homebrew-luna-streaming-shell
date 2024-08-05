class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.4/lunastreaming-shell-3.1.4.4-bin.tar.gz"
    sha256 "d53d354fdaabd23a399a03f1850b84ae23f53650cb5ef490df2c0d4b30ae6e61"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
