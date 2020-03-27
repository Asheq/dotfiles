### ANSI codes to color text

  Color name  | Color config number | ANSI code (fg/bg)
--------------|---------------------|------------------
Black         | 0                   | 30/40
Red           | 1                   | 31/41
Green         | 2                   | 32/42
Yellow        | 3                   | 33/43
Blue          | 4                   | 34/44
Magenta       | 5                   | 35/45
Cyan          | 6                   | 36/46
White         | 7                   | 37/47
--------------|---------------------|------------------
Light black   | 8                   | 90/100
Light red     | 9                   | 91/101
Light green   | 10                  | 92/102
Light yellow  | 11                  | 93/103
Light blue    | 12                  | 94/104
Light magenta | 13                  | 95/105
Light cyan    | 14                  | 96/106
Light white   | 15                  | 97/107
--------------|---------------------|------------------
Default       | fg/bg               | 39/49


### ANSI codes to format text

Format type         | ANSI code (set/reset)
--------------------|----------------------
All                 | N.A./0
Bold (more intense) | 1/21
Dim (less intense)  | 2/22
Italic              | 3/23
Underline           | 4/24
Slow blink          | 5/25
Rapid blink         | 6/26
Reverse [1]         | 7/27
Conceal/hidden [2]  | 8/28
Crossed-out         | 9/29

NOTES:
[1] Invert foreground/background colors
[2] Useful for passwords
