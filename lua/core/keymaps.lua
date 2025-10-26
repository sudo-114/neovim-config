-- lua/core/keymaps.lua
local map = vim.keymap.set

-- General
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { silent = true, desc = "Close window" })
map("n", "<leader>Q", ":qa<CR>", { silent = true, desc = "Close all windows" })
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":Gw<CR>", { noremap = true, silent = true, desc = "Git write and adc, Save file" })

-- Buffers
map("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>p", ":bprev<CR>", { desc = "Previous buffer" })
map("n", "<leader>c", ":bdelete<CR>", { desc = "Close buffer" })

-- Tabs
map("n", "<leader>t", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })

-- Splits
map("n", "<leader>sp", ":new<CR>", { desc = "Horizontal split" })
map("n", "<leader>vs", ":vnew<CR>", { desc = "Vertical split" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic details" })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape active terminal" })

-- Running code/servers
map("n", "<M-b>", ":terminal ~/build.sh %<CR>", { silent = true, desc = "Compile/run C++ file" })
map("n", "<M-5>", ":w<CR>:terminal python %<CR>", { silent = true, desc = "Run python file" })
map("n", "<M-l>", ":terminal ~/server.sh<CR>", { silent = true, desc = "Deploy local server in $HOME/webdoc/" })
map("n", "<C-l>", ":terminal python3 -m http.server<CR>", { silent = true, desc = "Deploy local server here" })

-- Others
map("n", "]c", ":CccPick<CR>", { noremap = true, silent = true, desc = "Open Colortils" })

map("n", "<M-n>", function()
	require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications" })
