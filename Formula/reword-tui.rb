class RewordTui < Formula
  desc "Spaced-repetition terminal companion for ReWord vocabulary"
  homepage "https://github.com/odiumuniverse/reword-tui"
  url "https://github.com/odiumuniverse/reword-tui/releases/download/v0.1.2/reword-tui-0.1.2-darwin-universal.tar.gz"
  sha256 "221ab81270fe717d2db9c3d30d724e2f4182fe18483b36c1960cdef3cdf76bb8"
  license "MIT"

  def install
    libexec.install "reword-tui", "rwcore"

    (bin/"reword-tui").write <<~SH
      #!/bin/sh
      exec "#{libexec}/reword-tui" --rwcore "#{libexec}/rwcore" "$@"
    SH
    (bin/"reword-tui").chmod 0755
  end

  test do
    assert_predicate libexec/"rwcore", :executable?
    assert_predicate bin/"reword-tui", :executable?
  end
end
