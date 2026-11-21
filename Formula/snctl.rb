# This file is written by the snctl release workflow; edits are overwritten.
class Snctl < Formula
  desc "Command-line client for the Supernote cloud"
  homepage "https://github.com/altessa-s/snctl"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl_1.0.0_darwin_arm64.zip"
      sha256 "3a263fab0f04b116633bc8a5ccc2b58bafa3ddf60433825ec19b5943b3fc24c5"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl_1.0.0_darwin_amd64.zip"
      sha256 "8b496df71f0e8d60081b7ebaff59b0be819a85bffc77822fd6d6e5156021a59d"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "gdk-pixbuf"
    depends_on "freetype"

    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl_1.0.0_linux_arm64.tar.gz"
      sha256 "a374c34dc4d3b309a70dfaedc846ac2291af7e865c2b042b10b2424c3a3fb91a"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl_1.0.0_linux_amd64.tar.gz"
      sha256 "2f403ddcc1256634cfebb73da00b66e067339d04570577e7aeea98a09d3f9dc8"
    end
  end

  conflicts_with "snctl-lite", because: "both install an snctl binary"

  def install
    if OS.linux?
      libexec.install "snctl", "libpdfium.so"
      bin.install_symlink libexec/"snctl"
    else
      bin.install "snctl"
    end
    generate_completions_from_executable(bin/"snctl", "completion")
    doc.install "licenses" if File.directory?("licenses")
  end

  service do
    run [opt_bin/"snctl", "mirror", "run", "--service"]
    keep_alive successful_exit: false
    log_path var/"log/snctl-mirror.log"
    error_log_path var/"log/snctl-mirror.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/snctl version").strip
  end
end
