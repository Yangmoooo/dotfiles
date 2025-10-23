-- [[ 全局配置 ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- [[ 其他配置 ]]
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy") -- 加载 lazy.nvim 配置，如发生问题可移至全局配置后加载

print("闻说你时常在下午 来这里寄信件")
