#!/usr/bin/env bash

# Nix Lint Script
# This script lints all Nix files in the repository

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are available
check_tools() {
    local missing_tools=()
    
    if ! command -v nix &> /dev/null; then
        missing_tools+=("nix")
    fi
    
    if ! command -v nixpkgs-fmt &> /dev/null; then
        missing_tools+=("nixpkgs-fmt")
    fi
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_status "Installing missing tools..."
        nix-env -iA nixpkgs.nixpkgs-fmt
    fi
}

# Lint flake configuration
lint_flake() {
    print_status "Linting flake configuration..."
    
    if nix flake check --show-trace; then
        print_success "Flake configuration is valid"
    else
        print_error "Flake configuration has errors"
        return 1
    fi
}

# Check Nix file formatting
check_formatting() {
    print_status "Checking Nix file formatting..."
    
    # Find all .nix files excluding .git and result directories
    local nix_files
    nix_files=$(find . -name "*.nix" -not -path "./.git/*" -not -path "./result/*" -not -path "./.direnv/*")
    
    if [ -z "$nix_files" ]; then
        print_warning "No Nix files found to check"
        return 0
    fi
    
    local unformatted_files=()
    local total_count=0
    
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            total_count=$((total_count + 1))
            if ! nixpkgs-fmt --check "$file" &> /dev/null; then
                unformatted_files+=("$file")
            fi
        fi
    done <<< "$nix_files"
    
    if [ ${#unformatted_files[@]} -eq 0 ]; then
        print_success "All $total_count Nix files are properly formatted"
    else
        print_error "Found ${#unformatted_files[@]} unformatted files:"
        for file in "${unformatted_files[@]}"; do
            print_error "  - $file"
        done
        print_status "Run './scripts/format.sh' to fix formatting issues"
        return 1
    fi
}

# Check for common Nix issues
check_common_issues() {
    print_status "Checking for common Nix issues..."
    
    local issues_found=0
    
    # Check for unfree packages without allowUnfree
    if grep -r "unfree" . --include="*.nix" | grep -v "allowUnfree" | grep -v "unfreeRedistributable" &> /dev/null; then
        print_warning "Found potential unfree packages without allowUnfree configuration"
        issues_found=$((issues_found + 1))
    fi
    
    # Check for deprecated functions
    if grep -r "stdenv\.mkDerivation" . --include="*.nix" &> /dev/null; then
        print_warning "Found deprecated stdenv.mkDerivation usage"
        issues_found=$((issues_found + 1))
    fi
    
    # Check for missing descriptions
    if grep -r "mkDerivation" . --include="*.nix" | grep -v "description" &> /dev/null; then
        print_warning "Found derivations without descriptions"
        issues_found=$((issues_found + 1))
    fi
    
    if [ $issues_found -eq 0 ]; then
        print_success "No common issues found"
    else
        print_warning "Found $issues_found potential issues"
    fi
}

# Check build configurations
check_builds() {
    print_status "Checking build configurations..."
    
    # Check Darwin configuration
    if nix build .#darwinConfigurations.moonshot.system --dry-run --show-trace &> /dev/null; then
        print_success "Darwin configuration builds successfully"
    else
        print_error "Darwin configuration has build errors"
        return 1
    fi
    
    # Check dev shells
    local dev_shells=("default" "go" "rust" "node")
    for shell in "${dev_shells[@]}"; do
        if nix develop .#"$shell" --command echo "Dev shell $shell works" &> /dev/null; then
            print_success "Dev shell '$shell' works correctly"
        else
            print_warning "Dev shell '$shell' may have issues"
        fi
    done
}

# Main function
main() {
    print_status "Starting Nix linting..."
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        exit 1
    fi
    
    # Check tools
    check_tools
    
    local exit_code=0
    
    # Run lint checks
    lint_flake || exit_code=1
    check_formatting || exit_code=1
    check_common_issues || exit_code=1
    check_builds || exit_code=1
    
    if [ $exit_code -eq 0 ]; then
        print_success "All lint checks passed!"
    else
        print_error "Some lint checks failed"
    fi
    
    exit $exit_code
}

# Run main function
main "$@"
