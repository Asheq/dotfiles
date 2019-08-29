function print_terminal_colors() {
  # Background
  for clbg in {40..47} {100..107} 49 ; do
    # Foreground
    for clfg in {30..37} {90..97} 39 ; do
      # Formatting
      for attr in {0..8} ; do
        # Print the result
        echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
      done
      echo # Newline
    done
  done
}

# Background values
# =================
#  40 - Black
#  41 - Red
#  42 - Green
#  43 - Yellow
#  44 - Blue
#  45 - Magenta
#  46 - Cyan
#  47 - Light gray
# 100 - Dark gray
# 101 - Light red
# 102 - Light green
# 103 - Light yellow
# 104 - Light blue
# 105 - Light magenta
# 106 - Light cyan
# 107 - White
#  49 - Default background color

# Foreground values
# =================
# 30 - Black
# 31 - Red
# 32 - Green
# 33 - Yellow
# 34 - Blue
# 35 - Magenta
# 36 - Cyan
# 37 - Light gray
# 90 - Dark gray
# 91 - Light red
# 92 - Light green
# 93 - Light yellow
# 94 - Light blue
# 95 - Light magenta
# 96 - Light cyan
# 97 - White
# 39 - Default foreground color

# Formatting values
# =================
## Set
## ---
# 1 - Bold/Bright
# 2 - Dim
# 3 - Italic
# 4 - Underline
# 5 - Blink (does not work in most terminal emulators)
# 6 - ???
# 7 - Reverse (invert the foreground and background colors)
# 8 - Hidden (useful for passwords)

## Reset
## -----
#  0 - Reset all attributes
# 21 - Reset bold/bright
# 22 - Reset dim
# 23 - Reset italic
# 24 - Reset underline
# 25 - Reset blink (does not work in most terminal emulators)
# 26 - Reset ???
# 27 - Reset reverse
# 28 - Reset hidden
