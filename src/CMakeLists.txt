
# Dependencies
find_package(boost_program_options CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET boost_program_options)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT TARGET boost_program_options)

find_package(google_test CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET google_test)
  add_subdirectory("${config_gtest_dir}/build/libs/google_test" "${CMAKE_CURRENT_BINARY_DIR}/google_test")
endif(NOT TARGET google_test)

find_package(environment CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET environment)
  add_subdirectory("${config_environment_dir}" "${CMAKE_CURRENT_BINARY_DIR}/environment")
endif(NOT TARGET environment)

# ProjectName Library
add_library(${PROJECT_NAME} 
  ./project_name.h
  ./project_name.cpp
  )
# target_compile_definitions(${PROJECT_NAME} 
#   PUBLIC <definition>
#   ) 
target_include_directories(${PROJECT_NAME} 
  # PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC ${config_base_dir}
  PUBLIC ${config_base_dir}/gtest/googletest/include
  )
target_link_libraries(${PROJECT_NAME}
  environment
  )
set_target_properties(${PROJECT_NAME} PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
	COMPILE_PDB_NAME ${PROJECT_NAME}
	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
  )
install(TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}-targets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )
install(EXPORT ${PROJECT_NAME}-targets
  FILE ${PROJECT_NAME}-config.cmake
  DESTINATION build
  )
install(DIRECTORY ${PROJECT_BINARY_DIR}/symbols/
	DESTINATION symbols
)

# ProjectName Executable
add_executable(${PROJECT_NAME}_exec 
  ./main.cpp
  )
target_include_directories(${PROJECT_NAME}_exec 
  # PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC ${config_base_dir}
  )
target_link_libraries(${PROJECT_NAME}_exec
  ${PROJECT_NAME}
  boost_program_options
  )
set_target_properties(${PROJECT_NAME}_exec 
  PROPERTIES 
  OUTPUT_NAME ${PROJECT_NAME}
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
	COMPILE_PDB_NAME ${PROJECT_NAME}
	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
  )
install(TARGETS ${PROJECT_NAME}_exec
  EXPORT ${PROJECT_NAME}-targets
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )
install(DIRECTORY ${PROJECT_BINARY_DIR}/symbols/
	DESTINATION symbols
)
