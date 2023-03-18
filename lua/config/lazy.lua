local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      }
    end,
  },
  -- {
  --   'declancm/cinnamon.nvim',
  --   config = function()
  --     require('cinnamon').setup {
  --       default_keymaps = true,
  --       extra_keymaps = true,
  --       extended_keymaps = true,
  --       always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
  --       centered = true, -- Keep cursor centered in window when using window scrolling.
  --       disabled = false, -- Disables the plugin.
  --       default_delay = 12, -- The default delay (in ms) between each line when scrolling.
  --       hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
  --       horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
  --       max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
  --       -- re-calculated. Setting to -1 will disable this option.
  --       scroll_limit = 150, -- Max number of lines moved before scrolling is skipped. Setting
  --       -- to -1 will disable this option.
  --     }
  --   end,
  -- },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   priority = 999,
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require("sxxrfx.nvim-tree").init()
  --   end
  -- },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        -- sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.spell,
        -- },
      }
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    config = function()
      require('mason-null-ls').setup {
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
      }
      require('mason-null-ls').setup_handlers()
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    priority = 10,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  -- { 'folke/which-key.nvim',          opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-storm'
    end,
  },
  { 'ellisonleao/gruvbox.nvim' },
  { 'EdenEast/nightfox.nvim' },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'tpope/vim-repeat',
  },
  {
    'https://git.sr.ht/~nedia/auto-save.nvim',
    event = 'BufWinEnter',
    config = function()
      require('auto-save').setup()
    end,
  },
  {
    'https://git.sr.ht/~nedia/auto-format.nvim',
    event = 'BufWinEnter',
    config = function()
      require('auto-format').setup()
    end,
  },
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
    },
    config = function()
      require('flit').setup()
    end,
  },

  -- {
  --   's1n7ax/nvim-search-and-replace',
  --   config = function() require'nvim-search-and-replace'.setup() end,
  -- },
  {
    'roobert/search-replace.nvim',
    config = function()
      require('search-replace').setup {
        -- optionally override defaults
        default_replace_single_buffer_options = 'gcI',
        default_replace_multi_buffer_options = 'egcI',
      }
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt', 'vim' },
      }
    end,
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- {
  --   'abecodes/tabout.nvim',
  --   priority = 3,
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     require('tabout').setup {
  --       tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
  --       backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
  --       act_as_tab = true, -- shift content if tab out is not possible
  --       act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
  --       default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --       default_shift_tab = '<C-d>', -- reverse shift default action,
  --       enable_backwards = true, -- well ...
  --       completion = true, -- if the tabkey is used in a completion pum
  --       tabouts = {
  --         { open = "'", close = "'" },
  --         { open = '"', close = '"' },
  --         { open = '`', close = '`' },
  --         { open = '(', close = ')' },
  --         { open = '[', close = ']' },
  --         { open = '{', close = '}' },
  --       },
  --       ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --       exclude = {},
  --     }
  --   end,
  -- },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    config = function()
      local rt = require 'rust-tools'

      rt.setup {
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
      local opts = {
        tools = { -- rust-tools options
          executor = require('rust-tools.executors').termopen,
          on_initialized = nil,
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = 'Comment',
          },
        },
        server = {
          standalone = true,
        },
        dap = {
          adapter = {
            type = 'executable',
            command = 'lldb-vscode',
            name = 'rt_lldb',
          },
        },
      }
      require('rust-tools').setup(opts)
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})
