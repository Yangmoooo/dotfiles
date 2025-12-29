return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    formatters = {
      rustfmt = {
        prepend_args = { "+nightly" },
      },
    },
  },
}
