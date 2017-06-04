
# Dependencies
find_package(boost_program_options CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET boost_program_options)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT TARGET boost_program_options)

find_package(environment CONFIG QUIET PATHS ${CMAKE_INSTALL_PREFIX}/build)
if(NOT TARGET environment)
  add_subdirectory("${config_environment_dir}" "${CMAKE_CURRENT_BINARY_DIR}/environment")
endif(NOT TARGET environment)

# Fuzzy Test
add_executable(${PROJECT_NAME}_test_fuzzy ./fuzzy_test.cpp)
target_link_libraries(${PROJECT_NAME}_test_fuzzy
  boost_program_options
  )
set_target_properties(${PROJECT_NAME}_test_fuzzy PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}_test_fuzzy-d
	COMPILE_PDB_NAME ${PROJECT_NAME}
	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
  )
install(TARGETS ${PROJECT_NAME}_test_fuzzy
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )
install(DIRECTORY ${PROJECT_BINARY_DIR}/symbols/
	DESTINATION symbols
)

# # Test
# add_executable(${PROJECT_NAME}_test ./test.cpp)
# # target_include_directories(${PROJECT_NAME}_test
# #   PUBLIC ${config_base_dir}
# #   # PUBLIC ${config_base_dir}/gtest/googletest/include
# #   )
# target_link_libraries(${PROJECT_NAME}_test
#   environment
#   project_name
#   # INTERFACE ${CMAKE_BINARY_DIR}/lib/libgtest_main.a 
#   # INTERFACE ${CMAKE_BINARY_DIR}/lib/libgtest.a 
#   ${CMAKE_BINARY_DIR}/lib/libgtest_main.a 
#   ${CMAKE_BINARY_DIR}/lib/libgtest.a 
#   )
# set_target_properties(${PROJECT_NAME}_test PROPERTIES 
#   OUTPUT_NAME_DEBUG ${PROJECT_NAME}_test-d
# 	COMPILE_PDB_NAME ${PROJECT_NAME}
# 	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
#   )
# install(TARGETS ${PROJECT_NAME}_test
#   ARCHIVE DESTINATION lib
#   LIBRARY DESTINATION lib
#   RUNTIME DESTINATION bin
#   )
# install(DIRECTORY ${PROJECT_BINARY_DIR}/symbols/
# 	DESTINATION symbols
# )
