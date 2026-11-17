# typed: false
# frozen_string_literal: true

# Rendered from scripts/publish/skif.rb.tmpl in polylint/skif by its release workflow; do not edit by hand.
class Skif < Formula
  desc "Fast dependency linter for JavaScript and TypeScript monorepos"
  homepage "https://github.com/polylint/skif"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-aarch64-apple-darwin.tar.gz"
      sha256 "f962298e0a205e7e7c8a0a4704eccda988715bb60ccba855a8b166c9afe6bb21"
    end

    on_intel do
      url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-x86_64-apple-darwin.tar.gz"
      sha256 "7e79a577cace9e4bb2b30270a4cfb9992d6649dea081b84f55890cbc176e9773"
    end
  end

  on_linux do
    # The glibc archives need glibc 2.34 (SKIF_GLIBC_FLOOR in scripts/lib/libc.sh); older systems get the static
    # musl archives. Homebrew can evaluate Linux formulae while running on macOS.
    glibc_ok = OS.linux? && OS::Linux::Glibc.system_version >= Version.new("2.34")
    on_arm do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "c59f257fd25f01727a6844e5ceff5efc776e34f3e59389130e8a88c88694f335"
      else
        url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-aarch64-unknown-linux-musl.tar.gz"
        sha256 "30d0e8416a7b35da0757715182bffa4cc63ca4f09c397c2efedacbc22e0c39ba"
      end
    end

    on_intel do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "313da180a14c009b2b4d1ac1018b1c269625fa58d7edeeeb6995374a1fabc027"
      else
        url "https://github.com/polylint/skif/releases/download/v0.7.0/skif-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8c78a690caa10c39204642bd0f3cab117ae8d4994c3af1428ef2ce6bea2adee1"
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
