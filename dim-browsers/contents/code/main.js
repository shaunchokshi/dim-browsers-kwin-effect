// Fixed main.js for dim-browsers KWin effect
// This version addresses the configuration issues identified in the analysis

//var TARGET_CLASSES = ["firefox", "chromium", "google-chrome"];
var TARGET_CLASSES = parseTargetClasses(effect.configuration.TargetClasses);
var SHADER_PATH = "shaders/darken.frag";
var DARKEN_FACTOR = effect.configuration.darkenFactor;
var shader;
var darkenedWindows = new Set();

function parseTargetClasses(configValue) {
    try {
        var classes = JSON.parse(configValue);
        if (Array.isArray(classes)) {
            return classes;
        } else {
            console.warn("TargetClasses is not an array, using default");
            return ["firefox", "chromium", "google-chrome", "vivaldi"];
        }
    } catch (e) {
        console.error("Failed to parse TargetClasses:", e);
        return ["firefox", "chromium", "google-chrome", "vivaldi"];
    }
}

function isTargetWindow(w) {
    return w && w.windowClass && TARGET_CLASSES.includes(w.windowClass.toLowerCase());
}

function applyDarken(w) {
    if (!shader) {
        shader = effect.createShaderFromFile(Effect.PaintRole, SHADER_PATH);
        shader.setUniform("darkenFactor", DARKEN_FACTOR);
    }
    
    darkenedWindows.add(w);
    effect.addRepaint(w);
}

function clearWindow(w) {
    darkenedWindows.delete(w);
    effect.addRepaint(w);
}

// Configuration change handler for real-time updates
effect.configChanged.connect(function() {
    // Update target classes from configuration
    TARGET_CLASSES = parseTargetClasses(effect.configuration.TargetClasses);
    
    // Update darken factor from configuration
    DARKEN_FACTOR = effect.configuration.darkenFactor;
    
    // Update shader uniform with new darken factor
    if (shader) {
        shader.setUniform("darkenFactor", DARKEN_FACTOR);
    }
    
    // Re-evaluate all windows with new settings
    var windows = workspace.windowList();
    for (var i = 0; i < windows.length; i++) {
        var w = windows[i];
        if (isTargetWindow(w)) {
            if (!darkenedWindows.has(w)) {
                applyDarken(w);
            }
        } else {
            if (darkenedWindows.has(w)) {
                clearWindow(w);
            }
        }
    }
    
    // Trigger effect refresh to apply new settings immediately
    effect.addRepaint();
});

effects.windowAdded.connect(function(w) {
    if (isTargetWindow(w)) {
        applyDarken(w);
    }
});

effects.windowClosed.connect(function(w) {
    clearWindow(w);
});

effects.paintWindow.connect(function(w, mask, region, data) {
    if (darkenedWindows.has(w)) {
        shader.bind();
        shader.setUniform(shader, "darkenFactor", DARKEN_FACTOR);
        effect.paintWindowWithShader(w, mask, region, shader);
        shader.unbind();
    } else {
        effect.paintWindow(w, mask, region);
    }
});

