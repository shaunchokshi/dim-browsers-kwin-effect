#!/bin/bash

cmake -B build -S .
cmake --build build
mkdir -p ~/.local/share/kwin/effects/dim-browsers
cp -r contents metadata.json ~/.local/share/kwin/effects/dim-browsers/
