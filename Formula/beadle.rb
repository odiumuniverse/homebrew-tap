class Beadle < Formula
  desc "Sync AI coding agent config from one private vault"
  homepage "https://github.com/odiumuniverse/beadle"
  url "https://github.com/odiumuniverse/beadle/releases/download/v0.3.2/beadle-0.3.2-darwin-universal.tar.gz"
  sha256 "89c039ca01de00c2e9c40680a704f3ca71d1ee642a76c867e8284113bc9c0e4e"
  license "MIT"

  def install
    bin.install "beadle"
  end

  service do
    run [opt_bin/"beadle", "watch"]
    keep_alive true
    log_path var/"log/beadle.log"
    error_log_path var/"log/beadle.err.log"
    working_dir var
  end

  def caveats
    <<~EOS
      Run `brew services start beadle` to keep the watcher running.
      It serves the default vault (~/.beadle); for a custom vault use
      `beadle daemon install` instead.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beadle --version")
  end
end
