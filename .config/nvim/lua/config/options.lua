local opt = vim.opt

-- [[ 常规 ]]
opt.termguicolors = true  -- 启用 True Color 支持
opt.number = true         -- 显示行号
opt.relativenumber = true -- 显示相对行号
opt.scrolloff = 8         -- 光标上下保留 8 行
opt.sidescrolloff = 8     -- 光标左右保留 8 列
opt.wrap = false          -- 禁用自动换行
opt.mouse = "a"           -- 在所有模式下启用鼠标支持
opt.ignorecase = true     -- 搜索时忽略大小写
opt.smartcase = true      -- 如果搜索词包含大写字母，则不忽略大小写
opt.hlsearch = true       -- 高亮搜索结果
opt.incsearch = true      -- 输入时即时搜索
-- opt.showmode = false       -- 不显示当前模式

-- [[ 缩进 ]]
opt.tabstop = 4        -- 制表符宽度为 4 空格
opt.shiftwidth = 4     -- 自动缩进宽度为 4 空格
opt.expandtab = true   -- 使用空格代替制表符
opt.autoindent = true  -- 自动缩进
opt.smartindent = true -- 智能缩进

-- [[ 其他 ]]
opt.undofile = true     -- 启用撤销文件，在关闭 Neovim 后仍然可以撤销
opt.backup = false      -- 禁用备份文件
opt.writebackup = false -- 禁用写时备份
opt.swapfile = false    -- 禁用交换文件
opt.updatetime = 100    -- 更新时间间隔为 100 毫秒
opt.signcolumn = "yes"  -- 始终显示符号列
opt.colorcolumn = "80"  -- 显示垂直线

-- [[ Windows 特定配置 ]]
if vim.fn.has("win32") == 1 then
    -- 剪贴板集成
    opt.clipboard = "unnamedplus" -- 与系统剪贴板共享

    -- Shell 配置
    vim.o.shell = "pwsh"
    vim.o.shellcmdflag = "-NoLogo -Command "
    vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.o.shellpipe = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    opt.shellquote = ""
    opt.shellxquote = ""
end
