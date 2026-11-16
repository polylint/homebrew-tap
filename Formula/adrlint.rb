# typed: false
# frozen_string_literal: true

# Rendered by xberg-io/actions/publish-homebrew-source-formulas from scripts/publish/adrlint.rb.tmpl
# in polylint/adrlint; the bottle block is merged in afterwards. Do not edit by hand.
class Adrlint < Formula
  desc "Lint and format MADR architecture decision records"
  homepage "https://github.com/polylint/adrlint"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-aarch64-apple-darwin.tar.gz"
      sha256 "062a4f6f35dc8bda147e36f3825b2049fc758f49ab688ccb5671bce063dae241"
    end

    on_intel do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-x86_64-apple-darwin.tar.gz"
      sha256 "7b522caa8cd96f419c98f099244ad01db6158f772591ca8020522b75c13163e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eaabc04c46d811e7d59db98f651a5b350ea707f8975ba067f4c1ebc513b15b7e"
    end

    on_intel do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18ed5775e0a45ae3be20d108ce82bb0309be8e340e5faddbf195ec4a9d0ca0f8"
    end
  end

  def install
    bin.install "adrlint"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/adrlint --version")
  end
end
