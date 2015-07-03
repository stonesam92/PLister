DEBUG = 0
GO_EASY_ON_ME = 1
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 8.0
ARCHS = armv7 arm64 armv7s

include theos/makefiles/common.mk

TOOL_NAME = plcat
plcat_FILES = main.mm NSData+Base64.m NSDate+XMLRepr.m

include $(THEOS_MAKE_PATH)/tool.mk
