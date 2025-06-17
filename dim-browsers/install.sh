#!/bin/bash

# Install the effect scripts and configuration files
install -D -m 644 kcms/kcm_kwin4_dim_browsers/main.xml ~/.local/share/kwin/effects/dim-browsers/kcms/kcm_kwin4_dim_browsers/main.xml
install -D -m 644 kcms/kcm_kwin4_dim_browsers/* ~/.local/share/kwin/effects/kwin/effects/configs/kcm_kwin4_dim_browsers/
cp -r contents/ ~/.local/share/kwin/effects/dim-browsers/contents/

# Install metadata for the effect
install -D -m 644 metadata.json ~/.local/share/kwin/effects/dim-browsers/metadata.json
qdbus org.kde.KWin /KWin reconfigure