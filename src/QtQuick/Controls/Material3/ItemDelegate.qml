// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material3
import QtQuick.Controls.Material3.impl

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 16
    verticalPadding: 8
    spacing: 16

    icon.width: 24
    icon.height: 24
    icon.color: enabled ? Material.foreground : Material.hintTextColor

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: control.display === IconLabel.IconOnly || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft

        icon: control.icon
        text: control.text
        font: control.font
        color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
    }

    background: Rectangle {
        id: backgroundRect

        readonly property color delegateColor: control.highlighted ? control.Material.listHighlightColor : "transparent"

        implicitHeight: control.Material.delegateHeight

        color: control.Material.noEffects && control.down ?
                   control.Material.theme === Material.Dark ?
                       Qt.lighter(control.Material.listHighlightColor) :
                       Qt.darker(control.Material.listHighlightColor) : backgroundRect.delegateColor

        Ripple {
            enabled: !control.Material.noEffects

            width: parent.width
            height: parent.height

            clip: visible
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.Material.rippleColor
        }
    }
}
