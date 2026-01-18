# NEOVIM CONFIG

## Directory Structure

```
.
├── init.lua
├── lua
│   ├── core
│   │   ├── keymaps.lua
│   │   └── options.lua
│   └── plugins
│       ├── init.lua
│       ├── lsp.lua
│       ├── tools.lua
│       └── ui.lua
├── README.md
├── run
└── serve
```

## Utility

- **build:** A C++ compiler. It handles the build and prompts to save or discard the executable.

- **serve**
  - **Stack detection:** Fingerprints the project to launch Node (pnpm/npm/yarn), PHP, or Python servers automatically.
  - **Tunneling:** Integrated localhost.run to instantly share the local environment via a public URL (optional).

## Plugins

### UI

- **Tokyonight:** High-contrast, low-fatigue color scheme optimized for long coding sessions.

- **Lualine & Bufferline:** State awareness. Provides a real-time status bar and a clean top-bar for buffer and tab management.

- **Neotree:** Structural navigation. A sidebar for file management with integrated git status and previews.

- **Indent Blankline:** Visual orientation. Adds vertical indentation guides to maintain focus within deep code blocks.

- **Noice & Dressing:** Interface overhaul. Replaces legacy command-line and input prompts with modern, centered UI modals.

- **Lspsaga & Dropbar:** Navigation. Adds breadcrumbs for file context and enhanced, interactive hover windows for LSP actions.

### Tools

- **Telescope & Trouble:** The search and diagnostics hub. Fuzzy-finds anything while centralizing all errors and warnings into a clean, actionable list.

- **Avante & Emmet:** High-speed generation. Combines AI-powered code assistance with shorthand expansion for rapid web development.

- **Neogit & Gitsigns:** Git workflow. Provides a full-screen management interface and real-time gutter indicators for staged or modified lines.

- **Conform & Comment.nvim:** Formatting and logic. Handles automated code styling and fast, context-aware line commenting.

- **Blink.pairs & Auto Tag:** Structural automation. Automatically manages closing brackets, quotes, and HTML tags as you type.

- **CCC.nvim & Highlight Colors:** Visual feedback. A professional color picker and high-fidelity highlighting for color codes directly in the buffer.

- **Render Markdown & Sleuth:** Environment polish. Prettifies documentation in real-time and automatically detects indentation settings based on the file.

- **Which Key:** Command discovery. Displays a dynamic popup of available keybindings to eliminate memorization fatigue.

### LSP

- **Mason & Mason-lspconfig:** Automated lifecycle management. Installs and bridges LSP servers, linters, and debuggers directly to the Neovim environment.

- **Blink.cmp:** High-performance completion engine. A fast, modern alternative for snippet and LSP-based code suggestions.

- **Treesitter:** Syntax architecture. Provides granular, language-aware parsing for superior highlighting, selection, and structural navigation.
