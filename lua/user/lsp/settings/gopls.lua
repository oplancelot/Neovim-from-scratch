require('lspconfig').gopls.setup({
  gopls_cmd = {install_root_dir .. '/go/gopls'},
  fillstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = true
})
local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.diagnostics.revive,
  null_ls.builtins.formatting.golines.with({
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  })
}
-- for go.nvim
local gotest = require("go.null_ls").gotest()
local gotest_codeaction = require("go.null_ls").gotest_action()
local golangci_lint = require("go.null_ls").golangci_lint()
table.insert(sources, gotest, golangci_lint)
table.insert(sources, gotest_codeaction)
null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })

-- alternatively
null_ls.register(gotest)

