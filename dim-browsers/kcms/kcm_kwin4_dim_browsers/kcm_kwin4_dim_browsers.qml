import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kcm 2.0

KConfigItem {
    id: darkenFactor
    configName: "darkenFactor"
    label: "Darkening Level"
    type: double
    defaultValue: 0.5
    minValue: 0.0
    maxValue: 1.0
    stepSize: 0.01
    tooltip: "Set the amount of darkening for browser windows (0 = no darkening, 1 = maximum darkening)"
    value: 0.5
}

KConfigItem {
    id: targetClasses
    configName: "TargetClasses"
    label: "Browser classes to dim"
    type: string
    defaultValue: '["firefox", "chromium", "google-chrome", "vivaldi"]'
    tooltip: "Specify the browser window classes to apply the effect to, as a JSON array (e.g., ['firefox', 'chromium'])"
    value: '["firefox", "chromium", "google-chrome", "vivaldi"]'
}

KPage {
    id: page
    title: "Dim Browser Windows"

    ColumnLayout {
        anchors.fill: parent

        // Darkening Level Slider
        Slider {
            id: slider
            from: darkenFactor.minValue
            to: darkenFactor.maxValue
            value: darkenFactor.value
            stepSize: darkenFactor.stepSize
            onValueChanged: {
                darkenFactor.value = value
            }

            Layout.fillWidth: true
            Layout.preferredHeight: 50
        }

        Text {
            text: "Darkening Level: " + darkenFactor.value.toFixed(2)
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Browser Classes TextField
        TextArea {
            id: classesField
            width: parent.width
            height: 100
            text: targetClasses.value
            placeholderText: "Enter browser classes (e.g., ['firefox', 'chrome'])"
            wrapMode: TextArea.Wrap
            onTextChanged: {
                targetClasses.value = text
            }
        }

        Button {
            text: "Apply Changes"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                // Handle the apply action, might be empty for this KCM
                console.log("Applied changes: Darkening Level " + darkenFactor.value)
            }
        }
    }
}
