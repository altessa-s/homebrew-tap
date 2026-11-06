# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl-lite_1.2.1_darwin_arm64.zip"
      sha256 "dbe596d533088a51ab751ad98acd3c774ebe7fcbe221a7e62fd78f067db8892d"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl-lite_1.2.1_darwin_amd64.zip"
      sha256 "49cab31a9022fbf374b433072ae9f550ce9d5f4c804ebac8b04d05aa6d1b02cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl-lite_1.2.1_linux_arm64.tar.gz"
      sha256 "b61d74e7a6046b1cfaebe42d9f1c402693fbc52bde01cf247a6a122e75c0e9f7"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl-lite_1.2.1_linux_amd64.tar.gz"
      sha256 "07f13bbd3155bad2e3b7d131fc4531aebb737115ef653b72a12bb07c0d86cf29"
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
