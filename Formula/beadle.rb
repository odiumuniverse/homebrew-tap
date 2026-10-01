class Beadle < Formula
  desc "One configuration for every AI coding agent"
  homepage "https://github.com/odiumuniverse/beadle"
  license "MIT"

  on_macos do
    # brew style rejects a bare url/sha256 directly inside
    # on_macos/on_linux: the arch has to be stated, because
    # "darwin-universal" and "linux-amd64" are not the same file.
    # Both mac branches point at the same universal tarball, which
    # is exactly what Homebrew expects a universal artifact to look
    # like: one url, declared for both arches.
    on_intel do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.1/beadle-0.5.1-darwin-universal.tar.gz"
      sha256 "d6a8c85d01710bac8483a22eb93695476dbcf62c89aa9b5dfef65a6ba193be91"
    end

    on_arm do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.1/beadle-0.5.1-darwin-universal.tar.gz"
      sha256 "d6a8c85d01710bac8483a22eb93695476dbcf62c89aa9b5dfef65a6ba193be91"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.1/beadle-0.5.1-linux-amd64.tar.gz"
      sha256 "1fb2a1f1fc3c006d5cdb8a622b8c6f742d6ba3c51e7ffbc4b21c26f23ba48499"
    end

    on_arm do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.1/beadle-0.5.1-linux-arm64.tar.gz"
      sha256 "34a7896fa78fbd18d2b05e0a1bf42eba401a29c3a5914c21abe539a99cdbcd36"
    end
  end

  def install
    bin.install "beadle"
    # The man page ships inside the platform tarball, so a brew
    # install gets it without a second download. Dir[] because
    # gendocs may add subcommand pages later and they should land
    # without another edit here.
    man1.install Dir["man/*.1"]
    # No shells: list. The default is the set the binary actually
    # generates, so adding a shell is a change in one place — the
    # binary — instead of two.
    generate_completions_from_executable(bin/"beadle", "completion")
  end

  test do
    # beadle has no `version` subcommand; the flag is the only
    # surface that prints the version, so `brew test` must use it.
    # No backslash before #{bin}: both heredocs here are quoted
    # (<<'RB' and <<~'FORMULA'), so nothing expands the template on
    # its way to disk and a "\#{bin}" would ship a literal backslash
    # into the formula. In the formula's own double-quoted string
    # that is an escaped '#', so `brew test` would run the command
    # "#{bin}/beadle --version" - a path that does not exist.
    assert_match version.to_s, shell_output("#{bin}/beadle --version")
    # `brew test` is the only place a missing man1.install shows up
    # as a failure rather than as a user typing `man beadle` and
    # getting nothing.
    assert_path_exists man1/"beadle.1"
  end
end
