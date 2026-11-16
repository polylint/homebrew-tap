# typed: false
# frozen_string_literal: true

class Uncomment < Formula
  desc "Fast, AST-accurate comment removal and tag-comment linting built on tree-sitter"
  homepage "https://github.com/polylint/uncomment"
  version "3.12.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-apple-darwin.tar.gz"
      sha256 "568d148a70b9ce30333435ffc06a64bf79e7c529f913f00cb6afb60f7b2d5961"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-apple-darwin.tar.gz"
      sha256 "9866f45701bbd19e0983fc5538ef16fc9115d8044c402258619852f8c95f73e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cbb5b32d4f0f5ec3a5a50ffdfc735003023132be19f5163c27ead679ac08f7cf"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67e89fcd7dd31273d8910944a0532ebb8b2aaa13cf7169849a39db862697e8b9"
    end
  end

  def install
    bin.install "uncomment"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uncomment --version")
  end
end
