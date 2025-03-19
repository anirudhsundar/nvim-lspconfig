local util = require 'lspconfig.util'

local function get_compile_commands_path()
  local files = vim.fs.find('tablegen_compile_commands.yml', { path = vim.fn.expand('%:p:h'), upward = true })
  if #files > 0 then
    local file = files[1]
    return '--tablegen-compilation-database=' .. vim.fs.dirname(file) .. '/tablegen_compile_commands.yml'
  end

  return ''
end

return {
  default_config = {
    cmd = { 'tblgen-lsp-server', get_compile_commands_path() },
    filetypes = { 'tablegen' },
    root_dir = function(fname)
      return util.root_pattern 'tablegen_compile_commands.yml'(fname)
        or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
  },
  docs = {
    description = [[
https://mlir.llvm.org/docs/Tools/MLIRLSP/#tablegen-lsp-language-server--tblgen-lsp-server

The Language Server for the LLVM TableGen language

`tblgen-lsp-server` can be installed at the llvm-project repository (https://github.com/llvm/llvm-project)
]],
  },
}
