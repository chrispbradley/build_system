#[=======================================================================[.rst:
OpenCMISS Operating systems
---------------------------

All OpenCMISS operating system functions.

#]=======================================================================]

unset(OC_IS_IOS_UNIX CACHE)
unset(OC_IS_MACOS_UNIX CACHE)
unset(OC_IS_CENTOS_LINUX CACHE)
unset(OC_IS_DEBIAN_LINUX CACHE)
unset(OC_IS_FEDORA_LINUX CACHE)
unset(OC_IS_GENTOO_LINUX CACHE)
unset(OC_IS_MANDRAKE_LINUX CACHE)
unset(OC_IS_MINT_LINUX CACHE)
unset(OC_IS_REDHAT_LINUX CACHE)
unset(OC_IS_SCIENTIFIC_LINUX CACHE)
unset(OC_IS_SLACKWARE_LINUX CACHE)
unset(OC_IS_SUSE_LINUX CACHE)
unset(OC_IS_UBUNTU_LINUX CACHE)
unset(OC_IS_UNKNOWN_LINUX CACHE)
unset(OC_IS_YELLOWDOG_LINUX CACHE)
if(WIN32)
  # Windows operating system
  set(OC_OPERATING_SYSTEM "Windows" CACHE INTERNAL "OS system name")
  OCCMakeDebug("OS is Windows." 1)
elseif(UNIX)
  OCCMakeDebug("OS is UNIX." 1)
  if(APPLE)
    # Apple operating system
    if(IOS)
      set(OC_OPERATING_SYSTEM "iOS" CACHE INTERNAL "OS system name")
      set(OC_IS_IOS_UNIX ON CACHE BOOL "OS is iOS UNIX" FORCE)
    else()
      set(OC_OPERATING_SYSTEM "macOS" CACHE INTERNAL "OS system name")
      set(OC_IS_MACOS_UNIX ON CACHE BOOL "OS is macOS UNIX" FORCE)
    endif()
    OCCMakeDebug("OS is Apple UNIX." 1)
    if(${OC_IS_IOS_UNIX})
      OCCMakeDebug("OS is iOS Apple UNIX." 1)
    elseif(${OC_IS_MACOS_UNIX})
      OCCMakeDebug("OS is macOS Apple UNIX." 1)
    else()
      OCCMakeFatalError("Unknown Apple OS.")
    endif()
  elseif(LINUX)
    # Linux operating system, determine the distro
    set(OC_OPERATING_SYSTEM "Linux" CACHE INTERNAL "OS system name")
    # See if we have a Fedora based system
    find_file(_OC_FEDORA_LINUX fedora-release PATHS /etc NO_CACHE)
    if(EXISTS ${_OC_FEDORA_LINUX})
      set(OC_LINUX_SYSTEM_NAME "Fedora" CACHE INTERNAL "Linux OS system name")
      set(OC_IS_FEDORA_LINUX ON CACHE BOOL "OS is Fedora Linux" FORCE)
    else()
      # See if we have a RedHat based system
      find_file(_OC_REDHAT_BASED redhat-release PATHS /etc NO_CACHE)
      if(EXISTS ${_OC_REDHAT_BASED})
	# RedHat based, determine type
	file(STRINGS /etc/redhat-release _OC_REDHAT_LINUX REGEX "Red Hat Enterprise")
	if(${_OC_REDHAT_LINUX})
	  set(OC_LINUX_SYSTEM_NAME "RedHat" CACHE INTERNAL "Linux OS system name")
	  set(OC_IS_REDHAT_LINUX ON CACHE BOOL "OS is Red Hat Linux" FORCE)
	else()
	  file(STRINGS /etc/redhat-release _OC_FEDORA_LINUX REGEX "Fedora")
	  if(${_OC_FEDORA_LINUX})
	    set(OC_LINUX_SYSTEM_NAME "Fedora" CACHE INTERNAL "Linux OS system name")
	    set(OC_IS_FEDORA_LINUX ON CACHE BOOL "OS is Fedora Linux" FORCE)
	  else()
	    file(STRINGS /etc/redhat-release _OC_SCIENTIFIC_LINUX REGEX "Scientific Linux")
	    if(${_OC_SCIENTIFIC_LINUX})
	      set(OC_LINUX_SYSTEM_NAME "Scientific" CACHE INTERNAL "Linux OS system name")
	      set(OC_IS_SCIENTIFIC_LINUX ON CACHE BOOL "OS is Scientific Linux" FORCE)
	    else()
	      file(STRINGS /etc/redhat-release _OC_CENTOS_LINUX REGEX "CentOS")
	      if(${_OC_CENTOS_LINUX})
		set(OC_LINUX_SYSTEM_NAME "CentOS" CACHE INTERNAL "Linux OS system name")
		set(OC_IS_CENTOS_LINUX ON CACHE BOOL "OS is CentOS Linux" FORCE)
	      else()
		set(OC_LINUX_SYSTEM_NAME "Unknown" CACHE INTERNAL "Linux OS system name")
		set(OC_IS_UNKNOWN_LINUX ON CACHE BOOL "OS is unknown Linux" FORCE)
	      endif()
	      unset(_OC_CENTOS_LINUX CACHE)
	    endif()
	    unset(_OC_SCIENTIFIC_LINUX CACHE)
	  endif()
	  unset(_OC_FEDORA_LINUX CACHE)
	endif()
	unset(_OC_REDHAT_LINUX CACHE)
      else()
	# See if we have a Ubuntu based system
	find_file(_OC_UBUNTU_BASED lsb-release PATHS /etc NO_CACHE)
	if(${_OC_UBUNTU_BASED})
	  # Ubuntu based, determine type
	  file(STRINGS /etc/lsb-release _OC_UBUNTU_LINUX REGEX "DISTRIB_ID=Ubuntu")
	  if(${_OC_UBUNTU_LINUX})
	    set(OC_LINUX_SYSTEM_NAME "Ubuntu" CACHE INTERNAL "Linux OS system name")
	    set(OC_IS_UBUNTU_LINUX ON CACHE BOOL "OS is Ubuntu Linux" FORCE)
	  else()
	    file(STRINGS /etc/lsb-release _OC_MINT_LINUX REGEX "DISTRIB_ID=LinuxMint")
	    if(${_OC_MINT_LINUX})
	      set(OC_LINUX_SYSTEM_NAME "Mint" CACHE INTERNAL "Linux OS system name")
	      set(OC_IS_MINT_LINUX ON CACHE BOOL "OS is Mint Linux" FORCE)
	    else()
	      set(OC_LINUX_SYSTEM_NAME "Unknown" CACHE INTERNAL "Linux OS system name")
	      set(OC_IS_UNKNOWN_LINUX ON CACHE BOOL "OS is unknown Linux" FORCE)
	    endif()
	    unset(_OC_MINT_LINUX CACHE)
	  endif()
	  unset(_OC_UBUNTU_LINUX CACHE)
	else()
	  # See if we have a SuSe based system
	  find_file(_OC_SUSE_LINUX SuSE-release PATHS /etc NO_CACHE)
	  if(${_OC_SUSE_LINUX})
	    set(OC_LINUX_SYSTEM_NAME "SuSE" CACHE INTERNAL "Linux OS system name")
	    set(OC_IS_SUSE_LINUX ON CACHE BOOL "OS is SuSE Linux" FORCE)
	  else()
	    # See if we have a Slackware based system
	    find_file(_OC_SLACKWARE_LINUX slackware-release PATHS /etc NO_CACHE)
	    if(${_OC_SLACKWARE_LINUX})
	      set(OC_LINUX_SYSTEM_NAME "Slackware" CACHE INTERNAL "Linux OS system name")
	      set(OC_IS_SLACKWARE_LINUX ON CACHE BOOL "OS is Slackware Linux" FORCE)
	    else()
	      # See if we have a Debian based system
	      find_file(_OC_DEBIAN_LINUX debian_release PATHS /etc NO_CACHE)
	      if(${_OC_DEBIAN_LINUX})
		set(OC_LINUX_SYSTEM_NAME "Debian" CACHE INTERNAL "Linux OS system name")
		set(OC_IS_DEBIAN_LINUX ON CACHE BOOL "OS is Debian Linux" FORCE)
	      else()
		# See if we have a Mandrake based system
		find_file(_OC_MANDRAKE_LINUX mandrake-release PATHS /etc NO_CACHE)
		if(${_OC_MANDRAKE_LINUX})
		  set(OC_LINUX_SYSTEM_NAME "Mandrake" CACHE INTERNAL "Linux OS system name")
		  set(OC_IS_MANDRAKE_LINUX ON CACHE BOOL "OS is Mandrake Linux" FORCE)
		else()
		  # See if we have a Yellow Dog based system
		  find_file(_OC_YELLOWDOG_LINUX sun-release PATHS /etc NO_CACHE)
		  if(${_OC_YELLOWDOG_LINUX})
		    set(OC_LINUX_SYSTEM_NAME "Yellow Dog" CACHE INTERNAL "Linux OS system name")
		    set(OC_IS_YELLOWDOG_LINUX ON CACHE BOOL "OS is Yellow Dog Linux" FORCE)
		  else()
		    # See if we have a Gentoo based system
		    find_file(_OC_GENTOO_LINUX gentoo-release PATHS /etc NO_CACHE)
		    if(${_OC_GENTOO_LINUX})
		      set(OC_LINUX_SYSTEM_NAME "Gentoo" CACHE INTERNAL "Linux OS system name")
		      set(OC_IS_GENTOO_LINUX ON CACHE BOOL "OS is Gentoo Linux" FORCE)
		    else()
		      set(OC_LINUX_SYSTEM_NAME "Unknown" CACHE INTERNAL "Linux OS system name")
		      set(OC_IS_UNKNOWN_LINUX ON CACHE BOOL "OS is unknown Linux" FORCE)
		    endif()
		    unset(_OC_GENTOO_LINUX CACHE)
		  endif()
		  unset(_OC_YELLOWDOG_LINUX CACHE)
		endif()
		unset(_OC_MANDRAKE_LINUX CACHE)
	      endif()
	      unset(_OC_DEBIAN_LINUX CACHE)
	    endif()
	    unset(_OC_SLACKWARE_LINUX CACHE)
	  endif()
	  unset(_OC_SUSE_LINUX CACHE)
	endif()
	unset(_OC_UBUNTU_BASED CACHE)
      endif()
    endif()
    unset(_OC_FEDORA_LINUX CACHE)
    OCCMakeDebug("OS is Linux." 1)
    if(${OC_IS_CENTOS_LINUX})
      OCCMakeDebug("OS is CentOS Linux." 1)
    elseif(${OC_IS_DEBIAN_LINUX})
      OCCMakeDebug("OS is Debian Linux." 1)
    elseif(${OC_IS_FEDORA_LINUX})
      OCCMakeDebug("OS is Fedora Linux." 1)
    elseif(${OC_IS_GENTOO_LINUX})
      OCCMakeDebug("OS is Gentoo Linux." 1)
    elseif(${OC_IS_MANDRAKE_LINUX})
      OCCMakeDebug("OS is Mandrake Linux." 1)
    elseif(${OC_IS_MINT_LINUX})
      OCCMakeDebug("OS is Mint Linux." 1)
    elseif(${OC_IS_REDHAT_LINUX})
      OCCMakeDebug("OS is Red Hat Linux." 1)
    elseif(${OC_IS_SCIENTIFIC_LINUX})
      OCCMakeDebug("OS is Scientific Linux." 1)
    elseif(${OC_IS_SLACKWARE_LINUX})
      OCCMakeDebug("OS is Slackware Linux." 1)
    elseif(${OC_IS_SUSE_LINUX})
      OCCMakeDebug("OS is SuSE Linux." 1)
    elseif(${OC_IS_UBUNTU_LINUX})
      OCCMakeDebug("OS is Ubuntu Linux." 1)
    elseif(${OC_IS_UNKNOWN_LINUX})
      OCCMakeDebug("OS is unknown Linux." 1)
    elseif(${OC_IS_YELLOWDOG_LINUX})
      OCCMakeDebug("OS is Yellow Dog Linux." 1)
    else()
      OCCMakeFatalError("Unknown Linux OS.")
    endif()
  else()
    # UNIX operating system
    set(OC_OPERATING_SYSTEM "UNIX" CACHE INTERNAL "OS system name")
    OCCMakeDebug("OS is unknown UNIX." 1)
  endif()
else()
  OCCMakeWarning("Operating system is Unknown.")
  set(OC_OPERATING_SYSTEM "Unknown" CACHE INTERNAL "OS system name")
endif()