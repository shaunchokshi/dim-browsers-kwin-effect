#!/bin/bash

# KCM Installation Script for dim-browsers KWin effect
# This script properly installs the KCM as a KPackage plugin

echo "Installing dim-browsers KCM..."

# Check if kpackagetool6 is available
if ! command -v kpackagetool6 &> /dev/null; then
    echo "Error: kpackagetool6 not found. Please install KDE Frameworks 6."
    exit 1
fi

# Navigate to the KCM directory
cd "$(dirname "$0")/kcms/kcm_kwin4_dim_browsers" || {
    echo "Error: Could not find KCM directory"
    exit 1
}

# Install the corrected metadata.json
echo "Updating KCM metadata..."
cat > metadata.json << 'EOF'
{
    "KPackageStructure": "KCModule",
    "KPlugin": {
        "Id": "kcm_kwin4_dim_browsers",
        "Name": "Dim Browser Windows",
        "Description": "Configuration module for the Dim Browser Windows KWin effect",
        "Authors": [
            {
                "Email": "shaunchokshi-gh@pm.me",
                "Name": "Shaun Chokshi"
            }
        ],
        "Category": "Window Management",
        "Version": "3.0",
        "License": "GPL",
        "ServiceTypes": ["KCModule"]
    },
    "X-KDE-ParentComponents": ["dim_browsers"],
    "X-KDE-ParentApp": "org.kde.kwin"
}
EOF

# Remove any existing installation
echo "Removing any existing KCM installation..."
kpackagetool6 --type KCModule --remove kcm_kwin4_dim_browsers 2>/dev/null || true

# Install the KCM as a KPackage plugin
echo "Installing KCM as KPackage plugin..."
if kpackagetool6 --type KCModule --install . --packageroot ~/.local/share/kpackage/kcms/; then
    echo "KCM installed successfully!"
else
    echo "Error: Failed to install KCM"
    exit 1
fi

# Verify installation
echo "Verifying installation..."
if kcmshell6 --list | grep -q "kcm_kwin4_dim_browsers"; then
    echo "✓ KCM is properly registered and discoverable"
else
    echo "⚠ Warning: KCM may not be properly registered"
fi

echo "Installation complete!"
echo ""
echo "To test the configuration:"
echo "1. Go to System Settings > Window Management > Desktop Effects"
echo "2. Find 'Dim Browser Windows' effect"
echo "3. Click the configuration button"
echo ""
echo "If you still get errors, try restarting KDE or running:"
echo "kquitapp6 plasmashell && plasmashell &"

