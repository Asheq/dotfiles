# TODO

- Convert to lua

- Read the following for ideas about how to present options:
    - `:h options.txt`
    - `:h :set...`

- Read the following for ideas about how to present mappings:
	- `:h :map...`

- Ideas for how to present options:
	- Highlight option values in a special color when value is different from __default__ value
		- Show `[Empty]` for __empty__ values so they are visible
    - Indicate if the option is
		1. __global__ (`[g]`)
		2. __local__ to window, buffer, tab (`[w]`, `[b]`, `[t]`)
		3. __global__ *and* __local__
			- Print both values

- Ideas for how to present mappings:
    - Add Print command for mappings
		- Buffer-local mappings first
		- Global mappings second
	- Indicate if a buffer-local mapping overrides a global mapping or default keybinding
	- Indicate if a global mapping overrides a default keybinding
	- Do not show mappings that map from `<Plug>`
	- Include where last set

- Ideas for how to present variables:
    - Add Print command for buffer-local variables
	- Indicate where last set

- Shorten `plugged` directory in "where last let" paths

- Add Print commands for other settings:
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
