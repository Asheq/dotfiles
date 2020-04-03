Comments
================================================================================

Capitalization and puncuation
--------------------------------------------------------------------------------

```bash
# Write comments in sentence case, where possible

echo 'hi' # This is a comment to the right of code

# This is a comment. There are periods here only because there are multiple
# sentences.

# someVar is a variable. Identifier case is not changed.
```

Titles, grouping, and folding
--------------------------------------------------------------------------------

### Non-foldable

```bash
# vim:foldmethod=marker

# Non-foldable heading 1
# ==============================================================================

Content goes here

# Non-foldable heading 2
# ------------------------------------------------------------------------------

Content goes here
```

### Foldable

```bash
# Foldable heading 1 {{{
# ==============================================================================

Content goes here

  # Foldable, nested heading 2 {{{
  # ----------------------------------------------------------------------------
  Content goes here
  # }}}

# }}}

# Foldable heading 2 {{{
# -------------------------------------------------------------------------------
Content goes here
# }}}
```

