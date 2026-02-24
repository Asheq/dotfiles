This document lists unused or duplicate Neovim keys by mode, helping you find conflict-free mappings. Only standalone keys and single-modifier chords (`<S-...>`, `<C-...>`, `<M-...>`) are included. `<D-...>` chords are excluded to preserve OS shortcuts.

Note: Some keys here may still be unsuitable because:

1. They are reserved by the OS or terminal and never reach Neovim, e.g.:
    - `<S-Space>` sends `<Space>`
    - `<C-1>`–`<C-9>`: MacOS desktop switching
    - `<C-Tab>`: tab cycling in kitty
    - `<C-Space>`: MacOS "AI Assistant"
    - `<C-Up>`, `<C-Down>`, `<C-Left>`, `<C-Right>`: MacOS "Mission Control"
    - `<M-Esc>`: MacOS text-to-speech
    - `<M-Space>`: MacOS dictation
2. They are hard to press due to keyboard layout or require extra modifiers.

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

- Standalone
    - `x` (same as `d`)
    - `s` (same as `c`)
    - ???
- Shift
    - `X` (same as `D`)
    - `S` (same as `C`)
    - ???
- Control
    - ???
- Option/Meta/Alt
    - ???

# Visual-mode (line)

- Standalone
    - `x` (same as `d`)
    - `s` (same as `c`)
    - ???
- Shift
    - `X` (same as `d`)
    - `S` (same as `c`)
    - `D` (same as `d`)
    - `C` (same as `c`)
    - ???
- Control
    - ???
- Option/Meta/Alt
    - ???

# Visual-mode (block)

- Standalone
    - `x` (same as `d`)
    - `s` (same as `c`)
    - ???
- Shift
    - `X` (same as `d`)
    - ???
- Control
    - ???
- Option/Meta/Alt
    - ???
