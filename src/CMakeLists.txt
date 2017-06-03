
# Dependencies
list(APPEND CMAKE_PREFIX_PATH "${config_stage_dir}/${PROJECT_NAME}/build/${config_platform_name}")
find_package(boost_program_options CONFIG QUIET)
if(NOT TARGET boost_program_options)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT TARGET boost_program_options)

# Project
file(GLOB var_source_files
  *.h
  *.cpp
  )
message("[${PROJECT_NAME}] - Source Files: ${var_source_files}")
add_executable(${PROJECT_NAME} ${var_source_files})

# Definitions
# target_compile_definitions(${PROJECT_NAME} 
#   PUBLIC <definition>
#   ) 

# Includes
# target_include_directories(${PROJECT_NAME} 
#   # PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
#   PUBLIC ${config_base_dir}
#   )

target_link_libraries(${PROJECT_NAME}
  boost_program_options
  )

# Target Properties
set_target_properties(${PROJECT_NAME} PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
	COMPILE_PDB_NAME ${PROJECT_NAME}
	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
  )

# Installation
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
install(DIRECTORY ${PROJECT_BINARY_DIR}/symbols/
	DESTINATION symbols/${config_platform_name}
)
