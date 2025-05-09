<<<<<<< HEAD
# Install script for directory: C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows
=======
# Install script for directory: C:/khuthon_2025real/windows
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "$<TARGET_FILE_DIR:khuthon>")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
<<<<<<< HEAD
  include("C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/flutter/cmake_install.cmake")
=======
  include("C:/khuthon_2025real/build/windows/x64/flutter/cmake_install.cmake")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
<<<<<<< HEAD
  include("C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/cmake_install.cmake")
=======
  include("C:/khuthon_2025real/build/windows/x64/runner/cmake_install.cmake")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/khuthon.exe")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Debug/khuthon.exe")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug" TYPE EXECUTABLE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/khuthon.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/khuthon.exe")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Debug" TYPE EXECUTABLE FILES "C:/khuthon_2025real/build/windows/x64/runner/Debug/khuthon.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/khuthon.exe")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile" TYPE EXECUTABLE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/khuthon.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/khuthon.exe")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile" TYPE EXECUTABLE FILES "C:/khuthon_2025real/build/windows/x64/runner/Profile/khuthon.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/khuthon.exe")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release" TYPE EXECUTABLE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/khuthon.exe")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release" TYPE EXECUTABLE FILES "C:/khuthon_2025real/build/windows/x64/runner/Release/khuthon.exe")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/data/icudtl.dat")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Debug/data/icudtl.dat")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/data" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data/icudtl.dat")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Debug/data" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/data/icudtl.dat")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data/icudtl.dat")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile/data" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/data/icudtl.dat")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/icudtl.dat")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release/data" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/icudtl.dat")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/flutter_windows.dll")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Debug/flutter_windows.dll")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/flutter_windows.dll")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Debug" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/flutter_windows.dll")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/flutter_windows.dll")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/flutter_windows.dll")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/windows/flutter/ephemeral/flutter_windows.dll")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release" TYPE FILE FILES "C:/khuthon_2025real/windows/flutter/ephemeral/flutter_windows.dll")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Debug/")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/native_assets/windows/")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Debug" TYPE DIRECTORY FILES "C:/khuthon_2025real/build/native_assets/windows/")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/native_assets/windows/")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile" TYPE DIRECTORY FILES "C:/khuthon_2025real/build/native_assets/windows/")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/native_assets/windows/")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release" TYPE DIRECTORY FILES "C:/khuthon_2025real/build/native_assets/windows/")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    
<<<<<<< HEAD
  file(REMOVE_RECURSE "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    
  file(REMOVE_RECURSE "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    
  file(REMOVE_RECURSE "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data/flutter_assets")
=======
  file(REMOVE_RECURSE "C:/khuthon_2025real/build/windows/x64/runner/Debug/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    
  file(REMOVE_RECURSE "C:/khuthon_2025real/build/windows/x64/runner/Profile/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    
  file(REMOVE_RECURSE "C:/khuthon_2025real/build/windows/x64/runner/Release/data/flutter_assets")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/data/flutter_assets")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Debug/data/flutter_assets")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Debug/data" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data/flutter_assets")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Debug/data" TYPE DIRECTORY FILES "C:/khuthon_2025real/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/data/flutter_assets")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data/flutter_assets")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile/data" TYPE DIRECTORY FILES "C:/khuthon_2025real/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/data/flutter_assets")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data" TYPE DIRECTORY FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build//flutter_assets")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release/data" TYPE DIRECTORY FILES "C:/khuthon_2025real/build//flutter_assets")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
<<<<<<< HEAD
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data/app.so")
=======
     "C:/khuthon_2025real/build/windows/x64/runner/Profile/data/app.so")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Profile/data" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/app.so")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data/app.so")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Profile/data" TYPE FILE FILES "C:/khuthon_2025real/build/windows/app.so")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "C:/khuthon_2025real/build/windows/x64/runner/Release/data/app.so")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
<<<<<<< HEAD
    file(INSTALL DESTINATION "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/runner/Release/data" TYPE FILE FILES "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/app.so")
=======
    file(INSTALL DESTINATION "C:/khuthon_2025real/build/windows/x64/runner/Release/data" TYPE FILE FILES "C:/khuthon_2025real/build/windows/app.so")
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
<<<<<<< HEAD
file(WRITE "C:/Users/dldbs/Desktop/khuthon/khuthon_2025/build/windows/x64/${CMAKE_INSTALL_MANIFEST}"
=======
file(WRITE "C:/khuthon_2025real/build/windows/x64/${CMAKE_INSTALL_MANIFEST}"
>>>>>>> 5ace4fc3a3683e59d2448af9f32dda52eae13987
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
