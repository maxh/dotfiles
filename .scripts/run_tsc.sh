#!/bin/sh

# This script runs the TypeScript compiler. Useful if you need to pass
# an executable path to a tool to run tsc yet want to use the memory
# flags configured in our package.json file.
#
# For example for
# https://github.com/dmmulroy/tsc.nvim
#
# Set this in your configuration:
#	bin_path = vim.fn.findfile("scripts/run_tsc.sh"),

yarn tsc
