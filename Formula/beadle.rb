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
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.0/beadle-0.5.0-darwin-universal.tar.gz"
      sha256 "4135753ff3cab718296f0c002f271bfe0d5044c613e8dcca91a44ea8b18e0882"
    end

    on_arm do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.0/beadle-0.5.0-darwin-universal.tar.gz"
      sha256 "4135753ff3cab718296f0c002f271bfe0d5044c613e8dcca91a44ea8b18e0882"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.0/beadle-0.5.0-linux-amd64.tar.gz"
      sha256 "48102a99db99671dfdea84a6b4def6a08945221898b83be70a5efa08beb2d3ce"
    end

    on_arm do
      url "https://github.com/odiumuniverse/beadle/releases/download/v0.5.0/beadle-0.5.0-linux-arm64.tar.gz"
      sha256 "d08d60291590f5c5ecf36eba7629a996110239b0a683831cda38cc3a4703032c"
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
