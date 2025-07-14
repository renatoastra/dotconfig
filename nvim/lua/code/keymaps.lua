local M = {}

M.load = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	vim.keymap.set("n", "<Space>", "<nop>", { noremap = true, silent = true })
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	-- yank to system clipboard
	keymap({ "n", "v" }, "<leader>y", '"+y', opts)

	-- paste from system clipboard
	keymap({ "n", "v" }, "<leader>p", '"+p', opts)

	-- better indent handling
	keymap("v", "<", "<gv", opts)
	keymap("v", ">", ">gv", opts)

	-- move text up and down
	keymap("v", "J", ":m .+1<CR>==", opts)
	keymap("v", "K", ":m .-2<CR>==", opts)
	keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
	keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

	-- paste preserves primal yanked piece
	keymap("v", "p", '"_dP', opts)

	-- removes highlighting after escaping vim search
	keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

	-- explorer
	keymap({ "n", "v" }, "<leader>we", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

	-- zen mode
	keymap({ "n", "v" }, "<leader>wz", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>")

	-- toogle terminal
	keymap({ "n", "v" }, "<leader>pn", "<cmd>lua require('vscode').action('workbench.action.togglePanel')<CR>")

	-- workBench go to nextEditor
	keymap({ "n", "v" }, "<leader>wn", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>")

	-- workBench go to previousEditor
	keymap({ "n", "v" }, "<leader>wp", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>")

	-- workBench close all editor
	keymap({ "n", "v" }, "<leader>wqa", "<cmd>lua require('vscode').action('workbench.action.closeAllEditors')<CR>")

	-- workBench reopen previous closed window
	keymap({ "n", "v" }, "<leader>wt", "<cmd>lua require('vscode').action('workbench.action.reopenClosedEditor')<CR>")

	-- workBench split vertical
	keymap({ "n", "v" }, "<leader>ws", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>")

	-- workBench split horizontal
	keymap({ "n", "v" }, "<leader>wsh", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>")

	-- workBench Focus left editor
	keymap("n", "<leader>wh", "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>", opts)
	keymap("n", "<leader>wl", "<cmd>lua require('vscode').action('workbench.action.focusActiveEditorGroup')<CR>", opts)
	keymap("n", "<leader>wk", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>", opts)
	keymap("n", "<leader>wj", "<cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>", opts)

	--workBench joinAll Groups
	keymap({ "n", "v" }, "<leader>wj", "<cmd>lua require('vscode').action('workbench.action.joinAllGroups')<CR>")
	-- quick open
	keymap({ "n", "v" }, "<leader><Space>", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
	-- call vscode commands from neovim
	keymap("n", "<leader>v", "<cmd>lua require('vscode').action('workbench.action.toggleCenteredLayout')<CR>", opts)
	-- general keymaps
	keymap(
		{ "n", "v" },
		"<leader>t",
		"<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>"
	)
	keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
	keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
	keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
	keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
	keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
	keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
	keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
	keymap({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
	keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
	--
	-- harpoon keymaps
	--
	keymap({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
	keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
	keymap({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
	keymap({ "n", "v" }, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
	keymap({ "n", "v" }, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
	keymap({ "n", "v" }, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
	keymap({ "n", "v" }, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
	keymap({ "n", "v" }, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
	keymap({ "n", "v" }, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
	keymap({ "n", "v" }, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
	keymap({ "n", "v" }, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
	keymap({ "n", "v" }, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

	-- project manager keymaps
	keymap({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
	keymap({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")

	keymap({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")

	-- Navegar entre parênteses/chaves usando comandos nativos do VSCode
	keymap({ "n", "v" }, "<leader>]", "<cmd>lua require('vscode').action('editor.action.jumpToBracket')<CR>", opts)
	keymap({ "n", "v" }, "<leader>[", "<cmd>lua require('vscode').action('editor.action.jumpToBracket')<CR>", opts)
	keymap({ "n", "v" }, "<leader>5", "%", opts)

	keymap({ "n", "v" }, "<leader>dall", "ggVGd")
	keymap({ "n", "v" }, "<leader>call", "ggVGy")

	-- Comentários inteligentes usando o sistema do VS Code
	keymap("n", "<leader>/", "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>", opts)
	keymap("v", "<leader>/", "<cmd>lua require('vscode').action('editor.action.commentLine')<CR>", opts)
	keymap("n", "<leader>cm", "<cmd>lua require('vscode').action('editor.action.blockComment')<CR>", opts)
	keymap("v", "<leader>cm", "<cmd>lua require('vscode').action('editor.action.blockComment')<CR>", opts)

	-- Seleção Inteligente (Expandir/Diminuir seleção de bloco)
	keymap("v", "<leader>v", "<cmd>lua require('vscode').action('editor.action.smartSelect.expand')<CR>", opts)
	-- Para diminuir, o atalho padrão do VSCode (Shift+Alt+Seta Esquerda) geralmente funciona bem.

	-- Renomeação de Símbolos (Refatoração)
	keymap("n", "<leader>rn", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)

	-- Mover para Definição e Referências
	keymap("n", "gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", opts)
	keymap("n", "gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", opts)

	print("🚀 - [CODE] - KEYMAPS LOADED")

	return keymap
end

return M
