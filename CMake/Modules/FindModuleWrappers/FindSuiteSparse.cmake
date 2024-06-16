#[=======================================================================[.rst:
OpenCMISS FindSuiteSparse
-------------------------

An OpenCMISS wrapper to find a SuiteSparse implementation.

#]=======================================================================]

## SEE https://ceres-solver.googlesource.com/ceres-solver/+/master/cmake/FindSuiteSparse.cmake

## SEE https://github.com/sergiud/SuiteSparse


include(OCCMakeMiscellaneous)

set(SuiteSparse_FOUND NO)

if(OpenCMISS_FIND_SYSTEM_SUITESPARSE)
  
  OCCMakeMessage(STATUS "Trying to find SuiteSparse at the system level.")
  
  set(_ORIGINAL_CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}")
  unset(CMAKE_MODULE_PATH)

  find_package(SuiteSparse)

  set(CMAKE_MODULE_PATH "${_ORIGINAL_CMAKE_MODULE_PATH}")
  unset(_ORIGINAL_CMAKE_MODULE_PATH)

endif()

if(NOT SuiteSparse_FOUND)
  
  OCCMakeMessage(STATUS "Trying to find SuiteSparse in the OpenCMISS build system.")
    
endif()
