local M = {}

local prefixes = {
	{ path = vim.env.VIMRUNTIME,              alias = "$VIMRUNTIME", highlight = "DiagnosticError" },
	{ path = vim.env.HOME .. "/.config/nvim", alias = "$VIMCONFIG",  highlight = "DiagnosticWarn" },
	{ path = vim.g.plug_home,                 alias = "$PLUGHOME",   highlight = "Special" },
}

local special_sids = {
	[-1] = "SID_MODELINE",
	[-2] = "SID_CMDARG",
	[-3] = "SID_CARG",
	[-4] = "SID_ENV",
	[-5] = "SID_ERROR",
	[-6] = "SID_NONE",
	[-7] = "SID_WINLAYOUT",
	[-8] = "SID_LUA",
	[-9] = "SID_API_CLIENT",
	[-10] = "SID_STR",
}

---@param sid integer | nil
---@alias SidSpecial { kind: "special", name: string }
---@alias SidScript { kind: "script", filename: string }
---@alias SidUnknown { kind: "unknown", sid: integer }
---@return SidSpecial | SidScript | SidUnknown | nil
function M.get_sid_info(sid)
	if not sid or sid == 0 then
		return nil
	end

	if sid < 0 then
		if special_sids[sid] then
			return { kind = "special", name = special_sids[sid] }
		else
			return { kind = "unknown", sid = sid }
		end
	end

	local scripts = vim.fn.getscriptinfo({ sid = sid })


	if scripts[1] and scripts[1].name and scripts[1].name ~= "" then
		return { kind = "script", filename = scripts[1].name }
	end

	return { kind = "unknown", sid = sid }
end

---@param filename string | nil
---@return { path: string, alias: string, highlight: string, rel: string } | nil
function M.get_filename_prefix(filename)
	if not filename then
		return nil
	end

	for _, p in ipairs(prefixes) do
		if vim.startswith(filename, p.path) then
			return {
				path = p.path,
				alias = p.alias,
				highlight = p.highlight,
				rel = string.sub(filename, #p.path + 1),
			}
		end
	end

	return nil
end

---@return string | nil
function M.get_selected_text()
	local mode = vim.fn.mode()

	local CTRL_V = "\022" -- NOTE: 22 = ASCII decimal value of <C-v> key
	if not (mode == "v" or mode == "V" or mode == CTRL_V) then
		return nil
	end

	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
	return table.concat(lines, "\n")
end

---@alias EchoChunk {[1]: string, [2]: string}

---@class Printer
---@field private chunks EchoChunk[]
---@field private history boolean
---@field private opts vim.api.keyset.echo_opts
---@field append_line fun(self: Printer, chunks: (EchoChunk | nil)[], indent?: integer)
---@field flush fun(self: Printer)

---@param conf? { history?: boolean, opts?: vim.api.keyset.echo_opts }
---@return Printer
---NOTE: Could use metatable approach to avoid creating new functions for each printer instance
function M.new_printer(conf)
	local buf = {
		chunks = {},
		history = (conf and conf.history) or false,
		opts = (conf and conf.opts) or {},
	}

	---Append a single line beginning with an optional indent, and terminating with a newline
	function buf:append_line(chunks, indent)
		local indent_str = string.rep(" ", indent or 0)
		table.insert(self.chunks, { indent_str, "Normal" })
		for _, chunk in ipairs(chunks) do
			if chunk then
				table.insert(self.chunks, chunk)
			end
		end
		table.insert(self.chunks, { "\n", "Normal" })
	end

	function buf:flush()
		if #self.chunks == 0 then
			return
		end
		vim.api.nvim_echo(self.chunks, self.history, self.opts)
	end

	return buf
end

return M
