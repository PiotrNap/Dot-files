require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = "send_to_qflist",
                ["<esc>"] = "close"
            },
            n = {
                ["<Down>"] = "move_selection_next",
                ["<Up>"] = "move_selection_previous",
             }
        },

        file_ignore_patterns = {
            "node_modules/.*",
            "%.env",
            "yarn.lock",
            "pnpm%-lock.yaml",
            "package%-lock.json",
            "lazy%-lock.json",
            "init.sql",
            "target/.*",
            ".git/.*",
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        -- project = {
        --     base_dirs = {
        --         {path = '~/Workspace', max_depth = 2}
        --     },
        --     hidden_files = true
        -- }
    }
}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('project')
