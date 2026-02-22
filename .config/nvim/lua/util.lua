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

---@param sid integer | nil
---@return string | nil
function M.get_filename(sid)
	if not sid or sid == 0 then
		return nil
	end

	local special_sids = {
		[-1] = "[modeline]",
		[-2] = "[--cmd]",
		[-3] = "[-c]",
		[-4] = "[env variable]",
		[-5] = "[reset b/c of error]",
		[-6] = "[none]",
		[-7] = "[changed window size]",
		[-8] = "[Lua script/chunk]",
		[-9] = "[API client]",
		[-10] = "[sourced string]",
	}

	if sid < 0 then
		return special_sids[sid] or tostring(sid)
	end

	local scripts = vim.fn.getscriptinfo({ sid = sid })
	if scripts[1] and scripts[1].name and scripts[1].name ~= "" then
		local filename = scripts[1].name

		local prefixes = {
			{ vim.env.VIMRUNTIME,              "$VIMRUNTIME" },
			{ vim.env.HOME .. "/.config/nvim", "$VIMCONFIG" },
			{ vim.g.plug_home,                 "$PLUGHOME" },
		}
		for _, pair in ipairs(prefixes) do
			local prefix, alias = pair[1], pair[2]
			if prefix and prefix ~= "" and vim.startswith(filename, prefix) then
				filename = alias .. filename:sub(#prefix + 1)
				break
			end
		end

		return filename
	end

	return tostring(sid)
end

---@param filename string | nil
---@return string
function M.get_filename_hl(filename)
	if not filename then
		return "DiagnosticError"
	end

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
---@field append_line fun(self: Printer, chunks: any[], indent?: integer)
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
	---@param chunks any[]
	---@param indent? integer
	function buf:append_line(chunks, indent)
		local indent_str = string.rep("  ", indent and (indent * 2) or 0)
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
