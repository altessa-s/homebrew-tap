# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl-lite_1.2.0_darwin_arm64.zip"
      sha256 "5916a7bf07164fd5cd9c9491f5acdd3f06084cc1561c3b97e3325060c0793db6"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl-lite_1.2.0_darwin_amd64.zip"
      sha256 "78a70f84df73224f8cf9d9d45caafed05ca9528aa1313ae7eb2119af440fe0aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl-lite_1.2.0_linux_arm64.tar.gz"
      sha256 "6b77b69f5e4ed1b3c60de2a9b55f8aa8c353875efbcd664ad52430cc4555208a"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl-lite_1.2.0_linux_amd64.tar.gz"
      sha256 "29f16328d3ad1100ee59233011194476601a4f29b4a851c9b6b797497403573c"
    end
  end

  conflicts_with "rmctl", because: "both install an rmctl binary"

  def install
    bin.install "rmctl"
    doc.install "licenses" if File.directory?("licenses")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rmctl version").strip
  end
end
