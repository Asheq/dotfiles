Unused or Duplicate keys

# Normal-mode
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

# Visual-mode (char)

- `d`
    - `x`
- `D`
    - `X`
- `c`
    - `s`
- `C`
    - `S`

# Visual-mode (line)

- `d`
    - `x`
    - `X`
    - `D`
- `c`
    - `s`
- `C`
    - `S`

# Visual-mode (block)

- `d`
    - `x`
    - `X`
- `c`
    - `s`

# Insert-mode

- `<BS>`
    - `<C-h>`
- `<Tab>`
    - `<C-i>`
- `<CR>`
    - `<C-j>`
    - `<C-m>`
- `<C-v>`
    - `<C-q>`

- `<C-b>` (unused)
- `<C-f>` (unused)
- `<C-l>` (unused, but used in completion mode)

- `<C-a>` (not used for something useful)
- `<C-y>` (not used for something useful, but used in completion mode)
- `<C-e>` (not used for something useful, but used in completion mode)

CHECK:
|i_<Left>|	<Left>		cursor one character left
|i_<S-Left>|	<S-Left>	cursor one word left
|i_<C-Left>|	<C-Left>	cursor one word left
|i_<Right>|	<Right>		cursor one character right
|i_<S-Right>|	<S-Right>	cursor one word right
|i_<C-Right>|	<C-Right>	cursor one word right
|i_<Up>|	<Up>		cursor one line up
|i_<S-Up>|	<S-Up>		same as <PageUp>
|i_<Down>|	<Down>		cursor one line down
|i_<S-Down>|	<S-Down>	same as <PageDown>
|i_<Home>|	<Home>		cursor to start of line
|i_<C-Home>|	<C-Home>	cursor to start of file
|i_<End>|	<End>		cursor past end of line
|i_<C-End>|	<C-End>		cursor past end of file
|i_<PageUp>|	<PageUp>	one screenful backward
|i_<PageDown>|	<PageDown>	one screenful forward
|i_<F1>|	<F1>		same as <Help>
|i_<Help>|	<Help>		stop insert mode and display help window
|i_<Insert>|	<Insert>	toggle Insert/Replace mode
|i_<LeftMouse>|	<LeftMouse>	cursor at mouse click
|i_<ScrollWheelDown>|	<ScrollWheelDown>	move window three lines down
|i_<S-ScrollWheelDown>|	<S-ScrollWheelDown>	move window one page down
|i_<ScrollWheelUp>|	<ScrollWheelUp>		move window three lines up
|i_<S-ScrollWheelUp>|	<S-ScrollWheelUp>	move window one page up
|i_<ScrollWheelLeft>|	<ScrollWheelLeft>	move window six columns left
|i_<S-ScrollWheelLeft>|	<S-ScrollWheelLeft>	move window one page left
|i_<ScrollWheelRight>|	<ScrollWheelRight>	move window six columns right
|i_<S-ScrollWheelRight>| <S-ScrollWheelRight>	move window one page right
