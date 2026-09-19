cask "cuelight" do
  version "2.0.0-alpha"
  sha256 "34e64f770e08da1381d7dd945c9d0f66802652b8f5c6412cb0788ebe7fdfe4c4"

  url "https://github.com/odiumuniverse/cuelight/releases/download/v#{version}/cuelight-#{version}.zip"
  name "cuelight"
  desc "Caps Lock LED indicator for coding agent sessions"
  homepage "https://github.com/odiumuniverse/cuelight"

  depends_on macos: :ventura

  app "cuelight.app"
  binary "#{appdir}/cuelight.app/Contents/MacOS/cuelight", target: "cuelight"
  zsh_completion "completions/_cuelight"

  uninstall quit: "com.odiumuniverse.cuelight"

  zap trash: [
    "~/.config/cuelight",
  ]

  caveats <<~EOS
    cuelight lives in the menu bar (no Dock icon). Grant Input Monitoring when asked.
    Hooks are opt-in: `cuelight hooks install <agent>` or the Agent hooks submenu.
  EOS
end
