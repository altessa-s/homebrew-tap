# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl-lite_1.3.2_darwin_arm64.zip"
      sha256 "3e71d1ce5132c532530910da6afe36dd4d070cce139a49b119ee8458b4625292"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl-lite_1.3.2_darwin_amd64.zip"
      sha256 "1a4e488b57284d678df8d0fe08882a4bc4aa0ddea8e7ab90e8c659ba061f9e95"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl-lite_1.3.2_linux_arm64.tar.gz"
      sha256 "57dd74a23474bad902b2fe0a0cbf2ddc5693d918133797de819a98b483353575"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.2/rmctl-lite_1.3.2_linux_amd64.tar.gz"
      sha256 "0b6e3401bfdcf0355ac8d4ff657ae8a2f528edb2552b494b0ba54b46371da121"
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
