class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls210_2.7/lunastreaming-shell-2.10.2.7-bin.tar.gz"
    sha256 "f6a0c7b6c07a775a5ecce07df210119ee3a5dc3529cbcb28bdca7797e84ecf95"
    license "Apache-2.0"
  
    depends_on "openjdk@11"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
