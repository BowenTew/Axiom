# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

Axiom is a Nix Flakes-based declarative system configuration repo for macOS (nix-darwin) and NixOS. It is **not** a traditional application — there are no servers, databases, or build artifacts to run. The core "product" is the Nix flake itself and its dev shells.

### Prerequisites

- **Nix** (>= 2.4) with `experimental-features = nix-command flakes` enabled in `/etc/nix/nix.conf`.
- The nix-daemon must be running: `sudo /nix/var/nix/profiles/default/bin/nix-daemon &`
- Ensure Nix is on PATH: `export PATH="/nix/var/nix/profiles/default/bin:$PATH"` (or source the profile script).

### Key commands

| Task | Command |
|---|---|
| Show flake outputs | `nix flake show` |
| Flake metadata | `nix flake metadata` |
| Enter default dev shell | `nix develop` |
| Enter Node 22 dev shell | `nix develop .#node22` |
| Enter Go dev shell | `nix develop .#go` |
| Enter Rust+WASM dev shell | `nix develop .#rust-wasm` |
| Update flake inputs | `nix flake update` |

See `README.md` for the full list of available dev shells and build/switch scripts.

### Gotchas

- **No lint/test/build in the traditional sense.** This repo has no ESLint, pytest, `npm test`, or CI pipelines. Validation is done via `nix flake show` (evaluates all outputs) and entering dev shells.
- **darwin/NixOS builds cannot run on plain Linux.** The `darwinConfigurations` output requires macOS, and `nixos-rebuild switch` requires NixOS. On a plain Linux VM, you can only evaluate the flake and use dev shells.
- **Corepack EACCES error in Node shells is expected.** The `shellHook` tries to run `corepack enable` which fails because the Nix store is read-only. This is harmless — `pnpm`, `yarn`, and `npm` are all still available.
- **The `%USER%`, `%EMAIL%`, `%NAME%` tokens in `.nix` files** are placeholders replaced by the `scripts/*/apply` script. Do not run `apply` in a cloud agent context as it is interactive and modifies all files in-place.
