#.rst:
# FindGitRepo
# -------
#
# The module defines the following variables:
#
# ::
#
#    GITREPO_FOUND - true if the command line client was found
#    GITREPO_BRANCH - the current branch of the Git Repository
#    GITREPO_HASH - the current hash of the Git Repository
#    GITREPO_LAST_COMMIT_MESSAGE - Commit message of the last commit
#
# Example usage:
#
# ::
#
#    find_package(GitRepo)
#    if(GITREPO_FOUND)
#      message("git repo found: ${GITREPO_BRANCH}")
#    endif()

#=============================================================================
# Copyright 2015 Kitware, Inc.
# Copyright 2015 Steven Ceuppens <steven.ceuppens@icloud.com>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

find_package(Git)

if(GIT_FOUND)

  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
                  OUTPUT_VARIABLE GITREPO_BRANCH
                  ERROR_QUIET
                  OUTPUT_STRIP_TRAILING_WHITESPACE)

  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
                  OUTPUT_VARIABLE GITREPO_HASH
                  ERROR_QUIET
                  OUTPUT_STRIP_TRAILING_WHITESPACE)

  execute_process(COMMAND ${GIT_EXECUTABLE} log -1 --pretty=%B
                  OUTPUT_VARIABLE GITREPO_LAST_COMMIT_MESSAGE
                  ERROR_QUIET
                  OUTPUT_STRIP_TRAILING_WHITESPACE)

  set(GITREPO_VERSION_STRING "${GITREPO_BRANCH} - ${GITREPO_HASH}")

else(GIT_FOUND)

  message(STATUS "Cannot discover Git Repositories as Git executable is not found")

endif(GIT_FOUND)

# Handle the QUIETLY and REQUIRED arguments and set GIT_FOUND to TRUE if
# all listed variables are TRUE

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GitRepo REQUIRED_VARS GITREPO_VERSION_STRING GITREPO_BRANCH GITREPO_HASH GITREPO_LAST_COMMIT_MESSAGE)
