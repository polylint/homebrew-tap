# Bottles

Every formula in this tap is bottled for:

| Platform             | Bottle tag     | Runner             |
| -------------------- | -------------- | ------------------ |
| macOS, Apple Silicon | `arm64_tahoe`  | `macos-26`         |
| Linux x86_64         | `x86_64_linux` | `ubuntu-latest`    |
| Linux arm64          | `arm64_linux`  | `ubuntu-24.04-arm` |

Platforms without a bottle (for example, Intel macOS) install from the prebuilt release archive that the formula
downloads, so no Rust toolchain is needed in either case.

## How bottles get here

Nobody edits a formula here by hand. Each tool's release workflow does the following:

1. It renders the formula from a template in the tool's repository with
   [`xberg-io/actions/publish-homebrew-source-formulas`](https://github.com/xberg-io/actions/tree/main/publish-homebrew-source-formulas)
   and pushes it here as `polylint-release-helper[bot]`, using a token minted from the organization GitHub App
   (`BOT_APP_ID` / `BOT_APP_PRIVATE_KEY`).
2. It builds a bottle on each runner above with `xberg-io/actions/homebrew-build-bottles` and uploads it to the
   tool's GitHub release.
3. It merges the `bottle do` block into the formula with `xberg-io/actions/homebrew-merge-bottles`.

If a bottle build fails, step 3 does not run, and the previous version's `bottle do` block stays in place with a stale
`root_url`. [`verify-bottles`](.github/workflows/verify-bottles.yml) catches this case. It runs daily and on every
formula change, and it resolves every declared bottle URL using
[`scripts/verify-bottle-urls.sh`](scripts/verify-bottle-urls.sh).

## Troubleshooting

- **brew builds from source or downloads the archive instead of a bottle.** Run `brew tap --repair polylint/tap`, then
  check that the formula's `root_url` points at the current release.
- **verify-bottles is red.** Re-run the failed bottle leg of the tool's release workflow, or cut a patch release.
