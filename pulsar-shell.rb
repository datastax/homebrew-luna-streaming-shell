class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url " https://github.com/datastax/pulsar/releases/download/ls31_0.2/lunastreaming-shell-3.1.0.2-bin.tar.gz"
    sha256 "fb57b0b43d21fbde91d18702c0885894835e75dc12b40b1bc0b51bf401f409b7"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
