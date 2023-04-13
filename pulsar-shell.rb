class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url " https://github.com/datastax/pulsar/releases/download/ls210_4.2/lunastreaming-shell-2.10.4.2-bin.tar.gz"
    sha256 "254a412ab3a7c722e37ebc8f86d59949fa2e1ed40b13cf2d32c3963657cbbc60"
    license "Apache-2.0"
  
    depends_on "openjdk@11"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
