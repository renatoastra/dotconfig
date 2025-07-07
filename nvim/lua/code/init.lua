-- Ponto de entrada para a configuração do VS Code Neovim.

local M = {}
local keymaps = require("code.keymaps")
M.load = function()
	keymaps.load()
end

return M
