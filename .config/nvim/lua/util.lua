local M = {}

---@return string | nil
function M.get_selected_text()
	local mode = vim.fn.mode()
	-- NOTE: 22 = ASCII decimal value of <C-v> key
	if not (mode == "v" or mode == "V" or mode == "\022") then
		return nil
	end

	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
	return table.concat(lines, "\n")
end

---@param sid integer
---@return string | nil
function M.get_filename(sid)
	if sid == 0 then
		return nil
	end

	if sid == -1 then
		return "[modeline]"
	end

	if sid < 0 then
		return tostring(sid)
	end

	local scripts = vim.fn.getscriptinfo({ sid = sid })

	if scripts[1] and scripts[1].name and scripts[1].name ~= "" then
		local name = scripts[1].name

		local runtime = vim.env.VIMRUNTIME
		if runtime and runtime ~= "" and name:sub(1, #runtime) == runtime then
			name = "$VIMRUNTIME" .. name:sub(#runtime + 1)
		end

		local vimconfig = vim.env.HOME .. "/.config/nvim"
		if name:sub(1, #vimconfig) == vimconfig then
			name = "$VIMCONFIG" .. name:sub(#vimconfig + 1)
		end

		local plug_home = vim.g.plug_home
		if plug_home and plug_home ~= "" and name:sub(1, #plug_home) == plug_home then
			name = "$PLUGHOME" .. name:sub(#plug_home + 1)
		end

		return name
	end

	return tostring(sid)
end

---@param filename string
---@return string | nil
function M.get_filename_hl(filename)
	if vim.startswith(filename, "$VIMCONFIG") then
		return "DiagnosticError"
	elseif vim.startswith(filename, "$VIMRUNTIME") then
		return "DiagnosticError"
	else
		return "DiagnosticWarn"
	end
end

---@class Printer
---@field private chunks any[]
---@field private history boolean
---@field private opts vim.api.keyset.echo_opts
---@field append_line fun(self: Printer, line_chunks: any[], indent?: integer)
---@field flush fun(self: Printer)

---@param conf? { history?: boolean, opts?: vim.api.keyset.echo_opts }
---@return Printer
function M.new_printer(conf)
	local buf = {
		chunks = {},
		history = conf and conf.history or false,
		opts = conf and conf.opts or {},
	}

	---Append a single line beginning with an optional indent, and terminating with a newline
	---@param line_chunks any[]
	---@param indent? integer
	function buf:append_line(line_chunks, indent)
		local indent_str = string.rep("  ", indent and (indent * 2) or 0)
		table.insert(self.chunks, { indent_str, "Normal" })
		for _, chunk in ipairs(line_chunks) do
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
