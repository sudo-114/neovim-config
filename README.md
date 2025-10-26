# 🌙 My Neovim Configuration (LazyVim Style)

This is a fast, feature-rich Neovim setup built entirely in Lua, managed by lazy.nvim. It's focused on a modern coding experience with integrated LSP, auto-formatting, and a clean UI based on the Tokyo Night theme.

## ⚙️ Configuration Structure

All configuration is written in Lua and follows a modular structure:
| File/Directory | Purpose |
|---|---|
| init.lua | The main entry point. It bootstraps lazy.nvim and loads core settings. |
| core/options.lua | Sets up vim.opt values (tab stops, line numbers, clipboard). |
| core/keymaps.lua | Defines all custom keybindings. |
| plugins/\*.lua | Contains specifications and configuration for all installed plugins. |

## ✨ Features

| Category        | Key Plugins                                                          | Description                                                                    |
| --------------- | -------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Plugin Manager  | lazy.nvim                                                            | Modern, performant plugin manager.                                             |
| Theme           | folke/tokyonight.nvim                                                | Clean, dark theme using the tokyonight-storm style.                            |
| UI/UX           | nvim-lualine/lualine.nvim, akinsho/bufferline.nvim, folke/noice.nvim | Custom statusline, buffer tabs, and a cleaner command-line/message UI.         |
| File Explorer   | nvim-tree/neo-tree.nvim                                              | A powerful file explorer (mapped to <leader>e and <leader>l).                  |
| LSP & Tools     | mason.nvim, mason-lspconfig.nvim, nvim-treesitter                    | Seamless LSP server installation/management, and accurate syntax highlighting. |
| Autocompletion  | hrsh7th/nvim-cmp, LuaSnip                                            | Fast and smart code completion with snippet support.                           |
| AI/Assistance   | github/copilot.vim, CopilotC-Nvim/CopilotChat.nvim                   | Integrated AI coding assistant and chat functionality.                         |
| Fuzzy Finder    | nvim-telescope/telescope.nvim                                        | Quick file/text searching powered by ripgrep and fd.                           |
| Code Formatting | stevearc/conform.nvim                                                | Automatic code formatting on save for various languages.                       |
| Git             | tpope/vim-fugitive, lewis6991/gitsigns.nvim                          | Powerful Git integration and line-by-line diffs.                               |

## Configured Language Servers

The configuration uses mason and mason-lspconfig to automatically install the following Language Servers (LSP) and formatters:

- PHP: intelephense, pint, phpcbf (formatter)
- Python: pyright, isort (formatter), black (formatter)
- TypeScript/JavaScript: ts_ls, eslint, prettier (formatter)
- Web: cssls, html, tailwindcss, somesass_ls
- C/C++: clangd
- Lua: lua_ls, stylua (formatter)

## ⚙️ Installation

**Prerequisites**

- Neovim (v0.8.0 or later, as this is a Lua-based config).
- Git
- ripgrep and fd (for Telescope functionality).
  Steps
- Backup your existing Neovim configuration:
  mv ~/.config/nvim ~/.config/nvim.bak

- Clone this repository:

```sh
git clone https://github.com/sudo-114/neovim-config.git ~/.config/nvim
```

- Launch Neovim:
  nvim

  > The lazy.nvim manager will automatically bootstrap itself and install all the plugins.

## 🔧 Configuration Highlights

- Leader Key: The main leader key is set to <space>.
- Tabs & Indentation: Indentation is set to 2 spaces (tabstop=2, shiftwidth=2).
- Line Numbers: Both absolute and relative line numbers are enabled.
- Clipboard: Clipboard integration is enabled to use the system clipboard (unnamedplus).
- Language Servers: mason.nvim is configured to ensure the installation of a wide range of LSPs for languages like PHP (intelephense), Python (pyright), TS/JS (ts_ls, eslint), C/C++ (clangd), Lua (lua_ls), HTML, CSS, and Tailwind CSS.
- Auto-Formatting: conform.nvim is set up to automatically format on save using tools like stylua, prettier, black, and pint.

## ⌨️ Keybindings

The following are some of the most important keybindings, all using the <leader> key (<space>):

### General

| Keybinding            | Description                                    |
| --------------------- | ---------------------------------------------- |
| <C-s>                 | Save File                                      |
| <leader>h             | Clear search highlight                         |
| <leader>q / <leader>Q | Close window / Close all windows               |
| <leader>w             | Git write and add (:Gw)                        |
| <M-5>                 | Run Python file (:w<CR>:terminal python %<CR>) |

### Files and Buffers

| Keybinding            | Description                                         |
| --------------------- | --------------------------------------------------- |
| <leader>e             | Toggle Neo-tree (File Explorer) in a float window   |
| <leader>l             | Toggle Neo-tree (File Explorer) on the left sidebar |
| <leader>ff            | Telescope Find Files                                |
| <leader>fg            | Telescope Live Grep (Search contents)               |
| <leader>n / <leader>p | Next / Previous buffer                              |
| <leader>c             | Close current buffer                                |

### LSP and Diagnostics

| Keybinding  | Description                                     |
| ----------- | ----------------------------------------------- |
| `[d` / `]d` | Jump to previous / next diagnostic              |
| <leader>d   | Show diagnostic details (float window)          |
| <leader>xx  | Toggle Trouble diagnostics (for all files)      |
| <leader>xX  | Toggle Trouble diagnostics (for current buffer) |

### Splits and Tabs

| Keybinding              | Description             |
| ----------------------- | ----------------------- |
| <leader>sp              | Horizontal split (:new) |
| <leader>vs              | Vertical split (:vnew)  |
| <leader>t               | Open new tab            |
| <leader>tn / <leader>tp | Next / Previous tab     |
| <leader>tc              | Close current tab       |
