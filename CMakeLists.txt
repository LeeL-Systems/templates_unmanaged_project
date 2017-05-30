cmake_minimum_required (VERSION 2.8.11)
project (project_name)

if(NOT EXISTS ${PROJECT_SOURCE_DIR}/source)
  message("[${PROJECT_NAME}] - Source directory does not exist. Skipping compilation")
  return()
endif()

# Configuration
if(NOT CMAKE_BUILD_TYPE) 
  set(CMAKE_BUILD_TYPE Debug)
  message("[${PROJECT_NAME}] - Build Type: ${CMAKE_BUILD_TYPE}")
endif(NOT CMAKE_BUILD_TYPE)

set(config_links_dir "/home/links" CACHE FILEPATH "Links directory")
message("[${PROJECT_NAME}] - Links Directory: ${config_links_dir}")

set(config_stage_dir "${PROJECT_SOURCE_DIR}/stage" CACHE FILEPATH "Stage directory.")
message("[${PROJECT_NAME}] - Stage Directory: ${config_stage_dir}")

# string(TOLOWER "${PROJECT_SOURCE_DIR}/stage/${CMAKE_PROJECT_NAME}/${CMAKE_VS_PLATFORM_TOOLSET}" var_bin_output_dir)
# set(config_bin_output_dir "${config_stage_dir}/${CMAKE_PROJECT_NAME}/${CMAKE_SYSTEM}/${CMAKE_BUILD_TYPE}" CACHE FILEPATH "Bin output directory")
set(config_bin_output_dir "${config_stage_dir}/${CMAKE_PROJECT_NAME}/${CMAKE_VS_PLATFORM_TOOLSET}" CACHE FILEPATH "Bin output directory")
message("[${PROJECT_NAME}] - Bin Output Directory: ${config_bin_output_dir}")

set(config_boost_dir "${config_links_dir}/boost" CACHE FILEPATH "Boost directory")
message("[${PROJECT_NAME}] - Boost Directory: ${config_boost_dir}")

# Definitions
add_definitions(-DBOOST_ALL_NO_LIB) # Remove boost autolink feature (E.g.: Do not link to libboost_program_options-vc110-mt-gd-1_55.lib)

# Dependencies
add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")

# Test
add_subdirectory (test)

# Project
add_executable (${PROJECT_NAME}
  ./source/main.cpp
  )

target_include_directories (${PROJECT_NAME} 
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  ${config_boost_dir}
  )

target_link_libraries(${PROJECT_NAME}
  boost_program_options
  )

message("[${PROJECT_NAME}] - Setting binary output directory to: ${config_bin_output_dir}")
set_target_properties(${PROJECT_NAME}
  PROPERTIES 
  LIBRARY_OUTPUT_DIRECTORY ${config_bin_output_dir}
  ARCHIVE_OUTPUT_DIRECTORY ${config_bin_output_dir}
  RUNTIME_OUTPUT_DIRECTORY ${config_bin_output_dir}
  OUTPUT_NAME ${PROJECT_NAME}
  )

