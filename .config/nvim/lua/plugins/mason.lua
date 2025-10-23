return {
    -- Mason 本身，用于管理 LSP 服务器、DAP 适配器、Linter、Formatter
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- Mason 和 lspconfig 的桥梁，简化 LSP 服务器安装后的配置
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {
            -- 确保这些 LSP 服务器已经通过 Mason 安装
            -- :Mason 命令打开界面安装: pyright, black, ruff
            ensure_installed = {
                "ruff", -- Python LSP 服务器
                -- "ruff_lsp", -- 可选的 Ruff LSP (如果你更喜欢 Ruff 的诊断)
                -- "lua_ls",   -- Lua LSP (用于 Neovim 配置本身)
                "rust_analyzer", -- Rust LSP 服务器
                "clangd",        -- C/C++ LSP 服务器
            },
            -- 自动为通过 Mason 安装的 LSP 调用 lspconfig 的 setup
            automatic_installation = true, -- 如果未安装，尝试自动安装
        },
    },
}
