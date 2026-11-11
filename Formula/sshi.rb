class Sshi < Formula
  desc "Search your SSH hosts with fzf and connect"
  homepage "https://github.com/iMaGd/sshi"
  url "https://github.com/iMaGd/sshi/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "28c6cb6a9524236012584111b6ebc72c5aa6cf0c9f6e09fcdae525e6d9f8506c"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "bin/sshi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sshi --version")

    (testpath/".ssh").mkpath
    (testpath/".ssh/config").write <<~EOS
      Host web-prod.deploy example.com
        HostName 203.0.113.10
        User deploy
    EOS
    assert_match "web-prod.deploy\texample.com\tdeploy\t203.0.113.10",
                 shell_output("HOME=#{testpath} #{bin}/sshi --list")
  end
end
