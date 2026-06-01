if vim.b.jdtls_started then
	return
end

vim.b.jdtls_started = true

print("JDTLS STARTING")
local jdtls = require("jdtls")
local home = os.getenv("HOME")

jdtls.start_or_attach({
	cmd = {
		"jdtls",
		"-data",
		home .. "/.local/share/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
		"--jvm-arg=-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar"),
	},

	root_dir = require("jdtls.setup").find_root({
		"mvnw",
		"gradlew",
		"pom.xml",
		"build.gradle",
	}),

	settings = {
		java = {
			configuration = {
				updateBuildConfiguration = "interactive",
			},
		},
	},

	init_options = {
		bundles = {},
	},
})
