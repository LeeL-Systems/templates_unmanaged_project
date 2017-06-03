cmake_minimum_required(VERSION 3.0)
project (project_name_test)

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

# Dependencies
list(APPEND CMAKE_PREFIX_PATH "${config_stage_dir}/${PROJECT_NAME}/build/${config_platform_name}")
find_package(boost_program_options CONFIG)
if(NOT boost_program_options_FOUND)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT boost_program_options_FOUND)

# Fuzzy Test Project
add_executable(${PROJECT_NAME}_fuzzy ./fuzzy_test.cpp)
target_link_libraries(${PROJECT_NAME}_fuzzy
  boost_program_options
  )
set_target_properties(${PROJECT_NAME}_fuzzy PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
  )

# Installation
set(CMAKE_INSTALL_PREFIX ${config_stage_dir}/${PROJECT_NAME})
install(TARGETS ${PROJECT_NAME}_fuzzy
  EXPORT ${PROJECT_NAME}-targets
  ARCHIVE DESTINATION bin/${config_platform_name}
  LIBRARY DESTINATION bin/${config_platform_name}
  RUNTIME DESTINATION bin/${config_platform_name}
  )

install(EXPORT ${PROJECT_NAME}-targets
  FILE ${PROJECT_NAME}-config.cmake
  DESTINATION build/${config_platform_name}
  )

