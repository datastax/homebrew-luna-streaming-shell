class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.2/lunastreaming-shell-3.1.4.2-bin.tar.gz"
    sha256 "8608704a69c7d2da48408ee5fe28aa53faae1c6a1ce4888e67b2fd0dc2da3d8d"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
