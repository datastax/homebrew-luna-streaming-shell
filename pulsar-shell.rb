class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_3.0/lunastreaming-shell-3.1.3.0-bin.tar.gz"
    sha256 "cc2c69be4d2fcb6f8da3ed811c5352b4ce412afd25aa63738a3e0ac0a888112b"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
