cmake_minimum_required(VERSION 3.16)

project(dim-browsers)

install(DIRECTORY contents/ DESTINATION ${KDE_INSTALL_DATADIR}/kwin/effects/dim-browsers)
install(FILES metadata.json DESTINATION ${KDE_INSTALL_DATADIR}/kwin/effects/dim-browsers)
