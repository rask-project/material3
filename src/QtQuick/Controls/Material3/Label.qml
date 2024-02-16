// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material3

T.Label {
    id: control

    color: enabled ? Material.foreground : Material.hintTextColor
    linkColor: Material.accentColor
}
