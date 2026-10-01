class Verger < Formula
  desc "Deliver agent packages to every coding agent host"
  homepage "https://github.com/odiumuniverse/verger"
  # brew audit flags an explicit version as redundant with the one
  # it scans from the url; the tarball names carry it.
  license "MIT"

  on_macos do
    # brew style rejects a bare url/sha256 directly inside
    # on_macos/on_linux: the arch has to be stated, because
    # "darwin-universal" and "linux-amd64" are not the same file.
    # Both mac branches point at the same universal tarball, which
    # is exactly what Homebrew expects a universal artifact to look
    # like: one url, declared for both arches.
    on_intel do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.4/verger-0.1.4-darwin-universal.tar.gz"
      sha256 "502e5cd19dd114066ed67fe7b3f5795f39d83b903235c5b962d727806606eb9d"
    end

    on_arm do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.4/verger-0.1.4-darwin-universal.tar.gz"
      sha256 "502e5cd19dd114066ed67fe7b3f5795f39d83b903235c5b962d727806606eb9d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.4/verger-0.1.4-linux-amd64.tar.gz"
      sha256 "90f1bc81b7c1733bb069f1581687c9d4ffd30685c6b07e55166ef049385caa3e"
    end

    on_arm do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.4/verger-0.1.4-linux-arm64.tar.gz"
      sha256 "babcbff311f673c5404b78b103be947ae11827dce928e4a21a454195f2ee3646"
    end
  end

  def install
    bin.install "verger"
    # The man page ships inside the platform tarball, so a brew
    # install gets it without a second download. Dir[] because
    # gendocs may add subcommand pages later and they should land
    # without another edit here.
    man1.install Dir["man/*.1"]
    # No shells: list. The default is the set the binary actually
    # generates, so adding a shell is a change in one place — the
    # binary — instead of two.
    generate_completions_from_executable(bin/"verger", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verger version")
    # `brew test` is the only place a missing man1.install shows up
    # as a failure rather than as a user typing `man verger` and
    # getting nothing.
    assert_path_exists man1/"verger.1"
  end
end
