# Axiom Nix Configuration Makefile

.PHONY: help format lint check build clean dev-shells

# Default target
help:
	@echo "Available targets:"
	@echo "  format      - Format all Nix files"
	@echo "  lint        - Lint all Nix files and configurations"
	@echo "  check       - Run flake check"
	@echo "  build       - Build all configurations (dry run)"
	@echo "  clean       - Clean build artifacts"
	@echo "  dev-shells  - Test all dev shells"
	@echo "  install     - Install required tools"

# Format all Nix files
format:
	@echo "Formatting Nix files..."
	@chmod +x scripts/format.sh
	@./scripts/format.sh

# Lint all Nix files and configurations
lint:
	@echo "Linting Nix files and configurations..."
	@chmod +x scripts/lint.sh
	@./scripts/lint.sh

# Run flake check
check:
	@echo "Running flake check..."
	@nix flake check --show-trace

# Build all configurations (dry run)
build:
	@echo "Building configurations (dry run)..."
	@nix build .#darwinConfigurations.moonshot.system --dry-run --show-trace
	@nix build .#nixosConfigurations.nixos.system --dry-run --show-trace || true

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf result
	@rm -rf .direnv
	@nix-collect-garbage -d || true

# Test all dev shells
dev-shells:
	@echo "Testing dev shells..."
	@nix develop .#default --command echo "Default dev shell works"
	@nix develop .#go --command echo "Go dev shell works"
	@nix develop .#rust --command echo "Rust dev shell works"
	@nix develop .#node --command echo "Node dev shell works"

# Install required tools
install:
	@echo "Installing required tools..."
	@nix-env -iA nixpkgs.nixpkgs-fmt
	@nix-env -iA nixpkgs.nix-direnv

# Pre-commit hook
pre-commit: format lint check
	@echo "Pre-commit checks completed successfully!"

# CI pipeline
ci: format lint check build dev-shells
	@echo "CI pipeline completed successfully!"
