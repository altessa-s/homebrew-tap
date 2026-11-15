# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl_1.3.2_darwin_arm64.zip"
      sha256 "0c4498924643b4de4fbe839f64ab36b8eafd2c6918b7a5f571143c34a16d52be"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl_1.3.2_darwin_amd64.zip"
      sha256 "a18f192688e50aae960cf30275fe23dbe1886d76e5079d4c60ef0ddc5ecb28f1"
    end
  end

  on_linux do
    depends_on "cairo"
    depends_on "fontconfig"
    depends_on "gdk-pixbuf"
    depends_on "harfbuzz"
    depends_on "pango"

    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl_1.3.2_linux_arm64.tar.gz"
      sha256 "deed879f4b6bcb0ca75c1621350f5aa1c05302247161ea3c50b5c468bdfbfda5"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl_1.3.2_linux_amd64.tar.gz"
      sha256 "963eb6fd9e0501f8723b7e20537d40488a2aa14b16f3bd62a28848c4d7c99cc1"
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
