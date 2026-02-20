local util = require("util")

local M = {}

-- Helpers
-- ============================================================================

local mode_names = {
	["n"] = "Normal",
	["i"] = "Insert",
	["v"] = "Visual+Select",
	["x"] = "Visual",
	["s"] = "Select",
	["o"] = "Operator-pending",
	["c"] = "Command-line",
	["t"] = "Terminal",
	["l"] = "Lang-Arg",
	["!"] = "Insert+Command",
	[""] = "NVO",
}

---@param map table
---@return boolean
local function is_plug_mapping(map)
	local lhs = map.lhs or ""
	return lhs:find("<Plug>") ~= nil
end

---@param map table
---@return string
local function get_rhs_display(map)
	if map.callback then
		return "<Lua function>"
	end
	return map.rhs or ""
end

---@param map table
---@return string|nil
local function get_set_location(map)
	local sid = map.sid or 0
	local filename = util.get_filename(sid)
	if filename and map.lnum and map.lnum > 0 then
		return filename .. ":" .. map.lnum
	end
	return filename
end

-- Print a single mapping
-- ============================================================================

---@param map table
---@param printer EchoBuffer
---@param overrides_global? table  -- the global mapping it overrides, if any
local function print_mapping(map, printer, overrides_global)
	local scope_label = map.buffer ~= 0 and "buf-local" or "global"

	local attrs = {}
	if map.noremap == 1 then table.insert(attrs, "nore") end
	if map.silent == 1 then table.insert(attrs, "silent") end
	if map.expr == 1 then table.insert(attrs, "expr") end
	if map.nowait == 1 then table.insert(attrs, "nowait") end
	local attr_str = #attrs > 0 and (" " .. table.concat(attrs, ",")) or ""

	local rhs = get_rhs_display(map)
	local location = get_set_location(map)

	printer:append_line({
		{ " " .. map.lhs .. " ", "TermCursor" },
		{ " " .. scope_label,    "Identifier" },
		{ attr_str,              "NonText" },
	}, 1)

	printer:append_line({
		{ "→ ", "Normal" },
		{ tostring(rhs), "String" },
	}, 2)

	if location then
		printer:append_line({
			{ "set: ",            "Normal" },
			{ tostring(location), "DiagnosticInfo" },
		}, 2)
	end

	if overrides_global then
		local global_rhs = get_rhs_display(overrides_global)
		local global_location = get_set_location(overrides_global)

		printer:append_line({
			{ "overrides global → ", "DiagnosticWarn" },
			{ tostring(global_rhs), "DiagnosticWarn" },
		}, 2)

		if global_location then
			printer:append_line({
				{ "global set: ",            "Normal" },
				{ tostring(global_location), "DiagnosticWarn" },
			}, 2)
		end
	end
end

-- Main functions
-- ============================================================================

---Print all mappings for a given mode
---@param mode string
---@param printer? Printer
function M.print_mode(mode, printer)
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

---Print all mappings for common modes
---@param modes? string[]
function M.print_all(modes)
	modes = modes or { "n", "x", "o", "i", "c", "t" }

	local printer = util.new_printer({ history = true })

	for _, mode in ipairs(modes) do
		M.print_mode(mode, printer)
	end

	printer:flush()
end

return M
