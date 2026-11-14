# The OS state lives on the central half only.
if (CONFIG_ZMK_OSKEY_STATE AND ((NOT CONFIG_ZMK_SPLIT) OR CONFIG_ZMK_SPLIT_ROLE_CENTRAL))
  target_sources(app PRIVATE os_persist.c)
endif()
