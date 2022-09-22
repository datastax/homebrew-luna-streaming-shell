class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna/streaming/2.8/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls210_1.7/lunastreaming-shell-2.10.1.7-bin.tar.gz"
    sha256 "03719ba20e4371709fc0147f82af23c102e94da4f5bbafa2c89061d26d13b2b1"
    license "Apache-2.0"
  
    depends_on "openjdk@11"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
