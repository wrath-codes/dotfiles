local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Determine OS
local os_config = "linux"
if vim.fn.has("mac") == 1 then
	os_config = "mac"
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {

			configuration = {
				updateBuildConfiguration = "automatic",
				runtimes = {
					-- {
					-- 	name = "JavaSE-21",
					-- 	path = "/home/wrath/.sdkman/candidates/java/21.0.3-tem",
					-- 	default = true,
					-- },
					-- {
					-- 	name = "JavaSE-1.8",
					-- 	path = "/home/wrath/.sdkman/candidates/java/jdk1.8.0_131",
					-- 	default = false,
					-- },
					-- -- Determine OS
					-- local os_config = "linux"
					-- if vim.fn.has("mac") == 1 then
					-- 	os_config = "mac"
					-- end
					{
						name = "JavaSE-21",
						path = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/21.0.3-tem/",
						default = true,
					},
					{
						name = "JavaSE-1.8",
						path = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/1.8.0_131/",
						default = true,
					},
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
			completion = {
				favoriteStaticMembers = {
					"org.assertj.core.api.Assertions.*",
					"org.junit.Assert.*",
					"org.junit.Assume.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.jupiter.api.Assumptions.*",
					"org.junit.jupiter.api.DynamicContainer.*",
					"org.junit.jupiter.api.DynamicTest.*",
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
					"org.mockito.Answers.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				importOrder = {
					"#",
					"java",
					"javax",
					"org",
					"com",
				},
			},
			contentProvider = { preferred = "fernflower" },
			eclipse = {
				downloadSources = true,
			},
			flags = {
				allow_incremental_sync = true,
				server_side_fuzzy_completion = true,
			},
			implementationsCodeLens = {
				enabled = false, --Don"t automatically show implementations
			},
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = false, --Don"t automatically show references
			},
			references = {
				includeDecompiledSources = true,
			},
			saveActions = {
				organizeImports = true,
			},
			signatureHelp = { enabled = true },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	},

	init_options = {
		bundles = {},
	},
}
require("jdtls").start_or_attach(config)

local wk = require("which-key")
wk.register({
	["<leader>e"] = { name = "+extract" },
	["<leader>ev"] = { require("jdtls").extract_variable_all, "Extract Variable" },
	["<leader>ec"] = { require("jdtls").extract_constant, "Extract Constant" },
	["gs"] = { require("jdtls").super_implementation, "Goto Super" },
	["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
	["<leader>eo"] = { require("jdtls").organize_imports, "Organize Imports" },
}, { mode = "n" })
wk.register({
	["<leader>em"] = {
		[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		"Extract Method",
	},
	["<leader>ev"] = {
		[[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
		"Extract Variable",
	},
	["<leader>ec"] = {
		[[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
		"Extract Constant",
	},
}, { mode = "v" })
