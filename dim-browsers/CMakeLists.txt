cmake_minimum_required(VERSION 3.16)

project(dim-browsers)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDEFrameworkCompilerSettings)

install(DIRECTORY contents/ DESTINATION ${KDE_INSTALL_DATADIR}/kwin/effects/dim-browsers)
install(FILES metadata.json DESTINATION ${KDE_INSTALL_DATADIR}/kwin/effects/dim-browsers)
