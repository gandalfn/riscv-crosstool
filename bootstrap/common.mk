define DEFINE_BUILD_PATH
$(1):
	$(ECHO_VERBOSE)$(ECHO) "Create $(1) directory..."
	$(ECHO_VERBOSE)$(MKDIR) -p $(1)
endef

define  DECLARE_BUILD_PATH
$(shell echo '$(1)' | tr '[:lower:]' '[:upper:]')_PATH=$(BASE_PATH)/$(1)
endef

define  DECLARE_BUILD_PATH_RULE
$(call DEFINE_BUILD_PATH,$($(shell echo '$(1)' | tr '[:lower:]' '[:upper:]')_PATH))
endef

define DECLARE_BUILD_PATHS
$(foreach t,$(1),$(eval $(call DECLARE_BUILD_PATH,$(t))))
$(foreach t,$(1),$(eval $(call DECLARE_BUILD_PATH_RULE,$(t))))
endef