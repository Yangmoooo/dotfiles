return {
  {
    "Mofiqul/dracula.nvim",
    opts = {
      overrides = function(colors)
        return {
          NormalFloat = { bg = colors.nontext },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
