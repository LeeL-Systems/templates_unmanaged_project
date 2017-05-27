#!/bin/bash

echo "### Compile project_name ###"

# Build configuration
config_project_name="project_name"
config_platform="linux_default"
config_flavor="default"

# Exit on any non-zero status.
trap 'exit' ERR
set -E

echo " "
echo "*** Build Configuration:" 
echo "1 - Project Name: $config_project_name"
echo "2 - Platform: $config_platform"
echo "3 - Flavor: $config_flavor"

# Get variables based on the configuration
cd "$(dirname "$0")"
bash_dir=$(pwd)

build_dir="$bash_dir/$config_project_name"
mkdir -p $build_dir
cd $build_dir
build_dir="$(pwd)/$config_platform"
mkdir -p $build_dir
cd $build_dir
build_dir="$(pwd)/$config_flavor"
mkdir -p $build_dir
cd $build_dir
echo "A - Build Directory: $build_dir"

echo " "
echo "*** Staging:" 
cmake ../../../.. 

echo " "
echo "*** Compiling:" 
# make VERBOSE=1
# make
cmake --build . --config RelWithDebInfo --clean-first


