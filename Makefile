include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=coffeec
PKG_RELEASE:=1
PKG_VERSION:=2.1

include $(INCLUDE_DIR)/package.mk

define Package/coffeec
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Client tool to talk to a instance of coffeed
endef

define Package/coffeec/description
	Tool for controlling gpio pins
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) CFLAGS="-O $(TARGET_CFLAGS) -I$(LINUX_DIR)/include"
endef

define Package/coffeec/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/coffeec $(1)/usr/bin/coffeec
endef

$(eval $(call BuildPackage,coffeec))
