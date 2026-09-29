class Verger < Formula
  desc "Deliver agent packages to every coding agent host"
  homepage "https://github.com/odiumuniverse/verger"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.1/verger-0.1.1-darwin-universal.tar.gz"
      sha256 "66fc4d7cb27a51a1c4f76a89159009239bcfc901f20b7fea230efe90b746ac65"
    end

    on_arm do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.1/verger-0.1.1-darwin-universal.tar.gz"
      sha256 "66fc4d7cb27a51a1c4f76a89159009239bcfc901f20b7fea230efe90b746ac65"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.1/verger-0.1.1-linux-amd64.tar.gz"
      sha256 "f3bf89289a902b9f0f5f9b7e601ee3acc7f459753a35f234d650125b38256ceb"
    end

    on_arm do
      url "https://github.com/odiumuniverse/verger/releases/download/v0.1.1/verger-0.1.1-linux-arm64.tar.gz"
      sha256 "e601eb4b973d30526d862fe5663b830292de2b050fe4f167fae76dfb06cc7ec2"
    end
  end

  def install
    bin.install "verger"
    # The man page ships inside the platform tarball, so a brew install gets
    # it without a second download. Dir[] because gendocs may add subcommand
    # pages later and they should land without another edit here.
    man1.install Dir["man/*.1"]
    # No shells: list. The default is the set the binary actually generates,
    # so adding a shell is a change in one place — here — instead of two.
    generate_completions_from_executable(bin/"verger", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verger version")
    # `brew test` is the only place a missing man1.install shows up as a
    # failure rather than as a user typing `man verger` and getting nothing.
    assert_path_exists man1/"verger.1"
  end
end
