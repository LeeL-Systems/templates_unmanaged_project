cmake_minimum_required(VERSION 3.0)
project (project_name)

# Configuration
if(NOT CMAKE_BUILD_TYPE) 
  set(CMAKE_BUILD_TYPE Debug)
  message("[${PROJECT_NAME}] - Build Type: ${CMAKE_BUILD_TYPE}")
endif(NOT CMAKE_BUILD_TYPE)

set(config_base_dir "$ENV{HOME}/projects" CACHE FILEPATH "Links directory")
message("[${PROJECT_NAME}] - Links Directory: ${config_base_dir}")

set(config_stage_dir "${PROJECT_SOURCE_DIR}/stage" CACHE FILEPATH "Stage directory.")
# set(config_stage_dir "${config_base_dir}/stage" CACHE FILEPATH "Stage directory.")
message("[${PROJECT_NAME}] - Stage Directory: ${config_stage_dir}")

set(config_installation_dir "${config_stage_dir}/${CMAKE_PROJECT_NAME}/${CMAKE_SYSTEM}/${CMAKE_BUILD_TYPE}" CACHE FILEPATH "Installation directory")
message("[${PROJECT_NAME}] - Installation Directory: ${config_installation_dir}")

if(WIN32)
  set(config_platform_name "${CMAKE_VS_PLATFORM_TOOLSET}" CACHE FILEPATH "Platform sub directory")
else(WIN32)
  set(config_platform_name "${CMAKE_SYSTEM}" CACHE FILEPATH "Platform sub directory")
  # set(config_platform_name "${CMAKE_SYSTEM}/${CMAKE_BUILD_TYPE}" CACHE FILEPATH "Platform sub directory")
endif(WIN32)
message("[${PROJECT_NAME}] - Platform sub-directory: ${config_platform_name}")

set(config_boost_dir "${config_base_dir}/boost" CACHE FILEPATH "Boost directory")
message("[${PROJECT_NAME}] - Boost Directory: ${config_boost_dir}")

# Source Files
file(GLOB var_source_files
  ./source/*.h
  ./source/*.cpp
  )
message("[${PROJECT_NAME}] - Source Files: ${var_source_files}")

# Dependencies
list(APPEND CMAKE_PREFIX_PATH "${config_stage_dir}/${PROJECT_NAME}/build/${config_platform_name}")
find_package(boost_program_options CONFIG)
if(NOT boost_program_options_FOUND)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT boost_program_options_FOUND)

# Project
add_executable(${PROJECT_NAME} ${var_source_files})

# Definitions
# target_compile_definitions(${PROJECT_NAME} 
#   PUBLIC <definition>
#   ) 

# target_include_directories(${PROJECT_NAME} 
#   PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
#   ${config_boost_dir}
#   )

target_link_libraries(${PROJECT_NAME}
  boost_program_options
  )

# Target Properties
set_target_properties(${PROJECT_NAME} PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
  )

# Test
add_subdirectory (test)

# Installation
set(CMAKE_INSTALL_PREFIX ${config_stage_dir}/${PROJECT_NAME})
install(TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}-targets
  ARCHIVE DESTINATION bin/${config_platform_name}
  LIBRARY DESTINATION bin/${config_platform_name}
  RUNTIME DESTINATION bin/${config_platform_name}
  )

install(EXPORT ${PROJECT_NAME}-targets
  FILE ${PROJECT_NAME}-config.cmake
  DESTINATION build/${config_platform_name}
  )

