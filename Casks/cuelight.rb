cask "cuelight" do
  version "2.0.1-alpha"
  sha256 "96034e89249d8dda57d47fac76a2bdc585b3bd2d4bc50a3655446bc17ab6bae1"

  url "https://github.com/odiumuniverse/cuelight/releases/download/v#{version}/cuelight-#{version}.zip"
  name "cuelight"
  desc "Caps Lock LED indicator for coding agent sessions"
  homepage "https://github.com/odiumuniverse/cuelight"

  livecheck do
    url "https://github.com/odiumuniverse/cuelight.git"
    strategy :git
  end

  depends_on macos: :ventura

  app "cuelight.app"
  binary "#{appdir}/cuelight.app/Contents/MacOS/cuelight", target: "cuelight"
  zsh_completion "completions/_cuelight"

  uninstall quit: "com.odiumuniverse.cuelight"

  zap trash: "~/.config/cuelight"

  caveats <<~EOS
    cuelight lives in the menu bar (no Dock icon). Grant Input Monitoring when asked.
    Hooks are opt-in: `cuelight hooks install <agent>` or the Agent hooks submenu.
  EOS
end
