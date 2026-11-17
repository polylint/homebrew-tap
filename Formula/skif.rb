# typed: false
# frozen_string_literal: true

# Rendered from scripts/publish/skif.rb.tmpl in polylint/skif by its release workflow; do not edit by hand.
class Skif < Formula
  desc "Fast dependency linter for JavaScript and TypeScript monorepos"
  homepage "https://github.com/polylint/skif"
  version "0.9.0"
  license "MIT"

  bottle do
    root_url "https://github.com/polylint/skif/releases/download/v0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_linux: "c5d02832bed48fe2521d15ef35fec11694eab9cabe9117e2ce9dd6a77df0f56e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d3a18a6261053e11e42a0f0bba5ff825d2bbcf7d7b5e3ebc54d8e26f105eeea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "329e8b721d88a99488386205936eec8f6bee693eb241c331d428eafdd9b1e0b0"
  end

  on_macos do
    on_arm do
      url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-aarch64-apple-darwin.tar.gz"
      sha256 "4c6547903be8ba97dd51347964a4e7ea559c1bc30ecf6eff24b4580c17e8dc48"
    end

    on_intel do
      url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-x86_64-apple-darwin.tar.gz"
      sha256 "cf5f8d4a5e1c13cf11ea95609147995529514f87355648f1d51ec08548694691"
    end
  end

  on_linux do
    # The glibc archives need glibc 2.34 (SKIF_GLIBC_FLOOR in scripts/lib/libc.sh); older systems get the static
    # musl archives. Homebrew can evaluate Linux formulae while running on macOS.
    glibc_ok = OS.linux? && OS::Linux::Glibc.system_version >= Version.new("2.34")
    on_arm do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "6d9675c73427cfffe86a6e9854d6e7a58cfafd9bd4b45f89fe056bf65ce28eee"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-aarch64-unknown-linux-musl.tar.gz"
        sha256 "489b6b9fc7091ec361866c2eca2dcdb5d9ad9b1cd458b09736fe2713a09943a0"
      end
    end

    on_intel do
      if glibc_ok
        url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c99b478a1d855dd889b294dc3a5e1f9394f28893cc4d082276d780a206d1134c"
      else
        url "https://github.com/polylint/skif/releases/download/v0.9.0/skif-x86_64-unknown-linux-musl.tar.gz"
        sha256 "581b41e7bb4bab2629a82f9609c0752557b396f6b9e644724b75ac9afb74a804"
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
