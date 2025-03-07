#!/bin/sh

# Error on unset variables.
set -u

set -x

nix-build || exit 1
