#!/usr/bin/env bash

set -eu

source "bash-lambda.sh"

echo 'a' | lambda a : lambda b : echo '$a'
