#--------------------------------------------------------------------------------------------------------------
#
# @file     ecgsimulator.pro
# @author   Christoph Dinh <chdinh@nmr.mgh.harvard.edu>;
#           Matti Hamalainen <msh@nmr.mgh.harvard.edu>
# @version  1.0
# @date     July, 2012
#
# @section  LICENSE
#
# Copyright (C) 2012, Christoph Dinh and Matti Hamalainen. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that
# the following conditions are met:
#     * Redistributions of source code must retain the above copyright notice, this list of conditions and the
#       following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and
#       the following disclaimer in the documentation and/or other materials provided with the distribution.
#     * Neither the name of MNE-CPP authors nor the names of its contributors may be used
#       to endorse or promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
#
# @brief    This project file generates the makefile for the ecgsimulator plug-in.
#
#--------------------------------------------------------------------------------------------------------------

include(../../../../mne-cpp.pri)

TEMPLATE = lib

CONFIG += plugin

DEFINES += ECGSIMULATOR_LIBRARY

QT += core widgets

TARGET = ecgsimulator
CONFIG(debug, debug|release) {
    TARGET = $$join(TARGET,,,d)
}

LIBS += -L$${MNE_LIBRARY_DIR}
CONFIG(debug, debug|release) {
    LIBS += -lMNE$${MNE_LIB_VERSION}Utilsd \
            -lscMeasd \
            -lscDispd \
            -lscSharedd
}
else {
    LIBS += -lMNE$${MNE_LIB_VERSION}Utils \
            -lscMeas \
            -lscDisp \
            -lscShared
}

DESTDIR = $${MNE_BINARY_DIR}/mne_scan_plugins

SOURCES += \
        ecgsimulator.cpp \
        ecgsimchannel.cpp \
        ecgproducer.cpp \
        FormFiles/ecgsetupwidget.cpp \
        FormFiles/ecgaboutwidget.cpp

HEADERS += \
        ecgsimulator.h\
        ecgsimulator_global.h \
        ecgsimchannel.h \
        ecgproducer.h \
        FormFiles/ecgsetupwidget.h \
        FormFiles/ecgaboutwidget.h

FORMS += \
        FormFiles/ecgsetup.ui \
        FormFiles/ecgabout.ui

RESOURCE_FILES +=\
    $${ROOT_DIR}/resources/mne_scan/plugins/ECGSimulator/readme.txt \
    $${ROOT_DIR}/resources/mne_scan/plugins/ECGSimulator/data/ECG_I_256_s30661.txt \
    $${ROOT_DIR}/resources/mne_scan/plugins/ECGSimulator/data/ECG_II_256_s30661.txt \
    $${ROOT_DIR}/resources/mne_scan/plugins/ECGSimulator/data/ECG_III_256_s30661.txt \
    $${ROOT_DIR}/resources/mne_scan/plugins/ECGSimulator/data/ecgdata.txt \

# Copy resource files from repository to bin resource folder
COPY_CMD = $$copyResources($${RESOURCE_FILES})
QMAKE_POST_LINK += $${COPY_CMD}

INCLUDEPATH += $${EIGEN_INCLUDE_DIR}
INCLUDEPATH += $${MNE_INCLUDE_DIR}
INCLUDEPATH += $${MNE_SCAN_INCLUDE_DIR}

RESOURCES += \
    ecgsimulator.qrc

OTHER_FILES += ecgsimulator.json

# Put generated form headers into the origin --> cause other src is pointing at them
UI_DIR = $${PWD}

unix: QMAKE_CXXFLAGS += -isystem $$EIGEN_INCLUDE_DIR

# suppress visibility warnings
unix: QMAKE_CXXFLAGS += -Wno-attributes
