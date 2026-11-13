# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl_1.3.1_darwin_arm64.zip"
      sha256 "6eeb84d38a79650a3d067b365a9c3d59527f59200e60bdda044a7684457b4d9b"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl_1.3.1_darwin_amd64.zip"
      sha256 "41dd101335e0aa2069fb4e27db73c5d5bed0d29e17968b4854fff25c9015922c"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl_1.3.1_linux_arm64.tar.gz"
      sha256 "4982dbcbd13a1422c407622010c3479a5b61ad7466609a21b6ae8e5ad0542687"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl_1.3.1_linux_amd64.tar.gz"
      sha256 "20d8f32512646fa23b5180bdd15264fa53a16cb271361426915e113322123458"
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
