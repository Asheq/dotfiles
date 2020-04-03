ANSI codes
================================================================================

For coloring text
--------------------------------------------------------------------------------

  Color name   | Color alias         | ANSI code (fg) | ANSI code (bg)
-------------- |---------------------|----------------|---------------
Black          | color0              | 30             |40
Red            | color1              | 31             |41
Green          | color2              | 32             |42
Yellow         | color3              | 33             |43
Blue           | color4              | 34             |44
Magenta        | color5              | 35             |45
Cyan           | color6              | 36             |46
White          | color7              | 37             |47
Black light    | color8              | 90             |100
Red light      | color9              | 91             |101
Green light    | color10             | 92             |102
Yellow light   | color11             | 93             |103
Blue light     | color12             | 94             |104
Magenta light  | color13             | 95             |105
Cyan light     | color14             | 96             |106
White light    | color15             | 97             |107
Default fg     | foreground          | 39             |N/A
Default bg     | background          | N/A            |49


For formatting text
--------------------------------------------------------------------------------

Format              | ANSI code (set) | ANSI code (reset)
--------------------|-----------------|----------------
All                 | N/A             |0
Bold (more intense) | 1               |1
Dim (less intense)  | 2               |2
Italic              | 3               |3
Underline           | 4               |4
Slow blink          | 5               |5
Rapid blink         | 6               |6
Reverse [1]         | 7               |7
Conceal/hidden [2]  | 8               |8
Crossed-out         | 9               |9

NOTES:
- [1] Invert foreground/background colors
- [2] Useful for passwords
