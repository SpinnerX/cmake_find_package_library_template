# These are going to let cmake know that when we configure this project
# We are going to tell CMake, that here are our configuration cmake files for the library.
set(
  LIBRARY_MODULE_FILES
  ${PROJECT_NAME}FindPackageConfig.cmake
)

## find relative path to make package relocatable
# this is a bit involved to handle these cases:
#   - CMAKE_INSTALL_LIBDIR is overridden by the user
#   - CMAKE_INSTALL_LIBDIR contains multiple levels for Debian multiarch support
if (IS_ABSOLUTE "${CMAKE_INSTALL_PREFIX}")
  set(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
else()
  get_filename_component(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
endif()


### Setting headers and .cpp files
message(STATUS "TestLib is installed with the default  prefix ---> \"${CMAKE_INSTALL_PREFIX}\"")
message(STATUS "TestLib is cmakes current list dir with the default  prefix ---> \"${CMAKE_CURRENT_LIST_DIR}\"")
message(STATUS "TestLib is cmakes current list dir with the default  prefix ---> \"${CMAKE_CURRENT_SOURCE_DIR}\"")

set(
    TEST_LIB_CURRENT_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}/include
)

set(
    TEST_LIB_INCLUDES_DIR
    ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/include
    ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/include/${PROJECT_NAME}
)

include_directories(
    ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/include
    ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/include/${PROJECT_NAME}
)

message(STATUS "TestLib TEST_LIB_INCLUDES_DIR ---> \"${TEST_LIB_INCLUDES_DIR}\"")
set(
    TEST_LIB_SRC_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}/src/${PROJECT_NAME}
) # /usr/local/include/<ProjectName>/src/<ProjectName>


set(
    TEST_LIB_SRC
    ${TEST_LIB_SRC_DIR}/Core/Core.cpp
)

# target_include_directories(
#     ${PROJECT_NAME}
#     ${TEST_LIB_INCLUDES_DIR}
#     ${TEST_LIB_INCLUDES_DIR}/${PROJECT_NAME}
# )
