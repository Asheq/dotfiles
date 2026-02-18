This document lists all keys (either single keys or single-modifier key chords) that are either unused or duplicated in Neovim for each mode. This is useful for identifying potential key mappings that can be added without conflicts.

That said, some of these keys may still not be ideal for key mappings because:

1. They are reserved at the OS level or terminal level, and are therefore "intercepted" before they reach Neovim.

2. They are difficult to press because:
   i. They can only be accessed on a symbols layer on a programmable keyboard, requiring an extra modifier to begin with (the symbols layer modifier)
   ii. The modifier is not easy to reach, even after OS-level key mappings added by `Karabiner-Elements`, etc.

# Normal-mode

- Duplicate
    - `h`
        - `<Left>`
        - `<C-h>`
        - `<BS>`
    - `l`
        - `<Right>`
        - `<Space>`
    - `j`
        - `<Down>`
        - `<C-j>`
        - `<C-n>`
    - `k`
        - `<Up>`
        - `<C-p>`
    - `<Enter>`
        - `+`
        - `<C-m>`
    - `cc`
        - `S`
- Unused
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
        - `<C-;>`
        - `<C-'>`
        - `<C-CR>`
        - `<C-,>`
        - `<C-.>`
        - `<C-/>`
        - `<C-Up>`
        - `<C-Down>`
        - `<C-Left>`
        - `<C-Right>`
    - Meta
        - `<M-[all]>`

# Insert-mode

- Duplicate
    - `<BS>`
        - `<C-h>`
    - `<Tab>`
        - `<C-i>`
    - `<CR>`
        - `<C-j>`
        - `<C-m>`
    - `<C-v>`
        - `<C-q>`
- Unused
    - Control
        - `<C-Esc>`
        - ``<C-`>``
        - `<C-1>`
        - `<C-2>`
        - `<C-3>`
        - `<C-4>`
        - `<C-5>`
        - `<C-6>`
        - `<C-7>`
        - `<C-8>`
        - `<C-9>`
        - `<C-0>`
        - `<C-->`
        - `<C-=>`
        - `<C-BS>`
        - `<C-Tab>`
        - `<C-q>`
        - `<C-]>`
        - `<C-a>`
        - `<C-s>`
        - `<C-;>`
        - `<C-'>`
        - `<C-CR>`
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
- Unused
    - ???

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
- Unused
    - ???

# Visual-mode (block)

- Duplicate
    - `d`
        - `x`
        - `X`
    - `c`
        - `s`
- Unused
    - ???
