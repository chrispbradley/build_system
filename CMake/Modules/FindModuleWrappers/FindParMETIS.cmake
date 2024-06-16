#[=======================================================================[.rst:
OpenCMISS FindParMETIS
----------------------

An OpenCMISS wrapper to find a ParMETIS implementation.

#]=======================================================================]

include(OCCMakeMiscellaneous)

set(ParMETIS_FOUND NO)

if(OpenCMISS_FIND_SYSTEM_ParMETIS)
  
  OCCMakeMessage(STATUS "Trying to find ParMETIS at the system level.")
  
  set(_ORIGINAL_CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}")
  unset(CMAKE_MODULE_PATH)

  find_package(ParMETIS)

  set(CMAKE_MODULE_PATH "${_ORIGINAL_CMAKE_MODULE_PATH}")
  unset(_ORIGINAL_CMAKE_MODULE_PATH)

endif()

if(NOT ParMETIS_FOUND)
  
  OCCMakeMessage(STATUS "Trying to find ParMETIS in the OpenCMISS build system.")
  
  find_package(ParMETIS ${ParMETIS_FIND_VERSION} CONFIG
    QUIET
    PATHS ${CMAKE_PREFIX_PATH}
    NO_CMAKE_ENVIRONMENT_PATH
    NO_SYSTEM_ENVIRONMENT_PATH
    NO_CMAKE_BUILDS_PATH
    NO_CMAKE_PACKAGE_REGISTRY
    NO_CMAKE_SYSTEM_PATH
    NO_CMAKE_SYSTEM_PACKAGE_REGISTRY
  )

  if(ParMETIS_FOUND)
    OCCMakeMessage(STATUS "Found ParMETIS (version ${ParMETIS_VERSION}) in the OpenCMISS build system.")
    if(TARGET ParMETIS::ParMETIS)
      get_property(_HAVE_MULTICONFIG_ENV GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
      if(_HAVE_MULTICONFIG_ENV)
	set(ParMETIS_LIBRARIES ${ParMETIS_LIBARAY_$<UPPER_CASE:$<CONFIG>>})
      else()
	string(TOUPPER ${CMAKE_BUILD_TYPE} _UPPER_BUILD_TYPE)
	set(ParMETIS_LIBRARIES ${ParMETIS_LIBRARY_${_UPPER_BUILD_TYPE}})
	unset(_UPPER_BUILD_TYPE)
      endif()
      unset(_HAVE_MULTICONFIG_ENV)
    endif()
  else()
    OCCMakeMessage(STATUS "Could not find ParMETIS.")
  endif()
else()
  OCCMakeMessage(STATUS "Found ParMETIS (version ${ParMETIS_VERSION}) at the system level.")
endif()

if(ParMETIS_FOUND)
  OCCMakeDebug("ParMETIS_LIBRARIES = '${ParMETIS_LIBRARIES}'." 1)    
  OCCMakeDebug("ParMETIS_INCLUDE_DIRECTORIES = '${ParMETIS_INCLUDE_DIRECTORIES}'." 1)    
endif()
