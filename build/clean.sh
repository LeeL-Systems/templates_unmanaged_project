#!/bin/bash

echo "### Clean project_name ###"

# Exit on any non-zero status.
trap 'exit' ERR
set -E

# Get variables based on the configuration
cd "$(dirname "$0")"
bash_dir=$(pwd)

echo " "
echo "*** Cleanning:" 
rm -r ./project_name
rm -r ../stage
