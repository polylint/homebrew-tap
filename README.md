# polylint/homebrew-tap

[Homebrew](https://brew.sh) formulae for the [polylint](https://github.com/polylint) tools, for macOS and Linux.

```sh
brew tap polylint/tap
brew install polylint/tap/<formula>
```

| Formula                                            | Commands           | Description                                                                   |
| -------------------------------------------------- | ------------------ | ----------------------------------------------------------------------------- |
| [polylint](https://github.com/polylint/polylint)   | `poly`, `polylint` | One linter and formatter for every language in a repository                   |
| [skif](https://github.com/polylint/skif)           | `skif`             | Dependency and package-manager linter for JavaScript and TypeScript monorepos |
| [adrlint](https://github.com/polylint/adrlint)     | `adrlint`          | Linter and formatter for MADR architecture decision records                   |
| [uncomment](https://github.com/polylint/uncomment) | `uncomment`        | AST-accurate comment removal and linting for 300+ languages                   |

`poly` is an alias of `polylint`, so `brew install polylint/tap/poly` also works. Every formula is bottled for macOS 15+
arm64 and Linux x86_64/arm64; see [BOTTLES.md](BOTTLES.md).

## How formulae are updated

Each project's release workflow renders its own formula with
[`xberg-io/actions/publish-homebrew-source-formulas`](https://github.com/xberg-io/actions/tree/main/publish-homebrew-source-formulas)
and pushes it here through the organization's GitHub App. Do not edit a formula by hand. Change the template in the
project's repository instead, then cut a release.
