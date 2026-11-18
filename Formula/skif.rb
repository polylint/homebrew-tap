# typed: false
# frozen_string_literal: true

# Rendered from scripts/publish/skif.rb.tmpl in polylint/skif by its release workflow; do not edit by hand.
class Skif < Formula
  desc "Fast dependency linter for JavaScript and TypeScript monorepos"
  homepage "https://github.com/polylint/skif"
  version "0.9.2"
  license "MIT"

  bottle do
    root_url "https://github.com/polylint/skif/releases/download/v0.9.2"
    sha256 cellar: :any_skip_relocation, arm64_linux: "07a02bab2e5363987a1f4af6bef340b580f1d27875d8d303c57dc24e2ce3b061"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1762fa5a90e255d6fa425de299fe6ab556f6ee61cbd783bd4b58bf7589bf82b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8483583ddcb08c6edbcaf0ec609a33dbea14a493d0f70edcc415c490a57f1c1c"
  end

  on_macos do
    on_arm do
      url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-aarch64-apple-darwin.tar.gz"
      sha256 "1eaa0f219200299e2e662492f7af523975f451a849fbc147bb78e3d8b9299502"
    end

    on_intel do
      url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-x86_64-apple-darwin.tar.gz"
      sha256 "a6627787882eb7f09c8eb9f701ec0ce61246082774d5ed4428a37b214de6bd22"
    end
  end

  on_linux do
    # The glibc archives need glibc 2.34 (SKIF_GLIBC_FLOOR in scripts/lib/libc.sh); older systems get the static
    # musl archives. Homebrew can evaluate Linux formulae while running on macOS.
    glibc_ok = OS.linux? && OS::Linux::Glibc.system_version >= Version.new("2.34")
    on_arm do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "0d3bac7d8a1b82cd78b0071904975874c1d4a586be56ac58a51c90608f403229"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-aarch64-unknown-linux-musl.tar.gz"
        sha256 "a555e5e02f4322d50ce2d1932037c95eea6f18d4701b031fcf3ebff32ba5dd23"
      end
    end

    on_intel do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5c9ddeeda4b6bb530163f79ba1b01d9a2dbcb6ed5a012a73666e1aea8646df87"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.2/skif-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4fcbdb6f6496d852181ab93670373d39fdf783d7174f90531bc14c40c38ecc1d"
      end
    end
  end

  # The Linux bottles are built on runners with a recent glibc, so they carry the glibc archive. Below the floor the
  # bottle is skipped and the formula installs the musl archive selected above.
  pour_bottle? do
    reason "The Linux bottle carries the glibc build of skif, which needs glibc 2.34 or newer."
    satisfy { !OS.linux? || OS::Linux::Glibc.system_version >= Version.new("2.34") }
  end

  def install
    bin.install "skif"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skif --version")
  end
end
