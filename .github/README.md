# zmk-config

My ZMK firmware for a Corne-ish Zen v2 (42 keys, 6-column layout).

Forked from [urob/zmk-config](https://github.com/urob/zmk-config). His write-up on
timeless home-row mods, magic shift and the rest of the base setup is the root
[readme.md](../readme.md), left unchanged so upstream merges stay clean. GitHub shows
this file (`.github/README.md`) instead.

## Notes

- [TODO.md](../TODO.md): open work.
- [KEYS.md](../KEYS.md): key position labels (`LT0`, `RH0`, …), numbers, and thumb keys.

## What's different from urob's

- Dsend base layer (QWERTY also available), on all 42 keys including the outer columns.
- OS-aware shortcuts via [zmk-oskey](https://github.com/mentaldesk/oskey) ([`config/oskeys.dtsi`](../config/oskeys.dtsi)):
  copy/paste, tabs, screenshots, desktops and window tiling switch between Windows, macOS and Linux.
  Bluetooth profile 0 selects Windows, profile 1 selects macOS.
- The selected OS survives deep sleep and power cycles ([`os-persist/`](../os-persist), a small local Zephyr module).
- App and window swappers on the APP layer.

## Layers

| # | Layer | Reached by |
|---|---|---|
| 0 | Dsend | default |
| 1 | QWERTY | FIG layer |
| 2 | SYM | hold Space (RH1) |
| 3 | NAV | hold Backspace (LH0) or Enter (RH0) |
| 4 | NUM | hold RH2; tap for num-word |
| 5 | FIG (configuration) | hold RT5 |
| 6 | MOU | mouse combo or FIG + LB0 (Smart Mouse) |
| 7 | BTN | FIG + LB1 (Smart Button) |
| 8 | APP | hold LH2 |
| 9 | FN | APP + NUM together |
| 10 | MNT (maintenance) | hold RT3 on FIG |

On MNT, tap LB0/RB0 to restart the left/right half or LB1/RB1 to enter its bootloader.

### FIG language keys

| OS | LM4 · English | LM3 · Pinyin | LM2 · Cycle |
|---|---|---|---|
| macOS | F18 | F19 | Control+Option+Space |
| Windows | Ctrl+Shift+1 | Ctrl+Shift+2 | Win+Space |
| Linux (GNOME/IBus) | F18 | F19 | Super+Space |

On macOS, install `macism` with `brew install laishulu/homebrew/macism` and use the [Zen Karabiner rules](https://github.com/andrewxhc/keyboard-host-tools/blob/main/karabiner/karabiner.json).
On Windows or Linux, assign the English and Pinyin shortcuts in the host settings.

## Building

Requires Nix, and a workspace initialised once with:

```bash
nix develop --command just init
```

Then build both halves:

```bash
nix develop --command just build zen
```

or run `../build-zen-mac.sh` from this folder, which does the same and prints where the files are.
Firmware lands in `firmware/`. Zephyr can't build from a path that contains a space.

GitHub Actions builds both halves when a push changes `config/`, `os-persist/`, or `build.yaml` (see the [firmware workflow](workflows/build-nix.yml)).

## Flashing

Double-press the reset button on one half so it mounts as a USB drive, then copy that half's
`.uf2` from `firmware/` onto it. Repeat for the other half.
