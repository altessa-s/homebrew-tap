# This file is written by the rmctl release workflow; edits are overwritten.
class Rmctl < Formula
  desc "Command-line client for the reMarkable cloud"
  homepage "https://github.com/altessa-s/rmctl"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.0.0/rmctl_1.0.0_darwin_arm64.tar.gz"
      sha256 "4abc5a5d102fa90bfdd75674553788c470bba11c7083079ece99e4058b978024"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.0.0/rmctl_1.0.0_darwin_amd64.tar.gz"
      sha256 "beaecfa2fffd292fc9be6e228cd4f8ab34cb82a1dbd6385a9ce427ef9fc97b78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.0.0/rmctl_1.0.0_linux_arm64.tar.gz"
      sha256 "7e569cbc0ec17a85be12742eb9b341d5f7e6f91f4fa2b1d861118d151c989b1b"
    end
    on_intel do
      url "https://github.com/altessa-s/rmctl/releases/download/v1.0.0/rmctl_1.0.0_linux_amd64.tar.gz"
      sha256 "bddb87affbd2f404dd7006e49d31ae5a85d9b3b8064f546cee511e0a5cc9d555"
    end
  end

  def install
    bin.install "rmctl"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/rmctl version").strip
  end
end
