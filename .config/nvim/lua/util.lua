local M = {}

---@return string|nil
function M.get_selected_text()
	local mode = vim.fn.mode()

	if not (mode == "v" or mode == "V" or mode == "\022") then
		return nil
	end

	local pos1 = vim.fn.getpos("v")
	local pos2 = vim.fn.getpos(".")

	if pos1[2] == 0 or pos2[2] == 0 then
		return nil
	end

	-- Normalize order
	if pos1[2] > pos2[2] or (pos1[2] == pos2[2] and pos1[3] > pos2[3]) then
		pos1, pos2 = pos2, pos1
	end

	pos1[1] = 0
	pos2[1] = 0

	local lines = vim.fn.getregion(pos1, pos2, { type = mode })
	return table.concat(lines, "\n")
end

---@class EchoBuffer
---@field private chunks any[]
---@field private history boolean
---@field private opts vim.api.keyset.echo_opts
---@field append_line fun(self: EchoBuffer, line_chunks: any[], indent?: integer)
---@field flush fun(self: EchoBuffer)

---@param conf? { history?: boolean, opts?: vim.api.keyset.echo_opts }
---@return EchoBuffer
function M.new_echo_buffer(conf)
	local buf = {
		chunks = {},
		history = conf and conf.history ~= nil and conf.history or false,
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

---@param sid integer
---@return string|nil
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
		if name:sub(1, #plug_home) == plug_home then
			name = "$PLUGHOME" .. name:sub(#plug_home + 1)
		end

		return name
	end

	return tostring(sid)
end

return M
