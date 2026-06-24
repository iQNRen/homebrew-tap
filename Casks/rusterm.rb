cask "rusterm" do
  version "0.5.16"
  sha256 : "214e0114f4f65f743b9d4601c1fb1c8ead84da5389350cf57544ff06d4c23e93"

  on_arm do
    url "https://github.com/iQNRen/rusterm/releases/download/v#{version}/rusterm-v#{version}-macos-aarch64.zip"
  end
  on_intel do
    url "https://github.com/iQNRen/rusterm/releases/download/v#{version}/rusterm-v#{version}-macos-x86_64.zip"
  end

  name "Rusterm"
  desc "Lightweight Rust + Slint SSH/terminal client"
  homepage "https://github.com/iQNRen/rusterm"

  depends_on macos: ">= 12"

  app "rusterm.app"

  zap trash: [
    "~/Library/Application Support/rusterm",
    "~/.config/rusterm",
  ]
end
