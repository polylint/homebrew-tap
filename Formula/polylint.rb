# typed: false
# frozen_string_literal: true

# Rendered from packaging/polylint.rb.tmpl in polylint/polylint by its release workflow; do not edit by hand.
class Polylint < Formula
  desc "Universal polyglot linter and formatter"
  homepage "https://github.com/polylint/polylint"
  version "0.36.0"
  license "MIT"

  # Homebrew validates the stable URL even on platforms excluded by requirements, so the macOS
  # archive stays at class scope. Intel macOS is not shipped (ADR 0046): `depends_on arch: :arm64`
  # refuses it with an accurate message. Check with `brew readall --os=all --arch=all polylint/tap`.
  url "https://github.com/polylint/polylint/releases/download/v0.36.0/poly-0.36.0-aarch64-apple-darwin.tar.gz"
  sha256 "18e1f15581740ab8d810813282b13b47d95f900eb08692826c37f4f895499f76"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/polylint/releases/download/v0.36.0/poly-0.36.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b42d27a4bc4968f4a11c9c00715f332b474b5e64828e88ac7ba0f5804d8c6f46"
    end

    on_intel do
      url "https://github.com/polylint/polylint/releases/download/v0.36.0/poly-0.36.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3db2f43ee4b545da45fb427ce57554592b043a70dc9fb991ae7e6f762cedbde3"
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
