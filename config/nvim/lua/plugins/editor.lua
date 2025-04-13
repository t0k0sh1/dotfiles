return {
  -- Hihglight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    tag = "0.1.8",
    branch = "0.1.x",
    priority = 1000,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
        lazy = true,
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("telescope").load_extension("ui-select")
        end,
        lazy = true,
      },
    },
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        file_ignore_patterns = { ".git/", "^.cache/", "^LIbrary/", "node_modules/", "vendor/", ".aws-sam/" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "-uu",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }),
    keys = {
      {
        ";f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep()
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "\\\\",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<F12>]],
        direction = "float",
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.6),
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },
  {
    "smoka7/hop.nvim",
    config = function()
      require("hop").setup({
        multi_windows = true,
      })
    end,
    keys = {
      { mode = "", "<leader>h", "<cmd>HopWord<CR>" },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
      })
      npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
    end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "copilot",
      auto_suggestion_provider = "copilot",
      behavior = {
        auto_suggestions = true,
        auto_set_highlight_group = true,
        auto_set_keywords = true,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
      },
      windows = {
        position = "right",
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = false,
        },
        ask = {
          floating = true,
          start_insert = true,
          border = "rounded",
        },
      },
      copilot = {
        model = "gpt-4o-2024-05-13",
        max_tokens = 4096,
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      current_line_blame = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      update_debounce = 100,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}
