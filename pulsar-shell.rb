class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna/streaming/2.8/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls210_1.6/lunastreaming-shell-2.10.1.6-bin.tar.gz"
    sha256 "e5516b4744725c087566682d47988b8e66f4a61618a8ea83e6e4dce2ce70fef6"
    license "Apache-2.0"
  
    depends_on "openjdk@11"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
