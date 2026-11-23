# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl-lite_1.4.0_darwin_arm64.zip"
      sha256 "4d5e57bcf4a6f812e5469b1c301ff376d359ee4efcc62d037df116350c75d1f4"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl-lite_1.4.0_darwin_amd64.zip"
      sha256 "179354428d81bd5a661f100988d2257350b467107e3c5e21681f972503bc8f8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl-lite_1.4.0_linux_arm64.tar.gz"
      sha256 "66dd8a4c402b449dc5256498f2d4fe861758795e992a9ac6d28dd052353dc97f"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.4.0/rmctl-lite_1.4.0_linux_amd64.tar.gz"
      sha256 "0fe531ede313ce51cc9760b034e39db4898a21d715d8d2460749f5f6347191b4"
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
