# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl_1.3.0_darwin_arm64.zip"
      sha256 "e19fe01177753998ee8c8def05a0ece945198fe9fe25caba61ab06dc3575d6b1"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl_1.3.0_darwin_amd64.zip"
      sha256 "15c537282a5ce972e249329177eab3d62e3c140b88c4af3fb6445ffb97ce93a3"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl_1.3.0_linux_arm64.tar.gz"
      sha256 "fff4e55a769c245ea07daa48491aa3a93200d3cc7bb95e6212ba58c9df39b365"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl_1.3.0_linux_amd64.tar.gz"
      sha256 "ded1a802cb3d6a39a6a5c9810025cfcd82d8b229ac86be12a479166f23cee2bb"
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
    generate_completions_from_executable(bin/"rmctl", "completion")
    doc.install "licenses" if File.directory?("licenses")
  end

  service do
    run [opt_bin/"rmctl", "mirror", "run", "--service"]
    keep_alive successful_exit: false
    log_path var/"log/rmctl-mirror.log"
    error_log_path var/"log/rmctl-mirror.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rmctl version").strip
  end
end
