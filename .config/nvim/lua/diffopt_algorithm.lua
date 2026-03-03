local M = {}

M.algorithms = { "myers", "minimal", "patience", "histogram" }

function M.set(algo)
	for _, a in ipairs(M.algorithms) do
		vim.opt.diffopt:remove("algorithm:" .. a)
	end
	vim.opt.diffopt:append("algorithm:" .. algo)
end

function M.select()
	vim.ui.select(M.algorithms, {
		prompt = "Select diff algorithm:",
	}, function(choice)
		if choice then
			M.set(choice)
		end
	end)
end

return M
