local path = vim.fn.stdpath("config") .. "/lua/settings/formatters.lua"

local M = {}

local function read_file()
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local chunk = f:read("*a")
	f:close()
	local fn = load(chunk)
	if not fn then
		return {}
	end
	local ok, data = pcall(fn)
	if not ok or type(data) ~= "table" then
		return {}
	end
	return data
end

local function serialize(data)
	local parts = { "return {" }
	local fts = vim.tbl_keys(data)
	table.sort(fts)
	for _, ft in ipairs(fts) do
		local names = data[ft]
		if type(names) == "table" and #names > 0 then
			local inner = {}
			for _, n in ipairs(names) do
				inner[#inner + 1] = string.format("\t\t%q,", n)
			end
			parts[#parts + 1] = string.format("\t%s = {\n%s\n\t},", ft, table.concat(inner, "\n"))
		end
	end
	parts[#parts + 1] = "}"
	return table.concat(parts, "\n") .. "\n"
end

local function write(data)
	local tmp = path .. ".tmp"
	local f = io.open(tmp, "w")
	if not f then
		return
	end
	f:write(serialize(data))
	f:close()
	os.rename(tmp, path)
end

---Adds auto-installed formatters for a filetype, persisting them to the file.
---Only applies when the user has not already defined an entry for `ft`, so
---manual config is never overridden. Also merges into conform's in-memory map.
---@param ft string
---@param names string[]
function M.add(ft, names)
	if not names or #names == 0 then
		return
	end
	local data = read_file()
	if data[ft] ~= nil then
		return
	end

	local existing = {}
	for _, n in ipairs(vim.deepcopy(require("conform").formatters_by_ft[ft] or {})) do
		existing[n] = true
	end
	for _, n in ipairs(names) do
		existing[n] = true
	end
	data[ft] = vim.tbl_keys(existing)
	table.sort(data[ft])

	write(data)

	local fbf = require("conform").formatters_by_ft
	fbf[ft] = vim.deepcopy(data[ft])
end

return M
