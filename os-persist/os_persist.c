/*
 * Remembers the selected OS across deep sleep and power cycles.
 *
 * Deep sleep powers the MCU off, so waking is a cold boot and the OS mode
 * falls back to its compiled-in default. This saves the selection to flash
 * when the keyboard goes idle or to sleep, and at boot replays the matching
 * select_* macro from oskeys.dtsi.
 *
 * SPDX-License-Identifier: MIT
 */

#include <zephyr/devicetree.h>
#include <zephyr/kernel.h>
#include <zephyr/settings/settings.h>

#include <zmk/behavior.h>
#include <zmk/event_manager.h>
#include <zmk/events/activity_state_changed.h>
#include <oskey/os_state.h>

static const char *const select_macros[] = {
    [OSKEY_OS_WINDOWS] = DEVICE_DT_NAME(DT_NODELABEL(select_win)),
    [OSKEY_OS_MACOS] = DEVICE_DT_NAME(DT_NODELABEL(select_mac)),
    [OSKEY_OS_LINUX] = DEVICE_DT_NAME(DT_NODELABEL(select_lin)),
};

static uint8_t saved_os = UINT8_MAX;

static int os_persist_load(const char *name, size_t len, settings_read_cb read_cb, void *cb_arg) {
    uint8_t os;

    if (read_cb(cb_arg, &os, sizeof(os)) != sizeof(os) || os >= ARRAY_SIZE(select_macros)) {
        return -EINVAL;
    }

    saved_os = os;
    struct zmk_behavior_binding binding = {.behavior_dev = select_macros[os]};
    struct zmk_behavior_binding_event event = {.timestamp = k_uptime_get()};
    return zmk_behavior_invoke_binding(&binding, event, true);
}

SETTINGS_STATIC_HANDLER_DEFINE(os_persist, "os_persist", NULL, os_persist_load, NULL, NULL);

static int os_persist_save(const zmk_event_t *eh) {
    uint8_t os = zmk_oskey_get_os();

    if (as_zmk_activity_state_changed(eh)->state != ZMK_ACTIVITY_ACTIVE && os != saved_os &&
        settings_save_one("os_persist", &os, sizeof(os)) == 0) {
        saved_os = os;
    }
    return ZMK_EV_EVENT_BUBBLE;
}

ZMK_LISTENER(os_persist, os_persist_save);
ZMK_SUBSCRIPTION(os_persist, zmk_activity_state_changed);
