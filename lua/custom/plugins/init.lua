-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'vimwiki/vimwiki',
    -- The keys that trigger the plugin
    -- keys = { '<leader>ww', '<leader>wt', '<leader>w<leader>w' },
    -- Config
    init = function()
      local base_path = '~/OneDrive/Documentos/vimwiki/'
      local notes = { 'personal', 'work' }
      vim.g.vimwiki_list = {
        {
          path = base_path,
          syntax = 'markdown',
          ext = '.md',
          links_space_char = '-',
          path_html = base_path .. 'html',
          custom_wiki2html = 'vimwiki_markdown',
        },
        {
          path = base_path .. 'work',
          syntax = 'markdown',
          ext = '.md',
          links_space_char = '-',
          path_html = base_path .. 'html',
          custom_wiki2html = 'vimwiki_markdown',
        },
        {
          path = base_path .. 'personal',
          syntax = 'markdown',
          ext = '.md',
          links_space_char = '-',
          path_html = base_path .. 'html',
          custom_wiki2html = 'vimwiki_markdown',
        },
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
      vim.g.vimwiki_use_mouse = 1
      vim.g.vimwiki_markdown_link_ext = 1
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_folding = 'custom'

      local builtin = require 'telescope.builtin'
      local search_dirs = {}
      for k, v in pairs(vim.g.vimwiki_list) do
        search_dirs[k] = v['path']
      end
      -- Shortcut for searching your Wiki files
      vim.keymap.set('n', '<leader>wg', function()
        local vimwiki_path = vim.api.nvim_eval 'vimwiki#vars#get_wikilocal("path")'
        builtin.find_files {
          cwd = vimwiki_path,
          search_dirs = search_dirs,
          path_display = { 'tail' },
        }
      end, { desc = '[G]o to Wiki File' })
      -- Shortcut for searching in your Wiki files
      vim.keymap.set('n', '<leader>si', function()
        local vimwiki_path = vim.api.nvim_eval 'vimwiki#vars#get_wikilocal("path")'
        builtin.live_grep {
          cwd = vimwiki_path,
          search_dirs = search_dirs,
          path_display = { 'tail' },
          -- path_display = { 'truncate' },
          prompt_title = 'Live Grep in Wiki',
        }
      end, { desc = 'Search in W[i]ki Files' })
    end,
  },
  {
    'godlygeek/tabular',
    branch = 'master',
  },
}
