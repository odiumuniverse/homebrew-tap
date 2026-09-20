class RewordTui < Formula
  desc "Spaced-repetition terminal companion for ReWord vocabulary"
  homepage "https://github.com/odiumuniverse/reword-tui"
  url "https://github.com/odiumuniverse/reword-tui/releases/download/v0.1.1/reword-tui-0.1.1-darwin-universal.tar.gz"
  sha256 "5c7d3ea0b1a9abfec0cab3b5786613f4f6fec61ffb676d5ffbc357a6695ce8fc"
  license "MIT"
  head "https://github.com/odiumuniverse/reword-tui.git", branch: "master"

  depends_on "go" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(root: libexec, path: "cli")
    system "go", "build", *std_go_args(output: "reword-tui"), "./cmd/reword-tui"

    libexec.install "reword-tui"

    (bin/"reword-tui").write <<~SH
      #!/bin/sh
      exec "#{libexec}/reword-tui" --rwcore "#{libexec}/bin/rwcore" "$@"
    SH
    (bin/"reword-tui").chmod 0755
  end

  test do
    assert_predicate libexec/"bin/rwcore", :executable?
    assert_predicate bin/"reword-tui", :executable?
  end
end
