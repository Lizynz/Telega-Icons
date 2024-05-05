ARCHS = arm64e arm64
export TARGET = iphone:15.0
THEOS_PACKAGE_SCHEME=rootless
export Bundle = ph.telegra.Telegraph
PACKAGE_VERSION = 1.2
DEBUG = 0

export SYSROOT = $(THEOS)/sdks/iPhoneOS15.0.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegaIcons

TelegaIcons_FILES = Tweak.xm TelegaIcons.swift
TelegaIcons_FRAMEWORKS = UIKit Foundation SpringBoardServices
TelegaIcons_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

install5::
		install5.exec
