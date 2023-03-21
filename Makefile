export ARCHS = arm64 arm64e
DEBUG = 0
export TARGET = iphone:clang:14.2
GO_EASY_ON_ME = 1

PACKAGE_VERSION = 1.0

export SYSROOT = $(THEOS)/sdks/iPhoneOS14.2.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TelegaIcons
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation SpringBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk
