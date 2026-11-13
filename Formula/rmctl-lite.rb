# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl-lite_1.3.1_darwin_arm64.zip"
      sha256 "acd27635bfb70df6322fd33b0f9d73b4e94e7cd130450986dcc5597c9c628391"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl-lite_1.3.1_darwin_amd64.zip"
      sha256 "40b9a0c82c9b8b9475f110d146d43a33bab23a3e8a1571723a49a889d77ec5f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl-lite_1.3.1_linux_arm64.tar.gz"
      sha256 "3f4e279dc2e12ebf79bf7eaee67eb5a2d5e43f9e6bb06092af6cb417a9281352"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.1/rmctl-lite_1.3.1_linux_amd64.tar.gz"
      sha256 "caf0d27f747659e4a9577fe3c9e7c674a39506cb1f6d3601ca14c8a815fc409b"
    end
  end

  conflicts_with "rmctl", because: "both install an rmctl binary"

  def install
    bin.install "rmctl"
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
