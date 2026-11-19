# typed: false
# frozen_string_literal: true

# Rendered from packaging/polylint.rb.tmpl in polylint/polylint by its release workflow; do not edit by hand.
class Polylint < Formula
  desc "Universal polyglot linter and formatter"
  homepage "https://github.com/polylint/polylint"
  version "0.36.1"
  license "MIT"

  # Homebrew validates the stable URL even on platforms excluded by requirements, so the macOS
  # archive stays at class scope. Intel macOS is not shipped (ADR 0046): `depends_on arch: :arm64`
  # refuses it with an accurate message. Check with `brew readall --os=all --arch=all polylint/tap`.
  url "https://github.com/polylint/polylint/releases/download/v0.36.1/poly-0.36.1-aarch64-apple-darwin.tar.gz"
  sha256 "f79ef96f69ca3c3a9e0f9c1543d5278ec138648fda6032e19c5d5ebeb5b8f757"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/polylint/releases/download/v0.36.1/poly-0.36.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8b46f5aa309f4b8806c325931ed8d4ecc5fb34caf12f7107ab7726727fef4006"
    end

    on_intel do
      url "https://github.com/polylint/polylint/releases/download/v0.36.1/poly-0.36.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f473e2db1d1a26587d92a87e27114bddda914aa7d2c281f00fec93ebe2f0d0ad"
    end
  end

  def install
    bin.install("poly")
    # polylint is an alias for the same executable, not a second binary. The
    # tool is published as polylint on PyPI and @polylint/polylint on npm (the
    # unscoped poly name is taken on both registries), so someone who installed
    # it under that name will reasonably type polylint.
    bin.install_symlink(bin / "poly" => "polylint")
  end

  test do
    # Assert the whole version line, not just the number: the bare version
    # substring matched even when the build id was missing, which is how an
    # unknown-channel build once shipped unnoticed. The release archives are
    # stamped with POLY_BUILD_ID by publish.yaml.
    assert_match(
      "poly #{version} (release build v#{version}, release)",
      shell_output("#{bin}/poly --version")
    )
    # The alias is part of the shipped surface, so prove it resolves to the same
    # binary rather than trusting install_symlink to have run.
    assert_match(
      "poly #{version} (release build v#{version}, release)",
      shell_output("#{bin}/polylint --version")
    )
  end
end
