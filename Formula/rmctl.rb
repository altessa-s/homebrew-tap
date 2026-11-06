# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl_1.2.1_darwin_arm64.zip"
      sha256 "306d90f31da9a219aa0e66db5d8077e544dae3bfc73a206bec695ece1b5c2149"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl_1.2.1_darwin_amd64.zip"
      sha256 "010dd86a44eb5dd2e6970422373c90ebcd6b4e6d77e8553dbaa62ef671195467"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl_1.2.1_linux_arm64.tar.gz"
      sha256 "db487c4249b49e37a539c1df24fe35b2768a1203a99fece03fad6c8c92344060"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.1/rmctl_1.2.1_linux_amd64.tar.gz"
      sha256 "24340efa0f74b08937b6b5466d590111c22a8910578eb195c563252d1831cc41"
    end
  end

  conflicts_with "rmctl-lite", because: "both install an rmctl binary"

  def install
    if OS.linux?
      libexec.install "rmctl", "libpdfium.so"
      bin.install_symlink libexec/"rmctl"
    else
      bin.install "rmctl"
    end
    doc.install "licenses" if File.directory?("licenses")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rmctl version").strip
  end
end
