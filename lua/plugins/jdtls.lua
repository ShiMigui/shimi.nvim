return {
	"mfussenegger/nvim-jdtls",
	lazy = true,
	ft = "java",
	config = function()
		local fn = vim.fn
		local jdtls = require("jdtls")
		local home = os.getenv("HOME") .. "/.local/share/jdtls-workspace/" .. fn.fnamemodify(fn.getcwd(), ":t")

		if vim.b.jdtls_started then
			return
		end
		vim.b.jdtls_started = true
		jdtls.start_or_attach({
			cmd = {
				"jdtls",
				"-data",
				home,
				"--jvm-arg=-javaagent:" .. fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar"),
			},
			root_dir = require("jdtls.setup").find_root({ "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			settings = { java = { configuration = { updateBuildConfiguration = "interactive" } } },
			init_options = { bundles = {} },
		})
	end,
}
