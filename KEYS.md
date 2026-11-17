# Key positions

See [.github/README.md](.github/README.md) for an overview of this config.

Reference for the Corne-ish Zen's 42 keys. Labels come from zmk-helpers'
`key-labels/42.h` (included in `config/corneish_zen.keymap`); combos and
`hold-trigger-key-positions` use them, and keymap-drawer uses the numbers.

```
        Position numbers                              Labels
╭────────────────────────┬────────────────────────╮   ╭─────────────────────────┬─────────────────────────╮
│  0   1   2   3   4   5 │  6   7   8   9  10  11 │   │ LT5 LT4 LT3 LT2 LT1 LT0 │ RT0 RT1 RT2 RT3 RT4 RT5 │
│ 12  13  14  15  16  17 │ 18  19  20  21  22  23 │   │ LM5 LM4 LM3 LM2 LM1 LM0 │ RM0 RM1 RM2 RM3 RM4 RM5 │
│ 24  25  26  27  28  29 │ 30  31  32  33  34  35 │   │ LB5 LB4 LB3 LB2 LB1 LB0 │ RB0 RB1 RB2 RB3 RB4 RB5 │
╰───────────╮ 36  37  38 │ 39  40  41 ╭───────────╯   ╰───────────╮ LH2 LH1 LH0 │ RH0 RH1 RH2 ╭───────────╯
            ╰────────────┴────────────╯                           ╰─────────────┴─────────────╯
```

## Reading a label

- First letter: half — `L` left, `R` right.
- Second letter: row — `T` top, `M` middle (home), `B` bottom, `H` thumb.
- Number: counts outward from the center — `0` is the inner (index-stretch) column,
  `1` index, `2` middle, `3` ring, `4` pinky, `5` the outer extra column.

So `LM1` is the left index home key and `RT5` is the top-right corner key.

## Thumb keys

| Label | Pos | Tap | Hold |
|---|---|---|---|
| LH2 | 36 | OS launcher / search | APP layer |
| LH1 | 37 | Sticky shift / repeat (Shift + tap: caps-word) | Shift |
| LH0 | 38 | Backspace | NAV layer |
| RH0 | 39 | Enter | NAV layer |
| RH1 | 40 | Space (Shift + tap: `. ` + sticky shift) | SYM layer |
| RH2 | 41 | Num-word (double-tap: sticky NUM) | NUM layer |

## Groups from `42.h`

- `KEYS_L` / `KEYS_R`: all non-thumb keys on one half.
- `THUMBS_L` / `THUMBS_R` / `THUMBS`: the thumb keys.
