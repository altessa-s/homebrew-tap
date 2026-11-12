# This file is written by the rmctl release workflow; edits are overwritten.
class RmctlLite < Formula
  desc "Command-line client for the reMarkable cloud, without rendering"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl-lite_1.3.0_darwin_arm64.zip"
      sha256 "0640b73ab26e3fcd69c50455d5466f8608e08c1de94f08e709ce86879cf0d589"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl-lite_1.3.0_darwin_amd64.zip"
      sha256 "0ebb6bf479ecbab1da3f1784a5abe335474e13c23cb779905542b0266fc183ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl-lite_1.3.0_linux_arm64.tar.gz"
      sha256 "eb24e49cdef5d06bdcb17776f97a32dae523af16aa63d3bb7c3082d2043b08a9"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.3.0/rmctl-lite_1.3.0_linux_amd64.tar.gz"
      sha256 "b2edfab8f5919a9d0d5617c5a44cb4634c35b363651581c21de4a31e0a8838ef"
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
