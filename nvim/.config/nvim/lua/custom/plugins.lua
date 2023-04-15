return function(use)
  use({
    "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  })
  use ({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup ({
      })
    end
  })
end
