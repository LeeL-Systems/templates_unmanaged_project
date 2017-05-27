cmake_minimum_required (VERSION 2.8.11)
project (project_name)

# Configuration
if(NOT CMAKE_BUILD_TYPE) 
  set(CMAKE_BUILD_TYPE Debug)
  message("[${PROJECT_NAME}] - Build Type: ${CMAKE_BUILD_TYPE}")
endif(NOT CMAKE_BUILD_TYPE)

if(NOT config_third_party_dir)
  get_filename_component(var_third_party_dir "/home/links/third-party" ABSOLUTE)
  set(config_third_party_dir ${var_third_party_dir})
  message("[${PROJECT_NAME}] - Third-Party Directory: ${config_third_party_dir}")
endif(NOT config_third_party_dir)

if(NOT config_stage_dir)
  get_filename_component(var_stage_dir "${PROJECT_SOURCE_DIR}/stage" ABSOLUTE)
  set(config_stage_dir ${var_stage_dir})
  message("[${PROJECT_NAME}] - Stage Directory: ${config_stage_dir}")
endif(NOT config_stage_dir)

if(NOT config_bin_output_dir)
  # string(TOLOWER "${PROJECT_SOURCE_DIR}/stage/${CMAKE_PROJECT_NAME}/${CMAKE_VS_PLATFORM_TOOLSET}" var_bin_output_dir)
  set(config_bin_output_dir "${config_stage_dir}/${CMAKE_PROJECT_NAME}/${CMAKE_SYSTEM}/${CMAKE_BUILD_TYPE}")
  message("[${PROJECT_NAME}] - Bin Output Directory: ${config_bin_output_dir}")
endif(NOT config_bin_output_dir)

# Dependencies
add_subdirectory("${config_third_party_dir}/build/libs/boost/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")

# Test
add_subdirectory (test)

# Project
add_executable (${PROJECT_NAME}
  ./source/main.cpp
  )

target_include_directories (${PROJECT_NAME} 
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  /home/links/third-party/boost
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

