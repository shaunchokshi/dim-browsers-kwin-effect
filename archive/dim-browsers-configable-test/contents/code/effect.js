var TARGET_CLASSES = ["firefox", "chromium", "google-chrome", "vivaldi"];
var SHADER_PATH = "shaders/darken.frag";
var config = Config.General;
var DARKEN_FACTOR = config.darkenFactor || 0.5;
var shader;
var darkenedWindows = new Set();

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
        effect.setUniform(shader, "darkenFactor", DARKEN_FACTOR);
        effect.paintWindowWithShader(w, mask, region, shader);
        shader.unbind();
    } else {
        effect.paintWindow(w, mask, region);
    }
});
