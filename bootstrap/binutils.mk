cross-binutils: $(BUILD_PATH)/$(TARGET)-cross-binutils-build.stamp

$(BUILD_PATH)/$(TARGET)-cross-binutils-build.stamp:
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-binutils
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-cross-binutils
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) cross binutils... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-cross-binutils... " && \
	set -o pipefail && \
	(cd $(BUILD_PATH)/$(TARGET)-cross-binutils && \
	export CXXFLAGS="-s" && \
	$(PROJECT_DIR)/$(SOURCES_PATH)/binutils/configure --target=$(TARGET) \
													  --prefix=$(CROSS_TOOLCHAIN_OUTPUT_PATH) \
													  --with-sysroot=$(CROSS_TOOLCHAIN_SYSROOT_PATH) \
													  --disable-multilib \
													  --disable-werror \
													  --disable-nls \
													  --with-expat=yes \
													  --disable-gdb \
													  --disable-sim \
													  --disable-libdecnumber \
													  --disable-readline \
													  --with-isa-spec=$(TARGET_ISA) \
													  --with-arch=$(TARGET_ARCH) \
													  $(CMD_VERBOSE) && \
	$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
	$(MAKE) install-strip $(CMD_VERBOSE)) | $(TEE) $(BUILD_PATH)/$(TARGET)-cross-binutils/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-binutils
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-binutils-build.stamp

native-binutils: $(BUILD_PATH)/$(TARGET)-native-binutils-build.stamp

$(BUILD_PATH)/$(TARGET)-native-binutils-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-binutils
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-native-binutils
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) native binutils... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-native-binutils... " && \
	set -o pipefail && \
	(cd $(BUILD_PATH)/$(TARGET)-native-binutils && \
	export CXXFLAGS="-s" && \
	export PATH="$(CROSS_TOOLCHAIN_BIN_PATH):$$PATH" && \
	$(PROJECT_DIR)/$(SOURCES_PATH)/binutils/configure --host=$(TARGET) \
													  --target=$(TARGET) \
													  --prefix=$(NATIVE_TOOLCHAIN_OUTPUT_PATH) \
													  --disable-multilib \
													  --disable-werror \
													  --disable-nls \
													  --disable-gdb \
													  --disable-sim \
													  --disable-libdecnumber \
													  --disable-readline \
													  --with-isa-spec=$(TARGET_ISA) \
													  --with-arch=$(TARGET_ARCH) \
													  $(CMD_VERBOSE) && \
	$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
	$(MAKE) install-strip $(CMD_VERBOSE)) | $(TEE) $(BUILD_PATH)/$(TARGET)-native-binutils/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-binutils
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-native-binutils-build.stamp

