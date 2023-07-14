cross-linux-headers: $(BUILD_PATH)/$(TARGET)-cross-linux-headers.stamp

$(BUILD_PATH)/$(TARGET)-cross-linux-headers.stamp: $(BUILD_PATH)/$(TARGET)-cross-binutils-build.stamp
	$(ECHO_VERBOSE)$(ECHO) "+++ Copy $(TARGET) cross linux-headers... "
	$(ECHO_VERBOSE)$(MKDIR) -p $(CROSS_TOOLCHAIN_SYSROOT_PATH)/usr/
	$(ECHO_VERBOSE)$(CP) -a $(SOURCES_PATH)/linux-headers/include $(CROSS_TOOLCHAIN_SYSROOT_PATH)/usr/
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-linux-headers.stamp

native-linux-headers: $(BUILD_PATH)/$(TARGET)-native-linux-headers.stamp

$(BUILD_PATH)/$(TARGET)-native-linux-headers.stamp: $(BUILD_PATH)/$(TARGET)-native-binutils-build.stamp
	$(ECHO_VERBOSE)$(ECHO) "+++ Copy $(TARGET) native linux-headers... "
	$(ECHO_VERBOSE)$(CP) -a $(SOURCES_PATH)/linux-headers/include $(NATIVE_TOOLCHAIN_OUTPUT_PATH)/
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-native-linux-headers.stamp
