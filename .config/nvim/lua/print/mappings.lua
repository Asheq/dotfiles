-- TODO: Fix

local util = require("util")

local M = {}

-- Helpers
-- ============================================================================

local valid_modes = { "n", "v", "s", "x", "o", "i", "l", "c", "t", "!" }
local valid_mode_set = {}
for _, m in ipairs(valid_modes) do
	valid_mode_set[m] = true
end

local mode_names = {
	["n"] = "Normal (n)",
	["v"] = "Visual + Select (v)",
	["s"] = "Select (s)",
	["x"] = "Visual (x)",
	["o"] = "Operator-pending (o)",
	["i"] = "Insert (i)",
	["l"] = "Insert + Comand-line + Lang-Arg (l)",
	["c"] = "Command-line (c)",
	["t"] = "Terminal (t)",
	["!"] = "Insert + Command-line (!)",
	-- [""] = "Normal + Visual + Operator-pending",
}

---@param map vim.api.keyset.get_keymap
---@return boolean
local function is_plug_mapping(map)
	local lhs = map.lhs or ""
	return lhs:find("<Plug>") ~= nil
end

---@param map vim.api.keyset.get_keymap
---@return string
local function get_rhs_display(map)
	if map.callback then
		return "<Lua func>"
	end
	return map.rhs or ""
end

---Return a copy of valid mode tokens accepted by print_mappings.
---@return string[]
function M.valid_modes()
	local out = {}
	for _, m in ipairs(valid_modes) do
		table.insert(out, m)
	end
	return out
end

-- Validate and normalize a list of mode tokens
-- Returns nil when modes is nil/empty
---@param modes? string[]
---@return string[]? normalized_modes
---@return string? err
function M.normalize_modes(modes)
	if not modes or not modes[1] then
		return nil, nil
	end

	local seen = {}
	local out = {}
	for _, m in ipairs(modes) do
		if not valid_mode_set[m] then
			return nil, ("Invalid mode '%s'. Allowed: %s"):format(m, table.concat(valid_modes, " "))
		end
		if not seen[m] then
			seen[m] = true
			table.insert(out, m)
		end
	end

	return out, nil
end

-- Print a single mapping
-- ============================================================================

---@param map vim.api.keyset.get_keymap
---@param printer Printer
---@param overrides_global? vim.api.keyset.get_keymap  -- the global mapping it overrides, if any
local function print_mapping(map, printer, overrides_global)
	local lhs = map.lhs:gsub(" ", "<Space>")
	local scope = map.buffer ~= 0 and "buf" or "global"
	local mode = map.mode
	printer:append_line({
		{ " " .. lhs .. " ",   "TermCursor" },
		{ " " .. scope,        "Identifier" },
		{ " [" .. mode .. "]", "NonText" },
	}, 1)

	local rhs = get_rhs_display(map)
	printer:append_line({
		{ "rhs: ", "Normal" },
		{ rhs,     "String" },
	}, 2)

	local filename = util.get_sid_info(map.sid)
	if filename then
		local filename_hl = util.get_filename_hl()
		printer:append_line({
			{ " ➤ " .. filename, filename_hl },
		}, 2)
	end

	if overrides_global then
		local g_rhs = get_rhs_display(overrides_global)
		printer:append_line({
			{ "global rhs: ", "Normal" },
			{ g_rhs,          "NonText" },
		}, 2)

		local g_filename = util.get_sid_info(overrides_global.sid)
		if g_filename then
			local g_filename_hl = util.get_filename_hl()
			printer:append_line({
				{ g_filename and (" ➤ " .. g_filename) or "", g_filename_hl },
			}, 2)
		end
	end
end

-- Print all mappings for a single mode
-- ============================================================================

---@param mode string
---@param printer? Printer
local function print_mode(mode, printer)
	local own_printer = false
	if not printer then
		printer = util.new_printer({ history = true })
		own_printer = true
	end

	local mode_label = mode_names[mode] or mode
	local extra_space = math.ceil((vim.opt.columns:get() - #mode_label) / 2)
	printer:append_line({ { mode_label .. string.rep(" ", extra_space), "Underlined" } }, 0)

	-- Get global and buffer-local mappings
	local global_maps = vim.api.nvim_get_keymap(mode)
	local buf_maps = vim.api.nvim_buf_get_keymap(0, mode)

	-- Build a lookup of global mappings by lhs for override detection
	local global_by_lhs = {}
	for _, map in ipairs(global_maps) do
		if not is_plug_mapping(map) then
			global_by_lhs[map.lhs] = map
		end
	end

	-- Collect all mappings (buffer-local first, then global)
	-- Track which global lhs are overridden by buffer-local
	local overridden_global_lhs = {}

	-- Print buffer-local mappings
	local has_buf_local = false
	for _, map in ipairs(buf_maps) do
		if not is_plug_mapping(map) then
			has_buf_local = true
			local overrides = global_by_lhs[map.lhs]
			overridden_global_lhs[map.lhs] = true
			print_mapping(map, printer, overrides)
		end
	end

	-- Print global mappings (skip those overridden by buffer-local)
	local has_global = false
	for _, map in ipairs(global_maps) do
		if not is_plug_mapping(map) and not overridden_global_lhs[map.lhs] then
			has_global = true
			print_mapping(map, printer)
		end
	end

	if not has_buf_local and not has_global then
		printer:append_line({ { "(no mappings)", "Comment" } }, 1)
	end

	if own_printer then
		printer:flush()
	end
end

-- Print all mappings for multiple modes
-- ============================================================================

---@param modes? string[]
function M.print_mappings(modes)
	modes = modes or { "n", "x", "o", "i", "c", "t" }

	local printer = util.new_printer({ history = true })

	for _, mode in ipairs(modes) do
		print_mode(mode, printer)
	end

	printer:flush()
end

return M
