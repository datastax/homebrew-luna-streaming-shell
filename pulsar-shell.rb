class PulsarShell < Formula
    desc "Datastax Luna Streaming Shell for managing Apache Pulsar clusters"
    homepage "https://docs.datastax.com/en/luna-streaming/docs/index.html"
    url "https://github.com/datastax/pulsar/releases/download/ls31_4.5/lunastreaming-shell-3.1.4.5-bin.tar.gz"
    sha256 "147c3e7f8238cbfdd149e204aaae46fbf5b7ad8d3b6ffc37c8c96ea64565d4e9"
    license "Apache-2.0"
  
    depends_on "openjdk@17"
  
    def install
      libexec.install Dir["*"]
      bin.install_symlink libexec/"bin/pulsar-shell"
    end
  end
  
