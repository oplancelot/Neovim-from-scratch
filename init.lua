-- [[ 基础配置 ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.oscyank_term = "default"    -- Windows Terminal 用默认
vim.g.oscyank_silent = true       -- 不显示提示信息
vim.g.have_nerd_font = true       -- 如果安装了 Nerd Font，设为 true

vim.opt.number = true
-- vim.opt.relativenumber = true     -- 可选相对行号
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ 基础快捷键 ]]
-- 搜索高亮清除
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic 快捷键
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "打开诊断 Quickfix 列表" })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "文件树切换 (nvim-tree)" })

-- 终端模式快速退出
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "退出终端模式" })

-- 窗口导航：Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "切换到左侧窗口" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "切换到右侧窗口" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "切换到下方窗口" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "切换到上方窗口" })

-- [[ 基础自动命令 ]]
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "复制文本时高亮",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ 安装并引导 lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("克隆 lazy.nvim 失败:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ 配置并加载插件 ]]
require("lazy").setup({
  "tpope/vim-sleuth", -- 自动检测 tabstop 和 shiftwidth

  { "Bilal2453/luvit-meta", lazy = true },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { import = "plugins" },  -- 从 lua/plugins 目录导入插件列表
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

