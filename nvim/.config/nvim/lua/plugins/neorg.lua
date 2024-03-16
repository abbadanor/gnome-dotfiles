return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    run = ":Neorg sync-parsers",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.autocommands"] = {},  -- Loads default behaviour
          ["core.concealer"] = { -- Adds pretty icons to your documents
            config = {
              folds = false,
              icon_preset = "diamond",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- Code completion
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                home = "~/notes/home",
                work = "~/notes/work",
              },
              default_workspace = "home"
            },
          },
        },
      }
    end,

  },
}
