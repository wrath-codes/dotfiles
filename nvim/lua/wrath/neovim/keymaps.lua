Map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
Map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
Map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
Map("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

Map("n", "<leader>wn", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
Map("n", "<leader>wc", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
Map("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })                          --  go to next tab
Map("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                    --  go to previous tab
Map("n", "<leader>ws", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
