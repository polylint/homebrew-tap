# typed: false
# frozen_string_literal: true

# Rendered from scripts/publish/skif.rb.tmpl in polylint/skif by its release workflow; do not edit by hand.
class Skif < Formula
  desc "Fast dependency linter for JavaScript and TypeScript monorepos"
  homepage "https://github.com/polylint/skif"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-aarch64-apple-darwin.tar.gz"
      sha256 "3d5e7485f8c93c5a62b347180a0e5de8a9d39adbbd04d5357761133079fddd65"
    end

    on_intel do
      url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-x86_64-apple-darwin.tar.gz"
      sha256 "eae32a5b1087c3ee740470a9df60d16d982f1de6c284e51b9b9ff0b84631992b"
    end
  end

  on_linux do
    # The glibc archives need glibc 2.34 (SKIF_GLIBC_FLOOR in scripts/lib/libc.sh); older systems get the static
    # musl archives. Homebrew can evaluate Linux formulae while running on macOS.
    glibc_ok = OS.linux? && OS::Linux::Glibc.system_version >= Version.new("2.34")
    on_arm do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "07bf7e4c2a54acbe748c32e9f329416125ee4dbbec77b98776c8747f7cee1f71"
      else
        url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-aarch64-unknown-linux-musl.tar.gz"
        sha256 "0b8666beb8b45fd7a5ccbbec55008bb8f4c1db6c5988b85090efb0653054b921"
      end
    end

    on_intel do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5e39d87b86954140952b821899196f7727f3f2e6ae9e4579799db27a36b04dff"
      else
        url "https://github.com/polylint/skif/releases/download/v0.8.0/skif-x86_64-unknown-linux-musl.tar.gz"
        sha256 "a01145a453608ca7ccf5e25b4ca12abbc6042afc3bf5f1b8e2fca0d0a19dc5e2"
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
