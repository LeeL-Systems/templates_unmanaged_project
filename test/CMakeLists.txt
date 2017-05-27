cmake_minimum_required (VERSION 2.8.11)
project (project_name_test)

add_definitions (-DTESTCODE)

add_executable (project_name_test
  ./test.cpp
  )

target_include_directories (project_name_test 
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
  )

install (TARGETS project_name_test
  DESTINATION bin
  )
