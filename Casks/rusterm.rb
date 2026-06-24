cask "rusterm" do
  version "v0.5.16"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

  url "https://github.com/iQNRen/rusterm/releases/download/v#{version}/rusterm-v#{version}-macos-aarch64.zip",
      verified: "github.com/iQNRen/rusterm/"
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
