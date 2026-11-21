# This file is written by the snctl release workflow; edits are overwritten.
class SnctlLite < Formula
  desc "Command-line client for the Supernote cloud, without rendering"
  homepage "https://github.com/altessa-s/snctl"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl-lite_1.0.0_darwin_arm64.zip"
      sha256 "b76b1d2c3425eee1e8ab8d03e70e6f74fd39c56a7c40e31ec4716c7192740753"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl-lite_1.0.0_darwin_amd64.zip"
      sha256 "026393cd6c8490f020f0132e342105c7b356ecc78561d426eedc854c4debaec3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl-lite_1.0.0_linux_arm64.tar.gz"
      sha256 "eed7dcbc4e61b2c60aa79df3b309a3c21b31a776067a816b9db5197edc3ab72e"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.0/snctl-lite_1.0.0_linux_amd64.tar.gz"
      sha256 "e18d918a9974f7fe6fc3b9c7f9a97f58df83a400ad4245caee7ceea5a3197906"
    end
  end

  conflicts_with "snctl", because: "both install an snctl binary"

  def install
    bin.install "snctl"
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
