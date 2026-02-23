#!/usr/bin/env lua

--
-- Generates terminal-editor-mods.json for Karabiner-Elements.
--
-- This swaps Cmd<->Ctrl (with optional Shift) for specific keys
-- in terminal/editor apps, excluding certain external keyboards.
--
-- Usage:
--   lua generate-terminal-editor-mods.lua > terminal-editor-mods.json
--

-- ─── Configuration ───────────────────────────────────────────────

-- Devices to exclude from the remapping (e.g. external keyboards
-- that already have the right layout).
local excluded_devices = {
	{ vendor_id = 10730, product_id = 258 },
	{ vendor_id = 5824,  product_id = 10203 },
}

-- Apps where the swap should be active (regex bundle identifiers).
local app_bundle_ids = {
	"^org\\.vim\\.MacVim$",
	"^net\\.kovidgoyal\\.kitty$",
	"^io\\.alacritty$",
	"^com\\.qvacua\\.VimR$",
	"^org\\.gnu\\.Emacs$",
	"^com\\.neovide\\.neovide$",
}

-- Keys to swap. Every key listed here gets a symmetric Cmd<->Ctrl mapping.
local swap_keys = {
	-- Letters
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
	"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	-- Other
	"escape", "0", "hyphen", "equal_sign", "delete_or_backspace", "delete_forward",
	"open_bracket", "close_bracket", "backslash",
	"semicolon", "quote", "return_or_enter",
	"comma", "period", "slash",
	"page_up", "page_down", "home", "end",
	"non_us_backslash", "non_us_pound",
}

local rule_description = "Swap Cmd<->Ctrl and Cmd+Shft<->Ctrl+Shft "
	.. "(except when paired with function keys, `, 1..9, Tab, Caps Lock, Space, arrows)"

-- ─── JSON Encoder ────────────────────────────────────────────────

local encode -- forward declaration

local function encode_string(s)
	-- Escape backslashes and double-quotes.
	s = s:gsub("\\", "\\\\")
	s = s:gsub('"', '\\"')
	return '"' .. s .. '"'
end

local function indent(depth)
	return string.rep("	", depth)
end

-- Encode a Lua value as a pretty-printed JSON string.
-- Tables with only sequential integer keys are treated as arrays.
function encode(value, depth)
	depth = depth or 0
	local vtype = type(value)

	if vtype == "string" then
		return encode_string(value)
	elseif vtype == "number" then
		return tostring(value)
	elseif vtype == "boolean" then
		return value and "true" or "false"
	elseif vtype == "table" then
		-- Detect array vs object.
		local is_array = #value > 0
		if is_array then
			-- Check if all values are simple (string/number/bool) for inline formatting.
			local all_simple = true
			for _, v in ipairs(value) do
				if type(v) == "table" then
					all_simple = false
					break
				end
			end
			if all_simple then
				local parts = {}
				for _, v in ipairs(value) do
					parts[#parts + 1] = encode(v, depth + 1)
				end
				return "[" .. table.concat(parts, ", ") .. "]"
			else
				local parts = {}
				for _, v in ipairs(value) do
					parts[#parts + 1] = indent(depth + 1) .. encode(v, depth + 1)
				end
				return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent(depth) .. "]"
			end
		else
			-- Object — use the __order key if present to control output order.
			local keys = value.__order
			if not keys then
				keys = {}
				for k in pairs(value) do
					if k ~= "__order" then
						keys[#keys + 1] = k
					end
				end
				table.sort(keys)
			end
			local parts = {}
			for _, k in ipairs(keys) do
				local v = value[k]
				parts[#parts + 1] = indent(depth + 1)
					.. encode_string(k) .. ": "
					.. encode(v, depth + 1)
			end
			return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent(depth) .. "}"
		end
	end
	error("unsupported type: " .. vtype)
end

-- ─── Manipulator Builder ─────────────────────────────────────────

--- Build the shared conditions block.
local function make_conditions()
	local device_ids = {}
	for _, dev in ipairs(excluded_devices) do
		device_ids[#device_ids + 1] = {
			__order    = { "vendor_id", "product_id" },
			vendor_id  = dev.vendor_id,
			product_id = dev.product_id,
		}
	end

	return {
		{
			__order = { "type", "identifiers" },
			type = "device_unless",
			identifiers = device_ids,
		},
		{
			__order = { "bundle_identifiers", "type" },
			bundle_identifiers = app_bundle_ids,
			type = "frontmost_application_if",
		},
	}
end

local conditions = make_conditions()

--- Build a single manipulator entry.
---@param key_code string
---@param from_mod string  "command" or "control"
---@param to_mod   string  "control" or "command"
local function make_manipulator(key_code, from_mod, to_mod)
	return {
		__order = { "conditions", "from", "to", "type" },
		conditions = conditions,
		from = {
			__order = { "key_code", "modifiers" },
			key_code = key_code,
			modifiers = {
				__order   = { "mandatory", "optional" },
				mandatory = { from_mod },
				optional  = { "shift" },
			},
		},
		to = {
			{
				__order   = { "key_code", "modifiers" },
				key_code  = key_code,
				modifiers = { to_mod },
			},
		},
		type = "basic",
	}
end

-- ─── Assemble ────────────────────────────────────────────────────

local manipulators = {}

-- First half: Cmd -> Ctrl
for _, key in ipairs(swap_keys) do
	manipulators[#manipulators + 1] = make_manipulator(key, "command", "control")
end

-- Second half: Ctrl -> Cmd
for _, key in ipairs(swap_keys) do
	manipulators[#manipulators + 1] = make_manipulator(key, "control", "command")
end

local config = {
	__order = { "title", "rules" },
	title = "Mods for Terminals/Editors",
	rules = {
		{
			__order      = { "description", "manipulators" },
			description  = rule_description,
			manipulators = manipulators,
		},
	},
}

print(encode(config))
