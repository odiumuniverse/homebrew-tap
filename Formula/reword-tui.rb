class RewordTui < Formula
  desc "Spaced-repetition terminal companion for ReWord vocabulary"
  homepage "https://github.com/odiumuniverse/reword-tui"
  url "https://github.com/odiumuniverse/reword-tui/archive/c3c6faa2f3c1487d44b83085ad4c390b3fd9e5ee.tar.gz"
  version "2026.09.20"
  sha256 "a93013a2c108573bb8bb292a764d454dedde79e51c07441108218b82d4c5c0c4"
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
