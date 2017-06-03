
echo off
echo "### Compile project_name ###"

rem Build configuration
set config_project_name=project_name
set config_platform=windows_default
set config_flavor=default

echo " "
echo "*** Build Configuration:" 
echo "1 - Project Name: %config_project_name%"
echo "2 - Platform: %config_platform%"
echo "3 - Flavor: %config_flavor%"

rem Get variables based on the configuration
set bash_dir=%~dp0
echo "Running from: %bash_dir%"

set build_dir=%bash_dir%%config_project_name%
if not exist "%build_dir%" mkdir %build_dir%
cd "%build_dir%"
set build_dir=%build_dir%\%config_platform%
if not exist "%build_dir%" mkdir %build_dir%
cd "%build_dir%"
set build_dir=%build_dir%\%config_flavor%
if not exist "%build_dir%" mkdir %build_dir%
cd "%build_dir%"
echo "A - Build Directory: %build_dir%"

echo " "
echo "*** Staging:" 
cmake ../../../.. 
rem cmake -DCMAKE_SYSTEM_VERSION=8.1 -G "Visual Studio 12 2013" -T v120 ../../../.. 

echo " "
echo "*** Compiling:" 
cmake --build . --config RelWithDebInfo --clean-first --target install
cmake --build . --config Debug --clean-first --target install

cd ../../.. 

