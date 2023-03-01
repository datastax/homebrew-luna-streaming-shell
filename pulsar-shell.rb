class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls210_3.4/lunastreaming-shell-2.10.3.4-bin.tar.gz"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    license "Apache-2.0"
  
    depends_on "openjdk@11"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
