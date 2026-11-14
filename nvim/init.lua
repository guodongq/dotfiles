vim.loader.enable()

require("config.options") -- first, so <leader> is set before plugins map keys
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
