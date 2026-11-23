# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl_1.4.0_darwin_arm64.zip"
      sha256 "daa0ba7f04d63e86ae8a8677d1d575b1512675a5519b99b755c342f2156d8fd9"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl_1.4.0_darwin_amd64.zip"
      sha256 "98ab24ca130480d60e2627ebb6c61124a2aff256eb7c6b21107458d29fcc8e6e"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl_1.4.0_linux_arm64.tar.gz"
      sha256 "10693bb858bd10f17fb84214e7b4c0715b61e004eadf04413b99f595dff0acce"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl_1.4.0_linux_amd64.tar.gz"
      sha256 "31dc64a20c3b45a2403366c17352966c3fd379e844d089c34b40cbd7b92f04b6"
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
