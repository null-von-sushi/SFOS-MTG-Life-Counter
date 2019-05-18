# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = Untap

CONFIG += sailfishapp

SOURCES += src/Untap.cpp

DISTFILES += qml/Untap.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/Untap.changes.in \
    rpm/Untap.changes.run.in \
    rpm/Untap.spec \
    rpm/Untap.yaml \
    translations/*.ts \
    Untap.desktop \
    qml/pages/Settings.qml \
    qml/pages/Players1.qml \
    qml/pages/Players2.qml \
    qml/pages/Players3.qml \
    qml/pages/Players4.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
#TRANSLATIONS += translations/Untap-de.ts
