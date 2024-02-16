# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

#####################################################################
## qtquickcontrols2materialstyleplugin Plugin:
#####################################################################

cmake_minimum_required(VERSION 3.22...3.27)

option(NO_EFFECTS "Disable Material3 effects" OFF)
option(DENSE_VARIANT "Enable dense variant theme" OFF)

project(qtquickcontrols2materialstyleplugin
    VERSION 2.0.0
    DESCRIPTION "Qt Quick Controls Material3 Style"
    LANGUAGES CXX
)

find_package(Qt6 6.5 REQUIRED COMPONENTS Gui Qml Quick QuickControls2 QuickTemplates2 QuickControls2Impl)
find_package(Qt6 COMPONENTS ShaderTools)

qt_standard_project_setup(REQUIRES 6.5)

set(PLUGIN_URI_PATH QtQuick/Controls/Material3)
set(PLUGIN_PATH ${DEST_DIR}/${PLUGIN_URI_PATH})
set(PLUGIN_URI QtQuick.Controls.Material3)

set(QML_FILES
    ApplicationWindow.qml
    BusyIndicator.qml
    Button.qml
    CheckBox.qml
    CheckDelegate.qml
    ComboBox.qml
    DelayButton.qml
    Dial.qml
    Dialog.qml
    DialogButtonBox.qml
    Drawer.qml
    Frame.qml
    GroupBox.qml
    HorizontalHeaderView.qml
    ItemDelegate.qml
    Label.qml
    Menu.qml
    MenuBar.qml
    MenuBarItem.qml
    MenuItem.qml
    MenuSeparator.qml
    Page.qml
    PageIndicator.qml
    Pane.qml
    Popup.qml
    ProgressBar.qml
    RadioButton.qml
    RadioDelegate.qml
    RangeSlider.qml
    RoundButton.qml
    ScrollView.qml
    ScrollBar.qml
    ScrollIndicator.qml
    SelectionRectangle.qml
    Slider.qml
    SpinBox.qml
    SplitView.qml
    StackView.qml
    SwipeDelegate.qml
    SwipeView.qml
    Switch.qml
    SwitchDelegate.qml
    TabBar.qml
    TabButton.qml
    TextArea.qml
    TextField.qml
    ToolBar.qml
    ToolButton.qml
    ToolSeparator.qml
    ToolTip.qml
    TreeViewDelegate.qml
    Tumbler.qml
    VerticalHeaderView.qml
)

set_source_files_properties(DelayButton.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.2;6.0"
)
set_source_files_properties(Dialog.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.1;6.0"
)
set_source_files_properties(DialogButtonBox.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.1;6.0"
)
set_source_files_properties(HorizontalHeaderView.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.15;6.0"
)
set_source_files_properties(MenuBar.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.3;6.0"
)
set_source_files_properties(MenuBarItem.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.3;6.0"
)
set_source_files_properties(MenuSeparator.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.1;6.0"
)
set_source_files_properties(RoundButton.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.1;6.0"
)
set_source_files_properties(SplitView.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.13;6.0"
)
set_source_files_properties(ToolSeparator.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.1;6.0"
)
set_source_files_properties(VerticalHeaderView.qml PROPERTIES
    QT_QML_SOURCE_VERSIONS "2.15;6.0"
)

qt6_add_qml_module(${PROJECT_NAME}
    URI ${PLUGIN_URI}
    VERSION ${PROJECT_VERSION}
    PAST_MAJOR_VERSIONS 2
    CLASS_NAME QtQuickControls2MaterialStylePlugin
    DEPENDENCIES
        QtQuick/auto
    IMPORTS
        QtQuick.Controls.Basic/auto
    PLUGIN_TARGET ${PROJECT_NAME}
    OUTPUT_DIRECTORY ${PLUGIN_PATH}
    IMPORT_PATH ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
    NO_PLUGIN_OPTIONAL
    NO_GENERATE_PLUGIN_SOURCE
    RESOURCE_PREFIX /
    OUTPUT_TARGETS output_targets
    FOLLOW_FOREIGN_VERSIONING
    SOURCES
        qquickmaterialstyle.cpp qquickmaterialstyle_p.h
        qquickmaterialtheme.cpp qquickmaterialtheme_p.h
        qtquickcontrols2materialstyleplugin.cpp
    QML_FILES
        ${QML_FILES}
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::CorePrivate
        Qt6::GuiPrivate
        Qt6::QmlPrivate
        Qt6::QuickControls2ImplPrivate
        Qt6::QuickControls2Private
        Qt6::QuickPrivate
        Qt6::QuickTemplates2Private
)

qt6_add_resources(${PROJECT_NAME} "${PROJECT_NAME}"
    PREFIX
        ${PLUGIN_URI_PATH}
    FILES
        "images/arrow-indicator.png"
        "images/arrow-indicator@2x.png"
        "images/arrow-indicator@3x.png"
        "images/arrow-indicator@4x.png"
        "images/check.png"
        "images/check@2x.png"
        "images/check@3x.png"
        "images/check@4x.png"
        "images/drop-indicator.png"
        "images/drop-indicator@2x.png"
        "images/drop-indicator@3x.png"
        "images/drop-indicator@4x.png"
)

set_target_properties(${PROJECT_NAME}
    PROPERTIES
        QT_QMLCACHEGEN_DIRECT_CALLS ON
)

qt6_add_shaders(qtquickcontrols2materialstyleplugin "qtquickcontrols2materialstyleplugin_shaders"
    SILENT
    BATCHABLE
    PRECOMPILE
    OPTIMIZED
    PREFIX
        ${PLUGIN_URI_PATH}
    FILES
        shaders/RectangularGlow.frag
)

add_subdirectory(impl)

target_compile_definitions(${PROJECT_NAME}
    PUBLIC
        NO_EFFECTS=$<IF:$<BOOL:${NO_EFFECTS}>,1,0>
        DENSE_VARIANT=$<IF:$<BOOL:${DENSE_VARIANT}>,1,0>
)
