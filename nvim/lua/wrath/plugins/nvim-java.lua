return {
    "nvim-java/nvim-java",
    dependencies = {
        "nvim-java/lua-async-await",
        "nvim-java/nvim-java-core",
        "nvim-java/nvim-java-test",
        "nvim-java/nvim-java-dap",
        "MunifTanjim/nui.nvim",
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        {
            "williamboman/mason.nvim",
            opts = {
                registries = {
                    "github:nvim-java/mason-registry",
                    "github:mason-org/mason-registry",
                },
            },

            config = function()
                local java = require("java")

                -- Run the test class in the active buffer
                vim.keymap.set("n", "<leader>jrc", "JavaTestRunCurrentClass")
                -- Debug the test class in the active buffer
                vim.keymap.set("n", "<leader>jdc", "JavaTestDebugCurrentClass")

                -- Run the test method on the cursor
                vim.keymap.set("n", "<leader>jrm", "JavaTestRunCurrentMethod")

                -- Debug the test method on the cursor
                vim.keymap.set("n", "<leader>jdm", "JavaTestDebugCurrentMethod")

                -- Open the last test report in a popup window
                vim.keymap.set("n", "<leader>jdm", "JavaTestViewLastReport")
            end,
        },
    },
}
