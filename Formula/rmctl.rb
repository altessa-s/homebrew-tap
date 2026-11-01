# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.1.0/rmctl_1.1.0_darwin_arm64.tar.gz"
      sha256 "8ef642f2de0540871a1df9f0efbbf9ac7b3f64aff5f5ee30d09bcc4c17b159fb"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.1.0/rmctl_1.1.0_darwin_amd64.tar.gz"
      sha256 "a1c86b118da3fda39a388018b6efc755a63bae23717025de25a0aea0e082a3ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.1.0/rmctl_1.1.0_linux_arm64.tar.gz"
      sha256 "def89dcc9c97d6c4fae23e3edbecb1c76bb7d3153c373c6f3414171a927f3f12"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.1.0/rmctl_1.1.0_linux_amd64.tar.gz"
      sha256 "89dfd4b20bde54e3080e529fe6d16628b28a6d4ee342b5944b036515f4800e2f"
    end
  end

  def install
    bin.install "rmctl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rmctl version").strip
  end
end
