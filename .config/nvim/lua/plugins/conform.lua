-- formatter

return {
    'stevearc/conform.nvim',
    opts = {},
    lazy = true,
    config = function()
        require("conform").setup({
            formatters = {
                clang_format = {
                    prepend_args = { "--style=file:/home/yoko/.config/clangd/clang.format" }
                }
            },
            formatters_by_ft = {
                -- lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                rust = { "rustfmt", lsp_format = "fallback" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
            },
        })
    end,
}
