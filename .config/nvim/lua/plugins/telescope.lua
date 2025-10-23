-- lua/plugins/telescope.lua

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- 依赖插件列表
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- C 编译器（gcc 或 clang）是必须的
            build = "make",
            -- 如果编译失败，cond 为 false 就不会加载这个插件
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
    },
    -- 插件配置
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local function find_command()
            if 1 == vim.fn.executable("rg") then
                return { "rg", "--files", "--color", "never", "-g", "!.git" }
            elseif 1 == vim.fn.executable("fd") then
                return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
            elseif 1 == vim.fn.executable("fdfind") then
                return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
            elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
                return { "find", ".", "-type", "f" }
            elseif 1 == vim.fn.executable("where") then
                return { "where", "/r", ".", "*" }
            end
        end

        telescope.setup({
            -- 默认配置
            defaults = {
                -- 窗口布局
                layout_strategy = "horizontal", -- "vertical", "cursor", "flex"
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                    vertical = {
                        mirror = false,
                    },
                },
                -- 排序算法
                sorting_strategy = "ascending",
                -- 映射
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<C-s>"] = actions.file_split,
                        ["<C-v>"] = actions.file_vsplit,
                        ["<PageUp>"] = actions.preview_scrolling_up,
                        ["<PageDown>"] = actions.preview_scrolling_down,

                    },
                    n = {
                        ["<esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<C-s>"] = actions.file_split,
                        ["<C-v>"] = actions.file_vsplit,
                        ["<PageUp>"] = actions.preview_scrolling_up,
                        ["<PageDown>"] = actions.preview_scrolling_down,
                    },
                },
                -- 其他默认设置
                file_ignore_patterns = { "node_modules", "%.git/" }, -- 忽略的文件/目录
                prompt_prefix = "  ", -- Nerd Font 搜索图标
                selection_caret = " ", -- Nerd Font 选择图标
            },
            -- 选择器 (pickers) 的特定配置
            pickers = {
                find_files = {
                    find_command = find_command,
                    hidden = true, -- 显示隐藏文件
                },
                live_grep = {
                    -- `rg` 是 live_grep 的最佳伴侣
                    -- vimgrep_arguments = {
                    --     "rg",
                    --     "--column",
                    --     "--line-number",
                    --     "--no-heading",
                    --     "--color=always",
                    --     "--smart-case",
                    --     "--hidden",
                    -- },
                },
                buffers = {
                    sort_mru = true, -- 按最近使用的顺序列出缓冲区
                },
            },
            -- 扩展配置
            extensions = {
                fzf = {
                    fuzzy = true, -- 启用 FZF 的模糊匹配算法
                    override_generic_sorter = true, -- 重写 Telescope 的通用排序器
                    override_file_sorter = true, -- 重写 Telescope 的文件排序器
                    case_mode = "smart_case", -- 智能大小写匹配
                },
            },
        })

        -- 启用 fzf-native 扩展
        -- 这一步至关重要！
        pcall(telescope.load_extension, "fzf")

        -- 定义快捷键
        local builtin = require("telescope.builtin")
        local map = vim.keymap.set

        map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
        map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
        map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        map("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
        map("n", "<leader>fr", builtin.resume, { desc = "Resume Last Search" })
        -- Git 相关
        map("n", "<leader>gc", builtin.git_commits, { desc = "Git Commits" })
        map("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
        -- LSP 相关
        map("n", "<leader>ld", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
        map("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP Workspace Symbols" })
    end,
}
