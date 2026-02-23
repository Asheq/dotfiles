This document lists all keys (standalone or single-modifier chords) that are unused or duplicated in Neovim for each mode, helping identify potential mappings without conflicts.

Note: Some keys may still be unsuitable because:

1. They are reserved by the OS or terminal and never reach Neovim.
2. They are hard to press, e.g.:
    - Only accessible via a symbols layer on programmable keyboards (requiring an extra modifier)
    - The modifier itself is hard to reach, even with tools like Karabiner-Elements.

# Normal-mode

- Standalone
    - `<Esc>`
    - `<BS>`
    - `\`
    - `S`
    - `<Space>`
    - `<Up>`
    - `<Down>`
    - `<Left>`
    - `<Right>`
- Shift
    - `<S-Esc>`
    - `+`
    - `<S-BS>`
    - `<S-Tab>`
    - `<S-CR>`
    - `<S-Space>`
    - `<S-Up>`
    - `<S-Down>`
    - `<S-Left>`
    - `<S-Right>`
- Control
    - `<C-Esc>`
    - ``<C-`>``
    - `<C-1>`
    - `<C-2>`
    - `<C-3>`
    - `<C-4>`
    - `<C-5>`
    - `<C-7>`
    - `<C-8>`
    - `<C-9>`
    - `<C-0>`
    - `<C-->`
    - `<C-=>`
    - `<C-BS>`
    - `<C-Tab>`
    - `<C-q>`
    - `<C-i>`
    - `<C-p>`
    - `<C-[>`
    - `<C-s>`
    - `<C-h>`
    - `<C-j>`
    - `<C-k>`
    - `<C-;>`
    - `<C-'>`
    - `<C-CR>`
    - `<C-n>`
    - `<C-m>`
    - `<C-,>`
    - `<C-.>`
    - `<C-/>`
    - `<C-Space>`
    - `<C-Up>`
    - `<C-Down>`
    - `<C-Left>`
    - `<C-Right>`
- Meta
    - `<M-[all]>`

# Insert-mode

- Standalone
    - `[NONE]`
- Shift
    - ???
- Control
    - `<C-q>`
    - `<C-i>`
    - `<C-h>`
    - `<C-j>`
    - `<C-m>`
    - ???
- Meta
    - `<M-[ALL]>`

# Visual-mode (char)

- Duplicate
    - `d`
        - `x`
    - `D`
        - `X`
    - `c`
        - `s`
    - `C`
        - `S`

# Visual-mode (line)

- Duplicate
    - `d`
        - `x`
        - `X`
        - `D`
    - `c`
        - `s`
    - `C`
        - `S`

# Visual-mode (block)

- Duplicate
    - `d`
        - `x`
        - `X`
    - `c`
        - `s`
