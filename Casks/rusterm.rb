cask "rusterm" do
  version "0.5.10"
  sha256 :no_check

  on_arm do
    url "https://github.com/iQNRen/rusterm/releases/download/v#{version}/rusterm-v#{version}-macos-aarch64.zip"
  end
  on_intel do
    url "https://github.com/iQNRen/rusterm/releases/download/v#{version}/rusterm-v#{version}-macos-x86_64.zip"
  end

  name "Rusterm"
  desc "Lightweight Rust + Slint SSH/terminal client"
  homepage "https://github.com/iQNRen/rusterm"

  app "rusterm.app"

  zap trash: [
    "~/Library/Application Support/rusterm",
    "~/.config/rusterm",
  ]
end
