return {

    { 'numToStr/Comment.nvim', opts = {} },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme onedark")
        end
    },

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    'folke/neodev.nvim', -- new

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',

            'hrsh7th/cmp-nvim-lsp',

        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },


    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },


    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = 'onedark',
            })
        end,
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                        },
                    },
                },
            }
        end,

    }


}
