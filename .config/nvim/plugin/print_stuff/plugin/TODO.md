# General

- Convert to lua
- Add Print commands for other options:
    - path
    - suffixesadd

    - suffixes

    - iskeyword
    - isfname

    - keywordprg

    - omnifunc

    - matchpairs

    - define
    - include
    - includeexpr

# Options

- Read the following for ideas about how to present options:
    - `:h options.txt`
    - `:h :set...`

- Ideas for how to present options:
    - Indicate if the option is
        1. **global**: `[g]`
        2. **local** to window, buffer, tab: `[w]`, `[b]`, `[t]`
        3. **global** _and_ **local**
            - Print both values
	- Indicate the "data type"
		- String: `{s}`
			- List (comma-separated): `{s-l}`
			- Flags (not comma-separated): `{s-f}`
		- Boolean: `{b}`
		- Number: `{n}`

# Mappings

- Read the following for ideas about how to present mappings:
    - `:h :map...`

- Ideas for how to present mappings:
    - Add Print command for mappings
        - Buffer-local mappings first
        - Global mappings second
    - Indicate if a buffer-local mapping overrides a global mapping or default keybinding
    - Indicate if a global mapping overrides a default keybinding
    - Do not show mappings that map from `<Plug>`
    - Include where last set

# Variables

- Ideas for how to present variables:
    - Add Print command for buffer-local variables
    - Indicate where last set
