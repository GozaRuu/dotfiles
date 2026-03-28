-- kais' neovim config
-- migrated from vim, same keybindings, modern internals

----------------------------------------------
-- OPTIONS
----------------------------------------------
vim.g.mapleader = "\\"

local o = vim.opt
o.background = "dark"
o.wildmenu = true
o.mouse = "a"
o.backspace = "indent,eol,start"
o.number = true
o.numberwidth = 4
o.ruler = true
o.splitright = true
o.showmode = true
o.autoindent = true
o.smartindent = true
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.errorbells = false
o.visualbell = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.encoding = "utf-8"
o.backup = false
o.writebackup = false
o.swapfile = false
o.hidden = true
o.wrap = true
o.linebreak = true
o.wildignore:append("**/node_modules/**")
o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true
o.formatoptions:remove({ "c", "r", "o" })
o.cmdheight = 2
o.updatetime = 300
o.shortmess:append("c")
o.signcolumn = "yes"
o.termguicolors = true
o.scrolloff = 8
o.cursorline = true

-- spell check for docs
o.spelloptions = "camel"
o.spellfile = vim.fn.expand("$HOME/vim/spell/en.utf-8.add")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.txt" },
  callback = function() vim.opt_local.spell = true end,
})

-- trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

----------------------------------------------
-- KEYMAPS (same muscle memory)
----------------------------------------------
local map = vim.keymap.set

-- visual line navigation
map("n", "j", "gj")
map("n", "k", "gk")

-- paste mode
map("n", "<F5>", ":set invpaste paste?<CR>")

-- paragraph navigation
map("n", "<C-J>", "}")
map("n", "<C-K>", "{")

-- yank file paths
map("n", "cr", ':let @* = expand("%")<CR>')
map("n", "cf", ':let @* = expand("%:p")<CR>')
map("n", "cn", ':let @* = expand("%:t")<CR>')

-- clear highlights
map("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { silent = true })

-- resize splits with arrow keys
map("n", "<Up>", ":resize +2<CR>")
map("n", "<Down>", ":resize -2<CR>")
map("n", "<Left>", ":vertical resize -2<CR>")
map("n", "<Right>", ":vertical resize +2<CR>")

-- auto-close brackets
map("i", "{<CR>", "{<CR>}<C-o>O<Tab>")
map("i", "[<CR>", "[<CR>]<C-o>O<Tab>")
map("i", "(<CR>", "(<CR>)<C-o>O<Tab>")

-- sudo write
vim.cmd("cnoremap sudow w !sudo tee % >/dev/null")

----------------------------------------------
-- LAZY.NVIM (plugin manager)
----------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- colorscheme
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized").setup({})
      vim.cmd.colorscheme("solarized")
    end,
  },

  -- treesitter (replaces ALL syntax plugins)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "typescript", "tsx", "javascript", "json", "html", "css",
          "swift", "lua", "bash", "markdown", "markdown_inline",
          "yaml", "graphql", "prisma", "vim", "vimdoc", "regex",
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig", version = "^2.0.0",
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", "eslint", "cssls", "html", "jsonls",
          "tailwindcss", "pyright", "lua_ls",
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- auto-setup all installed servers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({ capabilities = capabilities })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      })

      -- LSP keymaps (same as your coc bindings)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gy", vim.lsp.buf.type_definition, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
          map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
          map("n", "<leader>ac", vim.lsp.buf.code_action, opts)
          map("n", "<leader>qf", vim.diagnostic.open_float, opts)
        end,
      })

      -- diagnostic navigation (same as [g ]g)
      map("n", "[g", vim.diagnostic.goto_prev)
      map("n", "]g", vim.diagnostic.goto_next)

      -- commands
      vim.api.nvim_create_user_command("Format", function()
        vim.lsp.buf.format({ async = true })
      end, {})
      vim.api.nvim_create_user_command("OR", function()
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true,
        })
      end, {})
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- fzf (keep your muscle memory)
  {
    "junegunn/fzf",
    build = function() vim.fn["fzf#install"]() end,
  },
  {
    "junegunn/fzf.vim",
    config = function()
      vim.g.fzf_buffers_jump = 1
      map("n", "<C-p>", ":GFiles<CR>")
      map("n", "<C-g>", ":Rg<CR>")
    end,
  },

  -- file explorer (replaces NERDTree)
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
      })
      map("n", "<C-n>", ":Oil<CR>")
      map("n", "-", ":Oil<CR>")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "solarized_dark",
          section_separators = "",
          component_separators = "|",
        },
      })
    end,
  },

  -- text manipulation
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },
  "tpope/vim-repeat",
  "wellle/targets.vim",
  "tpope/vim-abolish",

  -- testing
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vert"
      map("n", "<leader>t", ":TestNearest<CR>", { silent = true })
      map("n", "<leader>T", ":TestFile<CR>", { silent = true })
      map("n", "<leader>ta", ":TestSuite<CR>", { silent = true })
    end,
  },

  -- markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = "markdown",
    config = function()
      require("render-markdown").setup({})
    end,
  },
  { "godlygeek/tabular", cmd = "Tabularize" },

  -- quickfix
  "yssl/QFEnter",

  -- misc
  "tpope/vim-dispatch",
  "psliwka/vim-smoothie",

}, {
  -- lazy.nvim options
  checker = { enabled = false },
  change_detection = { notify = false },
})

----------------------------------------------
-- SPELL HIGHLIGHTS (solarized-matched)
----------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#dc322f" })
    vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#268bd2" })
    vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#2aa198" })
    vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = "#d33682" })
  end,
})
vim.cmd("doautocmd ColorScheme")

----------------------------------------------
-- DIAGNOSTICS
----------------------------------------------
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
})
