# GitHub Workflows

This directory contains GitHub Actions workflows for the Axiom Nix configuration repository.

## Workflow Overview

### 1. CI (`ci.yml`)
Main continuous integration workflow that runs on pushes to main branch or when creating PRs:

- **Configuration Check**: Validates Nix configuration syntax and flake structure
- **Build Testing**: Tests Darwin and NixOS configuration builds
- **Dev Environment Check**: Verifies all dev shells work correctly
- **Code Quality**: Checks Nix code formatting and potential issues
- **Security Scan**: Checks for unfree or insecure packages
- **Build Cache**: Uses Cachix to cache build results

### 2. PR Check (`pr-check.yml`)
Quick checks specifically for Pull Requests:

- **Quick Validation**: Checks configuration syntax and basic builds
- **Format Check**: Validates Nix code formatting
- **Dev Environment Test**: Ensures dev shells are available

### 3. Update Flake (`update-flake.yml`)
Automatically updates flake.lock file:

- **Scheduled Updates**: Weekly automatic dependency updates
- **Manual Trigger**: Supports manual triggering of updates
- **Auto PR**: Creates update PRs for review

## Usage

### Local Development
Before pushing code, it's recommended to run checks locally:

```bash
# Check flake syntax
nix flake check

# Check Darwin configuration
nix build .#darwinConfigurations.moonshot.system --dry-run

# Check dev environment
nix develop .#default

# Format code
nixpkgs-fmt .
```

### Configure Cachix Cache
To speed up builds, it's recommended to configure Cachix:

1. Add `CACHIX_AUTH_TOKEN` secret in GitHub repository settings
2. Or use public cache: `nix-community`

## Troubleshooting

### Common Issues

1. **Build Failure**: Check if there are unfree packages that need `allowUnfree = true`
2. **Format Error**: Run `nixpkgs-fmt .` to format code
3. **Dependency Issues**: Check if flake.lock is up to date

### Debugging

If workflows fail, you can:

1. Check detailed error logs
2. Reproduce the issue locally
3. Check Nix configuration syntax

## Contributing

Contributions to improve these workflows are welcome! Please ensure:

- New workflows have clear names and descriptions
- Include appropriate error handling
- Follow existing code style
