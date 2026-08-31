--- Toggle file explorer for a given path.
--- - If the explorer is open, closes it.
--- - If it is closed, opens it anchored at `path`.
---   When `path` is a file, its parent directory is used as anchor and the
---   explorer focuses on that file.
--- @param path? string|nil Target path. Defaults to current working directory.
--- @param use_latest? boolean|nil Whether to restore the last used state for
---   the path. Defaults to `true`.
local function toggle(path, use_latest)
	local MiniFiles = require("mini.files")

	if MiniFiles.close() == nil then
		MiniFiles.open(path, use_latest)
	end
end

return { toggle = toggle }
