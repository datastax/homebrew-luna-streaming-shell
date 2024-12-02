class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.11/lunastreaming-shell-3.1.4.11-bin.tar.gz"
    sha256 "c94bea229aeafa855d29df9ac5693283fc6fca436b22d88454cb7dd16f78c84d"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
