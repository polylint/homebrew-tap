# typed: false
# frozen_string_literal: true

# Rendered by xberg-io/actions/publish-homebrew-source-formulas from scripts/publish/adrlint.rb.tmpl
# in polylint/adrlint; the bottle block is merged in afterwards. Do not edit by hand.
class Adrlint < Formula
  desc "Lint and format MADR architecture decision records"
  homepage "https://github.com/polylint/adrlint"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-aarch64-apple-darwin.tar.gz"
      sha256 "7e60c3cee2da5b41347ff94a43c4c97ec3327043005d7a84fcfdfe2da17a26a8"
    end

    on_intel do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-x86_64-apple-darwin.tar.gz"
      sha256 "9c3b2fbf146a3b8109124c2fda22c556804b7ae34fed48539e6a3912c5501edb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "599aa4b4e15e8ce2e47caf216d498ee8cf1543f4c20f57121fd17989ca6feab9"
    end

    on_intel do
      url "https://github.com/polylint/adrlint/releases/download/v#{version}/adrlint-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "510699c777864e4dc33e9f4311a339432788033e8804869ba1b5493d570dd9d9"
    end
  end

  def install
    bin.install "adrlint"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/adrlint --version")
  end
end
