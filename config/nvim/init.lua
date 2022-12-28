local ok, impatient = pcall(require, 'impatient')
if ok then
    impatient.enable_profile()
end

require('user.builtins')
require('user.options')
require('user.autocmds')
require('user.keymaps')
require('user.plugins')
