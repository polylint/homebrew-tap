# typed: false
# frozen_string_literal: true

class Uncomment < Formula
  desc "Fast, AST-accurate comment removal and tag-comment linting built on tree-sitter"
  homepage "https://github.com/polylint/uncomment"
  version "3.11.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-apple-darwin.tar.gz"
      sha256 "d358a0362d3f1bd0c631d683811456ac7111e0983000cf1d20359b615283277f"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-apple-darwin.tar.gz"
      sha256 "2527149b2d7d4e4e71b0cde23f229ed5f2e20d41c1832adf0000f277596f064f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "174dcdecd77c0fc21fea58f699b45f6af88b710ac0079e20a8d71fb5888e9e0d"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31bd3ce6580e5fb9355a290720714d961bd5610c1ef9f5750119073561c9cb22"
    end
  end

  def install
    bin.install "uncomment"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uncomment --version")
  end
end
