This document lists all keys that are unused or duplicates in Neovim for each mode, helping identify potential mappings without conflicts. Standalone keys and single-modifier chords (`<S-...>`, `<C-...>`, `<M-...>`) are documented. `<D-...>` chords are not documented as they should never be mapped in Neovim in order to keep them free for OS level shortcuts.

Note: Some keys listed may still be unsuitable for mappings because:

1. They never reach Neovim because they are reserved/consumed by the OS or terminal:
    - When <S-Space> is pressed, terminal emulators send <Space>
    - <C-1> to <C-9> are reserved for jumping to desktops in MacOS
    - <C-Tab> is reserved for cycling through tabs in kitty terminal
    - <C-Space> is reserved for "AI Assistant" in my own MacOS setup
    - <C-Up>, <C-Down>, <C-Left>, and <C-Right> are reserved for "Mission Control" in MacOS
    - <M-Esc> is reserved for text-to-speech in my own MacOS setup
    - <M-Space> is reserved for dictation in my own MacOS setup
2. They are hard to press, e.g.:
    - Only accessible via a symbols layer on programmable keyboards (requiring an extra modifier)
    - The modifier itself is hard to reach on certain keyboard setups

# Normal-mode

- Standalone
    - `<Esc>`
    - `<BS>` (same as `h`)
    - `<Tab>` (same as `<C-i>`)
    - `\`
    - `S` (same as `cc`)
    - `<Space>` (same as `l`)
    - `<Up>` (same as `k`)
    - `<Down>` (same as `j`)
    - `<Left>` (same as `h`)
    - `<Right>` (same as `l`)
- Shift
    - `<S-Esc>`
    - `+` (same as `<CR>`)
    - `<S-BS>`
    - `<S-Tab>`
    - `<S-CR>` (same as `<C-f>`)
    - `<S-Space>`
    - `<S-Up>` (same as `<C-b>`)
    - `<S-Down>` (same as `<C-f>`)
    - `<S-Left>` (same as `b`)
    - `<S-Right>` (same as `w`)
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
    - `<C-Tab>` (same as `g<Tab>`)
    - `<C-q>`
    - `<C-p>` (same as `k`)
    - `<C-[>`
    - `<C-s>`
    - `<C-h>` (same as `h`)
    - `<C-j>` (same as `j`)
    - `<C-k>`
    - `<C-;>`
    - `<C-'>`
    - `<C-CR>`
    - `<C-n>` (same as `j`)
    - `<C-m>` (same as `<CR>`)
    - `<C-,>`
    - `<C-.>`
    - `<C-/>`
    - `<C-Space>`
    - `<C-Up>`
    - `<C-Down>`
    - `<C-Left>` (same as `b`)
    - `<C-Right>` (same as `w`)
- Option/Meta/Alt
    - `<M-...>`

# Insert-mode

- Standalone
    - `[NONE]`
- Shift
    - `<S-Esc>`
    - `<S-BS>`
    - `<S-Tab>`
    - `<S-CR>`
    - `<S-Space>`
- Control
    - `<C-Esc>`
    - ``<C-`>``
    - `<C-1>`
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
    - `<C-q>` (same as `<C-v>`)
    - `<C-i>` (same as `<Tab>`)
    - `<C-[>` (same as `<Esc>`)
    - `<C-s>`
    - `<C-f>`
    - `<C-h>` (same as `<BS>`)
    - `<C-j>` (same as `<CR>`)
    - `<C-;>`
    - `<C-'>`
    - `<C-CR>`
    - `<C-z>`
    - `<C-b>`
    - `<C-m>` (same as `<CR>`)
    - `<C-,>`
    - `<C-.>`
    - `<C-/>`
    - `<C-Space>`
    - `<C-Up>`
    - `<C-Down>`
- Option/Meta/Alt
    - `<M-...>`

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
