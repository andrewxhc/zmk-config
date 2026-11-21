# To-do

See [.github/README.md](.github/README.md) for an overview of this config.

## Keymap features

- [ ] Finish window-management keys (APP layer: `OS_TILE_*`, `OS_MON_NEXT`, `OS_WIN_MIN`; pin-window alias is commented out)
- [ ] Rectangle (macOS) shortcuts
- [ ] AI shortcuts
- [ ] Verify FIG English, Pinyin and Cycle on Windows and Linux
- [ ] Media skip forward/backward instead of next/previous track (`C_PREV`/`C_NEXT` on the FIG layer)
- [ ] Ink display graphics

## Tuning

- [ ] Space key: re-evaluate `lt_spc` hold-tap (balanced, 200 ms) — symbol rolls after space resolve wrong

## Cleanup

- [ ] Clean up the misc aliases block in `config/base.keymap`
- [ ] `&caps_word` override relies on ZMK PR #1451 — rebase / check whether it is still needed
- [ ] Combos: urob's are fine for now; maybe make my own later

## Possible upstream contributions

- [ ] Reproduce held-Ctrl loss on current ZMK and consider an upstream report. On `0331b7d`, Zen Ctrl + trackpad click opens the context menu. Tap and release LH0 while keeping Ctrl held, then click before pressing another key: the menu stays closed, even after quitting Karabiner. Check existing upstream work and credit [Matoi’s patch](https://github.com/matoi/zmk/commit/1c9f8c05) and [cleanup follow-up](https://github.com/matoi/zmk/commit/82e552a). If pursuing a fix, test immediate Ctrl+click over USB and BLE.

## Done

- [x] Verified all three FIG language keys on macOS: direct English selection, direct Simplified Pinyin selection with candidates (macism 3.1.1), and input source cycling.

- [x] First-tap Ctrl+LH0 word deletion on macOS works with Karabiner-Elements beta 16.99.26 and the existing Zen firmware.

- [x] Browser keys on NAV (tabs, reload, back/forward, zoom) and hold-to-quit on APP
- [x] Local build instead of GitHub Actions (`nix develop --command just build zen`, or `../build-zen-mac.sh`)
