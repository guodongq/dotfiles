local ok, impatient = pcall(require, 'impatient')
if ok then
    impatient.enable_profile()
end

require('option')
require('autocmd')
require('keymap')
require('plugin')
