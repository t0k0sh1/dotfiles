local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Indent and unindent
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa!<Return>", opts)

-- Split windows
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Move buffer
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
keymap.set("n", "<S-l>", ":bnext<CR>", opts)

-- Center cursor after search
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)

-- Cancel search highlighting with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)
