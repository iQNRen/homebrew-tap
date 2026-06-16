#!/bin/bash
# 更新 Homebrew Cask 版本和 sha256
# 用法: ./update-cask.sh [版本号]
# 示例: ./update-cask.sh 0.6.0

set -e

VERSION="${1:?用法: $0 <版本号>}"
CASK_FILE="$(dirname "$0")/Casks/rusterm.rb"
REPO="iQNRen/rusterm"

echo "更新 rusterm cask 到 v${VERSION}"

# 下载两个架构的 zip 并计算 sha256
echo "下载 macos-aarch64..."
curl -sL "https://github.com/${REPO}/releases/download/v${VERSION}/rusterm-v${VERSION}-macos-aarch64.zip" \
  -o /tmp/rusterm-aarch64.zip
SHA_ARM=$(shasum -a 256 /tmp/rusterm-aarch64.zip | awk '{print $1}')
rm /tmp/rusterm-aarch64.zip

echo "下载 macos-x86_64..."
curl -sL "https://github.com/${REPO}/releases/download/v${VERSION}/rusterm-v${VERSION}-macos-x86_64.zip" \
  -o /tmp/rusterm-x86_64.zip
SHA_X86=$(shasum -a 256 /tmp/rusterm-x86_64.zip | awk '{print $1}')
rm /tmp/rusterm-x86_64.zip

echo "aarch64 sha256: ${SHA_ARM}"
echo "x86_64  sha256: ${SHA_X86}"

# 如果两个架构 sha256 一样，用单个值；否则用 on_arm/on_intel 分别设置
if [ "$SHA_ARM" = "$SHA_X86" ]; then
  SHA256="$SHA_ARM"
  cat > "$CASK_FILE" <<EOF
cask "rusterm" do
  version "${VERSION}"
  sha256 "${SHA256}"

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
EOF
else
  cat > "$CASK_FILE" <<EOF
cask "rusterm" do
  version "${VERSION}"
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

  depends_on macos: ">= 12"

  app "rusterm.app"

  zap trash: [
    "~/Library/Application Support/rusterm",
    "~/.config/rusterm",
  ]
end
EOF
fi

echo ""
echo "已更新 ${CASK_FILE}"
echo "提交并推送："
echo "  cd $(dirname "$0")"
echo "  git add -A && git commit -m 'rusterm v${VERSION}' && git push"
