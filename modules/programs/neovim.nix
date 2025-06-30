{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Install essential packages for LazyVim
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil # Nix language server
      pyright # Python language server
      nodePackages.typescript-language-server
      rust-analyzer
      gopls # Go language server
      clang-tools # C/C++ language server

      # Formatters
      stylua # Lua formatter
      nixpkgs-fmt # Nix formatter
      black # Python formatter
      nodePackages.prettier # JavaScript/TypeScript formatter
      rustfmt # Rust formatter
      gofmt # Go formatter

      # Linters
      luajitPackages.luacheck
      statix # Nix linter

      # Tools
      ripgrep # Better grep for telescope
      fd # Better find for telescope
      fzf # Fuzzy finder
      git # Git integration
      gcc # Compiler for tree-sitter
      tree-sitter # Syntax highlighting
      nodejs # For various plugins
      unzip # For Mason.nvim

      # Additional CLI tools
      lazygit # Git TUI
      bottom # System monitor
      curl # HTTP requests
      wget # Downloads
    ];

    # LazyVim configuration
    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- LazyVim configuration
      require("lazy").setup({
        -- LazyVim core
        {
          "LazyVim/LazyVim",
          import = "lazyvim.plugins",
          opts = {
            colorscheme = "tokyonight",
            news = {
              lazyvim = true,
              neovim = true,
            },
          },
        },

        -- Import LazyVim extras
        { import = "lazyvim.plugins.extras.lang.typescript" },
        { import = "lazyvim.plugins.extras.lang.python" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.go" },
        { import = "lazyvim.plugins.extras.lang.nix" },
        { import = "lazyvim.plugins.extras.formatting.prettier" },
        { import = "lazyvim.plugins.extras.linting.eslint" },
        { import = "lazyvim.plugins.extras.ui.mini-animate" },
        { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        { import = "lazyvim.plugins.extras.coding.copilot" },
        { import = "lazyvim.plugins.extras.editor.mini-files" },

        -- Additional frequently used plugins
        {
          "nvim-telescope/telescope.nvim",
          dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
          },
          opts = {
            defaults = {
              prompt_prefix = " ",
              selection_caret = " ",
              path_display = { "smart" },
              file_ignore_patterns = {
                ".git/",
                "node_modules/",
                "*.o",
                "*.a",
                "*.out",
                "*.class",
                "*.pdf",
                "*.mkv",
                "*.mp4",
                "*.zip"
              },
            },
          },
        },

        -- File explorer
        {
          "nvim-neo-tree/neo-tree.nvim",
          opts = {
            filesystem = {
              bind_to_cwd = false,
              follow_current_file = { enabled = true },
              use_libuv_file_watcher = true,
            },
            window = {
              mappings = {
                ["<space>"] = "none",
              },
            },
          },
        },

        -- Git integration
        {
          "kdheepak/lazygit.nvim",
          dependencies = {
            "nvim-lua/plenary.nvim",
          },
          keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
          },
        },

        -- Better commenting
        {
          "numToStr/Comment.nvim",
          opts = {},
        },

        -- Auto pairs
        {
          "windwp/nvim-autopairs",
          event = "InsertEnter",
          opts = {},
        },

        -- Surround text objects
        {
          "kylechui/nvim-surround",
          version = "*",
          event = "VeryLazy",
          opts = {},
        },

        -- Better quickfix
        {
          "kevinhwang91/nvim-bqf",
          ft = "qf",
        },

        -- Session management
        {
          "folke/persistence.nvim",
          event = "BufReadPre",
          opts = { options = vim.opt.sessionoptions:get() },
          keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
          },
        },

        -- Code action menu
        {
          "weilbith/nvim-code-action-menu",
          cmd = "CodeActionMenu",
          keys = {
            { "<leader>ca", "<cmd>CodeActionMenu<cr>", desc = "Code Action Menu" },
          },
        },

        -- Better fold
        {
          "kevinhwang91/nvim-ufo",
          dependencies = "kevinhwang91/promise-async",
          opts = {
            provider_selector = function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
            end
          },
        },

        -- Markdown preview
        {
          "iamcco/markdown-preview.nvim",
          cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
          build = "cd app && yarn install",
          init = function()
            vim.g.mkdp_filetypes = { "markdown" }
          end,
          ft = { "markdown" },
        },

        -- Better terminal
        {
          "akinsho/toggleterm.nvim",
          version = "*",
          opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
              border = "curved",
              winblend = 0,
              highlights = {
                border = "Normal",
                background = "Normal",
              },
            },
          },
        },

        -- Color picker
        {
          "uga-rosa/ccc.nvim",
          opts = {},
          keys = {
            { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
          },
        },

        -- Zen mode for focused writing
        {
          "folke/zen-mode.nvim",
          opts = {
            window = {
              backdrop = 0.95,
              width = 120,
              height = 1,
              options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = "0",
                list = false,
              },
            },
            plugins = {
              options = {
                enabled = true,
                ruler = false,
                showcmd = false,
              },
              twilight = { enabled = true },
              gitsigns = { enabled = false },
              tmux = { enabled = false },
            },
          },
          keys = {
            { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
          },
        },

        -- Highlight todo comments
        {
          "folke/todo-comments.nvim",
          dependencies = { "nvim-lua/plenary.nvim" },
          opts = {},
        },

      }, {
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })

      -- Basic Neovim settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.showmode = false
      vim.opt.clipboard = "unnamedplus"
      vim.opt.breakindent = true
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.list = true
      vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
      vim.opt.inccommand = "split"
      vim.opt.cursorline = true
      vim.opt.scrolloff = 10
      vim.opt.hlsearch = true

      -- Key mappings
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Clear highlights on search when pressing <Esc> in normal mode
      vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

      -- Better navigation between splits
      vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
      vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
      vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
      vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

      -- Better indenting
      vim.keymap.set("v", "<", "<gv")
      vim.keymap.set("v", ">", ">gv")

      -- Move lines up and down
      vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
      vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
      vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
      vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
      vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
      vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

      -- Better paste
      vim.keymap.set("x", "<leader>p", [["_dP]])

      -- Save file
      vim.keymap.set({"i", "x", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
    '';
  };
}
