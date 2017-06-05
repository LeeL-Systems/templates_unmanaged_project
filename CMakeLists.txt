cmake_minimum_required(VERSION 3.0)
project (project_name)

# Configuration
if(WIN32)
  set(config_platform_name "Windows-${CMAKE_SYSTEM_VERSION}-${CMAKE_VS_PLATFORM_TOOLSET}" CACHE FILEPATH "Platform sub directory")
  set(config_base_dir "$ENV{HOMEPATH}/projects" CACHE FILEPATH "Links directory")
else(WIN32)
  set(config_platform_name "${CMAKE_SYSTEM}" CACHE FILEPATH "Platform sub directory")
  set(config_base_dir "$ENV{HOME}/projects" CACHE FILEPATH "Links directory")
endif(WIN32)
message("[${PROJECT_NAME}] - Platform name: ${config_platform_name}")
message("[${PROJECT_NAME}] - Base Directory: ${config_base_dir}")

set(config_stage_dir "${PROJECT_SOURCE_DIR}/stage" CACHE FILEPATH "Stage directory.")
message("[${PROJECT_NAME}] - Stage Directory: ${config_stage_dir}")

set(config_boost_dir "${config_base_dir}/boost" CACHE FILEPATH "Boost directory")
message("[${PROJECT_NAME}] - Boost Directory: ${config_boost_dir}")

set(config_environment_dir "${config_base_dir}/environment" CACHE FILEPATH "Environment directory")
message("[${PROJECT_NAME}] - Environment Directory: ${config_environment_dir}")

set(config_quality_dir "${config_base_dir}/quality" CACHE FILEPATH "Quality directory")
message("[${PROJECT_NAME}] - Quality Directory: ${config_base_dir}")

# CMAKE Default values
if(NOT CMAKE_BUILD_TYPE) 
  set(CMAKE_BUILD_TYPE RelWithDebInfo)
  message("[${PROJECT_NAME}] - Build Type (Default): ${CMAKE_BUILD_TYPE}")
endif(NOT CMAKE_BUILD_TYPE)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT FALSE)
  set(CMAKE_INSTALL_PREFIX ${config_stage_dir}/${PROJECT_NAME}/bin/${config_platform_name} CACHE PATH "Installation Directory" FORCE)
  message("[${PROJECT_NAME}] - Installation Directory (Default): ${CMAKE_INSTALL_PREFIX}")
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

if(NOT config_output_binary_dir)
  set(config_output_binary_dir ${CMAKE_CURRENT_BINARY_DIR}/${config_platform_name} CACHE PATH "Binary Output Directory")
	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${config_output_binary_dir}/lib)
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${config_output_binary_dir}/lib)
	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${config_output_binary_dir}/bin)
  set(CMAKE_PDB_OUTPUT_DIRECTORY ${config_output_binary_dir}/symbols)
  install(DIRECTORY ${config_output_binary_dir}/symbols/ DESTINATION symbols)
endif(NOT config_output_binary_dir)

# Dependencies
find_package(boost_program_options CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET boost_program_options)
  message("[${PROJECT_NAME}] - Creating boost_program_options")
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT TARGET boost_program_options)

# find_package(google_test CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
# if(NOT TARGET google_test)
#   add_subdirectory("${config_gtest_dir}/build/libs/google_test" "${CMAKE_CURRENT_BINARY_DIR}/google_test")
# endif(NOT TARGET google_test)

find_package(environment CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET environment)
  message("[${PROJECT_NAME}] - Creating environment")
  add_subdirectory("${config_environment_dir}" "${CMAKE_CURRENT_BINARY_DIR}/environment")
endif(NOT TARGET environment)

find_package(quality CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET quality)
  message("[${PROJECT_NAME}] - Creating quality")
  add_subdirectory("${config_quality_dir}" "${CMAKE_CURRENT_BINARY_DIR}/quality")
endif(NOT TARGET quality)

# Project
if(EXISTS ${PROJECT_SOURCE_DIR}/src)
  message("[${PROJECT_NAME}] - Adding sources")
  add_subdirectory(src)
endif(EXISTS ${PROJECT_SOURCE_DIR}/src)

message("[${PROJECT_NAME}] - Adding tests")
add_subdirectory (test)

