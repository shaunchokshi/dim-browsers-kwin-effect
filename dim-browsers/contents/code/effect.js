var TARGET_CLASSES = ["firefox", "chromium", "google-chrome", "vivaldi"];
var DARKEN_AMOUNT = 0.75; // 0 = invisible, 1 = no change

effects.windowAdded.connect(function(w) {
    updateWindow(w);
});

effects.windowClosed.connect(function(w) {
    effects.unrefWindow(w);
});

function updateWindow(w) {
    if (w && w.windowClass && TARGET_CLASSES.includes(w.windowClass.toLowerCase())) {
        w.opacity = DARKEN_AMOUNT;
        effects.refWindow(w);
    }
}
