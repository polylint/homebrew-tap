# typed: false
# frozen_string_literal: true

# Rendered from scripts/publish/skif.rb.tmpl in polylint/skif by its release workflow; do not edit by hand.
class Skif < Formula
  desc "Fast dependency linter for JavaScript and TypeScript monorepos"
  homepage "https://github.com/polylint/skif"
  version "0.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-aarch64-apple-darwin.tar.gz"
      sha256 "44cbcb92a309173a771c31f383939af058f43e9fe890531a8f0663d694f37f8f"
    end

    on_intel do
      url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-x86_64-apple-darwin.tar.gz"
      sha256 "3478c8e8439646cfb1bda8225ab90c48499135cecd6b9711ee3e29b45e31e780"
    end
  end

  on_linux do
    # The glibc archives need glibc 2.34 (SKIF_GLIBC_FLOOR in scripts/lib/libc.sh); older systems get the static
    # musl archives. Homebrew can evaluate Linux formulae while running on macOS.
    glibc_ok = OS.linux? && OS::Linux::Glibc.system_version >= Version.new("2.34")
    on_arm do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "6c822cdc0ae5520775febd13eecf7077816d6eab2f5fa42210c79e72abe6c12b"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-aarch64-unknown-linux-musl.tar.gz"
        sha256 "472a5d53d9f7f525e6660f5463c7056b77da38ecdd62698601813045e3c990f1"
      end
    end

    on_intel do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2321c3594a9c3f0fca6e04015f52fd73b8a5d94a2fc7b29f45c7fa96ba592992"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.1/skif-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2bc944d76c9c39ff2218195b11c49b3781b0d0ae989c12bb58e8ba7ed2c6365c"
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
