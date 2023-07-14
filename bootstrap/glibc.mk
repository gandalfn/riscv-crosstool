cross-glibc: $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build.stamp

$(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-glibc-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) cross glibc headers... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-cross-glibc-headers-build... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build && \
		CC="$(CROSS_TOOLCHAIN_BIN_PATH)/$(TARGET)-gcc " \
		CXX="this-is-not-the-compiler-youre-looking-for" \
		CFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		CXXFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		ASFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) " \
		$(PROJECT_DIR)/$(SOURCES_PATH)/glibc/configure --prefix=$(CROSS_TOOLCHAIN_SYSROOT_PATH)/usr \
													   --host=$(TARGET) \
													   --enable-shared \
													   --with-headers=$(SOURCES_PATH)/linux-headers/include \
													   --disable-multilib \
													   --enable-kernel=3.0.0 $(CMD_VERBOSE) && \
		$(MAKE) install-headers $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build.stamp

$(BUILD_PATH)/$(TARGET)-cross-glibc-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-glibc-build
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-cross-glibc-build
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) cross glibc... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-cross-glibc-build... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-cross-glibc-build && \
		CC="$(CROSS_TOOLCHAIN_BIN_PATH)/$(TARGET)-gcc " \
		CXX="this-is-not-the-compiler-youre-looking-for" \
		CFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		CXXFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		ASFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) " \
		$(PROJECT_DIR)/$(SOURCES_PATH)/glibc/configure --host=$(TARGET) \
													   --prefix=/usr \
													   --disable-werror \
													   --enable-shared \
													   --enable-obsolete-rpc \
													   --with-headers=$(SOURCES_PATH)/linux-headers/include \
													   --disable-multilib \
													   --enable-kernel=3.0.0 \
													   --libdir=/usr/lib libc_cv_slibdir=/lib libc_cv_rtlddir=/lib \
													   $(CMD_VERBOSE) && \
		$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
		$(MAKE)  install install_root=$(CROSS_TOOLCHAIN_SYSROOT_PATH) $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-cross-glibc-build/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-glibc-build
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-glibc-build.stamp

native-glibc: $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build.stamp

$(BUILD_PATH)/$(TARGET)-native-glibc-headers-build.stamp: $(BUILD_PATH)/$(TARGET)-native-glibc-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) native glibc headers... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-native-glibc-headers-build... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build && \
		CC="$(CROSS_TOOLCHAIN_BIN_PATH)/$(TARGET)-gcc " \
		CXX="this-is-not-the-compiler-youre-looking-for" \
		CFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		CXXFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		ASFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) " \
		$(PROJECT_DIR)/$(SOURCES_PATH)/glibc/configure --prefix=$(NATIVE_TOOLCHAIN_OUTPUT_PATH) \
													   --host=$(TARGET) \
													   --target=$(TARGET) \
													   --enable-shared \
													   --with-headers=$(SOURCES_PATH)/linux-headers/include \
													   --disable-multilib \
													   --enable-kernel=3.0.0 $(CMD_VERBOSE) && \
		$(MAKE) install-headers $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-native-glibc-headers-build.stamp

$(BUILD_PATH)/$(TARGET)-native-glibc-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-glibc-build
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-native-glibc-build
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) native glibc... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-native-glibc-build... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-native-glibc-build && \
		CC="$(CROSS_TOOLCHAIN_BIN_PATH)/$(TARGET)-gcc " \
		CXX="this-is-not-the-compiler-youre-looking-for" \
		CFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		CXXFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) -g -O2 " \
		ASFLAGS="-march=$(TARGET_ARCH) -mabi=$(TARGET_ABI) -mcmodel=$(TARGET_CMODEL) " \
		$(PROJECT_DIR)/$(SOURCES_PATH)/glibc/configure --host=$(TARGET) \
													   --target=$(TARGET) \
													   --prefix=/ \
													   --disable-werror \
													   --enable-shared \
													   --enable-obsolete-rpc \
													   --with-headers=$(SOURCES_PATH)/linux-headers/include \
													   --disable-multilib \
													   --enable-kernel=3.0.0 \
													   --libdir=/usr/lib libc_cv_slibdir=/lib libc_cv_rtlddir=/lib \
													   $(CMD_VERBOSE) && \
		$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
		$(MAKE)  install install_root=$(NATIVE_TOOLCHAIN_OUTPUT_PATH) $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-native-glibc-build/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-glibc-build
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-native-glibc-build.stamp
