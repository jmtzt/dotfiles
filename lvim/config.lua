lvim.builtin.terminal.open_mapping = "<C-Bslash>"
lvim.builtin.bufferline.active = false
lvim.format_on_save.enabled = true
lvim.colorscheme = "rose-pine"
-- lvim.builtin.alpha.active = true
-- lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.alpha.active = false
lvim.builtin.lir.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.hijack_unnamed_buffer_when_opening = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.which_key.setup.plugins.presets.z = true

vim.g.loaded_nvimtree = 1

vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = { markdown = true, yaml = true }
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

-- local lspconfig = require("lspconfig")
-- lspconfig.basedpyright.setup{}
require'lspconfig'.pyright.setup{}
-- add `pyright` to `skipped_servers` list
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- -- remove `jedi_language_server` from `skipped_servers` list
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "basedpyright"
-- end, lvim.lsp.automatic_configuration.skipped_servers)
--
--
lvim.builtin.treesitter.ensure_installed = {
  "go",
  "gomod",
}

-- install plugins
lvim.plugins = {
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "github/copilot.vim",
  "opdavies/toggle-checkbox.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "ThePrimeagen/vim-be-good",
    {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },
  {
       "ThePrimeagen/harpoon",
       branch = "harpoon2",
       dependencies = { "nvim-lua/plenary.nvim" }
  },
    { 'rose-pine/neovim', name = 'rose-pine' },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
            lang = "python3",
            storage = {
                home = "/Users/joao.tozato/personal/projects/leetcode/leetcode.nvim",
                cache = "/Users/joao.tozato/personal/projects/leetcode/leetcode.nvim.cache",
            },
            injector = {
                ["python3"] = {
                    before = true
                },
            },
            description = {
                width = "30%"
            }
        },
    },
    "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
}

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
  "lua",
  "rust",
  "toml"
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "isort" },
    { name = "black", extra_args = { "--line-length", 80, "--preview"} },
    { command = "goimports", filetypes = { "go" } },
    { command = "gofumpt", filetypes = { "go" } },
}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.go" }

-- setup linting
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

lvim.builtin.which_key.mappings["d"] = {
    name = "Debug/Test",
    m = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" },
    M = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test Class" },
    F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" },
    S = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
}

-- REFACTOR
--
lvim.builtin.which_key.mappings["r"] = {
    name = "Refactor",
    r = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace Word"},
    e = { ":Refactor extract<cr>", "Extract" },
    f = { ":Refactor extract_to_file<cr>", "Extract to File" },
    v = { ":Refactor extract_var<cr>", "Extract Variable" },
    i = { ":Refactor inline_var<cr>", "Inline Variable" },
    I = { ":Refactor inline_func<cr>", "Inline Function" },
    b = { ":Refactor extract_block<cr>", "Extract Block" },
    B = { ":Refactor extract_block_to_file<cr>", "Extract Block to File" },
}


-- TODOlist
function insert_date_with_hash()
    local date = os.date("%d.%m.%y")  -- Get the current date in DDMMYYYY format
    local date_with_hash = "# " .. date  -- Prepend # to the date
    vim.api.nvim_put({date_with_hash}, 'c', true, true)  -- Insert the string at the cursor position
end

lvim.builtin.which_key.mappings["t"] = {
    name = "TODO",
    t = { ":lua require('toggle-checkbox').toggle()<CR>", "Toggle checkbox" },
    d = { ":lua insert_date_with_hash()<CR>", "Insert current date with # (DD.MM.YY)" },  -- New keybinding for date with #
}

-- HARPOON
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-q>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-r>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-t>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-r>", function() harpoon:list():next() end)


lvim.keys.normal_mode = {
    ["<C-s>"] = ":w<cr>",
    ["[b"] = ":bp<cr>",
    ["]b"] = ":bn<cr>",
    ["<leader>st"] = vim.cmd.Ex,
    ["J"] = "mzJ`z",
    ["n"] = "nzzzv",
    ["N"] = "Nzzzv",
    ["Q"] = "<nop>",
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",
    ["<M-[>"] = "<cmd>cnext<cr>",
    ["<M-]>"] = "<cmd>cprev<cr>",
}

require('swenv').setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
    end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('~/venvs'),
    -- Something to do after setting an environment, for example call vim.cmd.LspRestart
    -- post_set_venv = vim.cmd.LspRestart,
})

vim.api.nvim_set_keymap("i", "<C-x>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
lvim.keys.insert_mode = {
    ["jk"] = "<Esc>",
}
lvim.keys.visual_mode = {
    ["J"] = ":m '>+1<CR>gv=gv",
    ["K"] = ":m '<-2<CR>gv=gv",
}



lvim.builtin.which_key.mappings["s"] = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    -- t = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    t = { "<cmd>Explore<Cr>", "Explorer" },
    g = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    l = { "<cmd>Telescope resume<cr>", "Resume last search" },
    p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
    },
}

-- binding for switching python virtual environments
lvim.builtin.which_key.mappings["C"] = {
    name = "Code Utils",
    c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
    r = {"<cmd>Leet run<cr>", "Run Leetcode"},
    s = {"<cmd>Leet submit<cr>", "Submit Leetcode"},
    d = {"<cmd>Leet desc<cr>", "Description Leetcode"},
    l = {"<cmd>Leet<cr>", "Leetcode"},
    v = {"<cmd>LspRestart<cr>", "Restart LSP"},
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find "Windows" then
    codelldb_path = mason_path .. "packages\\codelldb\\extension\\adapter\\codelldb.exe"
    liblldb_path = mason_path .. "packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll"
else
    -- The liblldb extension is .so for linux and .dylib for macOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

pcall(function()
    require("rust-tools").setup {
        tools = {
            executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
            reload_workspace_from_cargo_toml = true,
            runnables = {
                use_telescope = true,
            },
            inlay_hints = {
                auto = true,
                only_current_line = false,
                show_parameter_hints = false,
                parameter_hints_prefix = "<-",
                other_hints_prefix = "=>",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highlight = "Comment",
            },
            hover_actions = {
                border = "rounded",
            },
            on_initialized = function()
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                    pattern = { "*.rs" },
                    callback = function()
                        local _, _ = pcall(vim.lsp.codelens.refresh)
                    end,
                })
            end,
        },
        dap = {
            -- adapter= codelldb_adapter,
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            on_attach = function(client, bufnr)
                require("lvim.lsp").common_on_attach(client, bufnr)
                local rt = require "rust-tools"
                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            end,

            capabilities = require("lvim.lsp").common_capabilities(),
            settings = {
                ["rust-analyzer"] = {
                    lens = {
                        enable = true,
                    },
                    checkOnSave = {
                        enable = true,
                        command = "clippy",
                    },
                },
            },
        },
    }
end)

lvim.builtin.dap.on_config_done = function(dap)
    dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }
end

vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

lvim.builtin.which_key.mappings["R"] = {
    name = "Rust",
    r = { "<cmd>RustRunnables<Cr>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
    d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
    R = {
        "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
        "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
    y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
    P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
    i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
    f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
    D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}


---- Go stuff
--
--
--------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()
--------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
    map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
    map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
    map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
    map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}

-- Prevent writing files with the name '\'
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.fn.expand('%:p') == '\\' then
      -- Abort the write operation if the file name is '\'
      vim.api.nvim_err_writeln("Cannot write to file '\\'")
      return true -- Abort the write operation
    end
  end,
})
