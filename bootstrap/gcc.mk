cross-$(GCC_PREFIX)gcc: $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp

$(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-linux-headers.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) cross $(GCC_PREFIX)gcc stage1... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-cross-$(GCC_PREFIX)gcc-stage1... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1 && \
		export PATH="$(CROSS_TOOLCHAIN_BIN_PATH):$$PATH" && \
		$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc/configure --target=$(TARGET) \
																  --prefix=$(CROSS_TOOLCHAIN_OUTPUT_PATH) \
																  --with-sysroot=$(CROSS_TOOLCHAIN_SYSROOT_PATH) \
										   						  --with-newlib \
																  --without-headers \
												    			  --disable-shared \
												    			  --disable-threads \
																  --with-system-zlib \
																  --enable-tls \
												    			  --enable-languages=c \
												    			  --disable-libatomic \
												    			  --disable-libmudflap \
												    			  --disable-libssp \
												    			  --disable-libquadmath \
												    			  --disable-libgomp \
												    			  --disable-nls \
												    			  --disable-bootstrap \
												    			  --src=$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc \
																  --disable-multilib \
																  --with-abi=$(TARGET_ABI) \
																  --with-arch=$(GCC_ARCH) \
																  --with-tune=$(TARGET_TUNE) \
																  --with-isa-spec=$(TARGET_ISA) \
																  CFLAGS_FOR_TARGET="-O2 -mcmodel=$(TARGET_CMODEL)" \
																  CXXFLAGS_FOR_TARGET="-O2 -mcmodel=$(TARGET_CMODEL)" \
												    			  $(CMD_VERBOSE) && \
		$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
		$(MAKE) install-strip $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-stage1-build.stamp

$(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp: $(BUILD_PATH)/$(TARGET)-cross-glibc-headers-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) cross $(GCC_PREFIX)gcc ... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-cross-$(GCC_PREFIX)gcc... " && \
	set -o pipefail && \
	( \
		cd $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc && \
		export PATH="$(CROSS_TOOLCHAIN_BIN_PATH):$$PATH" && \
		$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc/configure --target=$(TARGET) \
																  --prefix=$(CROSS_TOOLCHAIN_OUTPUT_PATH) \
																  --with-sysroot=$(CROSS_TOOLCHAIN_SYSROOT_PATH) \
										   						  --with-system-zlib \
																  --enable-shared \
												    			  --enable-tls \
												    			  --enable-languages=c,c++ \
																  --disable-libmudflap \
																  --disable-libssp \
																  --disable-libquadmath \
																  --disable-libsanitizer \
																  --disable-nls \
																  --disable-bootstrap \
												    			  --src=$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc \
																  --disable-multilib \
																  --with-abi=$(TARGET_ABI) \
																  --with-arch=$(GCC_ARCH) \
																  --with-tune=$(TARGET_TUNE) \
																  --with-isa-spec=$(TARGET_ISA) \
																  CFLAGS_FOR_TARGET="-O2 -mcmodel=$(TARGET_CMODEL)" \
																  CXXFLAGS_FOR_TARGET="-O2 -mcmodel=$(TARGET_CMODEL)" \
												    			  $(CMD_VERBOSE) && \
		$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
		$(MAKE) install-strip $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc/build.log $(BUILD_MACRO_VERBOSE)
	#$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-cross-$(GCC_PREFIX)gcc-build.stamp

native-$(GCC_PREFIX)gcc: $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc-build.stamp

$(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc-build.stamp: $(BUILD_PATH)/$(TARGET)-native-glibc-build.stamp
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)$(MKDIR) -p $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)$(ECHO) -n "+++ Building $(TARGET) native $(GCC_PREFIX)gcc ... " && \
	export BUILD_MESSAGE="+++ Building $(TARGET)-native-$(GCC_PREFIX)gcc-... " && \
	set -o pipefail && \
	( \
		if test -f $(SOURCES_PATH)/$(GCC_PREFIX)gcc/contrib/download_prerequisites; \
		then \
			cd $(SOURCES_PATH)/$(GCC_PREFIX)gcc $(CMD_VERBOSE) && \
			./contrib/download_prerequisites --directory=$(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc $(CMD_VERBOSE); \
		fi $(CMD_VERBOSE) && \
		cd $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc && \
		export PATH="$(CROSS_TOOLCHAIN_BIN_PATH):$$PATH" && \
		$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc/configure --host=$(TARGET) \
																  --target=$(TARGET) \
																  --prefix=$(NATIVE_TOOLCHAIN_OUTPUT_PATH) \
																  --without-system-zlib \
																  --enable-shared \
												    			  --enable-tls \
												    			  --enable-languages=c,c++ \
																  --disable-libmudflap \
																  --disable-libssp \
																  --disable-libquadmath \
																  --disable-nls \
																  --disable-bootstrap \
																  --with-native-system-header-dir=$(NATIVE_TOOLCHAIN_OUTPUT_PATH)/include \
												    			  --disable-multilib \
																  --disable-libsanitizer \
																  --with-abi=$(TARGET_ABI) \
																  --with-arch=$(GCC_ARCH) \
																  --with-tune=$(TARGET_TUNE) \
																  --with-isa-spec=$(TARGET_ISA) \
																  --src=$(PROJECT_DIR)/$(SOURCES_PATH)/$(GCC_PREFIX)gcc \
																  $(CMD_VERBOSE) && \
		$(MAKE) $(MAKEFLAGS) $(CMD_VERBOSE) && \
		$(MAKE) install-strip $(CMD_VERBOSE) \
	) | $(TEE) $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc/build.log $(BUILD_MACRO_VERBOSE)
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc
	$(ECHO_VERBOSE)touch $(BUILD_PATH)/$(TARGET)-native-$(GCC_PREFIX)gcc-build.stamp
