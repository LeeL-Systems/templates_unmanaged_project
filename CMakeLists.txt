cmake_minimum_required(VERSION 3.0)
project (project_name)

# Configuration
if(WIN32)
  set(config_platform_name "${CMAKE_VS_PLATFORM_TOOLSET}" CACHE FILEPATH "Platform sub directory")
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

# CMAKE Default values
if(NOT CMAKE_BUILD_TYPE) 
  set(CMAKE_BUILD_TYPE Debug)
  message("[${PROJECT_NAME}] - Build Type (Default): ${CMAKE_BUILD_TYPE}")
endif(NOT CMAKE_BUILD_TYPE)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${config_stage_dir}/${PROJECT_NAME} CACHE PATH "Installation Directory" FORCE)
  message("[${PROJECT_NAME}] - Installation Directory (Default): ${CMAKE_INSTALL_PREFIX}")
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

add_subdirectory(src)

# Test
# add_subdirectory (test)

