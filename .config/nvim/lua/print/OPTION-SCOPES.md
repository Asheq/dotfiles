# Values

- Global option (scope = global)
    1.  global value
- Buffer-local option (scope = buf)
    1.  local value
    2.  global value = used to initialize the local value for a new buffer
- Window-local option (scope = win)
    1.  local value = local to a window and local to a specific buffer in that window
    2.  global value = local to a window and global to all buffers in that window
- Global-local option (scope = buf | win, global_local = true)
    1.  local value = ???
    2.  global value = fallback when the local value is "unset"

# More Details

## Global option (scope = global)

For a global option, there is just one global value across the entire application.

- Examples:
    - `background`
    - `tabline`
    - `wildmenu`

## Buffer-local options (scope = buf)

For a buffer-local option, each buffer has a local value. There is also a global value across the entire application that is used to initialize the local value for a new buffer.

Examples:

- `expandtab`
- `indentexpr`

You can think of a buffer-local option as having values stored in a dictionary like this:

```javascript
{
	"global_value": "foo", // This is used to initialize the local value for a new buffer
	"buffer1_local_value": "foo",
	"buffer2_local_value": "bar",
	"buffer3_local_value": "bar"
}
```

## Window-local option (scope = win)

For a window-local option, each window has a local value for _each_ buffer ever displayed in the window and a global value. The global value is used to initialize the local value for a buffer when it is displayed in that window for the first time.

- Examples:
    - `number`
    - `list`
    - `relativenumber`
    - `signcolumn`

You can think of a window-local option as having values stored in a dictionary like this:

```javascript
{
	"window1": {
		"global_value": "foo", // This is used to initialize the local value for a buffer when it is displayed in window1 for the first time
		"buffer1_local_value": "foo",
		"buffer2_local_value": "bar"
	},
	"window2": {
		"global_value": "baz", // This is used to initialize the local value for a buffer when it is displayed in window2 for the first time
		"buffer1_local_value": "bar",
		"buffer3_local_value": "foo",
		"buffer4_local_value": "bar"
	}
}
```
# Other Notes
- When splitting a window to create a new one, window-local option values are copied from the previous window. This is true for most options, but there are a few exceptions like `previewwindow`.
