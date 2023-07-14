BASE_PATH:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TARGET=$(ARCH)-unknown-linux-gnu
HOST=$(shell bootstrap/config.guess)
BUILD_HOST=$(shell bootstrap/config.guess)

TOOLCHAINS=cross native

SHELL=bash
RM=rm
CP=cp
ECHO=echo
MKDIR=mkdir
CHMOD=chmod
TEE=tee
GIT=git
PRINTF=printf
READ=read
SED=sed

TOOLCHAINS_PATH=$(BASE_PATH)/toolchains
STAGE1_TOOLCHAIN_OUTPUT_PATH=$(TOOLCHAINS_PATH)/$(TARGET)-$(GCC_PREFIX)stage1-toolchain
CROSS_TOOLCHAIN_OUTPUT_PATH=$(TOOLCHAINS_PATH)/$(TARGET)-$(GCC_PREFIX)cross-toolchain
NATIVE_TOOLCHAIN_OUTPUT_PATH=$(TOOLCHAINS_PATH)/$(TARGET)-$(GCC_PREFIX)native-toolchain

ifeq (,$(GIT))
$(warning "No git in $(PATH), consider doing apt-get install git")
endif

ifeq (1,$(USE_REVYOS_GCC))
GCC_PREFIX=revyos-
GCC_ARCH=$(TARGET_ARCH)
else
GCC_PREFIX=
GCC_ARCH=$(shell $(ECHO) $(TARGET_ARCH) | $(SED) -e 's/v0p7/v/')
endif

define DECLARE_PATH
$(shell echo '$(1)' | tr '[:lower:]' '[:upper:]')_TOOLCHAIN_$(shell echo '$(2)' | tr '[:lower:]' '[:upper:]')_PATH=$($(shell echo '$(1)' | tr '[:lower:]' '[:upper:]')_TOOLCHAIN_OUTPUT_PATH)/$(2)
endef

define DEFINE_PATH
$(foreach t,$(TOOLCHAINS),$(eval $(call DECLARE_PATH,$(t),$(1))))
endef

all: $(TARGET)-$(GCC_PREFIX)cross-toolchain.tar.xz $(TARGET)-$(GCC_PREFIX)native-toolchain.tar.xz

$(call DEFINE_PATH,bin)
$(call DEFINE_PATH,sysroot)

ECHO_BUILD = $(echo_BUILD_$(V))
echo_BUILD_ = $(echo_BUILD_$(DEFAULT_VERBOSITY))
echo_BUILD_0 = @echo "  BUILD   " $@;

ECHO_GEN = $(echo_GEN_$(V))
echo_GEN_ = $(echo_GEN_$(DEFAULT_VERBOSITY))
echo_GEN_0 =   @echo "  GEN     " $@;

ECHO_LINK = $(echo_LINK_$(V))
echo_LINK_ = $(echo_LINK_$(DEFAULT_VERBOSITY))
echo_LINK_0 = @echo "  LINK    " $@;

ECHO_INSTALL = $(echo_INSTALL_$(V))
echo_INSTALL_ = $(echo_INSTALL_$(DEFAULT_VERBOSITY))
echo_INSTALL_0 =  @echo "  INSTALL " $@;

ECHO_VERBOSE = $(echo_VERBOSE_$(V))
echo_VERBOSE_ = $(echo_VERBOSE_$(DEFAULT_VERBOSITY))
echo_VERBOSE_0 = @

CMD_VERBOSE = $(cmd_VERBOSE_$(V))
cmd_VERBOSE_ = $(cmd_VERBOSE_$(DEFAULT_VERBOSITY))
cmd_VERBOSE_0 = 2>&1

BUILD_VERBOSE = $(build_VERBOSE_$(V))
build_VERBOSE_ = $(build_VERBOSE_$(DEFAULT_VERBOSITY))
build_VERBOSE_0 =  | \
	while $(READ); do i=$$(( ($${i:-0}+1) %4 )); \
		spin='-\|/'; \
		$(PRINTF) "\r$$BUILD_MESSAGE [ $${spin:$$i:1} ]"; \
	done && \
	$(PRINTF) "\r$$BUILD_MESSAGE [ \xE2\x9C\x94 ]\n"

BUILD_MACRO_VERBOSE = $(build_MACRO_VERBOSE_$(V))
build_MACRO_VERBOSE_ = $(build_MACRO_VERBOSE_$(DEFAULT_VERBOSITY))
build_MACRO_VERBOSE_0 =  | \
	while $(READ); do i=$$(( ($${i:-0}+1) %4 )); \
		spin='-\|/'; \
		$(PRINTF) "\r$$BUILD_MESSAGE [ $${spin:$$i:1} ]"; \
	done && \
	$(PRINTF) "\r$$BUILD_MESSAGE [ \xE2\x9C\x94 ]\n"
