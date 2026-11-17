# To-do

## Keymap features

- [ ] Finish window-management keys (APP layer: `OS_TILE_*`, `OS_MON_NEXT`, `OS_WIN_MIN`; pin-window alias is commented out)
- [ ] Rectangle (macOS) shortcuts
- [ ] Browser open/close tab keys
- [ ] AI shortcuts
- [ ] Media skip forward/backward instead of next/previous track (`C_PREV`/`C_NEXT` on the SYS layer)
- [ ] Ink display graphics

## Tuning

- [ ] Space key: re-evaluate `lt_spc` hold-tap (balanced, 200 ms) — symbol rolls after space resolve wrong

## Cleanup

- [ ] Clean up the misc aliases block in `config/base.keymap`
- [ ] `&caps_word` override relies on ZMK PR #1451 — rebase / check whether it is still needed
- [ ] Combos: urob's are fine for now; maybe make my own later

## Done

- [x] Local build instead of GitHub Actions (`nix develop --command just build zen`, or `../build-zen-mac.sh`)
