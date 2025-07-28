return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- 安装或更新时运行命令
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vim",
                "vimdoc",
                "lua",
                "bash",
                "markdown",
                "json",
                "yaml",
                "toml",
                "c",
                "python",
                "rust",
            },
            sync_install = false, -- 异步安装解析器
            auto_install = true,  -- 自动安装缺失的解析器

            highlight = {
                enable = true, -- 启用语法高亮
                -- disable = { "c", "rust" },  -- 你可以禁用某些语言的高亮 (如果需要)
                -- additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true, -- 启用基于 treesitter 的缩进 (可选)
            },
        })
    end,
}
