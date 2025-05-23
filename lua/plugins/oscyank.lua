return {
	"ojroques/vim-oscyank",
	event = "VeryLazy",
	config = function()
		-- 设置终端类型（支持 Windows Terminal 的 OSC52）
		vim.g.oscyank_term = "default"
		vim.g.oscyank_silent = false

		-- 可视模式复制：<leader>y
		vim.keymap.set("v", "<leader>y", ":OSCYankVisual<CR>", { noremap = true, silent = true })

		-- 复制操作时自动触发 OSC52 同步
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				if vim.v.event.operator == "y" and vim.v.event.regname == "" then
					vim.cmd("OSCYankReg 0")
				end
			end,
		})
	end,
}
