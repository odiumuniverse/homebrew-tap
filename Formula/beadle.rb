class Beadle < Formula
  desc "Sync AI coding agent config from one private vault"
  homepage "https://github.com/odiumuniverse/beadle"
  url "https://github.com/odiumuniverse/beadle/releases/download/v0.2.0/beadle-0.2.0-darwin-universal.tar.gz"
  sha256 "871353e3902ab8fd9fcd51959cd9c9db4ee4d03465cd24be5d92aa828190bb9e"
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
