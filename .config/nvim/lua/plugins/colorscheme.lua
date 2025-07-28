return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme dracula]])
        end,
    },
    {
        "loctvl842/monokai-pro.nvim",
        lazy = true,
        priority = 1000,
    },
}
