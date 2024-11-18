class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.10/lunastreaming-shell-3.1.4.10-bin.tar.gz"
    sha256 "2aab2c236ffa91f905fc321104e93b13e1a26f0ebaade7e828c62a3dd5f89265"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
