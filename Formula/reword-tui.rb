class RewordTui < Formula
  desc "Spaced-repetition terminal companion for ReWord vocabulary"
  homepage "https://github.com/odiumuniverse/reword-tui"
  url "https://github.com/odiumuniverse/reword-tui/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "688e494e0e6bdcb6b7f51d37682ec050d3c0e028de7b5bcd931053c01df69491"
  license "MIT"
  head "https://github.com/odiumuniverse/reword-tui.git", branch: "master"

  depends_on "go" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "--manifest-path", "cli/Cargo.toml"
    system "go", "build", *std_go_args(output: "reword-tui"), "./cmd/reword-tui"

    libexec.install "reword-tui", "cli/target/release/rwcore"

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
