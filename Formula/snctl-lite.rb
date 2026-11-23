# This file is written by the snctl release workflow; edits are overwritten.
class SnctlLite < Formula
  desc "Command-line client for the Supernote cloud, without rendering"
  homepage "https://github.com/altessa-s/snctl"
  version "1.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl-lite_1.0.1_darwin_arm64.zip"
      sha256 "4d47f0720f4332aacdd38aae1408b6568d97f2def382ac0f9b153647bffe72de"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl-lite_1.0.1_darwin_amd64.zip"
      sha256 "832e46092baa8c4aedeb15228bfbf4ce5501687517b884c44c99af0f28a19b6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl-lite_1.0.1_linux_arm64.tar.gz"
      sha256 "30a214d32bd8dbfde09f221d70fe112d7a51ce64b266902e6ab09b147b35f11a"
    end
    on_intel do
      url "https://github.com/altessa-s/snctl/releases/download/v1.0.1/snctl-lite_1.0.1_linux_amd64.tar.gz"
      sha256 "407e658e6a10de96523b94f630148505e458af9e0020406b1db91d627d99f010"
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
