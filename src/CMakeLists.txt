

# ProjectName Library
add_library(${PROJECT_NAME} 
  ./project_name.h
  ./project_name.cpp
  )
set_target_properties(${PROJECT_NAME} PROPERTIES 
  OUTPUT_NAME_DEBUG ${PROJECT_NAME}-d
	COMPILE_PDB_NAME ${PROJECT_NAME}
	COMPILE_PDB_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/symbols"
  )
# target_compile_definitions(${PROJECT_NAME} 
#   # PUBLIC <definition>
#   ) 
target_include_directories(${PROJECT_NAME} 
  # PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC ${config_base_dir}
  PUBLIC ${config_base_dir}/gtest/googletest/include
  )
# add_dependencies(${PROJECT_NAME}
#   environment
#   )
#   add_library(other STATIC IMPORTED) 
#   set_property(TARGET other PROPERTY IMPORTED_LOCATION /path/to/libother.a) 
#   target_link_libraries(mylib other) 
target_link_libraries(${PROJECT_NAME}
  environment
  )
# export(TARGETS ${PROJECT_NAME} environment
#   FILE ${PROJECT_NAME}-build.cmake
#   )
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
