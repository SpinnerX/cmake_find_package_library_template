cmake_minimum_required(VERSION 3.15)

if(MSVC)
  cmake_minimum_required(VERSION 3.10.0) # needed for CMAKE_CXX_STANDARD 17 on >=VS2017.3
endif()

# Seeing our default file path, because this is where our files and cmake modules are going to be located
# They will be put into a cmake or include/<libraryName> directory.
set(PROJECT_NAME LibraryTest)
set(CMAKE_CXX_FLAGS "-Wno-dev")
set(CMAKE_CXX_FLAGS "-fno-exceptions")
set(CMAKE_CXX_FLAGS "-std=c++20")
project(${PROJECT_NAME})
include(cmake/TestLibConfig.cmake)
set(CMAKE_FIND_PACKAGE_PREFER_CONFIG true)

# ${CMAKE_INSTALL_PREFIX} gets set when we are start building and not rebuilding the entire project
message(STATUS "TestLib include path #1 is ---> \"${TEST_LIB_CURRENT_DIR}\"")
message(STATUS "TestLib include path #2 is ---> \"${TEST_LIB_CURRENT_DIR}/TestLib\"")
message(STATUS "TestLib include path #3 is ---> \"${TEST_LIB_CURRENT_DIR}/TestLib/Core\"")

include_directories(
    ${TEST_LIB_CURRENT_DIR}
    ${TEST_LIB_CURRENT_DIR}/TestLib
    ${TEST_LIB_CURRENT_DIR}/TestLib/Core
)

# add_library(${PROJECT_NAME} INTERFACE)
# add_library(FormatCpp ALIAS ${PROJECT_NAME})
add_library(${PROJECT_NAME} SHARED ${TEST_LIB_SRC})
add_library(Lib::Lib ALIAS ${PROJECT_NAME}) # Allows to alias the library

set_property(TARGET ${PROJECT_NAME} PROPERTY INTERPROCEDURAL_OPTIMIZATION True)

# target_include_directories(${PROJECT_NAME} INTERFACE
#   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/TestLib/include>
#   $<INSTALL_INTERFACE:TestLib/include>
# )

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(EXPORT ${PROJECT_NAME}-targets
    FILE ${PROJECT_NAME}-config.cmake
    DESTINATION cmake
)

# We need this to tell cmake what files/dependencies that we want to install to our default system filepath
# When we do: sudo make install
# Which our default path is prob going to be: /usr/local/include
# Here is something to NOTE
# When we install and specify the FILE or DIRECTORY, we are basically saying that those files or directories
# are going to be installed to the default path
# To see the default pathh type ccmake ., to see what the CMAKE_INSTALL_PREFIX is.
# install(DIRECTORY include/formatCpp/core DESTINATION include/formatCpp) # Basically we are installing directory core to include/formatCpp when we install it
install(DIRECTORY TestLib DESTINATION include) # Basically we are installing directory core to include/formatCpp when we install it
# install(FILES ${HEADERS} DESTINATION include/formatCpp) # Installing the header files into include/formatCpp