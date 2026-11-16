# typed: false
# frozen_string_literal: true

class Uncomment < Formula
  desc "Fast, AST-accurate comment removal and tag-comment linting built on tree-sitter"
  homepage "https://github.com/polylint/uncomment"
  version "3.12.0"
  license "MIT"

  bottle do
    root_url "https://github.com/polylint/uncomment/releases/download/v3.12.0"
    sha256 cellar: :any_skip_relocation, arm64_linux: "8bc3a608d3e1e024cee403be481d3f063ba3bd858ed2b3cb300c8789008b2a03"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a17bf1e47b4f2b93a5aaec9f3dd51da2d470198ad977fece1cbb96262cbffc07"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e3d3c6fb423dcfd9b0ed93bb0bba12d9957b4de2511e212da350e13822e3faac"
  end

  on_macos do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-apple-darwin.tar.gz"
      sha256 "9c22db7881b5a2dae6442ec32eb49e71cb6d07a8317a09126608e992d1c3aa6b"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-apple-darwin.tar.gz"
      sha256 "287b5bf1451fbf02e84d9b5b362037dcde7c8e0389a5b4baa51a88743042633e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd0697c8a6e076596f8f7a479aa933fde0b936d16eef2f441c0c2a5e8a4ef5d7"
    end

    on_intel do
      url "https://github.com/polylint/uncomment/releases/download/v#{version}/uncomment-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c667d4579eeb14a5b520e46b707c93935549a1c4ba8bf9b2fb58d95753a0040c"
    end
  end

  def install
    bin.install "uncomment"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uncomment --version")
  end
end
