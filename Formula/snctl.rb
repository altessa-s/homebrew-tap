# This file is written by the snctl release workflow; edits are overwritten.
class Snctl < Formula
  desc "Command-line client for the Supernote cloud"
  homepage "https://github.com/altessa-s/snctl"
  version "1.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl_1.0.1_darwin_arm64.zip"
      sha256 "27ffa35baf3767ed005fdb608e7b738c9147c0d14b27b85745eadc3659353e8b"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl_1.0.1_darwin_amd64.zip"
      sha256 "3d9c9a73d20b6826216ed454d8a5746c5842e63c5c7682bafbfceba990ac8fc4"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "gdk-pixbuf"
    depends_on "freetype"

    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl_1.0.1_linux_arm64.tar.gz"
      sha256 "c44b434dbeaa277a955d8977d161ff6eff8386a89eff083c4f06a5c82e4df4ea"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl_1.0.1_linux_amd64.tar.gz"
      sha256 "144aacd434a811574e0c126170f152c5cb4f48620c2ce64b2199a75885c2a466"
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
