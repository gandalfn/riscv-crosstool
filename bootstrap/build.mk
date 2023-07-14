include bootstrap/vars.mk
include bootstrap/common.mk

$(call DECLARE_BUILD_PATHS,downloads sources build toolchains)

clean:
	@$(ECHO) "Cleaning..."
	$(ECHO_VERBOSE)$(RM) -rf $(BUILD_PATH)
	$(ECHO_VERBOSE)$(RM) -rf $(TOOLCHAINS_PATH)
	$(ECHO_VERBOSE)$(RM) -f $(TARGET)-cross-toolchain.tar.xz
	$(ECHO_VERBOSE)$(RM) -f $(TARGET)-native-toolchain.tar.xz
	
include bootstrap/binutils.mk
include bootstrap/linux-headers.mk
include bootstrap/gcc.mk
include bootstrap/glibc.mk
include bootstrap/toolchain.mk

.NOTPARALLEL: cross-binutils cross-linux-headers cross-gcc-stage1 cross-glibc cross-gcc native-binutils native-glibc native-gcc $(TARGET)-cross-toolchain.tar.xz $(TARGET)-native-toolchain.tar.xz

