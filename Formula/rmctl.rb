# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl_1.2.0_darwin_arm64.zip"
      sha256 "db97d658e5f83907dbba82c4d27acba0150a6c3cabbaa1d17f241059a76afde0"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl_1.2.0_darwin_amd64.zip"
      sha256 "e2cda65dae10e9195c998ca581ec990b3f339dcfd2a90c5e3700ea72af151543"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl_1.2.0_linux_arm64.tar.gz"
      sha256 "c8a3839e0eec8611622a331bbcffc5e815c270757f550cab7cffb11c6d347701"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.2.0/rmctl_1.2.0_linux_amd64.tar.gz"
      sha256 "10beb2a05fc395f7096bce1dba0b26a0b6667f269a892daa3c3a301c90798bd7"
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
