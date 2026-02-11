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

---@param chunks any[]
---@param indent? integer
---@param history? boolean
---@param opts? vim.api.keyset.echo_opts
function M.echo_with_indent(chunks, indent, history, opts)
	local indent_str = string.rep("  ", indent and (indent * 2) or 0)
	local indented_chunks = vim.deepcopy(chunks)
	table.insert(indented_chunks, 1, { indent_str, "Normal" })
	vim.api.nvim_echo(indented_chunks, history or true, opts or {})
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
