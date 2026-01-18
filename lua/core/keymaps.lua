-- lua/core/keymaps.lua
local map = vim.keymap.set

-- General
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { silent = true, desc = "Close window" })
map("n", "<leader>h", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Buffers
map("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>p", ":bprev<CR>", { desc = "Previous buffer", silent = true })
map("n", "<leader>c", ":bdelete<CR>", { desc = "Close buffer", silent = true })

-- Tabs
map("n", "<leader>tt", ":tabnew<CR>", { desc = "Open new tab", silent = true })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab", silent = true })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab", silent = true })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab", silent = true })

-- Splits
map("n", "<leader>sh", ":new<CR>", { desc = "Horizontal split", silent = true })
map("n", "<leader>sv", ":vnew<CR>", { desc = "Vertical split", silent = true })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", silent = true })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic details", silent = true })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape active terminal", silent = true })

-- Running code/servers
map("n", "<M-5>", ":terminal run %<CR>", { silent = true, desc = "Run file" })
map("n", "<F5>", ":terminal run %<CR>", { silent = true, desc = "Run file" })
map("n", "<M-l>", ":terminal serve --public<CR>", { silent = true, desc = "Deploy local server in $HOME/webdoc/" })
map("n", "<C-l>", ":terminal python3 -m http.server<CR>", { silent = true, desc = "Deploy local server here" })

-- Dismiss notifications
map("n", "<M-n>", function()
	require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications" })
