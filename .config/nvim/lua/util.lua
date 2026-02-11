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

return M
