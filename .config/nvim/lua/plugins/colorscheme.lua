return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      vim.o.background == "dark",
      colorscheme = "gruvbox",
    },
  },
}
