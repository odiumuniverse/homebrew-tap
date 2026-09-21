class Beadle < Formula
  desc "Sync AI coding agent config from one private vault"
  homepage "https://github.com/odiumuniverse/beadle"
  url "https://github.com/odiumuniverse/beadle/releases/download/v0.4.1/beadle-0.4.1-darwin-universal.tar.gz"
  sha256 "d8880cdc58c5a9ff2bc8dcf37c0b9e13c20068782e147ad6ad9ba0209c176369"
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
