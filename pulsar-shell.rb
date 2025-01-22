class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.12/lunastreaming-shell-3.1.4.12-bin.tar.gz"
    sha256 "87fb3fbf434c06c875daa5098a7a54785299654e4c6e6ecadab25de3049a5959"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
