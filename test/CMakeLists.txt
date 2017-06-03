
# Dependencies
list(APPEND CMAKE_PREFIX_PATH "${config_stage_dir}/${PROJECT_NAME}/build/${config_platform_name}")
find_package(boost_program_options CONFIG QUIET)
if(NOT TARGET boost_program_options)
  add_subdirectory("${config_boost_dir}/build/libs/program_options" "${CMAKE_CURRENT_BINARY_DIR}/boost_program_options")
endif(NOT TARGET boost_program_options)

add_executable(${PROJECT_NAME}_test_fuzzy ./fuzzy_test.cpp)
target_link_libraries(${PROJECT_NAME}_test_fuzzy
  boost_program_options
  )
set_target_properties(${PROJECT_NAME}_test_fuzzy PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}_test_fuzzy-d
  )
install(TARGETS ${PROJECT_NAME}_test_fuzzy
  ARCHIVE DESTINATION bin/${config_platform_name}
  LIBRARY DESTINATION bin/${config_platform_name}
  RUNTIME DESTINATION bin/${config_platform_name}
  DESTINATION build/${config_platform_name}
  )

