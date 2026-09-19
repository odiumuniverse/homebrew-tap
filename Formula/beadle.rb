class Beadle < Formula
  desc "Sync AI coding agent config from one private vault"
  homepage "https://github.com/odiumuniverse/beadle"
  url "https://github.com/odiumuniverse/beadle.git",
      revision: "14e5a2f05d1c7531e0d840502c0c44ed1ca838c4"
  version "2026.09.20"
  license "MIT"
  head "https://github.com/odiumuniverse/beadle.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}", output: bin/"beadle"), "./cmd/beadle"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beadle --version")
  end
end
