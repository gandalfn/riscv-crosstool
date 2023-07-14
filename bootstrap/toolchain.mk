$(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz: $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp
	$(ECHO_VERBOSE)$(RM) -f $(TOOLCHAINS_PATH)/$(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Create $(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz... " && \
	export BUILD_MESSAGE="+++ Create $(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz... " && \
	set -o pipefail && \
	( \
		cd $(TOOLCHAINS_PATH) && \
		tar jcvf $(BASE_PATH)/$(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz $(TARGET)-$(GCC_PREFIX)cross-toolchain $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-$(GCC_PREFIX)cross-toolchain-build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -f $(BUILD_PATH)/$(TARGET)-$(GCC_PREFIX)cross-toolchain-build.log
	
$(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz: $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc-build.stamp
	$(ECHO_VERBOSE)$(RM) -f $(TOOLCHAINS_PATH)/$(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Create $(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz... " && \
	export BUILD_MESSAGE="+++ Create $(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz... " && \
	set -o pipefail && \
	( \
		cd $(TOOLCHAINS_PATH) && \
		tar jcvf $(BASE_PATH)/$(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz $(TARGET)-$(GCC_PREFIX)native-toolchain $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-$(GCC_PREFIX)native-toolchain-build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -f $(BUILD_PATH)/$(TARGET)-$(GCC_PREFIX)native-toolchain-build.log
